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

var recipeCount = 0;


RecipeBuilder.newBuilder("mm_hysz", "QFT", 360)
    .addEnergyPerTickInput(150000000)
    .addInput(<thermalfoundation:material:768> * 21)
    .addInput(<mekanism:salt> * 1)
    .addInput(<fluid:hydrogen> * 15000)
    .addInput(<fluid:water> * 5000)
    .addOutput(<contenttweaker:mm_hysz>)
    .requireComputationPoint(1000)
    .requireResearch("qft_4")
    .build();

RecipeBuilder.newBuilder("mm_jbbmc", "QFT", 360)
    .addEnergyPerTickInput(150000000)
    .addInput(<thermalfoundation:material:768> * 20)
    .addInput(<fluid:hydrogen> * 12000)
    .addInput(<fluid:nitrogen> * 1000)
    .addOutput(<contenttweaker:mm_jbbmc>)
    .requireComputationPoint(1000)
    .requireResearch("qft_4")
    .build();

RecipeBuilder.newBuilder("mm_ldx", "QFT", 360)
    .addEnergyPerTickInput(150000000)
    .addInput(<thermalfoundation:material:768> * 14)
    .addInput(<thermalfoundation:material:66> * 3)
    .addInput(<contenttweaker:fragments_of_the_space_time_continuum> * 3)
    .addInput(<avaritia:resource:5> * 2)
    .addInput(<tconevo:metal:41> * 8)
    .addInput(<mekanism:dust:2> * 11)
    .addInput(<fluid:oxygen> * 7000)
    .addInput(<fluid:water> * 1000)
    .addOutput(<contenttweaker:mm_ldx>)
    .requireComputationPoint(1000)
    .requireResearch("qft_4")
    .build();

//不写会报错
function camelToSnake(camelStr as string) as string {
    var result = "";
    var index = 0;
    while (index < camelStr.length) {
        if (camelStr.matches(".*[A-Z].*")) {
            if (index != 0 && camelStr.substring(index,index + 1).matches(".*[A-Z].*")) {
                result += "_";
            }
            result += camelStr.substring(index, index + 1).toLowerCase();
        } else {
            result += camelStr.substring(index, index + 1);
        }
            index += 1;
        }
    return result;
}
zenClass NAME {
    static name as int = 0;
}
function registerRecipe(machine as string,inputs as IIngredient[],Weightedinputs as IWeightedIngredient[],outputs as IIngredient[],Weightedoutputs as IWeightedIngredient[],time as int,energy as long){
    val recipe = RecipeBuilder.newBuilder(machine + NAME.name + energy + time,machine,time);
        if (energy > 0){
            recipe.addEnergyPerTickInput(energy);
        }
        for input in inputs{
            recipe.addInput(input);
        }
        for input in Weightedinputs{
            recipe.addInput(input.ingredient).setChance(input.percent);
        }
        for output in outputs{
            recipe.addOutput(output);
        }
        for output in Weightedoutputs{
            recipe.addOutput(output.ingredient).setChance(output.percent);
        }
        recipe.build();
    NAME.name += 1;
}
function recistermax(input as IIngredient[],output as IIngredient,input1 as IIngredient[] = null){
    val re = RecipeBuilder.newBuilder("light-speed_material_accelerator" + NAME.name,"light-speed_material_accelerator",72000);
    if (!isNull(input1)){
        re.addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients(input1));
    }
        re.addInputs(input)
        .addOutput(output)
        .addEnergyPerTickInput(100000000000)
    .build();
    NAME.name += 1;
}

MachineModifier.setInternalParallelism("QFT", 1073741824);

RecipeAdapterBuilder.create("QFT", "modularmachinery:ion_generator")
    .addInput(<contenttweaker:programming_circuit_0>).setChance(0)
    .setMaxThreads(1)
    .build();
    
RecipeBuilder.newBuilder("mm_ldx1", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0)
    .addInput(<minecraft:glass> * 64)
    .addOutput(<mets:superconducting_cable> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ldx2", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0)
    .addInput(<ic2:crafting:2> * 64)
    .addOutput(<mets:super_circuit> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ldx3", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0)
    .addInput(<mets:super_circuit> * 64)
    .addOutput(<mets:living_circuit> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ldx4", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0)
    .addInput(<minecraft:iron_ingot> * 64)
    .addOutput(<mets:niobium_titanium_ingot> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ldx5", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0)
    .addInput(<mets:niobium_titanium_ingot> * 64)
    .addOutput(<mets:nano_living_metal> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ldx6", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0)
    .addInput(<mets:nano_living_metal> * 64)
    .addOutput(<mets:neutron_plate> * 64)
    .build();

//配方
RecipeBuilder.newBuilder("fluix_pure1_qft", "QFT", 1)
    .addEnergyPerTickInput(8192)
    .addInput(<contenttweaker:programming_circuit_c>).setChance(0)
    .addInputs([
        <ore:gemCertusQuartz> * 4,
    ])
    .addInputs([
        <liquid:astralsorcery.liquidstarlight> * 4000
    ]).setChance(0)
    .addOutputs(<ore:crystalPureCertusQuartz> * 8)
    .build();
    
RecipeBuilder.newBuilder("fluix_pure2_qft", "QFT", 1)
    .addEnergyPerTickInput(8192)
    .addInput(<contenttweaker:programming_circuit_c>).setChance(0)
    .addInputs([
        <ore:gemQuartz> * 4,
    ])
    .addInputs([
        <liquid:astralsorcery.liquidstarlight> * 4000
    ]).setChance(0)
    .addOutputs(<ore:crystalPureNetherQuartz> * 8)
    .build();

RecipeBuilder.newBuilder("fluix_pure3_qft", "QFT", 1)
    .addEnergyPerTickInput(8192)
    .addInput(<contenttweaker:programming_circuit_c>).setChance(0)
    .addInputs([
        <ore:gemFluix> * 4,
    ])
    .addInputs([
        <liquid:astralsorcery.liquidstarlight> * 4000
    ]).setChance(0)
    .addOutputs(<ore:crystalPureFluix> * 8)
    .build();

RecipeBuilder.newBuilder("fluix_fluix_qft", "QFT", 1)
    .addEnergyPerTickInput(16384)
    .addInput(<contenttweaker:programming_circuit_c>).setChance(0)
    .addInputs([
        <ore:dustCertusQuartz> * 3,
        <ore:dustQuartz> * 3,
        <liquid:redstone> * 200
    ])
    .addOutputs(<ore:gemFluix> * 6)
    .build();

RecipeBuilder.newBuilder("fluix_fluix_complex_qft", "QFT", 1)
    .addEnergyPerTickInput(16384)
    .addInput(<contenttweaker:programming_circuit_c>).setChance(0)
    .addInputs([
        <ore:dustCoal> * 3,
        <ore:dustFluix> * 3,
        <ore:itemSilicon> * 4,
    ])
    .addOutputs(<threng:material:1> * 4)
    .build();

RecipeBuilder.newBuilder("fluix_vibrant_qft", "QFT", 1)
    .addEnergyPerTickInput(16384)
    .addInput(<contenttweaker:programming_circuit_c>).setChance(0)
    .addInputs([
        <ore:gemDiamond> * 1,
        <ore:dustSkyStone> * 1,
        <liquid:ender> * 250,
    ])
    .addOutputs(<threng:material:5> * 1)
    .build();

RecipeBuilder.newBuilder("fluix_spectus_qft", "QFT", 1)
    .addEnergyPerTickInput(16384)
    .addInput(<contenttweaker:programming_circuit_c>).setChance(0)
    .addInputs([
        <ore:dustSkyStone> * 48,
    ])
    .addOutputs(<threng:material:13> * 1)
    .build();

RecipeBuilder.newBuilder("mm_ldx9", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0)
    .addInput(<ore:gemDiamond> * 64)
    .addOutput(<appliedenergistics2:material:24> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ldx10", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0)
    .addInput(<minecraft:gold_ingot> * 64)
    .addOutput(<appliedenergistics2:material:22> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ldx11", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0)
    .addInput(<appliedenergistics2:material:10> * 64)
    .addOutput(<appliedenergistics2:material:23> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ldx12", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0)
    .addInput(<threng:material:5> * 64)
    .addOutput(<threng:material:6> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ldx13", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0)
    .addInput(<threng:material:13> * 64)
    .addOutput(<threng:material:14> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ldx14", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0)
    .addInput(<thermalfoundation:material:132> * 64)
    .addOutput(<modularmachinery:itemmodularium> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ldx15", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0)
    .addInput(<appliedenergistics2:material:24> * 64)
    .addInput(<appliedenergistics2:material:23> * 64)
    .addInput(<appliedenergistics2:material:22> * 64)
    .addInput(<threng:material:6> * 64)
    .addInput(<threng:material:14> * 64)
    .addOutput(<contenttweaker:lifesense_processor> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ldx16", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0)
    .addInput(<contenttweaker:lifesense_processor> * 64)
    .addOutput(<contenttweaker:exponential_level_processor> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ldx17", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0)
    .addInput(<liquid:water> * 1000000)
    .addOutput(<liquid:ic2coolant> * 1000000)
    .build();

RecipeBuilder.newBuilder("mm_ldx18", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0)
    .addInput(<minecraft:coal> * 64)
    .addOutput(<ic2:crafting:15> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ldx19", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0)
    .addInput(<minecraft:emerald> * 64)
    .addOutput(<enderio:item_material:15> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ldx20", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0)
    .addInput(<enderio:item_material:15> * 64)
    .addOutput(<custommc:item929> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld21", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0)
    .addInput(<custommc:item929> * 64)
    .addOutput(<custommc:item170> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld22", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0)
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
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0)
    .addInput(<mekanism:ingot:1> * 64)
    .addOutput(<mekanism:controlcircuit> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld24", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0)
    .addInput(<mekanism:controlcircuit> * 64)
    .addOutput(<mekanism:controlcircuit:1> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld25", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0)
    .addInput(<mekanism:controlcircuit:1> * 64)
    .addOutput(<mekanism:controlcircuit:2> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld26", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0)
    .addInput(<mekanism:controlcircuit:2> * 64)
    .addOutput(<mekanism:controlcircuit:3> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld27", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0)
    .addInput(<minecraft:redstone> * 64)
    .addOutput(<botania:manaresource:5> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld28", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0)
    .addInput(<minecraft:iron_ingot> * 64)
    .addOutput(<botania:manaresource:4> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld29", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0)
    .addInput(<botania:manaresource:4> * 64)
    .addOutput(<botania:manaresource:14> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld30", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0)
    .addInput(<botania:manaresource:14> * 64)
    .addOutput(<extrabotany:material:1> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld31", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0)
    .addInput(<draconicevolution:draconium_ingot> * 64)
    .addOutput(<draconicevolution:draconic_ingot> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld32", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0)
    .addInput(<draconicevolution:draconic_ingot> * 64)
    .addOutput(<tconevo:metal> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld33", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0)
    .addInput(<tconevo:metal> * 64)
    .addOutput(<tconevo:metal:5> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld34", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0)
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

RecipeBuilder.newBuilder("mm_ldx37", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0)
    .addInput(<liquid:lava> * 1000000)
    .addOutput(<liquid:nitronite_fluid> * 1000000)
    .build();

RecipeBuilder.newBuilder("mm_ldx38", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0)
    .addInput(<avaritia:block_resource:1> * 64)
    .addOutput(<custommc:item968> * 1)
    .build();
RecipeBuilder.newBuilder("mm_ldx38", "QFT", 1)
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0)
    .addInput(<custommc:item968> * 4)
    .addOutput(<custommc:item132> * 1)
    .build();