#priority 50
#loader crafttweaker reloadable

import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;

import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.MachineModifier;

import novaeng.hypernet.HyperNetHelper;

//大型离子发生器 额外配方表
var ingredients as IIngredient[IIngredient]$orderly = {
<minecraft:iron_ingot>: <mets:niobium_titanium_ingot>,
<minecraft:gold_ore>:<ic2:resource:4>,
<ic2:cable:1>.withTag({type: 1 as byte, insulation: 0 as byte}):<mets:superconducting_cable>,
<mets:nano_living_metal>:<mets:neutron_plate>,
<mets:titanium_ingot>:<ic2:misc_resource:1>,
};
// 耗电

val energyUsage  = 9216000;
var recipeCounter = 114514;

for input, output in ingredients {
    RecipeBuilder.newBuilder("ion_generator_recipe_" + recipeCounter, "ion_generator", 5, recipeCounter, false)
        .addEnergyPerTickInput(energyUsage/5)
        .addInput(input)
        .addInput(<mets:te:22>).setChance(0)
        .addOutput(output)
        .requireComputationPoint(max(energyUsage/ 10000000.0F, 0.5F))
        .addRecipeTooltip("爱来自额外配方，耗电量和小机器一样")
        .build();
    recipeCounter += 1;
}

function max(a as float, b as float) as float {
    return a >= b ? a : b;
}
