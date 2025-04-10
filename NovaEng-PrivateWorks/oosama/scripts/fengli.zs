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
RecipeBuilder.newBuilder("wind_turbinesy_controller", "workshop", 300)
    .addEnergyPerTickInput(100000)
    .addInputs([
        <contenttweaker:industrial_circuit_v3> * 8,
        <contenttweaker:electric_motor_v3> * 8,
        <contenttweaker:sensor_v3> * 16,
        <mekanismgenerators:generator:6> * 16,
        <modularmachinery:blockcasing:4>,
        <mets:te:4>*8,
    ])
    .addOutput(<modularmachinery:wind_turbinesy_controller>)
    .build();
//风力涡轮机-无天气
RecipeBuilder.newBuilder("solar_panel_sunny", "wind_turbinesy", 13000, 0, true)
    .setWeather("sunny")
    .addEnergyPerTickOutput(500000000)
    .build();

//风力涡轮机-雨
RecipeBuilder.newBuilder("wind_turbinesy_night_raining", "wind_turbinesy", 13000, 0, true)
    .setWeather("raining")
    .addEnergyPerTickOutput(1000000000)
    .build();

//风力涡轮机-雪
RecipeBuilder.newBuilder("wind_turbinesy_day_snowing", "wind_turbinesy", 13000, 0, true)
    .setWeather("snowing")
    .addEnergyPerTickOutput(1500000000)
    .build();

//风力涡轮机-雷
RecipeBuilder.newBuilder("wind_turbinesy_day_thundering", "wind_turbinesy", 13000, 0, true)
    .setWeather("thundering")
    .addEnergyPerTickOutput(2000000000)
    .build();