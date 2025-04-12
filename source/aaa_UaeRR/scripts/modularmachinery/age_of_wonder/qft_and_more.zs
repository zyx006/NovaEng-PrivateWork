//ALL RIGHTS RESERVED
//也许你可以对私货进行更改。

#priority 1000
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

RecipeBuilder.newBuilder("aw_qft_1", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<extendedcrafting:material:14> * 64)
    .addOutput(<extendedcrafting:material:15> * 64)
    .build();
RecipeBuilder.newBuilder("aw_qft_2", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<extendedcrafting:material:15> * 64)
    .addOutput(<extendedcrafting:material:16> * 64)
    .build();
RecipeBuilder.newBuilder("aw_qft_3", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<extendedcrafting:material:16> * 64)
    .addOutput(<extendedcrafting:material:17> * 64)
    .build();
RecipeBuilder.newBuilder("aw_qft_4", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<extendedcrafting:material:17> * 64)
    .addOutput(<extendedcrafting:material:18> * 64)
    .build();
RecipeBuilder.newBuilder("aw_qft_5", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<extendedcrafting:material:18> * 64)
    .addOutput(<extendedcrafting:material:19> * 64)
    .build();
RecipeBuilder.newBuilder("aw_qft_6", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<extendedcrafting:material:8> * 64)
    .addOutput(<extendedcrafting:material:9>* 64)
    .build();
RecipeBuilder.newBuilder("aw_qft_7", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<extendedcrafting:material:9> * 64)
    .addOutput(<extendedcrafting:material:10> * 64)
    .build();
RecipeBuilder.newBuilder("aw_qft_8", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<extendedcrafting:material:10> * 64)
    .addOutput(<extendedcrafting:material:11> * 64)
    .build();
RecipeBuilder.newBuilder("aw_qft_9", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<extendedcrafting:material:11> * 64)
    .addOutput(<extendedcrafting:material:12> * 64)
    .build();
RecipeBuilder.newBuilder("aw_qft_10", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<extendedcrafting:material:12> * 64)
    .addOutput(<extendedcrafting:material:13> * 64)
    .build();
RecipeBuilder.newBuilder("aw_qft_11", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<contenttweaker:universalalloyt1> * 64)
    .addOutput(<contenttweaker:universalalloyt2> * 64)
    .build();
RecipeBuilder.newBuilder("aw_qft_12", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<contenttweaker:universalalloyt2> * 64)
    .addOutput(<contenttweaker:universalalloyt3> * 64)
    .build();
RecipeBuilder.newBuilder("aw_qft_13", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<thermalfoundation:material:136> * 64)
    .addOutput(<botania:manaresource> * 64)
    .build();
RecipeBuilder.newBuilder("aw_qft_14", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<botania:manaresource> * 64)
    .addOutput(<botania:manaresource:7> * 64)
    .build();
RecipeBuilder.newBuilder("aw_qft_15", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<avaritia:resource:5> * 512)
    .addOutput(<avaritia:resource:6> * 64)
    .build();
RecipeBuilder.newBuilder("aw_qft_16", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<avaritia:resource:6> * 64)
    .addOutput(<avaritiatweaks:enhancement_crystal> * 512)
    .build();
RecipeBuilder.newBuilder("qft_timespace_coil_assembly", "QFT",1)
        .addInput(<contenttweaker:coil_v5> * 1024)
        .addInput(<contenttweaker:infinite_coil> * 64)
        .addInput(<contenttweaker:fragments_of_the_space_time_continuum> * 16384)
        .addOutput(<contenttweaker:space_time_coil>)
        .addRecipeTooltip([
                "§a群80太可怕了呜呜呜",
            ])
        .addEnergyPerTickInput(8000)
        .build();
RecipeBuilder.newBuilder("aw_bug_qft_1", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<thermalfoundation:material:134> * 64)
    .addOutput(<additions:novaextended-psi_alloy> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_2", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<additions:novaextended-psi_alloy> * 64)
    .addOutput(<thermalfoundation:material:167> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_3", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<thermalfoundation:material:167> * 64)
    .addOutput(<enderutilities:enderpart> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_4", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<enderutilities:enderpart> * 64)
    .addOutput(<enderutilities:enderpart:2> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_5", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<enderutilities:enderpart:2> * 64)
    .addOutput(<extendedcrafting:material:36> * 64)
    .build();
    RecipeBuilder.newBuilder("aw_bug_qft_5", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<extendedcrafting:material:36> * 64)
    .addOutput(<extendedcrafting:material:48> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_6", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<extendedcrafting:material:48> * 64)
    .addOutput(<enderutilities:enderpart:3> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_7", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<enderio:item_material:38> * 64)
    .addOutput(<enderio:item_material:3> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_8", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<enderio:item_material:3> * 64)
    .addOutput(<enderio:block_solar_panel> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_9", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<enderio:block_solar_panel> * 64)
    .addOutput(<enderio:block_solar_panel:1> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_10", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<enderio:block_solar_panel:1> * 64)
    .addOutput(<enderio:block_solar_panel:2> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_11", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<enderio:block_solar_panel:2> * 64)
    .addOutput(<enderio:block_solar_panel:3> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_12", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<enderio:block_solar_panel:3> * 64)
    .addOutput(<enderio:block_solar_panel:4> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_13", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<enderio:block_solar_panel:4> * 64)
    .addOutput(<enderio:block_solar_panel:5> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_14", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<tconevo:material> * 64)
    .addOutput(<tconevo:metal:30> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_15", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<minecraft:diamond> * 64)
    .addOutput(<ancientspellcraft:astral_diamond_shard> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_16", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<avaritia:block_resource:1> * 64)
    .addOutput(<minecraft:dirt> * 1073741824)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_17", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<minecraft:cobblestone> * 1073741824).setChance(0)
    .addOutput(<fluid:fluidedmana> * 40960)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_18", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<minecraft:dirt> * 64)
    .addOutput(<minecraft:clay> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_19", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<tconstruct:ingots:1> * 64)
    .addOutput(<tconevo:material> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_20", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<tconevo:material> * 64)
    .addOutput(<deepmoblearning:polymer_clay> * 512)
    .build();