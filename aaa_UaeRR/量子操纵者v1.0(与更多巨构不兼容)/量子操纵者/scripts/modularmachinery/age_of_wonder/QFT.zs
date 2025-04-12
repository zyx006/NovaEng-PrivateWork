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

MachineModifier.setInternalParallelism("QFT", 1073741824);

RecipeAdapterBuilder.create("QFT", "modularmachinery:ion_generator")
    .addInput(<contenttweaker:programming_circuit_0>).setChance(0).setParallelizeUnaffected(true)
    .setMaxThreads(1)
    .build();
    
RecipeBuilder.newBuilder("qft_recipe1", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<minecraft:glass> * 64)
    .addOutput(<mets:superconducting_cable> * 64)
    .build();

RecipeBuilder.newBuilder("qft_recipe2", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<ic2:crafting:2> * 64)
    .addOutput(<mets:super_circuit> * 64)
    .build();

RecipeBuilder.newBuilder("qft_recipe3", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<mets:super_circuit> * 64)
    .addOutput(<mets:living_circuit> * 64)
    .build();

RecipeBuilder.newBuilder("qft_recipe4", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<minecraft:iron_ingot> * 64)
    .addOutput(<mets:niobium_titanium_ingot> * 64)
    .build();

RecipeBuilder.newBuilder("qft_recipe5", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<mets:niobium_titanium_ingot> * 64)
    .addOutput(<mets:nano_living_metal> * 64)
    .build();

RecipeBuilder.newBuilder("qft_recipe6", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<mets:nano_living_metal> * 64)
    .addOutput(<mets:neutron_plate> * 64)
    .build();

//配方
RecipeBuilder.newBuilder("fluix_pure1_qft", "QFT", 1)
    .addEnergyPerTickInput(8192)
    .addInput(<contenttweaker:programming_circuit_c>).setChance(0).setParallelizeUnaffected(true)
    .addInputs([
        <ore:gemCertusQuartz> * 4,
    ])
    .addInputs([
        <liquid:astralsorcery.liquidstarlight> * 4000
    ]).setChance(0).setParallelizeUnaffected(true)
    .addOutputs(<ore:crystalPureCertusQuartz> * 8)
    .build();
    
RecipeBuilder.newBuilder("fluix_pure2_qft", "QFT", 1)
    .addEnergyPerTickInput(8192)
    .addInput(<contenttweaker:programming_circuit_c>).setChance(0).setParallelizeUnaffected(true)
    .addInputs([
        <ore:gemQuartz> * 4,
    ])
    .addInputs([
        <liquid:astralsorcery.liquidstarlight> * 4000
    ]).setChance(0).setParallelizeUnaffected(true)
    .addOutputs(<ore:crystalPureNetherQuartz> * 8)
    .build();

RecipeBuilder.newBuilder("fluix_pure3_qft", "QFT", 1)
    .addEnergyPerTickInput(8192)
    .addInput(<contenttweaker:programming_circuit_c>).setChance(0).setParallelizeUnaffected(true)
    .addInputs([
        <ore:gemFluix> * 4,
    ])
    .addInputs([
        <liquid:astralsorcery.liquidstarlight> * 4000
    ]).setChance(0).setParallelizeUnaffected(true)
    .addOutputs(<ore:crystalPureFluix> * 8)
    .build();

RecipeBuilder.newBuilder("fluix_fluix_qft", "QFT", 1)
    .addEnergyPerTickInput(16384)
    .addInput(<contenttweaker:programming_circuit_c>).setChance(0).setParallelizeUnaffected(true)
    .addInputs([
        <ore:dustCertusQuartz> * 3,
        <ore:dustQuartz> * 3,
        <liquid:redstone> * 200
    ])
    .addOutputs(<ore:gemFluix> * 6)
    .build();

RecipeBuilder.newBuilder("fluix_fluix_complex_qft", "QFT", 1)
    .addEnergyPerTickInput(16384)
    .addInput(<contenttweaker:programming_circuit_c>).setChance(0).setParallelizeUnaffected(true)
    .addInputs([
        <ore:dustCoal> * 3,
        <ore:dustFluix> * 3,
        <ore:itemSilicon> * 4,
    ])
    .addOutputs(<threng:material:1> * 4)
    .build();

RecipeBuilder.newBuilder("fluix_vibrant_qft", "QFT", 1)
    .addEnergyPerTickInput(16384)
    .addInput(<contenttweaker:programming_circuit_c>).setChance(0).setParallelizeUnaffected(true)
    .addInputs([
        <ore:gemDiamond> * 1,
        <liquid:ender> * 250,
    ])
    .addOutputs(<threng:material:5> * 1)
    .build();

RecipeBuilder.newBuilder("fluix_spectus_qft", "QFT", 1)
    .addEnergyPerTickInput(16384)
    .addInput(<contenttweaker:programming_circuit_c>).setChance(0).setParallelizeUnaffected(true)
    .addInputs([
        <ore:dustSkyStone> * 48,
    ])
    .addOutputs(<threng:material:13> * 1)
    .build();

RecipeBuilder.newBuilder("qft_recipe9", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<ore:gemDiamond> * 64)
    .addOutput(<appliedenergistics2:material:24> * 64)
    .build();

RecipeBuilder.newBuilder("qft_recipe10", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<minecraft:gold_ingot> * 64)
    .addOutput(<appliedenergistics2:material:22> * 64)
    .build();

RecipeBuilder.newBuilder("qft_recipe11", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<appliedenergistics2:material:10> * 64)
    .addOutput(<appliedenergistics2:material:23> * 64)
    .build();

RecipeBuilder.newBuilder("qft_recipe12", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<threng:material:5> * 64)
    .addOutput(<threng:material:6> * 64)
    .build();

RecipeBuilder.newBuilder("qft_recipe13", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<threng:material:13> * 64)
    .addOutput(<threng:material:14> * 64)
    .build();

RecipeBuilder.newBuilder("qft_recipe14", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<thermalfoundation:material:132> * 64)
    .addOutput(<modularmachinery:itemmodularium> * 64)
    .build();

RecipeBuilder.newBuilder("qft_recipe15", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<appliedenergistics2:material:24> * 64)
    .addInput(<appliedenergistics2:material:23> * 64)
    .addInput(<appliedenergistics2:material:22> * 64)
    .addInput(<threng:material:6> * 64)
    .addInput(<threng:material:14> * 64)
    .addOutput(<contenttweaker:lifesense_processor> * 64)
    .build();

RecipeBuilder.newBuilder("qft_recipe16", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<contenttweaker:lifesense_processor> * 64)
    .addOutput(<contenttweaker:exponential_level_processor> * 64)
    .build();

RecipeBuilder.newBuilder("qft_recipe17", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<liquid:water> * 1000000)
    .addOutput(<liquid:ic2coolant> * 1000000)
    .build();

RecipeBuilder.newBuilder("qft_recipe18", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<minecraft:coal> * 64)
    .addOutput(<ic2:crafting:15> * 64)
    .build();

RecipeBuilder.newBuilder("qft_recipe19", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<minecraft:emerald> * 64)
    .addOutput(<enderio:item_material:15> * 64)
    .build();

RecipeBuilder.newBuilder("qft_recipe20", "qft", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<enderio:item_material:15> * 64)
    .addOutput(<contenttweaker:charging_crystal> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld21", "qft", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<contenttweaker:charging_crystal> * 64)
    .addOutput(<contenttweaker:charging_crystal_block> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld22", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<modularmachinery:itemmodularium> * 64)
    .addOutput(<modularmachinery:blockcasing> * 64)
    .addOutput(<modularmachinery:blockcasing:1> * 64)
    .addOutput(<modularmachinery:blockcasing:2> * 64)
    .addOutput(<modularmachinery:blockcasing:3> * 64)
    .addOutput(<modularmachinery:blockcasing:4> * 64)
    .addOutput(<modularmachinery:blockcasing:5> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld23", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<mekanism:ingot:1> * 64)
    .addOutput(<mekanism:controlcircuit> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld24", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<mekanism:controlcircuit> * 64)
    .addOutput(<mekanism:controlcircuit:1> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld25", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<mekanism:controlcircuit:1> * 64)
    .addOutput(<mekanism:controlcircuit:2> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld26", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<mekanism:controlcircuit:2> * 64)
    .addOutput(<mekanism:controlcircuit:3> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld27", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<minecraft:redstone> * 64)
    .addOutput(<botania:manaresource:5> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld28", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<minecraft:iron_ingot> * 64)
    .addOutput(<botania:manaresource:4> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld29", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<botania:manaresource:4> * 64)
    .addOutput(<botania:manaresource:14> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld30", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<botania:manaresource:14> * 64)
    .addOutput(<extrabotany:material:1> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld31", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<draconicevolution:draconium_ingot> * 64)
    .addOutput(<draconicevolution:draconic_ingot> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld32", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<draconicevolution:draconic_ingot> * 64)
    .addOutput(<tconevo:metal> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld33", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<tconevo:metal> * 64)
    .addOutput(<tconevo:metal:5> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld34", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<tconevo:metal:5> * 64)
    .addOutput(<tconevo:metal:10> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld35", "QFT", 1)
    .addEnergyPerTickInput(10000000000)
    .addInput(<contenttweaker:hypernet_ram_t5> * 64)
    .addInput(<contenttweaker:industrial_circuit_v4> * 64)
    .addInput(<contenttweaker:antimatter_core> * 64)
    .addInput(<liquid:crystalloid> * 100000000)
    .addInput(<avaritiaio:infinitecapacitor> * 16)
    .addInput(<liquid:infinity_metal> * 14400)
    .addOutput(<contenttweaker:hypernet_ram_max> * 1)
    .build();

RecipeBuilder.newBuilder("mm_ld36", "QFT", 1)
    .addEnergyPerTickInput(10000000000)
    .addInput(<contenttweaker:hypernet_gpu_t3> * 162)
    .addInput(<liquid:infinity_metal> * 14400)
    .addInput(<liquid:crystalloid> * 100000000)
    .addInput(<contenttweaker:industrial_circuit_v4> * 64)
    .addInput(<contenttweaker:antimatter_core> * 64)
    .addInput(<avaritiaio:infinitecapacitor> * 16)
    .addOutput(<contenttweaker:hypernet_gpu_max> * 1)
    .build();

RecipeBuilder.newBuilder("qft_recipe37", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<liquid:lava> * 1000000)
    .addOutput(<liquid:nitronite_fluid> * 1000000)
    .build();

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
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<extendedcrafting:material:14> * 64)
    .addOutput(<extendedcrafting:material:15> * 64)
    .build();
RecipeBuilder.newBuilder("aw_qft_2", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<extendedcrafting:material:15> * 64)
    .addOutput(<extendedcrafting:material:16> * 64)
    .build();
RecipeBuilder.newBuilder("aw_qft_3", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<extendedcrafting:material:16> * 64)
    .addOutput(<extendedcrafting:material:17> * 64)
    .build();
RecipeBuilder.newBuilder("aw_qft_4", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<extendedcrafting:material:17> * 64)
    .addOutput(<extendedcrafting:material:18> * 64)
    .build();
RecipeBuilder.newBuilder("aw_qft_5", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<extendedcrafting:material:18> * 64)
    .addOutput(<extendedcrafting:material:19> * 64)
    .build();
RecipeBuilder.newBuilder("aw_qft_6", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<extendedcrafting:material:8> * 64)
    .addOutput(<extendedcrafting:material:9>* 64)
    .build();
RecipeBuilder.newBuilder("aw_qft_7", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<extendedcrafting:material:9> * 64)
    .addOutput(<extendedcrafting:material:10> * 64)
    .build();
RecipeBuilder.newBuilder("aw_qft_8", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<extendedcrafting:material:10> * 64)
    .addOutput(<extendedcrafting:material:11> * 64)
    .build();
RecipeBuilder.newBuilder("aw_qft_9", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<extendedcrafting:material:11> * 64)
    .addOutput(<extendedcrafting:material:12> * 64)
    .build();
RecipeBuilder.newBuilder("aw_qft_10", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<extendedcrafting:material:12> * 64)
    .addOutput(<extendedcrafting:material:13> * 64)
    .build();
RecipeBuilder.newBuilder("aw_qft_11", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<contenttweaker:universalalloyt1> * 64)
    .addOutput(<contenttweaker:universalalloyt2> * 64)
    .build();
RecipeBuilder.newBuilder("aw_qft_12", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<contenttweaker:universalalloyt2> * 64)
    .addOutput(<contenttweaker:universalalloyt3> * 64)
    .build();
RecipeBuilder.newBuilder("aw_qft_13", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<thermalfoundation:material:136> * 64)
    .addOutput(<botania:manaresource> * 64)
    .build();
RecipeBuilder.newBuilder("aw_qft_14", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<botania:manaresource> * 64)
    .addOutput(<botania:manaresource:7> * 64)
    .build();
RecipeBuilder.newBuilder("aw_qft_15", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<avaritia:resource:5> * 512)
    .addOutput(<avaritia:resource:6> * 64)
    .build();
RecipeBuilder.newBuilder("aw_qft_16", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<avaritia:resource:6> * 64)
    .addOutput(<avaritiatweaks:enhancement_crystal> * 512)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_1", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<thermalfoundation:material:134> * 64)
    .addOutput(<additions:novaextended-psi_alloy> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_2", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<additions:novaextended-psi_alloy> * 64)
    .addOutput(<thermalfoundation:material:167> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_3", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<thermalfoundation:material:167> * 64)
    .addOutput(<enderutilities:enderpart> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_4", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<enderutilities:enderpart> * 64)
    .addOutput(<enderutilities:enderpart:2> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_5", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<enderutilities:enderpart:2> * 64)
    .addOutput(<extendedcrafting:material:36> * 64)
    .build();
    RecipeBuilder.newBuilder("aw_bug_qft_5", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<extendedcrafting:material:36> * 64)
    .addOutput(<extendedcrafting:material:48> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_6", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<extendedcrafting:material:48> * 64)
    .addOutput(<enderutilities:enderpart:3> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_7", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<enderio:item_material:38> * 64)
    .addOutput(<enderio:item_material:3> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_8", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<enderio:item_material:3> * 64)
    .addOutput(<enderio:block_solar_panel> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_9", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<enderio:block_solar_panel> * 64)
    .addOutput(<enderio:block_solar_panel:1> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_10", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<enderio:block_solar_panel:1> * 64)
    .addOutput(<enderio:block_solar_panel:2> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_11", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<enderio:block_solar_panel:2> * 64)
    .addOutput(<enderio:block_solar_panel:3> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_12", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<enderio:block_solar_panel:3> * 64)
    .addOutput(<enderio:block_solar_panel:4> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_13", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<enderio:block_solar_panel:4> * 64)
    .addOutput(<enderio:block_solar_panel:5> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_14", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<tconevo:material> * 64)
    .addOutput(<tconevo:metal:30> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_15", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<minecraft:diamond> * 64)
    .addOutput(<ancientspellcraft:astral_diamond_shard> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_16", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<avaritia:block_resource:1> * 64)
    .addOutput(<minecraft:dirt> * 1073741824)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_17", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<minecraft:cobblestone> * 1073741824).setChance(0).setParallelizeUnaffected(true)
    .addOutput(<fluid:fluidedmana> * 128)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_18", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<minecraft:dirt> * 64)
    .addOutput(<minecraft:clay> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_19", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<tconstruct:ingots:1> * 64)
    .addOutput(<tconevo:material> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_qft_20", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<tconevo:material> * 64)
    .addOutput(<deepmoblearning:polymer_clay> * 512)
    .build();

RecipeBuilder.newBuilder("no_mm_qft_assembly", "workshop", 72000)
        .addEnergyPerTickInput(10245760000)
        .addInput(<contenttweaker:industrial_circuit_v4> * 48)
        .addInput(<contenttweaker:field_generator_v4> * 32)
        .addInput(<contenttweaker:infinite_coil> * 8)
        .addInput(<moreplates:infinity_gear> * 4)
        .addInput(<contenttweaker:coil_v5> * 96)
        .addInput(<contenttweaker:antimatter_core> * 6)
        .addInput(<modularmachinery:chemical_complex_controller> * 4)
        .addOutput(<modularmachinery:qft_factory_controller>)
        .requireComputationPoint(40 * 1000.0F)
        .build();