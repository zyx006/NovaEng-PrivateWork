import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.MachineBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.MMEvents;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.RecipeModifierBuilder;

import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;

import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.research.ResearchCognitionData;

recipes.addShaped(<modularmachinery:deepmelon_controller>, 
    [
        [<mekanism:speedupgrade>, <mekanism:machineblock2:4>, <mekanism:speedupgrade>],
        [<mekanism:machineblock:6>, <mekanismmultiblockmachine:advanced_electrolysis_core>, <mekanism:machineblock:6>], 
        [<mekanism:energyupgrade>, <mekanism:energycube>, <mekanism:energyupgrade>]
    ]
);

recipes.addShaped(<modularmachinery:ethenecontroller_controller>,
    [
        [<mekanism:energycube>, <mekanism:controlcircuit:1>, <mekanism:energycube>],
        [<mekanism:controlcircuit:1>, <mekanismgenerators:generator:3>, <mekanism:controlcircuit:1>], 
        [<modularmachinery:blockupgradebus>, <mekanism:controlcircuit:1>, <modularmachinery:blockupgradebus>]
    ]
);

function melon(item as IItemStack,parallel as int,name as string,effi as int){
        var wcost=1880*parallel;
        var PEgot=18*parallel;
        var ethenegot=1600*parallel;
        var ethenecost=80*parallel;
        var oxgot=360*parallel;
    RecipeBuilder.newBuilder("deepmelon"+name,"deepmelon",20)
        .addInput(item).setChance(0)
        .addInputs([
            <liquid:water>*wcost,
            <minecraft:melon_block>*parallel
        ])
        .addEnergyPerTickInput(2000)
        .addOutputs([
            <mekanism:polyethene>*PEgot,
            <liquid:liquidethene>*ethenegot,
            <liquid:oxygen>*oxgot
        ])
        .build();
    RecipeBuilder.newBuilder("ethenecontroll"+name,"ethenecontroller",20)
        .addInput(item).setChance(0)
        .addFluidPerTickInput(<liquid:liquidethene>*ethenecost)
        .addEnergyPerTickOutput(parallel*effi)
        .build();
}
melon(<contenttweaker:programming_circuit_0>,1,0,48000);
melon(<contenttweaker:programming_circuit_a>,5,1,72000);
melon(<contenttweaker:programming_circuit_b>,10,2,96000);
melon(<contenttweaker:programming_circuit_c>,50,3,120000);
melon(<contenttweaker:programming_circuit_d>,100,4,144000);
melon(<contenttweaker:programming_circuit_e>,500,5,168000);
melon(<contenttweaker:programming_circuit_f>,1000,6,192000);