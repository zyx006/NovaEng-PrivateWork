import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.MachineBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.MMEvents;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.FactoryRecipeTickEvent;
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

import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.research.ResearchCognitionData;

RecipeBuilder.newBuilder("ThermalCreative","Paradox",7200)
    .addInputs([
        <thermalfoundation:upgrade:35>*1024,
        <mekanism:controlcircuit:4>*4,
        <mekanism:cosmicalloy>*4,
        <mekanism:cosmicmatter>*2,
        <contenttweaker:sunrune>,
        <contenttweaker:data_model_gelid_enderium>*4,
        <contenttweaker:data_model_gelid_gem>*4
    ])
    .addOutput(<thermalfoundation:upgrade:256>)
    .build();
RecipeBuilder.newBuilder("YabbaCreative","Paradox",7200)
    .addInputs([
        <thermalfoundation:upgrade:256> * 4,
        <yabba:upgrade_star_tier>*256,
        <yabba:antibarrel>*2048,
        <yabba:item_barrel>*8192,
        <contenttweaker:infinitycore>,
        <contenttweaker:fragments_of_the_space_time_continuum>*512,
        <contenttweaker:space_time_condensation_block>*256,
        <liquid:space_time_fluids>*20480,
    ])
    .addOutput(<yabba:upgrade_creative>)
    .build();
recipes.addShapeless("YabbaCopy",<yabba:upgrade_creative>*2,[<yabba:upgrade_creative>]);
RecipeBuilder.newBuilder("AECreative","Paradox",7200)
    .addInputs([
        <contenttweaker:starry_orgin>*256,
        <yabba:upgrade_creative>*256,
        <novaeng_core:ecalculator_cell_16384m>*4096,
        <novaeng_core:estorage_cell_fluid_256m>*8192,
        <novaeng_core:estorage_cell_item_256m>*8192,
        <nae2:storage_cell_fluid_16384k>*8192,
        <nae2:storage_cell_16384k>*8192,
        <nae2:storage_crafting_16384k>*8192,
        <appliedenergistics2:spatial_storage_cell_128_cubed>*8192,
    ])
    .addOutput(<appliedenergistics2:creative_storage_cell>)
    .addRecipeTooltip("§9§l§o再见了，所有的模块化机器")
    .build();