#priority 1

import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.IMachineController;

import crafttweaker.item.IItemStack;

import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.research.ResearchCognitionData;


RecipeBuilder.newBuilder("stellarator_controller", "workshop", 3600, 20)
    .addEnergyPerTickInput(8192000)
    .addInputs([
        <appliedenergistics2:material:47> * 16,
        <contenttweaker:industrial_circuit_v3> * 48,
        <mekanism:controlcircuit:3> * 16,
        <contenttweaker:field_generator_v1> * 64,
        <appliedenergistics2:controller>,
    ])
    .addOutput(<modularmachinery:stellarator_controller>*1)
    .requireComputationPoint(3000.0F)
    .requireResearch("stellarator_1")
    .build();

<modularmachinery:stellarator_controller>.addTooltip("文明对能源的需求永无止境");

RecipeBuilder.newBuilder("Helium-3","stellarator",20)
    .addEnergyPerTickInput(5000000)
    .addInput(<liquid:hydrogen>*1000)
    .addInput(<avaritia:resource:2>*2)
    .addOutput(<liquid:helium_3>*500)
    .addEnergyPerTickOutput(15000000)
    .build();