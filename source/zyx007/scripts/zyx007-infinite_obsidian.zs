#loader crafttweaker reloadable

import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.jei.JEI;

var recipeCounter = 1;

var lavaCell = <extendedae:infinity_cell>.withTag({r: {FluidName: "lava", Craft: 0, Cnt: 1, Count: 0, Req: 0}, t: "f"});
var waterCell = <extendedae:infinity_cell>.withTag({r: {FluidName: "water", Craft: 0, Cnt: 1, Count: 0, Req: 0}, t: "f"});
var obsidianCell = <extendedae:infinity_cell>.withTag({r: {Craft: 0, Cnt: 1, Count: 1, id: "minecraft:obsidian", Damage: 0, Req: 0}, t: "i"});

recipes.addShapeless(obsidianCell, [lavaCell, waterCell]);
JEI.addItem(obsidianCell);

MachineModifier.setInternalParallelism("obsidian_generate", 8);
MachineModifier.setMaxParallelism("obsidian_generate", 512);

recipes.addShaped(<modularmachinery:obsidian_generate_controller>, [
    [<minecraft:water_bucket>, <minecraft:lava_bucket>, <minecraft:water_bucket>],
    [<minecraft:lava_bucket>, <modularmachinery:blockcasing:4>, <minecraft:lava_bucket>],
    [<minecraft:water_bucket>, <minecraft:lava_bucket>, <minecraft:water_bucket>]
]);

JEI.removeAndHide(<modularmachinery:obsidian_generate_factory_controller>);

RecipeBuilder.newBuilder("obsidian_generate_1", "obsidian_generate", 40, recipeCounter, false)
    .addEnergyPerTickInput(2560)
    .addInputs([
        <liquid:water> * 1000,
        <liquid:lava> * 1000
    ])
    .addOutputs(<minecraft:obsidian> * 1)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("obsidian_generate_2", "obsidian_generate", 20, recipeCounter, false)
    .addEnergyPerTickInput(1280)
    .addInput(<liquid:lava> * 1000)
    .addInput(waterCell * 1).setChance(0).setParallelizeUnaffected(true)
    .addOutputs(<minecraft:obsidian> * 1)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("obsidian_generate_3", "obsidian_generate", 20, recipeCounter, false)
    .addEnergyPerTickInput(1280)
    .addInput(<liquid:lava> * 1000)
    .addInput(<cookingforblockheads:sink> * 1).setChance(0).setParallelizeUnaffected(true)
    .addOutputs(<minecraft:obsidian> * 1)
    .build();
recipeCounter += 1;

//1热量8线圈的谐振熔岩炉满载耗能27kRF/t，下界岩共需60k，其他共需300k
//耗能十分之一，耗时一半(向下取整)
RecipeBuilder.newBuilder("obsidian_generate_4", "obsidian_generate", 1, recipeCounter, false)
    .addEnergyPerTickInput(2700)
    .addInput(<minecraft:netherrack> * 1)
    .addOutput(<liquid:lava> * 1000)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("obsidian_generate_5", "obsidian_generate", 5, recipeCounter, false)
    .addEnergyPerTickInput(2700)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder().addIngredients([
            <minecraft:stone> * 1,
            <minecraft:stone:1> * 1,
            <minecraft:stone:2> * 1,
            <minecraft:stone:3> * 1,
            <minecraft:stone:4> * 1,
            <minecraft:stone:5> * 1,
            <minecraft:stone:6> * 1,
            <minecraft:cobblestone> * 1,
            <minecraft:obsidian> * 1
        ])
    )
    .addOutput(<liquid:lava> * 1000)
    .build();
recipeCounter += 1;