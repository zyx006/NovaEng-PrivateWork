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
import mods.modularmachinery.FactoryRecipeStartEvent;
import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.MachineTickEvent;
import mods.modularmachinery.SmartInterfaceType;

import crafttweaker.item.IItemStack;

import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.research.ResearchCognitionData;

RecipeBuilder.newBuilder("spacetime_continuum","light-speed_material_accelerator",3600)
    .addEnergyPerTickInput(2000000000000)
    .addInputs([
        <contenttweaker:sensor_v5>*8,
        <minecraft:melon_block>*64
    ])
    .requireComputationPoint(600000.0F)
    .requireResearch("spacetime")
    .addOutput(<contenttweaker:fragments_of_the_space_time_continuum>*1)
    .build();

RecipeBuilder.newBuilder("spacetime_block","light-speed_material_accelerator",360)
    .addEnergyPerTickInput(2000000000000)
    .requireComputationPoint(200000)
    .requireResearch("spacetime")
    .addInputs(<contenttweaker:arkforcefieldcontrolblock>*8).setChance(0)
    .addInputs([
        <avaritia:resource:6>*8,
        <eternalsingularity:eternal_singularity>,
        <contenttweaker:fragments_of_the_space_time_continuum>
    ])
    .addOutput(<contenttweaker:space_time_condensation_block>*1)
    .addOutput(<contenttweaker:fragments_of_the_space_time_continuum>*8)
    .build();


RecipeBuilder.newBuilder("gointo_singularity","light-speed_material_accelerator",20000)
    .addInputs([
        <contenttweaker:space_time_condensation_block>*8,
        <contenttweaker:fragments_of_the_space_time_continuum>*64,
        <contenttweaker:arkforcefieldcontrolblock>*32,
        <additions:novaextended-star_ingot>*48,
        <draconicevolution:reactor_component>*16,
        <draconicevolution:reactor_component:1>*4,
        <modularmachinery:data_processor_t4_factory_controller>,
        <modularmachinery:computation_center_t3_factory_controller>,
        <contenttweaker:processor> * 14
    ])
    .addEnergyPerTickInput(200000000000)
    .addOutput(<modularmachinery:horizonprobes_factory_controller>)
    .requireComputationPoint(30000.0F)
    .requireResearch("HorizonProbes")
    .build();
<contenttweaker:alpha_matter>.addTooltip("从奇点之中获得的奇异物质，对未来的发展有着至关重要的作用");

MachineModifier.setMaxThreads("HorizonProbes",0);
MachineModifier.addCoreThread("HorizonProbes",FactoryRecipeThread.createCoreThread("视界探针控制器").addRecipe("HorizonProbes_state"));
MachineModifier.addCoreThread("HorizonProbes",FactoryRecipeThread.createCoreThread("奇点状态监测器").addRecipe("singularity_state"));
MachineModifier.addCoreThread("HorizonProbes",FactoryRecipeThread.createCoreThread("物质操纵器").addRecipe("eternal_singularity_control"));
MachineModifier.addCoreThread("HorizonProbes",FactoryRecipeThread.createCoreThread("真理计算机").addRecipe("eternal_singularity_detection"));

HyperNetHelper.proxyMachineForHyperNet("HorizonProbes");

//主线程，探针控制器
RecipeBuilder.newBuilder("HorizonProbes_state","HorizonProbes",2147483647)
    .requireComputationPoint(10000.0F)
    .setThreadName("视界探针控制器")
    .addInputs(<avaritia:block_resource>*99)
    .addInputs(<avaritia:block_resource:1>)
    .addRecipeTooltip([
        "通过将极巨量的极限密度物质聚合，以无尽之力作为核心稳定",
        "在精密的控制之下，我们获得了可以用于研究的稳定黑洞",
        "相较于时空科技的部分，这些算力足以忽略不计"
    ])
    .build();
//副线程，可以产出时空碎片和块
RecipeBuilder.newBuilder("singularity_state","HorizonProbes",200)
    .addInputs(<liquid:crystalloid>*256000)
    .addCatalystInput(<ore:ingotInfinity>*16,
    ["在物质活化之前加入无尽之锭可以使奇点更加活跃,更容易粉碎空间,产出翻倍"],
    [RecipeModifierBuilder.create("modularmachinery:item","output",2,1,false).build()]).setChance(1)
    .addOutputs([
        <contenttweaker:space_time_condensation_block>*80,
        <contenttweaker:fragments_of_the_space_time_continuum>*640
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚不存在稳定黑洞");
            return;
        }
    })
    .addRecipeTooltip([
        "借助于紫晶素的神秘力量，奇点得以被进一步稳定",
        "现在可以更加高效地获得时空碎片"
    ])
    .setThreadName("奇点状态监测器")
    .build();
//发电线程，产出一些时空碎片和中子素块
RecipeBuilder.newBuilder("eternal_singularity_control","HorizonProbes",4000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚不存在稳定黑洞");
            return;
        }
    })
    .addInput(<eternalsingularity:eternal_singularity>)
    .addEnergyPerTickOutput(10000000000000)
    .addRecipeTooltip("质能转换")
    .setThreadName("物质操纵器")
    .addOutputs([
        <avaritia:block_resource>*640,
        <contenttweaker:fragments_of_the_space_time_continuum>*1280
    ])
    .build();


//生产线程，能够产出一些真理矩阵
RecipeBuilder.newBuilder("eternal_singularity_detection","HorizonProbes",400)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚不存在稳定黑洞");
            return;
        }
    })
    .addInputs([
        <contenttweaker:world_energy_core>,
        <avaritiatweaks:infinitato>*4
    ])
    .addEnergyPerTickOutput(6000000000000)
    .addRecipeTooltip("奇点探测")
    .setThreadName("真理计算机")
    .addOutputs(<contenttweaker:alpha_matter>*2).setChance(0.2)
    .addOutputs(<contenttweaker:alpha_matter>*4).setChance(0.1)
    .addOutputs(<contenttweaker:alpha_matter>*8).setChance(0.05)
    .addOutputs(<contenttweaker:alpha_matter>*16).setChance(0.01)
    .addOutputs(<contenttweaker:fragments_of_the_space_time_continuum>*64)
    .build();