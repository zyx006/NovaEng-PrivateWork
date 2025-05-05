
#loader crafttweaker reloadable

import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.MachineBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.MMEvents;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.RecipeStartEvent;
import mods.modularmachinery.RecipeTickEvent;
import mods.modularmachinery.RecipeFinishEvent;
import mods.modularmachinery.ControllerGUIRenderEvent;
import mods.modularmachinery.FactoryRecipeStartEvent;
import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.MachineTickEvent;
import mods.modularmachinery.SmartInterfaceType;
import mods.modularmachinery.MachineUpgradeHelper;

import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;

import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.research.ResearchCognitionData;
import novaeng.hypernet.ComputationCenterType;
import novaeng.hypernet.DataProcessorType;
import novaeng.hypernet.upgrade.type.ProcessorModuleGPUType;
import novaeng.hypernet.upgrade.type.ProcessorModuleRAMType;

RecipeBuilder.newBuilder("Circuit_Con","workshop",7200)
    .addInputs([
        <modularmachinery:universalassembly_factory_controller>,
        <contenttweaker:universalforcefieldcontrolblock>*6,
        <contenttweaker:hypernet_ram_t5>*4,
        <contenttweaker:hypernet_gpu_t3>*8,
    ])
    .addOutput(<modularmachinery:circuitassembly_factory_controller>)
    .requireResearch("CircuitAssembly")
    .requireComputationPoint(1000.0F)
    .build();

<contenttweaker:integratedcircuit>.addTooltip("§6工业化批量产出的cpu原料，融合了§4生命§6与§e光芒§6的力量");
<contenttweaker:integratedcircuit>.addTooltip("§6可以用来高效制作2级gpu与3级和4级的cpu与内存");
<contenttweaker:quantumchip>.addTooltip("§3精雕细琢之下产出的强大集成电路，有着控制量子跃迁的力量");
<contenttweaker:quantumchip>.addTooltip("§3可以用来高效制作5级内存和3级gpu");

MMEvents.onControllerGUIRender("circuitassembly",function(event as ControllerGUIRenderEvent){
    val ctrl = event.controller;
    val world = ctrl.world;
    val data = ctrl.customData;
    val dData = D(data);
    val num = dData.getInt("num",0);
    val nowlev = dData.getInt("lev",0);
    var info as string[] = [];
    info += "—————§c装配线§d监测器§r—————";
    info += "当前线圈等级：" + nowlev;
    info += "额外点数：" + num;
    event.extraInfo = info;
});

HyperNetHelper.proxyMachineForHyperNet("circuitassembly");
AddEnergyMachine("circuitassembly");
MachineModifier.setMaxThreads("circuitassembly",0);
MachineModifier.addCoreThread("circuitassembly",FactoryRecipeThread.createCoreThread("线圈处理").addRecipe("Coil1").addRecipe("Coil2").addRecipe("Coil3").addRecipe("RemoveCoil"));
for i in 1 to 17{
    MachineModifier.addCoreThread("circuitassembly",FactoryRecipeThread.createCoreThread("算力元件装配"+i)); 
}

function CoilMount(lev as int,input as IIngredient[]){
    val CoEnergy = pow(1000,lev) as long;
    RecipeBuilder.newBuilder("Coil"+lev,"circuitassembly",20)
        .addInputs(input)
        .addPreCheckHandler(function(event as RecipeCheckEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val nowlev = dData.getInt("lev",0);
            if((nowlev != 0)&&(lev != nowlev)){
                event.setFailed("已经存在不同线圈!");
            }
        })
        .addFactoryPreTickHandler(function(event as FactoryRecipeTickEvent){
            if(CostEnergy(event,0,CoEnergy)){
                event.preventProgressing("电量不足！");
            }
        })
        .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val num = dData.getInt("num",0);
            val nowlev = dData.getInt("lev",0);
            val map = data.asMap();
            if(nowlev == 0){
                map["lev"] = lev;
                ctrl.customData = data;
            }
            if(nowlev == 2){
                map["num"] = num + 1;
                ctrl.customData = data;
            }
            if(nowlev == 3){
                map["num"] = num + 3;
                ctrl.customData = data;
            }
        })
        .addRecipeTooltip("为机器安装"+lev+"级线圈","需要不存在其余种类的线圈","每tick消耗电网中"+formatNumberU(0,CoEnergy)+"RF")
        .setThreadName("线圈处理")
        .build();
}
CoilMount(1,[<contenttweaker:fixed_star_alloys_coil>*16]);
CoilMount(2,[<contenttweaker:infinite_coil>*16]);
CoilMount(3,[<contenttweaker:space_time_coil>*16]);

RecipeBuilder.newBuilder("RemoveCoil","circuitassembly",20)
    .addInput(<contenttweaker:programming_circuit_0>)
    .addOutput(<minecraft:stone>)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val nowlev = dData.getInt("lev",0);
        if(nowlev == 0){
            event.setFailed("还不存在可供拆解的线圈！");
        }
    })
    .addItemModifier(function(ctrl as IMachineController, oldItem as IItemStack) as IItemStack{
        val data = ctrl.customData;
        val dData = D(data);
        val nowlev = dData.getInt("lev",0);
        val num = dData.getInt("num",0);
        var relnum as int = 1;
        var backitem as IItemStack = <minecraft:stone>;
        if(nowlev == 1){
            relnum = 16;
        }else if(nowlev == 2){
            relnum = 16 * (num + 1);
        }else if(nowlev == 3){
            relnum = 16 * (1 + num/3) as int;
        }
        return backitem = getCoil(nowlev,relnum);
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        map["lev"] = 0;
        map["num"] = 0;
        ctrl.customData = data;
    })
    .addRecipeTooltip("会拆除所有的线圈","此产物仅供参考")
    .setThreadName("线圈处理")
    .build();
function getCoil(lev as int,num as int) as IItemStack{
    var backitem as IItemStack = <minecraft:stone>;
    if(lev == 1){
        backitem = <contenttweaker:fixed_star_alloys_coil> * num;
    }else if(lev == 2){
        backitem = <contenttweaker:infinite_coil> * num;
    }else if(lev == 3){
        backitem = <contenttweaker:space_time_coil> * num;
    }
    return backitem;
}
function CArecipe(needlev as int,ComReq as int,name as int,time as int,ener as long,input as IIngredient[],output as IIngredient[]){
    val baseComreq = 50.0F;
    val basetime = 1800;
    val relener = ener * pow(1000,needlev);
    var relComreq as float = (ComReq * baseComreq) as float;
    var reltime as int = basetime * time; 
    RecipeBuilder.newBuilder("weird"+name,"circuitassembly",reltime)
        .addInputs(input)
        .addOutputs(output)
        .addPreCheckHandler(function(event as RecipeCheckEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val lev = dData.getInt("lev",0);
            val num = dData.getInt("num",0);
            var timemagn as float = 1.0F;
            if(lev >= needlev){
                val rankgap as int = (num + lev) - needlev;
                timemagn= expo(0.8,rankgap);
            }
            if(lev < needlev){
                event.setFailed("线圈等级尚不足够！");
            }
            ctrl.addModifier("CAstart", RecipeModifierBuilder.create("modularmachinery:duration", "input", timemagn, 1, false).build());
        })
        .addFactoryPreTickHandler(function(event as FactoryRecipeTickEvent){
            if(!CostEnergy(event,0,relener)){
                event.preventProgressing("电量不足！");
            }
        })
        .addRecipeTooltip("需要"+needlev+"级线圈","每tick消耗电网中"+formatNumberU(0,relener)+"RF")
        .requireComputationPoint(relComreq)
        .build();
}

CArecipe(1,3,1,2,100,
    [
        <draconicevolution:mob_soul>*8,
        <astralsorcery:itemusabledust>*256,
        <enderio:item_material:42>*4,
        <liquid:lifeessence>*65536,
        <contenttweaker:lifesense_processor>*4,
        <contenttweaker:exponential_level_processor>,
        <contenttweaker:circuit_boards> * 4,
    ],
    [
    <contenttweaker:integratedcircuit>*4,
    ]
);
CArecipe(1,5,2,2,100,
    [
        <contenttweaker:sensor_v5>,
        <contenttweaker:field_generator_v4>,
        <contenttweaker:industrial_circuit_v4>*2,
        <additions:novaextended-ark_circuit>*4,
        <appliedenergistics2:material:47>*16,
        <contenttweaker:infinity_processor>*2,
        <liquid:crystalloid>*8192,
        <liquid:infinity_metal>*64,
        <contenttweaker:refine_circuit_boards> * 4
    ],
    [
    <contenttweaker:quantumchip>*16
    ]
);
CArecipe(1,2,3,1,200,
    [
        <ic2:advanced_heat_vent>*16,
        <contenttweaker:integratedcircuit>,
        <gas:nutrientsolution>*16384
    ],
    [
    <contenttweaker:hypernet_cpu_t3>*4
    ]
);
CArecipe(1,3,4,1,200,
    [
        <appliedenergistics2:material:22>*256,
        <threng:material:14>*8,
        <ic2:advanced_heat_vent>*16,
        <liquid:gold>*82994,
        <contenttweaker:integratedcircuit>,
    ],
    [
    <contenttweaker:hypernet_ram_t3>*4
    ]
);
CArecipe(2,1,5,2,250,
    [
        <mets:advanced_oc_heat_vent>*4,
        <mets:advanced_heat_vent>*4,
        <contenttweaker:integratedcircuit>,
        <contenttweaker:hypernet_ram_t3>,
        <contenttweaker:hypernet_cpu_t3>,
    ],
    [
    <contenttweaker:hypernet_gpu_t2>
    ]
);
CArecipe(2,20,6,2,50,
    [
        <mets:advanced_heat_vent>*16,
        <liquid:gold>*82994,
        <contenttweaker:integratedcircuit>,
        <contenttweaker:sensor_v3>*2
    ],
    [
    <contenttweaker:hypernet_cpu_t4>*2
    ]
);
CArecipe(2,20,7,2,50,
    [
        <contenttweaker:integratedcircuit>,
        <mets:advanced_heat_vent>*16,
        <appliedenergistics2:material:22>*512,
        <liquid:gold>*124416,
        <threng:material:6>*8,
    ],
    [
    <contenttweaker:hypernet_ram_t4>*2
    ]
);
CArecipe(2,40,8,3,150,
    [
        <contenttweaker:infinity_processor>*2,
        <contenttweaker:quantumchip>*4,
        <mets:advanced_heat_vent>*64,
        <liquid:gold>*165988
    ],
    [
    <contenttweaker:hypernet_ram_t5>*2
    ]
);
CArecipe(2,30,9,4,150,
    [
        <contenttweaker:sensor_v4>*2,
        <contenttweaker:quantumchip>*6,
        <contenttweaker:crystalgreen>
    ],
    [
    <contenttweaker:hypernet_gpu_t3>
    ]
);
CArecipe(2,4000,10,10,1500,
    [
        <additions:novaextended-ark_circuit>*8,
        <additions:novaextended-crystal4>*4,
        <novaeng_core:ecalculator_cell_16384m>*16,
    ],
    [
        <mekanism:controlcircuit:4>
    ]
);
CArecipe(2,3500,11,8,1500,
    [
        <mekanism:controlcircuit:3>*1024,
        <mekanism:atomicalloy>*4096,
        <additions:novaextended-extremecircuit>*4,
        <additions:novaextended-ark_circuit>*2,
    ],
    [
        <mekanism:cosmicalloy>
    ]
);
CArecipe(1,50,12,4,750,
    [
        <contenttweaker:hypernet_gpu_t3>*16,
        <contenttweaker:hypernet_ram_t5>*14,
        <contenttweaker:infinity_wire>*32,
        <avaritiaio:infinitecapacitor>*8,
        <contenttweaker:integratedcircuit>*128,
        <contenttweaker:refine_circuit_boards> * 4
    ],
    [
        <contenttweaker:processor>*2
    ]
);
CArecipe(2,200,13,10,625,
    [
        <contenttweaker:processor>*4,
        <contenttweaker:arkforcefieldcontrolblock>*2,
        <additions:novaextended-star_ingot>*8,
        <mekanism:cosmicmatter>,
        <contenttweaker:quantumchip>*64,
        <contenttweaker:alpha_matter>*4 ,
        <contenttweaker:overcircuit> * 2
    ],
    [
        <contenttweaker:assembly>*2
    ]
);
CArecipe(3,900,14,15,2250,
    [
        <contenttweaker:assembly>*4,
        <contenttweaker:rado_circuit> * 4,
        <contenttweaker:hypernet_ram_max>,
        <contenttweaker:hypernet_gpu_max>,
        <contenttweaker:fragments_of_the_space_time_continuum>*24,
        <contenttweaker:beta_matter> * 16,
    ],
    [
        <contenttweaker:processorcluster> * 2
    ]
);
CArecipe(3,1800,15,45,45000,
    [
        <contenttweaker:processorcluster> * 2,
        <mekanism:controlcircuit:4> * 6,
        <mekanism:cosmicalloy> * 8,
        <liquid:radox> * 5120,
        <liquid:space_time_fluids> * 1280,
        <contenttweaker:space_time_coil> * 8,
        <contenttweaker:space_time_condensation_block> * 64,
        <contenttweaker:polymer_matter>
    ],
    [
        <contenttweaker:mainframe>
    ]
);
CArecipe(2,150,16,9,1500,
    [
        <contenttweaker:infinite_coil> * 4,
        <contenttweaker:fragments_of_the_space_time_continuum> * 64,
        <contenttweaker:world_energy_core>,
        <contenttweaker:assembly>,
        <contenttweaker:industrial_circuit_v4> * 4,
        <contenttweaker:arkforcefieldcontrolblock> * 4
    ],
    [
        <contenttweaker:space_time_coil>
    ]
);

MachineUpgradeHelper.registerSupportedItem(<contenttweaker:processor>);
ProcessorModuleRAMType.create(2147483646,2147483647,5*1000*1000,50000.0F)
    .register("strange_processor_ram","奇异处理器",11.9F);
ProcessorModuleGPUType.createGPUType(2147483646,   2147483647,  5 * 1000 * 1000, 50000.0F).register(
        "strange_processor", "奇异处理器", 11.9F
);
MachineUpgradeHelper.addFixedUpgrade(<contenttweaker:processor>, "strange_processor");
MachineUpgradeHelper.addFixedUpgrade(<contenttweaker:processor>, "strange_processor_ram");

MachineUpgradeHelper.registerSupportedItem(<contenttweaker:rado_circuit>);
ProcessorModuleRAMType.create(2147483646,2147483647,30*1000*1000,300000.0F)
    .register("rado_circuit","拉多集成电路",11.9F);
MachineUpgradeHelper.addFixedUpgrade(<contenttweaker:rado_circuit>, "rado_circuit");

MachineUpgradeHelper.registerSupportedItem(<contenttweaker:assembly>);
ProcessorModuleRAMType.create(2147483646,2147483647,40*1000*1000,400000.0F)
    .register("strange_assembly_ram","奇异集成电路",11.9F);
ProcessorModuleGPUType.createGPUType(2147483646,   2147483647,  40 * 1000 * 1000, 700000.0F).register(
        "strange_assembly", "奇异集成电路", 11.9F
);
MachineUpgradeHelper.addFixedUpgrade(<contenttweaker:assembly>, "strange_assembly");
MachineUpgradeHelper.addFixedUpgrade(<contenttweaker:assembly>, "strange_assembly_ram");

MachineUpgradeHelper.registerSupportedItem(<contenttweaker:processorcluster>);
ProcessorModuleRAMType.create(2147483646,2147483647,280*1000*1000,2800000.0F)
    .register("strange_processorcluster_ram","奇异电路集群",11.9F);
ProcessorModuleGPUType.createGPUType(2147483646,   2147483647,  280 * 1000 * 1000, 2800000.0F).register(
        "strange_processorcluster", "奇异电路集群", 11.9F
);
MachineUpgradeHelper.addFixedUpgrade(<contenttweaker:processorcluster>, "strange_processorcluster");
MachineUpgradeHelper.addFixedUpgrade(<contenttweaker:processorcluster>, "strange_processorcluster_ram");

MachineUpgradeHelper.registerSupportedItem(<contenttweaker:mainframe>);
ProcessorModuleRAMType.create(2147483646,2147483647,920*1000*1000,9220000.0F)
    .register("strange_mainframe_ram","奇异主机",11.9F);
ProcessorModuleGPUType.createGPUType(2147483646,   2147483647,  922 * 1000 * 1000, 9220000.0F).register(
        "strange_mainframe", "奇异主机", 11.9F
);
MachineUpgradeHelper.addFixedUpgrade(<contenttweaker:mainframe>, "strange_mainframe");
MachineUpgradeHelper.addFixedUpgrade(<contenttweaker:mainframe>, "strange_mainframe_ram");

function expo(base as float,index as int) as float{
    var answer as float = base;
    for i in 1 to index{
        answer = answer * base;
    }
    return answer;
}