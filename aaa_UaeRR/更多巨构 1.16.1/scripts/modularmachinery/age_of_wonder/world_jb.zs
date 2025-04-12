//ALL RIGHTS RESERVED
//也许你可以对私货进行更改。

#priority 10
#loader crafttweaker reloadable

import mods.modularmachinery.MMEvents;
import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.MachineBuilder;
import mods.modularmachinery.MachineTickEvent;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.MultiblockModifierBuilder;
import mods.modularmachinery.ControllerGUIRenderEvent;
import mods.modularmachinery.BlockArrayBuilder;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.IMachineController;

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
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.research.ResearchCognitionData;
import novaeng.NovaEngUtils;

RecipeBuilder.newBuilder("world_jb","world_jb",1)
    .addOutputs(<fluid:milk> * 409600)
    .addOutputs(<fluid:milk_chocolate> * 409600)
    .addOutputs(<contenttweaker:anti_viod>)
    .addOutputs(<botania_tweaks:compressed_tiny_potato_8>)
    .addOutputs(<avaritia:ultimate_stew> * 1024)
    .addRecipeTooltip([
        "§aMy penis is really small.————notch"
    ])
    .build();

RecipeBuilder.newBuilder("age_of_wonder_world_jb", "ark_space_station", 20000)
        .addInput(<contenttweaker:industrial_circuit_v4> * 1024)
        .addInput(<contenttweaker:field_generator_v4> * 1024)
        .addInput(<contenttweaker:space_time_coil> * 1024)
        .addInput(<moreplates:infinity_gear> * 32)
        .addInput(<contenttweaker:coil_v5> * 16384)
        .addInput(<contenttweaker:antimatter_core> * 1024)
        .addInput(<contenttweaker:anti_viod> * 64)
        .addOutput(<modularmachinery:world_jb_controller>)
        .build();