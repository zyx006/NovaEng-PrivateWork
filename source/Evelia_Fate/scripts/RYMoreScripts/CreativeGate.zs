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

import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.research.ResearchCognitionData;
import novaeng.hypernet.ComputationCenterType;
import novaeng.hypernet.DataProcessorType;
import novaeng.hypernet.upgrade.type.ProcessorModuleGPUType;
import novaeng.hypernet.upgrade.type.ProcessorModuleRAMType;

RecipeBuilder.newBuilder("TranscendentMatterGenerator","workshop",3600)
    .addInputs([
        <avaritiaio:infinitecapacitor>*8,
        <contenttweaker:arkforcefieldcontrolblock>*4,
        <additions:novaextended-crystal4>*2,
        <contenttweaker:world_energy_core>,
        <contenttweaker:field_generator_v4>*4,
        <contenttweaker:antimatter_core>*2,
        <contenttweaker:hypernet_ram_t5>*4,
    ])
    .requireComputationPoint(40000.0F)
    .requireResearch("Creative")
    .addOutput(<modularmachinery:transcendentmattergenerator_factory_controller>)
    .build();
RecipeBuilder.newBuilder("CreativeComputer","workshop",1800)
    .addInputs([
        <modularmachinery:data_processor_t4_factory_controller>,
        <avaritiatweaks:enhancement_crystal>*8,
        <additions:novaextended-ark_circuit>*7,
        <additions:novaextended-extremecircuit>*16,
        <novaeng_core:ecalculator_cell_16384m>*32,
        <additions:novaextended-phocore_2>*20
    ])
    .requireComputationPoint(20000.0F)
    .requireResearch("Creative")
    .addOutput(<modularmachinery:creativecomputer_factory_controller>)
    .build();
RecipeBuilder.newBuilder("StarArray","workshop",1800)
    .addInputs([
        <modularmachinery:computation_center_t3_factory_controller>,
        <additions:novaextended-server_tier_1>*64,
        <avaritiatweaks:infinitato>,
        <contenttweaker:industrial_circuit_v4>*16,
        <contenttweaker:electric_motor_v5>*4,
        <contenttweaker:hypernet_gpu_t3>*8
    ])
    .requireComputationPoint(20000.0F)
    .requireResearch("Creative")
    .addOutput(<modularmachinery:stellarregulatorarray_factory_controller>)
    .build();

HyperNetHelper.proxyMachineForHyperNet("transcendentmattergenerator");
MachineModifier.setMaxThreads("transcendentmattergenerator", 0);
MachineModifier.addCoreThread("transcendentmattergenerator",FactoryRecipeThread.createCoreThread("微缩时空场发生器"));
MachineModifier.addCoreThread("transcendentmattergenerator",FactoryRecipeThread.createCoreThread("创世之境"));
MachineModifier.addCoreThread("transcendentmattergenerator",FactoryRecipeThread.createCoreThread("太初之光"));
MachineModifier.addCoreThread("transcendentmattergenerator",FactoryRecipeThread.createCoreThread("紫晶素生成"));

val maxenerlev as int =141000000;
RecipeBuilder.newBuilder("timespace_field","transcendentmattergenerator",2147483647)
    .addInputs([
        <avaritia:block_resource:1>,
        <contenttweaker:arkforcefieldcontrolblock>*4,
        <contenttweaker:universalforcefieldcontrolblock>*5,
        <avaritiatweaks:enhancement_crystal>*4,
        <avaritiaddons:avaritiaddons_chest:1>
    ])
    .setThreadName("微缩时空场发生器")
    .addRecipeTooltip("以无尽箱子的无穷空间创造出一个稳定持续的时空场")
    .build();
RecipeBuilder.newBuilder("Genesis","transcendentmattergenerator",25000)
    .addInputs([
        <contenttweaker:fwzrlb>,
        <mekanism:antimatterpellet>*4,
        <contenttweaker:antimatter_core>*2,
        <contenttweaker:world_energy_core>,
        <liquid:liquid_energy>*12000
    ])
    .addFluidPerTickInput(<liquid:liquid_energy>*10)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("时空场未建立！");
            return;
        }
    })
    .addRecipeTooltip("在时空场之中充入巨量能量以模拟大爆炸")
    .addOutput(<avaritia:block_resource:1>*4)
    .setThreadName("创世之境")
    .build();
RecipeBuilder.newBuilder("inf7yentr60py_model","workshop",7200)
    .addInputs([
        <modularmachinery:supercritical_phase_shifter_controller>,
        <modularmachinery:cnrc_factory_controller>,
        <contenttweaker:hxs>*256,
        <contenttweaker:soul_core>,
        <contenttweaker:forgotten_core>,
        <draconicevolution:ender_energy_manipulator>*64,
        <minecraft:dragon_egg>*128,
        <extrabotany:silenteternity>
    ])
    .addEnergyPerTickInput(200000000000)
    .requireComputationPoint(400000.0F)
    .requireResearch("Creative")
    .addOutput(<deepmoblearning:data_model_inf7yentr60py>)
    .addRecipeTooltip("在将复杂而大量的物质组合之后，我们沟通上了一位早已消失的前辈")
    .build();

RecipeBuilder.newBuilder("inf7yentr60py_matter","supercritical_phase_shifter",5)
    .addInput(<deepmoblearning:pristine_matter_inf7yentr60py>*16)
    .addOutput(<avaritia:resource:6>).setChance(0.01)
    .addOutput(<additions:novaextended-star_ingot>).setChance(0.01)
    .addOutput(<contenttweaker:crystalred>).setChance(0.15)
    .addOutput(<contenttweaker:crystalgreen>).setChance(0.1)
    .addOutput(<contenttweaker:crystalpurple>).setChance(0.05)
    .addOutput(<eternalsingularity:eternal_singularity>*2).setChance(0.2)
    .addOutput(<avaritia:resource:1>*32).setChance(0.4)
    .addOutput(<avaritia:resource:4>*16).setChance(0.3)
    .addOutput(<contenttweaker:hxs>*48).setChance(0.9)
    .addRecipeTooltip("在难以直接涉足的空间之中，有着数之不尽的宝藏")
    .addRecipeTooltip("得益于某位前辈的引导，我们能够将之采掘出来")
    .addEnergyPerTickInput(100000)
    .build();
mods.extendedcrafting
    .CompressionCrafting
    .addRecipe(
        <botania_tweaks:compressed_tiny_potato_8>,
        <deepmoblearning:pristine_matter_inf7yentr60py>,6561,
        <contenttweaker:antimatter_core>,0
    );
RecipeBuilder.newBuilder("EnergyLiquefy","transcendentmattergenerator",1000)
    .addInputs([
        <contenttweaker:world_energy_core>,
        <avaritiatweaks:infinitato>,
        <contenttweaker:hxsrlb>*8,
        <contenttweaker:universalforcefieldcontrolblock>,
    ])
    .addCatalystInput(<botania_tweaks:compressed_tiny_potato_8>,
        ["神奇的超大土豆，似乎蕴含着奇怪的东西？","可发电时间变为原来的2倍，发电量变为原来的3倍"],
        [RecipeModifierBuilder.create("modularmachinery:duration","input",2.0f,1,false).build(),
        RecipeModifierBuilder.create("modularmachinery:fluid","output",3.0f,1,false).build()]
    ).setChance(0)
    .addCatalystInput(<contenttweaker:world_energy_core>*4,
        ["一切能量最本源的所在，有着不可思议的力量","可发电时间变为原本的1.5倍，发电量变为原来的2倍"],
        [RecipeModifierBuilder.create("modularmachinery:duration","input",1.5f,1,false).build(),
        RecipeModifierBuilder.create("modularmachinery:fluid","output",2.0f,1,false).build()]
    ).setChance(0)
    .addCatalystInput(<modularmachinery:ark_auxiliary_warehouse_controller>,
        ["蕴含着微量的方舟之力，可以提高一些发电量","发电量变为原来的1.5倍"],
        [RecipeModifierBuilder.create("modularmachinery:fluid","output",1.5f,1,false).build()]
    ).setChance(0)
    .addCatalystInput(<appliedenergistics2:creative_energy_cell>,
        ["蕴含着中等含量的方舟之力，大幅提升发电时间","可发电时间变为原来的2倍"],
        [RecipeModifierBuilder.create("modularmachinery:duration","input",2.0f,1,false).build()]
    ).setChance(0)
    .addCatalystInput(<modularmachinery:starburst_reactor_controller>,
        ["蕴含着极巨量的方舟之力，大幅度提升发电量","发电量变为原来的2倍"],
        [RecipeModifierBuilder.create("modularmachinery:fluid","output",2.0f,1,false).build()]
    ).setChance(0)
    .addCatalystInput(<modularmachinery:ultra_zero_point_vacuum_displacer_controller>,
        ["真空并不空虚，借助于深邃玄微的科技，我们从中获得了庞大的能量","可发电时间变为原来的9倍，发电量变为原来的4倍"],
        [RecipeModifierBuilder.create("modularmachinery:duration","input",9.0f,1,false).build(),
        RecipeModifierBuilder.create("modularmachinery:fluid","output",4.0f,1,false).build()]
    ).setChance(0)
    .addCatalystInput(<deepmoblearning:data_model_inf7yentr60py>.withTag({tier: 4}),
        ["实验室某位传奇前辈给我们留下的遗产，有着近乎创世之神的力量","可发电时间变为原来的8倍，发电量变为原来的8倍"],
        [RecipeModifierBuilder.create("modularmachinery:duration","input",8.0f,1,false).build(),
        RecipeModifierBuilder.create("modularmachinery:fluid","output",8.0f,1,false).build()]
    ).setChance(0)
    .addCatalystInput(<modularmachinery:xihe_star_creation_device_controller>,
        ["我们洞见了星神的伟力，并将之复现","发电量变为原来的3倍"],
        [RecipeModifierBuilder.create("modularmachinery:fluid","output",3.0f,1,false).build()]
    ).setChance(0)
    .addCatalystInput(<modularmachinery:light-speed_material_accelerator_factory_controller>,
        ["光速曾长久地阻碍着我们的前进，而现在，前方一片坦途","可发电时间变为原来的3倍，发电量变为原来的5倍"],
        [RecipeModifierBuilder.create("modularmachinery:duration","input",3.0f,1,false).build(),
        RecipeModifierBuilder.create("modularmachinery:fluid","output",5.0f,1,false).build()]
    ).setChance(0)
    .addCatalystInput(<psicosts:creative_cell>,
        ["无穷无尽的ψ能量！你可以随意地挥霍它","可发电时间变为原来的2倍，发电量变为原来的2倍"],
        [RecipeModifierBuilder.create("modularmachinery:duration","input",2.0f,1,false).build(),
        RecipeModifierBuilder.create("modularmachinery:fluid","output",2.0f,1,false).build()]
    ).setChance(0)
    .addCatalystInput(<bloodmagic:sacrificial_dagger:1>,
        ["血液是从哪里来的？有趣的问题","可发电时间变为原来的4倍，发电量变为原来的4倍"],
        [RecipeModifierBuilder.create("modularmachinery:duration","input",4.0f,1,false).build(),
        RecipeModifierBuilder.create("modularmachinery:fluid","output",4.0f,1,false).build()]
    ).setChance(0)
    .addCatalystInput(<modularmachinery:melonfusion_controller>,
        ["这是神明吗？毫无疑问","可发电时间变为原来的5倍，发电量变为原来的10倍"],
        [RecipeModifierBuilder.create("modularmachinery:duration","input",5.0f,1,false).build(),
        RecipeModifierBuilder.create("modularmachinery:fluid","output",10.0f,1,false).build()]
    ).setChance(0)
    .addFluidPerTickOutput(<liquid:liquid_energy>)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[1].activeRecipe)){
            event.setFailed("时空场未充能！");
            return;
        }
    })
    .addRecipeTooltip("在创世之初的辉光中，物质震荡的幅度被统一力无限放大")
    .addRecipeTooltip("拥有难以想象的能量产出效率")
    .addRecipeTooltip("需要已经充能的时空场")
    .setThreadName("太初之光")
    .build();
function crystal(circuit as IItemStack,name as string,number as int,energycost as int){
    RecipeBuilder.newBuilder("pro_circuit"+name,"transcendentmattergenerator",1)
        .addInput(circuit).setChance(0)
        .addInput(<contenttweaker:life_regeneration_core>).setChance(0)
        .addFluidPerTickInput(<liquid:liquid_energy>*energycost)
        .requireComputationPoint(100.0F*number)
        .addPreCheckHandler(function(event as RecipeCheckEvent){
                if(isNull(event.controller.recipeThreadList[1].activeRecipe)){
                event.setFailed("时空场未充能！");
                return;
            }
        })
        .addFluidPerTickOutput(<liquid:crystalloid>*number)
        .addRecipeTooltip("可以通过编程电路决定紫晶素产出量")
        .setThreadName("紫晶素生成")
        .build();
}
crystal(<contenttweaker:programming_circuit_0>,0,10,1);
crystal(<contenttweaker:programming_circuit_a>,1,50,5);
crystal(<contenttweaker:programming_circuit_b>,2,100,10);
crystal(<contenttweaker:programming_circuit_c>,3,500,50);
crystal(<contenttweaker:programming_circuit_d>,4,1000,100);
crystal(<contenttweaker:programming_circuit_e>,5,2000,200);

HyperNetHelper.proxyMachineForHyperNet("stellarregulatorarray");
HyperNetHelper.proxyMachineForHyperNet("creativecomputer");
MachineModifier.setMaxThreads("stellarregulatorarray",0);
MachineModifier.setMaxThreads("CreativeComputer",0);
RegistryHyperNet.addComputationCenter("stellarregulatorarray");

RecipeBuilder.newBuilder("fake_creative_ram","star_collapser",7200)
    .addInputs([
        <additions:novaextended-ark_circuit>*8,
        <additions:novaextended-crystal4>*4,
        <novaeng_core:ecalculator_cell_16384m>*16,
    ])
    .addEnergyPerTickInput(20000000000)
    .addInput(<contenttweaker:universalforcefieldcontrolblock>).setChance(0.2)
    .requireComputationPoint(75000.0F)
    .requireResearch("Creative")
    .addOutput(<mekanism:controlcircuit:4>)
    .build();
RecipeBuilder.newBuilder("fake_creative_gpu","star_collapser",7200)
    .addInputs([
        <mekanism:controlcircuit:3>*1024,
        <mekanism:atomicalloy>*4096,
        <additions:novaextended-extremecircuit>*4,
        <additions:novaextended-ark_circuit>*2,
    ])
    .addEnergyPerTickInput(150000000000)
    .requireComputationPoint(64000.0F)
    .requireResearch("Creative")
    .addOutput(<mekanism:cosmicalloy>)
    .build();

MachineUpgradeHelper.registerSupportedItem(<mekanism:cosmicalloy>);
ProcessorModuleGPUType.createGPUType(20000,40000,50*1000*1000,900000.0F)
    .register("fake_creative_gpu","赝造创造处理器",11.9F);
MachineUpgradeHelper.addFixedUpgrade(<mekanism:cosmicalloy>, "fake_creative_gpu");

MachineUpgradeHelper.registerSupportedItem(<mekanism:controlcircuit:4>);
ProcessorModuleRAMType.create(30000,100000,50*1000*100,1000000.0F)
    .register("fake_creative_ram","赝造创造内存",11.9F);
MachineUpgradeHelper.addFixedUpgrade(<mekanism:controlcircuit:4>, "fake_creative_ram");

RegistryHyperNet.addComputationCenterType(ComputationCenterType.create("stellarregulatorarray", 150 * 1000 * 1000,
        // 最大连接数 单次最大算力支持 电路板耐久 最低电路板耐久消耗 最高电路板耐久消耗 电路板耐久消耗概率
        960,        9220000,        4000000,   200,            800,             0.02F)
        .addFixIngredient(1000, <contenttweaker:industrial_circuit_v1>)
        .addFixIngredient(4000, <contenttweaker:industrial_circuit_v2>)
        .addFixIngredient(150000, <contenttweaker:industrial_circuit_v3>)
        .addFixIngredient(3700000,<contenttweaker:industrial_circuit_v4>)
);
                                                                                    // *基础*能量消耗
RegistryHyperNet.addDataProcessorType(DataProcessorType.create("creativecomputer", 200 * 1000 * 1000,
        // 热量散发量 过热阈值
        440000,      2000000000)
        .addRadiatorIngredient(18000000, [<liquid:crystalloid> * 50], [<liquid:liquid_energy> * 1])
);