//热解配方
#priority 10
#loader crafttweaker reloadable

import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.MachineBuilder;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.MultiblockModifierBuilder;
import mods.modularmachinery.BlockArrayBuilder;

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
//导

//热解蒸馏炉1控制器
RecipeBuilder.newBuilder("oil_pyrolyse_oven_mk1", "machine_arm", 2400)
    .addEnergyPerTickInput(128000)
    .addInputs(<modularmachinery:blockcasing> * 64)  // 机械外壳
    .addInputs(<techguns:simplemachine:11> * 256)  // 高炉
    .addInputs(<mekanism:controlcircuit:2>* 64)  // 精英电路板
    .addOutputs(<modularmachinery:oil_pyrolyse_oven_mk1_controller> * 1) 
    .build();

//热解蒸馏炉2控制器

RecipeBuilder.newBuilder("oil_pyrolyse_oven_mk2", "machine_arm", 2400)
    .addEnergyPerTickInput(128000)
    .addInputs(<modularmachinery:blockcasing> * 64)  // 机械外壳
    .addInputs(<techguns:simplemachine:11> * 256)  // 高炉
    .addInputs(<mekanism:controlcircuit:2>* 64)  // 精英电路板
    .addOutputs(<modularmachinery:oil_pyrolyse_oven_mk1_controller> * 1) 
    .build();


//配方（痛苦）

// 新配方：原木 制作 木炭 和 杂酚油 
RecipeBuilder.newBuilder("hs_oil_pyrolysis_log", "oil_pyrolyse_oven_mk1", 200) // 时间调整为200 ticks (10秒)，能源类型为 oil_pyrolyse_oven_mk1
    .addItemInput(<minecraft:log> * 1) // 原木 x1
    .addItemOutput(<minecraft:coal:1> * 1) // 输出：木炭 x1
    .addFluidOutput(<liquid:creosote>* 250) // 输出：杂酚油 250mB
    .addEnergyPerTickInput(50) // 每 tick 输入 50 单位电力 (总电力消耗 = 50 * 200 = 10000)
    .build();

// 新配方：木炭 制作 焦煤 和 杂酚油 
RecipeBuilder.newBuilder("hs_oil_pyrolysis_charcoal_to_coke", "oil_pyrolyse_oven_mk1", 200) // 时间调整为200 ticks (10秒)
    .addItemInput(<minecraft:coal:1> * 1) // 输入：木炭 x1
    .addItemOutput(<immersiveengineering:material:6>* 1) // 输出：焦煤 x1
    .addFluidOutput(<liquid:creosote>* 250) // 输出：杂酚油 250mB
    .addEnergyPerTickInput(50) // 每 tick 输入 50 单位电力 (总电力消耗 = 50 * 200 = 10000)
    .build();


// 新配方：木炭 + 编程电路 A 制作 焦煤 和 木炭副产物 
RecipeBuilder.newBuilder("hs_oil_pyrolysis_charcoal_with_circuit_a", "oil_pyrolyse_oven_mk1", 200) // 时间调整为200 ticks (10秒)，能源类型为 oil_pyrolyse_oven_mk1
    .addItemInput(<minecraft:coal:1> * 1) // 输入：木炭 x1
    .addItemInput(<contenttweaker:programming_circuit_a> * 1) // 输入：编程电路 A x1
    .addItemOutput(<immersiveengineering:material:6>* 1) // 输出：焦煤 x1
    .addFluidOutput(<liquid:creosote>* 250) // 输出：杂酚油 250mB（木炭副产物）
    .addEnergyPerTickInput(50) // 每 tick 输入 50 单位电力 (总电力消耗 = 50 * 200 = 10000)
    //.addRecipeTooltip("优化热解：\n通过编程电路 A 提升焦煤产量并生成副产物！") // 提示信息：描述产物名称
    .build();


// 配方 1：原木 + 0号编程电路 制作 石油 和 木炭粉 
RecipeBuilder.newBuilder("hs_oil_pyrolysis_log_with_circuit_0", "oil_pyrolyse_oven_mk1", 200) // 时间调整为200 ticks (10秒)
    .addInput(<ore:logWood> * 1) // 输入：任意类型原木 x1
    .addItemInput(<contenttweaker:programming_circuit_0> * 1) // 输入：0号编程电路 x1
    .addFluidOutput(<liquid:oil> * 500) // 输出：石油 500mB
    .addItemOutput(<mekanism:otherdust:8> * 2) // 输出：木炭粉 x2
    .addEnergyPerTickInput(50) // 每 tick 输入 50 单位电力 (总电力消耗 = 50 * 200 = 10000)
    .build();

// 配方 2：木炭 + 0号编程电路 制作 石油 和 木炭粉 
RecipeBuilder.newBuilder("hs_oil_pyrolysis_charcoal_with_circuit_0", "oil_pyrolyse_oven_mk1", 200) // 时间调整为200 ticks (10秒)
    .addItemInput(<minecraft:coal:1> * 1) // 输入：木炭 x1
    .addItemInput(<contenttweaker:programming_circuit_0> * 1) // 输入：0号编程电路 x1
    .addFluidOutput(<liquid:oil> * 250) // 输出：石油 250mB
    .addItemOutput(<mekanism:otherdust:8> * 1) // 输出：木炭粉 x1
    .addEnergyPerTickInput(50) // 每 tick 输入 50 单位电力 (总电力消耗 = 50 * 200 = 10000)
    .build();

// 配方 3：原木 制作 木炭 和 杂酚油 
RecipeBuilder.newBuilder("hs_oil_pyrolysis_log", "oil_pyrolyse_oven_mk1", 200) // 时间调整为200 ticks (10秒)
    .addInput(<ore:logWood> * 2) // 输入：任意类型原木 x2
    .addItemOutput(<minecraft:coal:1> * 2) // 输出：木炭 x2
    .addFluidOutput(<liquid:creosote>* 500) // 输出：杂酚油 500mB
    .addEnergyPerTickInput(50) // 每 tick 输入 50 单位电力 (总电力消耗 = 50 * 200 = 10000)
    .build();

// 配方 4：焦煤 制作 木炭 和 杂酚油 
RecipeBuilder.newBuilder("hs_oil_pyrolysis_coke_coal", "oil_pyrolyse_oven_mk1", 200) // 时间调整为200 ticks (10秒)
    .addInput(<immersiveengineering:material:6>* 1) // 输入：焦煤 x1
    .addItemOutput(<minecraft:coal:1> * 1) // 输出：木炭 x1
    .addFluidOutput(<liquid:creosote>* 250) // 输出：杂酚油 250mB
    .addEnergyPerTickInput(50) // 每 tick 输入 50 单位电力 (总电力消耗 = 50 * 200 = 10000)
    .build();

