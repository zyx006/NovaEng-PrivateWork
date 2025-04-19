import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.MachineBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.RecipeModifierBuilder;

import crafttweaker.item.IItemStack;

import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.research.ResearchCognitionData;

val SuanLiBeiLv=0.5F;
val ShiJianBeiLv=0.4F;

HyperNetHelper.proxyMachineForHyperNet("UniversalAssembly");
MachineModifier.setInternalParallelism("UniversalAssembly",8);
MachineModifier.addCoreThread("UniversalAssembly",FactoryRecipeThread.createCoreThread("力场控制计算机").addRecipe("start"));
MachineModifier.setMaxThreads("UniversalAssembly", 0);
for i in 1 to 17{
        MachineModifier.addCoreThread("UniversalAssembly", FactoryRecipeThread.createCoreThread("物质输入口#" + i));
    }

<modularmachinery:universalassembly_factory_controller>.addTooltip("可以执行工业机械臂、高级元件装配室、集成式处理车间配方，耗时为1/10");
RecipeBuilder.newBuilder("UniversalAssembly_MAKE","workshop",3600,40)
    .addEnergyPerTickInput(4000000000)
    .addInputs([
        <modularmachinery:acar_factory_controller>*8,
        <modularmachinery:assembly_line_factory_controller>*8,
        <contenttweaker:exponential_level_processor>*16,
        <contenttweaker:infinity_processor>*4,
        <contenttweaker:field_generator_v3>*20,
        <avaritiatweaks:enhancement_crystal>,
    ])
    .requireResearch("UniversalAssembly_res")
    .requireComputationPoint(20000.0F)
    .addOutput(<modularmachinery:universalassembly_factory_controller>*1)
    .build();

<modularmachinery:universalassembly_factory_controller>.addTooltip("工程技术的本质，便是以我们的意志塑造这个世界");

RecipeAdapterBuilder.create("UniversalAssembly","modularmachinery:acar")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", ShiJianBeiLv, 1, false).build())
    .build();
RecipeAdapterBuilder.create("UniversalAssembly","modularmachinery:machine_arm")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", ShiJianBeiLv, 1, false).build())
    .build();
RecipeAdapterBuilder.create("UniversalAssembly","modularmachinery:workshop")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", ShiJianBeiLv, 1, false).build())
    .build();

RecipeBuilder.newBuilder("start","UniversalAssembly",2000)
    .requireComputationPoint(20000.0F)
    .addOutput(<avaritia:block_resource>)
    .setThreadName("力场控制计算机")
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism=1;
    })
    .addRecipeTooltip("强大的力场将空气中物质的电子压入了原子核")
    .build();

RecipeBuilder.newBuilder("infinity_catalyst_uni","UniversalAssembly",20)
    .addEnergyPerTickInput(30000)
    .addInputs([
        <contenttweaker:field_generator_v1>*2,
        <minecraft:nether_star>*2,
        <minecraft:ender_eye>*2,
        <avaritia:resource:4>*22,
        <tconevo:metal:5>,
        <enderio:item_material:15>*256,
        <avaritia:resource:1>*26,
        <contenttweaker:crystalpurple>*2,
        <contenttweaker:universalalloyt2>*2,
        <redstonerepository:storage>,
        <eternalsingularity:eternal_singularity>*4,
        <redstonerepository:storage:1>
    ])
    .addRecipeTooltip("无尽的力量")
    .requireComputationPoint(50.0F)
    .addOutput(<avaritia:resource:5>*8)
    .build();