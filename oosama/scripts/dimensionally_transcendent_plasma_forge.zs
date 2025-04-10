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
MachineModifier.setInternalParallelism("dimensionally_transcendent_plasma_forge", 16384);

//工厂线程设置
MachineModifier.setMaxThreads("dimensionally_transcendent_plasma_forge", 80);


var recipeCounter = 1;  // 配方优先级

//超维度离子锻炉集成控制器
RecipeBuilder.newBuilder("dimensionally_transcendent_plasma_forge1", "machine_arm", 2400)
    .addEnergyPerTickInput(128000)
    .addInputs(<modularmachinery:blockcasing> * 64)  // 机械外壳
    .addInputs(<techguns:simplemachine:11> * 64)  // 高炉
    .addInputs(<mekanism:controlcircuit:2>* 64)  // 精英电路板
    .addInputs(<minecraft:iron_ingot>*64)
    .addOutputs(<modularmachinery:dimensionally_transcendent_plasma_forge_factory_controller> * 1) 
    .build();


# 超维度离子锻炉配方继承
RecipeAdapterBuilder.create("dimensionally_transcendent_plasma_forge", "nuclearcraft:alloy_furnace")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.01,  1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 1000, 1, false).build())
    .build();

# 石墨烯
RecipeBuilder.newBuilder("graphene1", "dimensionally_transcendent_plasma_forge", 20)
    .addEnergyPerTickInput(10000)
    .addInputs([
        <ore:ingotSiliconCarbide> * 2,
    ])
    .addOutputs([
        <contenttweaker:graphene> * 1,
        <ore:itemSilicon> * 1,
    ])
    .build();





