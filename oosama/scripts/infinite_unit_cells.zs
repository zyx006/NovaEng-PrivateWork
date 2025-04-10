

#priority 50
#loader crafttweaker reloadable

import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.RecipeModifierBuilder;

import novaeng.hypernet.HyperNetHelper;

//////////无限晶孢//////////
HyperNetHelper.proxyMachineForHyperNet("infinite_unit_cells");
//最大并行数
MachineModifier.setMaxParallelism("infinite_unit_cells", 256);
//内置并行设置
MachineModifier.setInternalParallelism("infinite_unit_cells", 16);
//工厂线程设置
MachineModifier.setMaxThreads("infinite_unit_cells", 4);

# 控制器
//控制器合成
RecipeBuilder.newBuilder("infinite_unit_cells", "machine_arm", 600)
    .addEnergyPerTickInput(128000)
        .addInputs([
        <contenttweaker:industrial_circuit_v2> * 8,
        <contenttweaker:field_generator_v1> * 8,
        <contenttweaker:robot_arm_v3> * 4,
        <contenttweaker:engineering_battery_v2> * 12,
        <avaritia:resource:4> * 8,
        <modularmachinery:crystal_injector_factory_controller>*2,
        ])
        .addOutput(<modularmachinery:infinite_unit_cells_factory_controller>)
        .build();
var recipeCounter = 1;

//配方继承：水晶注入机
RecipeAdapterBuilder.create("infinite_unit_cells", "modularmachinery:crystal_injector")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.5F, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 2.0F, 1, false).build())
    .build();