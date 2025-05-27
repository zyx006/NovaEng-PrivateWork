#priority 50
#loader crafttweaker reloadable

import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.FactoryRecipeStartEvent;
import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.MachineTickEvent;


import mods.modularmachinery.SmartInterfaceType;

import mods.modularmachinery.MMEvents;

import novaeng.hypernet.HyperNetHelper;


//内置并行设置
MachineModifier.setInternalParallelism("mega_bricked_blast_furnace", 16384);

//工厂线程设置
MachineModifier.setMaxThreads("mega_bricked_blast_furnace", 80);


var recipeCounter = 1;  // 配方优先级


//巨型砖高炉控制器
RecipeBuilder.newBuilder("mega_bricked_blast_furnace1", "machine_arm", 2400)
    .addEnergyPerTickInput(128000)
    .addInputs(<modularmachinery:blockcasing> * 64)  // 机械外壳
    .addInputs(<techguns:simplemachine:11> * 256)  // 高炉
    .addInputs(<mekanism:controlcircuit:2>* 64)  // 精英电路板
    .addOutputs(<modularmachinery:mega_bricked_blast_furnace_controller> * 1) 
    .build();

# 巨型砖高炉继承配方？
RecipeAdapterBuilder.create("mega_bricked_blast_furnace", "enderio:block_alloy_smelter")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.10,  1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 1000, 1, false).build())
    .build();

//制作钢锭
RecipeBuilder.newBuilder("wudidegangding", "mega_bricked_blast_furnace", 2)
    .addInput(<minecraft:iron_ingot> )  //铁
    .addIngredientArrayInput(
     IngredientArrayBuilder.newBuilder()
        .addIngredients([
           <immersiveengineering:material:17>,  // 2
           <thermalfoundation:material:768>,  // 3
           <thermalfoundation:material:802>,//4
           <minecraft:coal>,//5
        ])
        )
        .addItemOutput(<thermalfoundation:material:160>)

    .build();

