
#loader crafttweaker reloadable

import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.MachineBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.MMEvents;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.RecipeFinishEvent;
import mods.modularmachinery.MachineTickEvent;
import mods.modularmachinery.FactoryRecipeStartEvent;
import mods.modularmachinery.ControllerGUIRenderEvent;
import mods.modularmachinery.SmartInterfaceType;
import mods.modularmachinery.RecipeTickEvent;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.RecipeModifierBuilder;

import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;
import crafttweaker.util.Math;

import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.research.ResearchCognitionData;

mods.extendedcrafting
    .CompressionCrafting
    .addRecipe(
        <contenttweaker:polymer_matter>,
        <ore:blockInfinity>,4096,
        <contenttweaker:space_time_condensation_block>,0
    );
MachineModifier.addSmartInterfaceType("Harmony",
    SmartInterfaceType.create("speed", 1)
        .setHeaderInfo("电量输入速度设置")
        .setValueInfo("速度：§a%.0f ")
        .setFooterInfo("§a每1代表10GRF/t的输入速度,最大100000")
        .setJeiTooltip("速度范围：最低 §a%.0f 倍§f，最高 §a%.0f 倍", 2)
        .setNotEqualMessage("§a输入速度过载或过低！")
);
MMEvents.onMachinePostTick("Harmony", function(event as MachineTickEvent) {
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    val nullable = ctrl.getSmartInterfaceData("speed");
    var speed = isNull(nullable) ? 1.0f : nullable.value;
    //检查数据正确性
    if (speed < 1 || speed > 100000) {
        nullable.value = 1;
    }
    map["speed"] = speed;
    ctrl.customData = data;
});
MMEvents.onControllerGUIRender("Harmony",function(event as ControllerGUIRenderEvent){
    val ctrl = event.controller;
    val world = ctrl.world;
    val data = ctrl.customData;
    val dData = D(data);
    val ener = dData.getLong("energy",0);
    var info as string[] = [];
    info += "§5鸿蒙§b演化§e监测器";
    info += "当前能源储量为："+formatNumber(ener)+"RF/1ERF";
    event.extraInfo = info;
});
function formatNumber(value as long) as string {
    if (value < 1000) {
        return "" + value + "G";
    } else if (value < 1000000) {
        return "" + (value / 1000) + "T";
    } else if (value < 1000000000) {
        return "" + ((value / 1000) as float / 1000) + "P";
    } else if (value < 1000000000000) {
        return "" + ((value / 1000000) as float / 1000) + "E";
    } else if (value < 1000000000000000) {
        return "" + ((value / 1000000000) as float / 1000) + "Z";
    } else if (value < 1000000000000000000) {
        return "" + ((value / 1000000000000) as float / 1000) + "Y";
    } else {
        return "" + ((value / 1000000000000000) as float / 1000) + "B";
    }
}
HyperNetHelper.proxyMachineForHyperNet("Harmony");
AddEnergyMachine("harmony");
MachineModifier.setMaxThreads("Harmony", 0);
MachineModifier.addCoreThread("Harmony",FactoryRecipeThread.createCoreThread("稳定时空场发生器").addRecipe("timespacecon"));
MachineModifier.addCoreThread("Harmony",FactoryRecipeThread.createCoreThread("能量注入器").addRecipe("enerin"));
MachineModifier.addCoreThread("Harmony",FactoryRecipeThread.createCoreThread("寰宇操纵机").addRecipe("infinitycontr"));
MachineModifier.addCoreThread("Harmony",FactoryRecipeThread.createCoreThread("空间塑造器"));
for i in 1 to 33{
    MachineModifier.addCoreThread("Harmony",FactoryRecipeThread.createCoreThread("物质扭曲仪#"+i));
}

RecipeBuilder.newBuilder("harmonyCon","light-speed_material_accelerator",666)
    .addInputs([
        <mekanism:cosmicalloy>*4,
        <mekanism:controlcircuit:4>*4,
        <contenttweaker:charging_crystal_block>*128,
        <contenttweaker:antimatter_core>*8,
        <modularmachinery:xihe_star_creation_device_controller>,
        <contenttweaker:assembly> * 32,
        <liquid:liquid_energy>*2000000
    ])
    .addEnergyPerTickInput(4000000000000)
    .requireResearch("Harmony")
    .addOutputs(<modularmachinery:harmony_factory_controller>)
    .build();
RecipeBuilder.newBuilder("timespacecon","Harmony",2147483647)
    .addInputs([
        <contenttweaker:space_time_condensation_block>*8,
        <contenttweaker:polymer_matter>,
        <contenttweaker:beta_matter>*64,
        <liquid:liquid_energy>*2000000,
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism=1;
    })
    .setThreadName("稳定时空场发生器")
    .addRecipeTooltip("基于全新物质的时空场有更强大的承载能力")
    .build();
RecipeBuilder.newBuilder("enerin","Harmony",1)
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val speed = dData.getLong("speed",1) * 10;
        val relenercost = speed * 1000000000;
        val energy = dData.getLong("energy",0);
        if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚不存在时空场！");
            return;
        }else if(energy>=1000000000){
            event.setFailed("存储电量已达极限！");
        }else if(!CostEnergy(event,0,relenercost)){
            event.setFailed("无线电网之中的电量尚不足够！");
        }
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent) {
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val map = data.asMap();
        val speed = dData.getLong("speed",1) * 10;
        val energy1 = dData.getLong("energy",0);
        map["energy"] = energy1+speed;
        ctrl.customData = data;
    })
    .setParallelized(false)
    .addRecipeTooltip("为塑世注入1GRF的电网能量","可在智能数据接口处调整速度")
    .setThreadName("能量注入器")
    .build();
RecipeBuilder.newBuilder("infinitycontr","Harmony",200)
    .addInput(<avaritia:resource:6>*4)
    .addInput(<contenttweaker:polymer_matter>).setChance(0)
    .addOutputs([
        <avaritia:resource:4>*106,
        <avaritia:resource:1>*130,
        <contenttweaker:field_generator_v1>*10,
        <avaritia:endest_pearl>*10,
        <redstonerepository:storage>*5,
        <redstonerepository:storage:1>*5,
        <tconevo:metal:5>*10,
        <contenttweaker:charging_crystal_block>*20,
        <contenttweaker:crystalpurple>*10,
        <contenttweaker:universalalloyt2>*10,
        <minecraft:iron_block>*145000,
        <minecraft:gold_block>*125000,
        <minecraft:lapis_block>*125000,
        <minecraft:redstone_block>*155000,
        <minecraft:quartz_block>*125000,
        <thermalfoundation:storage>*145000,
        <thermalfoundation:storage:1>*145000,
        <thermalfoundation:storage:3>*135000,
        <thermalfoundation:storage:2>*135000,
        <thermalfoundation:storage:5>*145000,
        <minecraft:diamond_block>*135000,
        <minecraft:emerald_block>*125000,
        <redstonearsenal:storage>*115000,
        <thermalfoundation:storage:6>*113000,
        <thermalfoundation:storage:7>*113000,
        <appliedenergistics2:sky_stone_block>*60000
    ])
    .addOutput(<contenttweaker:beta_matter>*16).setChance(0.5)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val energy = dData.getLong("energy",0) as long;
        val para = (energy/10000000) as int;
        if(energy<10000000){
            event.setFailed("电量尚不足够！");
        }else{
            event.activeRecipe.maxParallelism = Math.min(256,para);
        }
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val map = data.asMap();
        val energy = dData.getLong("energy",0) as long;
        map["energy"] = energy - 1000000;
        ctrl.customData=data;
    })
    .setThreadName("寰宇操纵机")
    .addRecipeTooltip("会消耗1PRF内置电量")
    .build();
function HarmonyRecipe(name as int,time as int,needen as long,research as string,item as IIngredient[],output as IIngredient[]){
    val enercost = formatNumber(needen);
    RecipeBuilder.newBuilder("atom"+name,"Harmony",time)
        .addInputs(item)
        .addOutputs(output)
        .addPreCheckHandler(function(event as RecipeCheckEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val energy = dData.getLong("energy",0) as long;
            val para = (energy/needen) as int;
            if(energy < needen){
                event.setFailed("电量尚不足够！");
            }else{
                event.activeRecipe.maxParallelism = Math.min(2048,para);
            }
        })
        .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            val para = event.activeRecipe.parallelism as long;
            val energy = dData.getLong("energy",0) as long;
            map["energy"] = energy - (needen * para);
            ctrl.customData=data;
        })
        .requireResearch(research)
        .addRecipeTooltip("需要"+enercost+"RF内置电量")
        .build();
}
HarmonyRecipe(1,6,50,"Harmony",
    [
        <contenttweaker:industrial_circuit_v4> * 2,
        <ore:circuitArk> * 2,
        <contenttweaker:coil_v5> * 4,
        <draconicevolution:chaotic_core> * 2,
        <avaritiatweaks:enhancement_crystal> * 1
    ],
    [
        <contenttweaker:field_generator_v4> * 2
    ]
);
HarmonyRecipe(2,6,50,"Harmony",
    [
        <ore:circuitArk> * 4,
        <ore:ingotInfinity> * 2,
        <ore:plateChaoticMetal> * 2,
        <avaritiatweaks:enhancement_crystal> * 1,
    ],
    [
        <contenttweaker:industrial_circuit_v4> * 4
    ]
);
HarmonyRecipe(3,6,50,"Harmony",
    [
        <ore:circuitArk> * 1,
        <contenttweaker:industrial_circuit_v4> * 1,
        <ore:stickWillowalloy> * 2,
        <ore:ingotInfinity> * 1,
        <ebwizardry:astral_diamond> * 1,
        <environmentaltech:aethium_crystal>
    ],
    [
        <contenttweaker:sensor_v5> * 2
    ]
);
HarmonyRecipe(4,6,50,"Harmony",
    [
        <contenttweaker:coil_v5> * 2,
        <ore:plateChaoticMetal> * 2,
        <contenttweaker:industrial_circuit_v4> * 1,
        <ore:ingotInfinity> * 1,
    ],
    [
        <contenttweaker:electric_motor_v5>
    ]
);
HarmonyRecipe(5,6,50,"Harmony",
    [
        <contenttweaker:electric_motor_v5> * 2,
        <ore:ingotInfinity> * 1,
        <contenttweaker:industrial_circuit_v4> * 1,
    ],
    [
        <contenttweaker:robot_arm_v5>
    ]
);
HarmonyRecipe(6,12,100,"Harmony",
    [
        <ore:ingotArk> * 8,
        <contenttweaker:arkmachineblock> * 2,
        <contenttweaker:coil_v5> * 12,
        <contenttweaker:field_generator_v4> * 12,
        <contenttweaker:sensor_v5> * 2,
        <contenttweaker:infinity_wire> * 18
    ],
    [
        <contenttweaker:arkforcefieldcontrolblock> * 2
    ]
);
HarmonyRecipe(7,36,750,"Harmony",
    [
        <avaritia:resource:5> * 1,
        <contenttweaker:infinity_processor> * 8,
        <ore:ingotArk> * 2,
        <ore:ingotAlloyT2> * 1,
        <appliedenergistics2:material:47> * 2,
    ],
    [
        <additions:novaextended-ark_circuit> * 8
    ]
);
HarmonyRecipe(8,60,450,"Harmony",
    [
        <ore:ingotGelidEnderium>,
        <ore:ingotAdamant>,
        <ore:ingotChaoticMetal>,
        <ore:ingotTerraAlloy>,
        <ore:ingotInfinity>
    ],
    [
        <additions:novaextended-star_ingot> * 2
    ]
);
HarmonyRecipe(9,6,250,"Harmony",
    [
        <ore:gemCrystalRed>
    ],
    [
        <contenttweaker:crystalpurple>*100
    ]
);
HarmonyRecipe(10,20,240,"Harmony",
    [
        <contenttweaker:kjcl> * 128,
        <additions:novaextended-star_ingot>,
        <contenttweaker:tyf2> * 2
    ],
    [
        <contenttweaker:tyf3> * 2
    ]
);
HarmonyRecipe(11,20,1024,"Harmony",
    [
        <additions:novaextended-ark_circuit>*8,
        <contenttweaker:industrial_circuit_v4>*16,
        <contenttweaker:field_generator_v4>*4,
        <avaritiaio:infinitecapacitor>*2,
        <avaritia:block_resource:1>*8
    ],
    [
        <contenttweaker:max_energy_containers>*4
    ]
);
HarmonyRecipe(12,20,4096,"Harmony",
    [
        <contenttweaker:max_energy_containers>,
        <liquid:liquid_energy>*200000
    ],
    [
        <contenttweaker:charged_max_energy_containers>,
    ]
);
HarmonyRecipe(13,3600,262144,"Inversion",
    [
        <contenttweaker:fragments_of_the_space_time_continuum>*1024,
        <contenttweaker:charged_max_energy_containers>*16,
        <contenttweaker:world_energy_core>*8,
        <contenttweaker:tyf3>*256,
        <contenttweaker:arkforcefieldcontrolblock>*64,
        <additions:novaextended-star_ingot>*64,
        <contenttweaker:processorcluster> * 24,
    ],
    [
        <modularmachinery:inversion_factory_controller>,
    ]
);
HarmonyRecipe(14,400,3600,"Harmony",
    [
        <contenttweaker:arkforcefieldcontrolblock>*8,
        <contenttweaker:tyf3>*16,
        <additions:novaextended-star_ingot>*64,
        <contenttweaker:charged_max_energy_containers>,
    ],
    [
        <contenttweaker:ark_launch_vehicle>*8,
        <contenttweaker:max_energy_containers>
    ]
);
HarmonyRecipe(15,20,131072,"Harmony",
    [
        <contenttweaker:polymer_matter>,
        <contenttweaker:space_time_condensation_block>,
    ],
    [
        <avaritia:block_resource:1>*4096,
    ]
);
HarmonyRecipe(16,3600,4194304,"TruthSeek",
    [
        <contenttweaker:truthmatrix>*1024,
        <contenttweaker:dark_matter>*4096,
        <contenttweaker:polymer_matter>*512,
        <contenttweaker:arkforcefieldcontrolblock>*1024,
        <additions:novaextended-star_ingot>*16384,
        <contenttweaker:ark_launch_vehicle>*128,
        <contenttweaker:charged_max_energy_containers>*4096,
        <contenttweaker:mainframe> * 16
    ],
    [
        <modularmachinery:truthseek_factory_controller>
    ]
);
HarmonyRecipe(17,20,20000,"Harmony",
    [
        <contenttweaker:geocentric_crystal>*16,
        <draconicevolution:chaotic_core>
    ],
    [
        <contenttweaker:geocentric_quartz_crystal>
    ]
);
HarmonyRecipe(18,40,500000,"Harmony",
    [
        <contenttweaker:geocentric_quartz_crystal>*16,
        <contenttweaker:charging_crystal_block>*4,
        <contenttweaker:charged_max_energy_containers>
    ],
    [
        <contenttweaker:geocentric_quartz_crystal_charged>,
        <contenttweaker:max_energy_containers>,
    ]
);
HarmonyRecipe(19,80,30000,"Harmony",
    [
        <contenttweaker:geocentric_quartz_crystal_charged>*16,
        <contenttweaker:polymer_matter>,
    ],
    [
        <contenttweaker:purified_geocentric_quartz_crystal>,
    ]
);
HarmonyRecipe(20,7200,134217728,"Paradox",
    [
        <contenttweaker:infinitycore>,
        <contenttweaker:sunrune>,
        <contenttweaker:starry_orgin>,
        <contenttweaker:charged_max_energy_containers>*64,
        <contenttweaker:purified_geocentric_quartz_crystal>*8,
        <contenttweaker:mainframe> * 64
    ],
    [
        <modularmachinery:paradox_controller>
    ]
);
HarmonyRecipe(21,120,200,"Harmony",
    [
        <additions:novaextended-star_ingot>*4,
        <contenttweaker:arkforcefieldcontrolblock>*2,
        <contenttweaker:field_generator_v4>,
        <contenttweaker:additional_component_3>
    ],
    [
        <contenttweaker:world_energy_core>*2
    ]
);