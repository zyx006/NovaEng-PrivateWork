
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

//配方继承
 RecipeAdapterBuilder.create("laser_etching", "modularmachinery:engineering_inscriber")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.25F, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 2.0F, 1, false).build())
    .build();
