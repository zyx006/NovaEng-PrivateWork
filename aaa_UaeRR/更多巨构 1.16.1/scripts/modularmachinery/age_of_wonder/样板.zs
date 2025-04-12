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