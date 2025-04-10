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



//风力涡轮控制器
RecipeBuilder.newBuilder("solar_panel_114514_controller", "machine_arm", 300)
    .addEnergyPerTickInput(100000)
    .addInputs([
        <contenttweaker:industrial_circuit_v3> * 8,
        <contenttweaker:electric_motor_v3> * 8,
        <contenttweaker:sensor_v3> * 16,
        <mekanismgenerators:generator:6> * 16,
        <modularmachinery:blockcasing:4>,
        <mets:te:4>*8,
    ])
    .addOutput(<modularmachinery:solar_panel_114514_controller>)
    .build();

//大型光热电站-日间
RecipeBuilder.newBuilder("solar_panel_114514_day", "solar_panel_114514", 13000, 0, true)
    .setTime(10, 12999)
    .addEnergyPerTickOutput(20000000000)
    .build();

//大型光热电站-夜间
RecipeBuilder.newBuilder("solar_panel_114514_night", "solar_panel_114514", 13000, 0, true)
    .setTime(13000, 23992)
    .addEnergyPerTickOutput(10000000000)
    .build();

//大型光热电站-日间 云层
RecipeBuilder.newBuilder("solar_panel_114514_2_day", "solar_panel_114514", 13000, 0, true)
    .setTime(10, 12999)
    .setAltitude(230, 256)
    .addEnergyPerTickOutput(40000000000)
    .build();

//大型光热电站-夜间 云层
RecipeBuilder.newBuilder("solar_panel_114514_2_night", "solar_panel_114514", 13000, 0, true)
    .setTime(13000, 23992)
    .setAltitude(230, 256)
    .addEnergyPerTickOutput(30000000000)
    .build();
