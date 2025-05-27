#priority 10
#loader crafttweaker reloadable

import mods.modularmachinery.RecipeCheckEvent;
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
//内置并行设置
MachineModifier.setInternalParallelism("bedrock_drilling_rigs", 64);
//设置最大线程
MachineModifier.setMaxThreads("bedrock_drilling_rigs", 9);
//bedrock_drilling_rigs控制器
recipes.addShaped( 
    <modularmachinery:bedrock_drilling_rigs_factory_controller>, // 输出物品
    [[<modularmachinery:bedrock_drilling_rigs_controller>, <modularmachinery:bedrock_drilling_rigs_controller>, <modularmachinery:bedrock_drilling_rigs_controller>],
    [<modularmachinery:bedrock_drilling_rigs_controller>, <modularmachinery:bedrock_drilling_rigs_controller>, <modularmachinery:bedrock_drilling_rigs_controller>],
    [<modularmachinery:bedrock_drilling_rigs_controller>, <modularmachinery:bedrock_drilling_rigs_controller>, <modularmachinery:bedrock_drilling_rigs_controller>]]
);

    recipes.addShaped( 
    <modularmachinery:bedrock_drilling_rigs_controller>, // 输出物品
    [[<enderio:block_sag_mill>, <ore:compressed3xDustBedrock>]]
);

// 新配方：产基岩粉
RecipeBuilder.newBuilder("jiyanfensc", "bedrock_drilling_rigs", 20)
    .addItemInput(<enderio:block_infinity:2> * 1).setChance(0).setParallelizeUnaffected(true) // 基岩块
    .addEnergyPerTickInput(1000) // 每 tick 输入 1000 单位电力 (总电力消耗 = 1000 * 70 = 70000)
    .addItemOutput(<enderio:item_material:20> * 100).setChance(0.01) // 输出：基岩粉 x1
    .addItemOutput(<enderio:item_material:20> * 10).setChance(0.1) // 输出：基岩粉 x1
    .addItemOutput(<enderio:item_material:20> * 1) // 输出：基岩粉 x1

    .addRecipeTooltip("§f放入§e一个基岩块§f提供§2一并行！") // 提示信息：描述配方功能
    .addCatalystInput(<minecraft:flint>,
        ["§f当做磨珠子使用喵§e120%§f额外，§e85%§f能效。"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output", 1.2F, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:energy", "input", 0.85F, 1, false).build(),
        ]).setChance(0.1)
     .addCatalystInput(<avaritiaio:grindingballinfinity>,
        ["§f当做磨珠子使用喵§e1000%§f额外，§e1%§f能效。"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output", 10.0F, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:energy", "input", 0.01F, 1, false).build(),
        ]).setChance(0)
    .addCatalystInput(<avaritiaio:grindingballneutronium>,
        ["§f当做磨珠子使用喵§e600%§f额外，§e10%§f能效。"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output", 6.0F, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:energy", "input", 0.1F, 1, false).build(),
        ]).setChance(0.01)
        .addCatalystInput(<enderio:item_alloy_ball>,
        ["§f当做磨珠子使用喵§e185%§f额外输出，§e80%§f能耗。"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output", 2.85F, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:energy", "input", 0.8F, 1, false).build(),
        ]).setChance(0.05)
        .addCatalystInput(<enderio:item_alloy_ball:1>,
        ["§f当做磨珠子使用喵§e280%§f额外输出，§e110%§f能耗。"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output", 2.8F, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:energy", "input", 1.1F, 1, false).build(),
        ]).setChance(0.05)
.addCatalystInput(<enderio:item_alloy_ball:2>,
        ["§f当做磨珠子使用喵§e310%§f额外输出，§e135%§f能耗。"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output", 3.1F, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:energy", "input", 1.35F, 1, false).build(),
        ]).setChance(0.05)

.addCatalystInput(<enderio:item_alloy_ball:3>,
        ["§f当做磨珠子使用喵§e200%§f额外输出，§e35%§f能耗。"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:energy", "input", 0.35F, 1, false).build(),
        ]).setChance(0.05)

.addCatalystInput(<enderio:item_alloy_ball:4>,
        ["§f当做磨珠子使用喵§e235%§f额外输出，§e100%§f能耗。"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output", 2.35F, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:energy", "input", 1.0F, 1, false).build(),
        ]).setChance(0.05)
        .addCatalystInput(<enderio:item_alloy_ball:5>,
        ["§f当做磨珠子使用喵§e285%§f额外输出，§e100%§f能耗。"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output", 2.85F, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:energy", "input", 1.0F, 1, false).build(),
        ]).setChance(0.05)

.addCatalystInput(<enderio:item_alloy_ball:6>,
        ["§f当做磨珠子使用喵§e335%§f额外输出，§e70%§f能耗。"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output", 3.35F, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:energy", "input", 0.7F, 1, false).build(),
        ]).setChance(0.05)

.addCatalystInput(<enderio:item_alloy_ball:7>,
        ["§f当做磨珠子使用喵§e320%§f额外输出，§e90%§f能耗。"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output", 3.2F, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:energy", "input", 0.9F, 1, false).build(),
        ]).setChance(0.05)
.addCatalystInput(<enderio:item_alloy_ball:8>,
        ["§f当做高效磨珠使用§e360%§f额外输出，§e65%§f能耗。"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output", 3.6F, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:energy", "input", 0.65F, 1, false).build(),
        ]).setChance(0.05)
.addCatalystInput(<enderio:item_alloy_ball:9>,
        ["§f当做磨珠子使用喵§e133%§f额外输出，§e25%§f能耗。"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output", 1.33F, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:energy", "input", 0.25F, 1, false).build(),
        ]).setChance(0.05)
.addCatalystInput(<enderio:item_material:57>,
        ["§f当做磨珠子使用喵§e275%§f额外输出，§e25%§f能耗。"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output", 2.75F, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:energy", "input", 0.25F, 1, false).build(),
        ]).setChance(0.05)

.addCatalystInput(<enderio:item_material:58>,
        ["§f当做磨珠子使用喵§e400%§f额外输出，§e100%§f能耗。"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output", 4.0F, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:energy", "input", 1.0F, 1, false).build(),
        ]).setChance(0.05)

.addCatalystInput(<enderio:item_material:59>,
        ["§f当做磨珠子使用喵§e350%§f额外输出，§e90%§f能耗。"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output", 3.5F, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:energy", "input", 0.9F, 1, false).build(),
        ]).setChance(0.05)
.addCatalystInput(<enderio:item_alloy_endergy_ball>,
        ["§f当做磨珠子使用喵§e245%§f额外输出，§e85%§f能耗。"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output", 2.45F, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:energy", "input", 0.85F, 1, false).build(),
        ]).setChance(0.05)

.addCatalystInput(<enderio:item_alloy_endergy_ball:1>,
        ["§f当做磨珠子使用喵§e320%§f额外输出，§e145%§f能耗。"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output", 3.2F, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:energy", "input", 1.45F, 1, false).build(),
        ]).setChance(0.05)

.addCatalystInput(<enderio:item_alloy_endergy_ball:2>,
        ["§f当做磨珠子使用喵§e400%§f额外输出，§e125%§f能耗。"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output", 4.0F, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:energy", "input", 1.25F, 1, false).build(),
        ]).setChance(0.05)

.addCatalystInput(<enderio:item_alloy_endergy_ball:3>,
        ["§f当做磨珠子使用喵§e400%§f额外输出，§e150%§f能耗。"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output", 4.0F, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:energy", "input", 1.5F, 1, false).build(),
        ]).setChance(0.05)

.addCatalystInput(<enderio:item_alloy_endergy_ball:4>,
        ["§f当做磨珠子使用喵§e330%§f额外输出，§e155%§f能耗。"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output", 3.3F, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:energy", "input", 1.55F, 1, false).build(),
        ]).setChance(0.05)

.addCatalystInput(<enderio:item_alloy_endergy_ball:5>,
        ["§f当做磨珠子使用喵§e270%§f额外输出，§e110%§f能耗。"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output", 2.7F, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:energy", "input", 1.1F, 1, false).build(),
        ]).setChance(0.05)
.addCatalystInput(<enderio:item_alloy_endergy_ball:6>,
        ["§f当做磨珠子使用喵§e310%§f额外输出，§e135%§f能耗。"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output", 3.1F, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:energy", "input", 1.35F, 1, false).build(),
        ]).setChance(0.05)
    .build();
