
#priority 10
#loader crafttweaker reloadable

import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.MachineBuilder;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.MultiblockModifierBuilder;
import mods.modularmachinery.BlockArrayBuilder;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.RecipeCheckEvent;

import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.RecipeTickEvent;
import mods.modularmachinery.Sync;

import crafttweaker.world.IBlockPos;
import crafttweaker.world.IWorld;
import crafttweaker.item.IItemStack;
import crafttweaker.data.IData;
import crafttweaker.item.IIngredient;
import crafttweaker.oredict.IOreDictEntry;
import crafttweaker.liquid.ILiquidStack;
import crafttweaker.item.WeightedItemStack;
import mod.mekanism.gas.IGasStack;
import mods.astralsorcery.Altar;
import crafttweaker.item.IWeightedIngredient;

import novaeng.hypernet.HyperNetHelper;



//最大线程
MachineModifier.setMaxThreads("laser_etching", 64);
//内置并行
MachineModifier.setInternalParallelism("laser_etching", 64);
//最大并行
MachineModifier.setMaxParallelism("laser_etching", 512);


//超维度激光雕刻控制器
RecipeBuilder.newBuilder("laser_etching", "workshop", 300)
    .addEnergyPerTickInput(100000)
    .addInputs([
        <contenttweaker:industrial_circuit_v3> * 8,
        <contenttweaker:electric_motor_v3> * 8,
        <contenttweaker:sensor_v3> * 16,
        //<mekanismgenerators:generator:6> * 16,
        //<modularmachinery:blockcasing:4>,
        //<mets:te:4>*8,
    ])
    .addOutput(<modularmachinery:laser_etching_factory_controller>)
    .build();

//配方创建
val inscriberModels as IItemStack[] = [
    <appliedenergistics2:material:13>,
    <appliedenergistics2:material:14>,
    <appliedenergistics2:material:15>,
    <appliedenergistics2:material:19>,
];

val circultConsumables as IOreDictEntry[] = [
    <ore:crystalPureCertusQuartz>,
    <ore:gemDiamond>,
    <ore:ingotGold>,
    <ore:itemSilicon>,
];

val circults as IItemStack[] = [
    <appliedenergistics2:material:16>,
    <appliedenergistics2:material:17>,
    <appliedenergistics2:material:18>,
    <appliedenergistics2:material:20>,
];

val processors as IItemStack[] = [
    <appliedenergistics2:material:23>,
    <appliedenergistics2:material:24>,
    <appliedenergistics2:material:22>,
];

val energyUsage = 1000;
val workTime = 30;

//推测处理器
RecipeBuilder.newBuilder("laser_etching_speculation_processor", "laser_etching", workTime)
    .addEnergyPerTickInput(energyUsage * 2)
    .addInput(<threng:material:13>).setTag("right")
    .addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients([circults[3],circultConsumables[3]])).setTag("right")
    .addInput(<ore:dustRedstone> * 1).setTag("right")
    .addOutput(<threng:material:14>)
    .addRecipeTooltip("在控制器右侧输入仓执行此配方")
    .build();

//大规模并行处理器
RecipeBuilder.newBuilder("laser_etching_parallel_processor", "laser_etching", workTime)
    .addEnergyPerTickInput(energyUsage * 2)
    .addInput(<threng:material:5>).setTag("right")
    .addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients([circults[3],circultConsumables[3]])).setTag("right")
    .addInput(<ore:dustRedstone>).setTag("right")
    .addOutput(<threng:material:6>)
    .addRecipeTooltip("在控制器右侧输入仓执行此配方")
    .build();

for i, processor in processors {
    RecipeBuilder.newBuilder("laser_etching_circult_to_processor_" + i, "laser_etching", workTime)
        .addEnergyPerTickInput(energyUsage)
        .addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients([circults[i],circultConsumables[i]])).setTag("right")
        .addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients([circults[3],circultConsumables[3]])).setTag("right")
        .addInput(<ore:dustRedstone>).setTag("right")
        .addOutput(processor)
        .addRecipeTooltip("在控制器右侧输入仓执行此配方")
        .build();
}

for i, circult in circults {
    RecipeBuilder.newBuilder("laser_etching_circult_" + i, "laser_etching", workTime)
        .addEnergyPerTickInput(energyUsage)
        .addInput(inscriberModels[i]).setChance(0).setParallelizeUnaffected(true).setTag("left")
        .addInput(circultConsumables[i]).setTag("left")
        .addOutput(circult)
        .addRecipeTooltip("在控制器左侧输入仓执行此配方")
        .build();
}
    RecipeBuilder.newBuilder("wafer_plate_laser_etching", "laser_etching", workTime)
        .addEnergyPerTickInput(energyUsage)
        .addInput(<appliedenergistics2:material:19>).setChance(0).setParallelizeUnaffected(true).setTag("left")
        .addInput(<advancedrocketry:wafer>).setTag("left")
        .addOutput(<appliedenergistics2:material:20>*4)
        .addRecipeTooltip("在控制器左侧输入仓执行此配方")
        .build();