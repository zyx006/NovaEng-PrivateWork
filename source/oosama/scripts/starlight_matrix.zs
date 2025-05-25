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
MachineModifier.setInternalParallelism("starlight_matrix", 32);
//设置最大线程
MachineModifier.setMaxThreads("starlight_matrix", 5);
//starlight_matrix控制器
RecipeBuilder.newBuilder("starlight_matrix_1", "machine_arm",2400)
    .addEnergyPerTickInput(128000)
    .addInputs(<modularmachinery:blockcasing> * 64)  // 机械外壳
    .addInputs(<mekanism:controlcircuit:2>* 64)  // 精英电路板
    .addOutputs(<modularmachinery:starlight_matrix_factory_controller> * 1) 
    .addRecipeTooltip("大机器！你为什么要抛弃我们！") // 提示信息：描述配方功能
    .build();

//星能液产出

var recipeCounter = -1;  // 配方优先级

RecipeBuilder.newBuilder("hs_xingnengyechanchu", "starlight_matrix", 300)
    .addInput(<extrabotany:material:3>).setChance(0)
    .addFluidPerTickOutput(<liquid:astralsorcery.liquidstarlight> *50)
    .addCatalystInput(<astralsorcery:itemcoloredlens:6>,
        ["注入了星能的彩色透镜拥有将星能汇聚的能力。", "使星能液的产量翻倍。"],
        [
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 2.0F, 1, false).build(),
        ]).setChance(0)
    .addCatalystInput(<ancientspellcraft:astral_diamond_charged>,
        ["充能后的星芒宝钻蕴含着众多遗灵强大的能量。", "使星能液的产量 §ax3§f。"],
        [
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 3.0F, 1, false).build(),
        ]).setChance(0)
        
    .addCatalystInput(<avaritia:resource:5>,
        ["一即全，全即一。", "使星能液的产量 §ax3§f。"],
        [
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 3.0F, 1, false).build(),
        ]).setChance(0)

    .addCatalystInput(<additions:novaextended-novaextended_medal2>,
        ["美丽的时钟座。", "使星能液的生产速率 §ax2§f。"],
        [
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 2.0F, 1, false).build(),
        ]).setChance(0)

    .addCatalystInput(<ebwizardry:astral_diamond>,
        ["事情的一部分当然是不可缺少的。", "使星能液的产量 §ax2§f。"],
        [
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 2.0F, 1, false).build(),
        ]).setChance(0.01)

    .addPreCheckHandler(function(event as RecipeCheckEvent) {
     event.activeRecipe.maxParallelism = 6;
    })
    .addRecipeTooltip(
    "§a英雄徽章§f数量影响并行数",
    "星能矩阵：运行此配方自带6并行"
    ) // 提示信息：描述配方功能
    .setMaxThreads(1)
    .build();

//岩浆产出
RecipeBuilder.newBuilder("xh_netherrack_lava", "starlight_matrix", 100)
    .addInput(<ore:netherrack>).setChance(0.45)
    .addFluidPerTickOutput(<liquid:lava> * 15)
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
     event.activeRecipe.maxParallelism = 6;
    })
    .addRecipeTooltip("星能矩阵：运行此配方自带6并行") // 提示信息：描述配方功能
    .setMaxThreads(1)
    .build();

RecipeBuilder.newBuilder("xh_magma_lava", "starlight_matrix", 200)
    .addInput(<ore:blockMagma>).setChance(0.25)
    .addFluidPerTickOutput(<liquid:lava> * 30)
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
     event.activeRecipe.maxParallelism = 6;
    })
    .addRecipeTooltip("星能矩阵：运行此配方自带6并行") // 提示信息：描述配方功能
    .setMaxThreads(1)
    .build();

//配方继承（五彩观象台）
RecipeAdapterBuilder.create("starlight_matrix", "modularmachinery:iridescentobservatory")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.5F, 1, false).build())
    .build();

// 新配方：飞龙剑
RecipeBuilder.newBuilder("xhzz_wyvern_sword", "starlight_matrix", 100)
    .addEnergyPerTickInput(640000)
    .addItemInput(<draconicevolution:draconium_ingot>*4) // 龙锭 x4
    .addItemInput(<mekanism:ingot>) // 强化黑曜石 x1
    .addItemInput(<redstonerepository:tool.sword_gelid>) // 凝胶斧头
    .addItemInput(<draconicevolution:wyvern_core>*2) // 飞龙核心 x2
    .addItemInput(<enderio:item_material:71>*2) // 无尽之杆 x2
    .addItemInput(<extrabotany:material:3>) // 英雄徽章X1
    .addItemInput(<deepmoblearning:glitch_fragment>) // 故障碎片 x1
    .addItemInput(<draconicevolution:wyvern_energy_core>) // 飞龙能量核心 x1
    .addItemOutput(<draconicevolution:wyvern_sword>) // 输出：飞龙剑
    .addRecipeTooltip("星辉铸造：\n凝聚星能与龙之力，锻造出强大的飞龙剑！") // 提示信息：描述配方功能
    .build();
    // 新配方：飞龙镐
RecipeBuilder.newBuilder("xhzz_wyvern_pick", "starlight_matrix", 100)
    .addEnergyPerTickInput(640000)
    .addItemInput(<draconicevolution:draconium_ingot>*4) // 龙锭 x4
    .addItemInput(<mekanism:ingot>*2) // 强化黑曜石 x2
    .addItemInput(<redstonerepository:tool.pickaxe_gelid>) // 凝胶镐头
    .addItemInput(<enderio:item_material:71>*2) // 无尽之杆 x2
    .addItemInput(<draconicevolution:wyvern_core>*2) // 飞龙核心 x2
    .addItemInput(<extrabotany:material:3>) // 英雄徽章X1
    .addItemInput(<deepmoblearning:glitch_fragment>) // 故障碎片 x1
    .addItemInput(<draconicevolution:wyvern_energy_core>) // 飞龙能量核心 x1
    .addItemOutput(<draconicevolution:wyvern_pick>) // 输出：飞龙镐
    .addRecipeTooltip("星辉铸造：\n凝聚星能与龙之力，锻造出强大的飞龙镐！") // 提示信息：描述配方功能
    .build();
    // 新配方：飞龙斧
RecipeBuilder.newBuilder("xhzz_wyvern_axe", "starlight_matrix", 100)
    .addEnergyPerTickInput(640000)
    .addItemInput(<draconicevolution:draconium_ingot>*2) // 龙锭 x2
    .addItemInput(<redstonerepository:tool.axe_gelid>) // 凝胶斧头
    .addItemInput(<enderio:item_material:71>*2) // 无尽之杆 x2
    .addItemInput(<draconicevolution:wyvern_core>) // 飞龙核心 x1
    .addItemInput(<enderio:item_alloy_endergy_ingot:2>) // 旋律合金 x1
    .addItemInput(<mekanism:ingot>) // 强化黑曜石 x1
    .addItemInput(<extrabotany:material:3>) // 英雄徽章X1
    .addItemInput(<deepmoblearning:glitch_fragment>) // 故障碎片 x1
    .addItemInput(<draconicevolution:wyvern_energy_core>) // 飞龙能量核心 x1
    .addItemOutput(<draconicevolution:wyvern_axe>) // 输出：飞龙斧
    .addRecipeTooltip("星辉铸造：\n凝聚星能与龙之力，锻造出强大的飞龙斧！") // 提示信息：描述配方功能
    .build();
    // 新配方：飞龙铲
RecipeBuilder.newBuilder("xhzz_wyvern_shovel", "starlight_matrix", 100)
    .addEnergyPerTickInput(640000)
    .addItemInput(<draconicevolution:draconium_ingot>*2) // 龙锭 x2
    .addItemInput(<redstonearsenal:tool.excavator_flux>) // 红石铲
    .addItemInput(<enderio:item_material:71>*2) // 无尽之杆 x2
    .addItemInput(<draconicevolution:wyvern_core>) // 飞龙核心 x1
    .addItemInput(<mekanism:ingot>) // 强化黑曜石 x1
    .addItemInput(<extrabotany:material:3>) // 英雄徽章X1
    .addItemInput(<deepmoblearning:glitch_fragment>) // 故障碎片 x1
    .addItemInput(<draconicevolution:wyvern_energy_core>) // 飞龙能量核心 x1
    .addItemOutput(<draconicevolution:wyvern_shovel>) // 输出：飞龙铲
    .addRecipeTooltip("星辉铸造：\n凝聚星能与龙之力，锻造出强大的飞龙铲！") // 提示信息：描述配方功能
    .build();
    // 新配方：飞龙弓
RecipeBuilder.newBuilder("xhzz_wyvern_bow", "starlight_matrix", 100)
    .addEnergyPerTickInput(640000)
    .addItemInput(<enderio:item_end_steel_bow>) // 末影钢弓
    .addItemInput(<enderio:item_material:71>*2) // 无尽之杆 x2
    .addItemInput(<draconicevolution:wyvern_core>*2) // 飞龙核心 x2
    .addItemInput(<botania:manaresource:16>*2) // 魔法绳索 x2
    .addItemInput(<draconicevolution:draconium_ingot>*2) // 龙锭 x2
    .addItemInput(<mekanism:ingot>*2) // 强化黑曜石 x2
    .addItemInput(<extrabotany:material:3>) // 英雄徽章X1
    .addItemInput(<deepmoblearning:glitch_fragment>) // 故障碎片 x1
    .addItemInput(<draconicevolution:wyvern_energy_core>) // 飞龙能量核心 x1
    .addItemOutput(<draconicevolution:wyvern_bow>) // 输出：飞龙弓
    .addRecipeTooltip("星辉铸造：\n凝聚星能与龙之力，锻造出强大的飞龙弓！") // 提示信息：描述配方功能
    .build();
// 新配方：飞龙头盔
RecipeBuilder.newBuilder("xhzz_wyvern_helm", "starlight_matrix", 100)
    .addEnergyPerTickInput(640000)
    .addItemInput(<draconicevolution:draconium_ingot>*4) // 龙锭 x4
    .addItemInput(<redstonerepository:armor.helmet_gelid>) // 凝胶头盔
    .addItemInput(<enderio:item_alloy_endergy_ingot:2>*2) // 旋律合金 x2
    .addItemInput(<draconicevolution:wyvern_core>*2) // 飞龙核心 x2
    .addItemInput(<mekanism:ingot>*3) // 强化黑曜石 x3
    .addItemInput(<extrabotany:material:3>) // 英雄徽章X1
    .addItemInput(<bloodmagic:item_demon_crystal:4>) // 恶魔水晶 x1
    .addItemInput(<contenttweaker:field_generator_v1>) // 场生成器 v1 x1
    .addItemInput(<draconicevolution:wyvern_energy_core>) // 飞龙能量核心 x1
    .addItemOutput(<draconicevolution:wyvern_helm>) // 输出：飞龙头盔
    .addRecipeTooltip("星辉铸造：\n凝聚星能与龙之力，锻造出坚固的飞龙头盔！") // 提示信息：描述配方功能
    .build();
    // 新配方：飞龙胸甲
RecipeBuilder.newBuilder("xhzz_wyvern_chest", "starlight_matrix", 100)
    .addEnergyPerTickInput(640000)
    .addItemInput(<enderio:item_alloy_endergy_ingot:2>*3) // 旋律合金 x3
    .addItemInput(<draconicevolution:draconium_ingot>*4) // 龙锭 x4
    .addItemInput(<redstonerepository:armor.chestplategelid>) // 凝胶胸甲
    .addItemInput(<draconicevolution:wyvern_core>*2) // 飞龙核心 x2
    .addItemInput(<mekanism:ingot>*2) // 强化黑曜石 x2
    .addItemInput(<extrabotany:material:3>) // 英雄徽章X1
    .addItemInput(<bloodmagic:item_demon_crystal:4>) // 恶魔水晶 x1
    .addItemInput(<contenttweaker:field_generator_v1>) // 场生成器 v1 x1
    .addItemInput(<draconicevolution:wyvern_energy_core>) // 飞龙能量核心 x1
    .addItemOutput(<draconicevolution:wyvern_chest>) // 输出：飞龙胸甲
    .addRecipeTooltip("星辉铸造：\n凝聚星能与龙之力，锻造出坚固的飞龙胸甲！") // 提示信息：描述配方功能
    .build();
    // 新配方：飞龙护腿
RecipeBuilder.newBuilder("xhzz_wyvern_legs", "starlight_matrix", 100)
    .addEnergyPerTickInput(640000)
    .addItemInput(<enderio:item_alloy_endergy_ingot:2>*3) // 旋律合金 x3
    .addItemInput(<draconicevolution:draconium_ingot>*4) // 龙锭 x4
    .addItemInput(<redstonerepository:armor.leggings_gelid>) // 凝胶护腿
    .addItemInput(<draconicevolution:wyvern_core>*2) // 飞龙核心 x2
    .addItemInput(<mekanism:ingot>*2) // 强化黑曜石 x2
    .addItemInput(<extrabotany:material:3>) // 英雄徽章X1
    .addItemInput(<bloodmagic:item_demon_crystal:4>) // 恶魔水晶 x1
    .addItemInput(<contenttweaker:field_generator_v1>) // 场生成器 v1 x1
    .addItemInput(<draconicevolution:wyvern_energy_core>) // 飞龙能量核心 x1
    .addItemOutput(<draconicevolution:wyvern_legs>) // 输出：飞龙护腿
    .addRecipeTooltip("星辉铸造：\n凝聚星能与龙之力，锻造出坚固的飞龙护腿！") // 提示信息：描述配方功能
    .build();
    // 新配方：飞龙靴子
RecipeBuilder.newBuilder("xhzz_wyvern_boots", "starlight_matrix", 100)
    .addEnergyPerTickInput(640000)
    .addItemInput(<draconicevolution:draconium_ingot>*2) // 龙锭 x2
    .addItemInput(<redstonerepository:armor.boots_gelid>) // 凝胶靴子
    .addItemInput(<enderio:item_material:71>*3) // 无尽之杆 x3
    .addItemInput(<draconicevolution:wyvern_core>*2) // 飞龙核心 x2
    .addItemInput(<mekanism:ingot>*3) // 强化黑曜石 x3
    .addItemInput(<extrabotany:material:3>) // 英雄徽章X1
    .addItemInput(<bloodmagic:item_demon_crystal:4>) // 恶魔水晶 x1
    .addItemInput(<contenttweaker:field_generator_v1>) // 场生成器 v1 x1
    .addItemInput(<draconicevolution:wyvern_energy_core>) // 飞龙能量核心 x1
    .addItemOutput(<draconicevolution:wyvern_boots>) // 输出：飞龙靴子
    .addRecipeTooltip("星辉铸造：\n凝聚星能与龙之力，锻造出坚固的飞龙靴子！") // 提示信息：描述配方功能
    .build();

      // 新配方：星耀勋章
RecipeBuilder.newBuilder("xhzz_medal", "starlight_matrix", 40)
    .addEnergyPerTickInput(640000)
    .addItemInput(<astralsorcery:itemcraftingcomponent:4> * 8) // 共振宝石 x8
    .addItemInput(<extrabotany:material:3> * 1) // 英雄徽章 x1
    .addItemInput(<additions:novaextended-terraalloy> * 1) // 泰拉合金 x1
    .addItemInput(<additions:novaextended-ingot8>* 2) // 柳木合金 x2
    .addInput(<liquid:astralsorcery.liquidstarlight>* 8000) // 星能液桶 1000 MB * 8
    .addItemOutput(<additions:novaextended-novaextended_medal>) // 输出：星耀勋章
    .addRecipeTooltip("星耀共鸣：\n汇聚星光之力，铸就荣耀勋章！") // 提示信息：描述配方功能
    .build();

// 新配方：星耀勋章1
RecipeBuilder.newBuilder("xhzz_medal1", "starlight_matrix", 40)
    .addEnergyPerTickInput(640000)
    .addItemInput(<additions:novaextended-novaextended_medal> * 1) // 星耀勋章
    .addItemInput(<astralsorcery:itemcraftingcomponent:4> * 4) // 共振宝石 x4
    .addItemInput(<minecraft:gold_ore> * 1) // 金矿石 x1
    .addItemInput(<minecraft:iron_ore> * 1) // 铁矿石 x1
    .addItemInput(<minecraft:diamond_ore> * 1) // 钻石矿石 x1
    .addItemInput(<minecraft:emerald_ore> * 1) // 绿宝石矿石 x1
    .addInput(<liquid:astralsorcery.liquidstarlight>* 4000) // 星能液桶 1000 MB * 4
    .addItemOutput(<additions:novaextended-novaextended_medal1>) // 输出：星耀勋章1
    .addRecipeTooltip("晶金共鸣：\n结合矿物的力量，提升勋章等级！") // 提示信息：描述配方功能
    .build();

// 新配方：星耀勋章2
RecipeBuilder.newBuilder("xhzz_medal2", "starlight_matrix", 40)
    .addEnergyPerTickInput(640000)
    .addItemInput(<additions:novaextended-novaextended_medal> * 1) // 星耀勋章
    .addItemInput(<astralsorcery:itemcraftingcomponent:4> * 4) // 共振宝石 x4
    .addItemInput(<minecraft:clock> * 1) // 时钟 x1
    .addItemInput(<minecraft:redstone> * 1) // 红石粉 x1
    .addItemInput(<minecraft:glowstone_dust> * 1) // 萤石粉 x1
    .addItemInput(<rftools:timer_block> * 1) // RFTools 定时器 x1
    .addInput(<liquid:astralsorcery.liquidstarlight>* 4000) // 星能液桶 1000 MB * 4
    .addItemOutput(<additions:novaextended-novaextended_medal2>) // 输出：星耀勋章2
    .addRecipeTooltip("时钟共鸣：\n融合时间的力量，提升勋章等级！") // 提示信息：描述配方功能
    .build();

// 新配方：星耀勋章3
RecipeBuilder.newBuilder("xhzz_medal3", "starlight_matrix", 40)
    .addEnergyPerTickInput(640000)
    .addItemInput(<avaritia:resource:5> * 2) // 极限资源 x2
    .addItemInput(<additions:novaextended-novaextended_medal> * 1) // 星耀勋章
    .addItemInput(<astralsorcery:itemcraftingcomponent:4> * 4) // 共振宝石 x4
    .addItemInput(<minecraft:diamond_block> * 1) // 钻石块 x1
    .addItemInput(<minecraft:lapis_block> * 1) // 青金石块 x1
    .addItemInput(<extrabotany:material:3> * 1) // 英雄徽章 x1
    .addItemInput(<jaopca:block_blockwillowalloy> * 1) // 柳木合金块 x1
    .addItemInput(<avaritia:resource:6>* 1) // 无尽锭 x1
    .addInput(<liquid:astralsorcery.liquidstarlight>* 4000) // 星能液桶 1000 MB * 4
    .addItemOutput(<additions:novaextended-novaextended_medal3>) // 输出：星耀勋章3
    .addRecipeTooltip("避役共鸣：\n融合无尽的力量，提升勋章等级！") // 提示信息：描述配方功能
    .build();

// 新配方：星耀勋章4
RecipeBuilder.newBuilder("xhzz_medal4", "starlight_matrix", 40)
    .addEnergyPerTickInput(640000)
    .addItemInput(<additions:novaextended-novaextended_medal> * 1) // 星耀勋章
    .addItemInput(<astralsorcery:itemcraftingcomponent:4> * 4) // 共振宝石 x4
    .addItemInput(<minecraft:pumpkin> * 1) // 南瓜 x1
    .addItemInput(<minecraft:melon> * 1) // 西瓜 x1
    .addItemInput(<minecraft:hay_block> * 1) // 干草块 x1
    .addItemInput(<minecraft:wool> * 1) // 羊毛块 x1
    .addInput(<liquid:astralsorcery.liquidstarlight>* 4000) // 星能液桶 1000 MB * 4
    .addItemOutput(<additions:novaextended-novaextended_medal4>) // 输出：星耀勋章4
    .addRecipeTooltip("牧夫共鸣：\n融合丰收的力量，提升勋章等级！") // 提示信息：描述配方功能
    .build();

// 新配方：星耀勋章5
RecipeBuilder.newBuilder("xhzz_medal5", "starlight_matrix", 40)
    .addEnergyPerTickInput(640000)
    .addItemInput(<additions:novaextended-novaextended_medal> * 1) // 星耀勋章
    .addItemInput(<astralsorcery:itemcraftingcomponent:4> * 4) // 共振宝石 x4
    .addItemInput(<minecraft:bone> * 1) // 骨头 x1
    .addItemInput(<minecraft:nether_star> * 1) // 下界之星 x1
    .addItemInput(<minecraft:ender_pearl> * 1) // 末影珍珠 x1
    .addItemInput(<deepmoblearning:glitch_heart> * 1) // 故障核心 x1
    .addInput(<liquid:astralsorcery.liquidstarlight>* 4000) // 星能液桶 1000 MB * 4
    .addItemOutput(<additions:novaextended-novaextended_medal5>) // 输出：星耀勋章5
    .addRecipeTooltip("唤生共鸣：\n融合星辰的力量，提升勋章等级！") // 提示信息：描述配方功能
    .build();

    // 新配方：玻璃板转化为玻璃透镜
RecipeBuilder.newBuilder("glass_to_lens", "starlight_matrix", 20) // 时间调整为20 ticks (1秒)，
    .addItemInput(<minecraft:glass_pane> * 1) // 玻璃板 x1
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:itemcraftingcomponent:3> * 1) // 输出：玻璃透镜 x1
    .addRecipeTooltip("星能矩阵转化：\n通过精确的电力输入，将普通的玻璃板转化为神秘的玻璃透镜！") // 提示信息：描述配方功能
    .build();

    // 新配方：海蓝宝石 + 萤石粉 制作 辉光粉
RecipeBuilder.newBuilder("hs_glow_dust", "starlight_matrix", 20) // 时间调整为20 ticks (1秒)，
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 1) // 海蓝宝石 x1
    .addItemInput(<minecraft:glowstone_dust> * 4) // 萤石粉 x4
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:itemusabledust> * 16) // 输出：辉光粉 x16
    .addRecipeTooltip("星能转化：\n通过星光矩阵的力量，将海蓝宝石与萤石粉转化为大量辉光粉！") // 提示信息：描述配方功能
    .build();

    // 新配方：海蓝宝石 + 煤炭变种 制作 暗夜粉
RecipeBuilder.newBuilder("hs_dark_dust", "starlight_matrix", 20) // 时间调整为20 ticks (1秒)，
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 1) // 海蓝宝石 x1
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <minecraft:coal>* 4,               // 普通煤炭
                <minecraft:coal:1>* 4,             // 木炭
                <contenttweaker:material_part:84>* 4 // 未雕琢的煤炭
            ]) // 每种煤炭变种的数量为 4
    )
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:itemusabledust:1> * 16) // 输出：暗夜粉 x16
    .addRecipeTooltip("星能转化：\n通过星光矩阵的力量，将海蓝宝石与煤炭转化为大量暗夜粉！") // 提示信息：描述配方功能
    .build();

    // 新配方：金粒 + 木板 + 大理石块 + 玻璃透镜 制作 光波增幅器
RecipeBuilder.newBuilder("hs_lightwave_amplifier", "starlight_matrix", 20) // 时间调整为20 ticks (1秒)，
    .addItemInput(<minecraft:gold_nugget> * 2) // 金粒 x2
    .addInput(<ore:plankWood>*2)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <astralsorcery:blockmarble> * 1,    // 大理石块 元数据 1 x1   
                <astralsorcery:blockmarble:1> * 1,    // 大理石块 元数据 1 x1
                <astralsorcery:blockmarble:2> * 1,    // 大理石块 元数据 2 x1
                <astralsorcery:blockmarble:3> * 1,    // 大理石块 元数据 3 x1
                <astralsorcery:blockmarble:4> * 1,    // 大理石块 元数据 4 x1
                <astralsorcery:blockmarble:5> * 1,    // 大理石块 元数据 5 x1
                <astralsorcery:blockmarble:6> * 1,    // 大理石块 元数据 6 x1
            ])
    )
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1) // 玻璃透镜 x1
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:blockattunementrelay> * 1) // 输出：光波增幅器 x1
    .addRecipeTooltip("星能转化：\n通过星光矩阵的力量，将材料转化为一个光波增幅器！") // 提示信息：描述配方功能及产物名称
    .build();

// 新配方：辉光粉 + 玻璃透镜 + 光波增幅器 制作 标记光波增幅器
RecipeBuilder.newBuilder("hs_marked_relay", "starlight_matrix", 20) // 时间调整为20 ticks (1秒)，
    .addItemInput(<astralsorcery:itemusabledust> * 3) // 辉光粉 x3
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1) // 玻璃透镜 x1
    .addItemInput(<astralsorcery:blockattunementrelay> * 1) // 光波增幅器 x1
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<packagedastral:marked_relay> * 1) // 输出：标记光波增幅器 x1
    .addRecipeTooltip("星能转化：\n将材料转化为标记光波增幅器！") // 提示信息：描述配方功能
    .build();

    // 新配方：羽毛 + 辉光粉 + 星尘 + 羊皮纸 + 煤炭变种 制作 知识共享卷轴
RecipeBuilder.newBuilder("hs_knowledge_share", "starlight_matrix", 20) // 时间调整为20 ticks (1秒)，
    .addItemInput(<minecraft:feather> * 1) // 羽毛 x1
    .addItemInput(<astralsorcery:itemusabledust> * 4) // 辉光粉 x4
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 2) // 星尘 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent:5> * 1) // 羊皮纸 x1
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <minecraft:coal>,               // 普通煤炭
                <minecraft:coal:1>,             // 木炭
                <contenttweaker:material_part:84> // 未雕琢的煤炭
            ]) // 煤炭变种 x1
    )
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:itemknowledgeshare> * 1) // 输出：知识共享卷轴 x1
    .addRecipeTooltip("星能转化：\n通过星光矩阵的力量，将材料转化为知识共享卷轴！") // 提示信息：描述配方功能
    .build();

// 新配方：水晶石 + 星辉锭 + 星尘 + 辉光粉 + 玻璃透镜 + 大理石块 制作 天体星门
RecipeBuilder.newBuilder("hs_celestial_gateway", "starlight_matrix", 20) // 时间调整为20 ticks (1秒)，
    .addItemInput(<astralsorcery:itemrockcrystalsimple> * 1) // 水晶石 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent:1> * 1) // 星辉锭 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 4) // 星尘 x4
    .addItemInput(<astralsorcery:itemusabledust> * 2) // 辉光粉 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1) // 玻璃透镜 x1
    .addItemInput(<astralsorcery:blockmarble:6>*2)//大理石X2
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:blockcelestialgateway> * 1) // 输出：天体星门 x1
    .addRecipeTooltip("星能转化：\n通过星光矩阵的力量，制造出天体星门！") // 提示信息：仅描述产物名称
    .build();

// 新配方：海蓝宝石 + 玻璃透镜 + 水晶石 + 金锭 + 大理石块 + 聚星木 制作 透镜
RecipeBuilder.newBuilder("hs_lens", "starlight_matrix", 20) // 时间调整为20 ticks (1秒)，
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 3) // 玻璃透镜 x3
    .addItemInput(<astralsorcery:itemrockcrystalsimple> * 1) // 水晶石 x1
    .addItemInput(<minecraft:gold_ingot> * 1) // 金锭 x1
    .addItemInput(<astralsorcery:blockmarble:6>*2)//大理石X2
    .addItemInput(<astralsorcery:blockinfusedwood:4> * 2) // 聚星木（元数据4）x2
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:blocklens> * 1) // 输出：透镜 x1
    .addRecipeTooltip("星能转化：\n制造出透镜！") // 提示信息：仅描述产物名称
    .build();

RecipeBuilder.newBuilder("hs_colored_lens_burning", "starlight_matrix", 20)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1) // 透镜 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<minecraft:blaze_powder> * 6) // 烈焰粉 x6
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:itemcoloredlens:0>) // 输出：燃烧透镜 x1
    .addRecipeTooltip("星能转化：\n制造出燃烧透镜！") // 提示信息
    .build();

RecipeBuilder.newBuilder("hs_colored_lens_destruction", "starlight_matrix", 20)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1) // 透镜 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<minecraft:iron_pickaxe> * 1) // 铁镐 x1
    .addItemInput(<minecraft:gold_ingot> * 2) // 金锭 x2
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:itemcoloredlens:1>) // 输出：破坏透镜 x1
    .addRecipeTooltip("星能转化：\n制造出破坏透镜！") // 提示信息
    .build();

RecipeBuilder.newBuilder("hs_colored_lens_growth", "starlight_matrix", 20)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1) // 透镜 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<minecraft:wheat_seeds> * 6) // 小麦种子 x6
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:itemcoloredlens:2>) // 输出：生长透镜 x1
    .addRecipeTooltip("星能转化：\n制造出生长透镜！") // 提示信息
    .build();

RecipeBuilder.newBuilder("hs_colored_lens_damage", "starlight_matrix", 20)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1) // 透镜 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<minecraft:iron_sword> * 2) // 铁剑 x2
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:itemcoloredlens:3>) // 输出：伤害透镜 x1
    .addRecipeTooltip("星能转化：\n制造出伤害透镜！") // 提示信息
    .build();

RecipeBuilder.newBuilder("hs_colored_lens_regeneration", "starlight_matrix", 20)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1) // 透镜 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<minecraft:apple> * 1) // 苹果 x1
    .addItemInput(<minecraft:diamond> * 1) // 钻石 x1
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:itemcoloredlens:4>) // 输出：再生透镜 x1
    .addRecipeTooltip("星能转化：\n制造出再生透镜！") // 提示信息
    .build();

RecipeBuilder.newBuilder("hs_colored_lens_repulsion", "starlight_matrix", 20)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1) // 透镜 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<minecraft:piston> * 2) // 活塞 x2
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:itemcoloredlens:5>) // 输出：抗拒透镜 x1
    .addRecipeTooltip("星能转化：\n制造出抗拒透镜！") // 提示信息
    .build();

RecipeBuilder.newBuilder("hs_colored_lens_convergence", "starlight_matrix", 20)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1) // 透镜 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<astralsorcery:itemusabledust> * 4) // 辉光粉 x4
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:itemcoloredlens:6>) // 输出：汇聚透镜 x1
    .addRecipeTooltip("星能转化：\n制造出汇聚透镜！") // 提示信息
    .build();

    // 新配方：树叶（可替代）+ 树苗（可替代）+ 星能液桶 + 大理石块（元数据6）+ 海蓝宝石 制作 烽火树
RecipeBuilder.newBuilder("hs_tree_beacon", "starlight_matrix", 20) // 时间调整为20 ticks (1秒)
    .addInput(<ore:treeLeaves>*6)
    .addInput(<ore:treeSapling>)
    .addInput(<liquid:astralsorcery.liquidstarlight>* 1000) // 星能液桶 x1
    .addItemInput(<astralsorcery:blockmarble:6> * 4) // 大理石块（元数据6）x4
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 1) // 海蓝宝石 x1
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:blocktreebeacon> * 1) // 输出：烽火树 x1
    .addRecipeTooltip("星能转化：\n制造出烽火树！") // 提示信息：仅描述产物名称
    .build();

    // 新配方：金粒 + 金锭 + 玻璃板 + 玻璃透镜 + 星尘 + 海蓝宝石 制作 效应链接通道 x2
RecipeBuilder.newBuilder("hs_ritual_link", "starlight_matrix", 20) // 时间调整为20 ticks (1秒)，
    .addItemInput(<minecraft:gold_nugget> * 4) // 金粒 x4
    .addItemInput(<minecraft:gold_ingot> * 1) // 金锭 x1
    .addItemInput(<minecraft:glass_pane> * 4) // 玻璃板 x4
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 2) // 玻璃透镜 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 1) // 星尘 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 1) // 海蓝宝石 x1
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:blockrituallink> * 2) // 输出：效应链接通道 x2
    .addRecipeTooltip("星能转化：\n制造出效应链接通道！") // 提示信息：仅描述产物名称
    .build();

    // 新配方：星尘 + 海蓝宝石 + 大理石柱（元数据6）+ 星能液桶 + 辉光粉 制作 更替之星
RecipeBuilder.newBuilder("hs_shifting_star", "starlight_matrix", 20) // 时间调整为20 ticks (1秒)，
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 2) // 星尘 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 4) // 海蓝宝石 x4
    .addItemInput(<astralsorcery:blockmarble:6> * 4) // 大理石柱（元数据6）x4
    .addInput(<liquid:astralsorcery.liquidstarlight>* 1000) // 星能液桶 x1
    .addItemInput(<astralsorcery:itemusabledust> * 2) // 辉光粉 x2
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:itemshiftingstar>* 1) // 输出：更替之星 x1
    .addRecipeTooltip("星能转化：\n制造出更替之星！") // 提示信息：仅描述产物名称
    .build();

    // 新配方：更替之星 + 原石 + 星尘 + 辉光粉 制作 辐射之星（解离座）
RecipeBuilder.newBuilder("hs_radiation_star_evorsio", "starlight_matrix", 20) // 时间1秒，
    .addItemInput(<astralsorcery:itemshiftingstar>* 1) // 更替之星 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 4) // 原石 x4
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 8) // 星尘 x8
    .addItemInput(<astralsorcery:itemusabledust> * 2) // 辉光粉 x2
    .addEnergyPerTickInput(600) // 每 tick 输入 600 单位电力 (总电力消耗 = 600 * 30 = 18000)
    .addItemOutput(<astralsorcery:itemshiftingstar>.withTag({astralsorcery: {starAttunement: "astralsorcery.constellation.evorsio"}}) * 1) // 输出：辐射之星（解离座）x1
    .addRecipeTooltip("星能转化：\n制造出解离座（Evorsio）！") // 提示信息：描述产物名称
    .build();

    // 新配方：更替之星 + 树苗 + 星尘 + 辉光粉 制作 生息座（Aevitas）
RecipeBuilder.newBuilder("hs_life_star_aevitas", "starlight_matrix", 20) // 时间1秒，
    .addItemInput(<astralsorcery:itemshiftingstar>* 1) // 更替之星 x1
    .addInput(<ore:treeSapling>*4)
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 8) // 星尘 x8
    .addItemInput(<astralsorcery:itemusabledust> * 2) // 辉光粉 x2
    .addEnergyPerTickInput(600) // 每 tick 输入 600 单位电力 (总电力消耗 = 600 * 30 = 18000)
    .addItemOutput(<astralsorcery:itemshiftingstar>.withTag({astralsorcery: {starAttunement: "astralsorcery.constellation.aevitas"}}) * 1) // 输出：生息座（Aevitas）x1
    .addRecipeTooltip("星能转化：\n制造出生息座（Aevitas）！") // 提示信息：描述产物名称
    .build();

    // 新配方：更替之星 + 羽毛 + 星尘 + 辉光粉 制作 虚御座（Vicio）
RecipeBuilder.newBuilder("hs_vicio_star", "starlight_matrix", 20) // 时间1秒，
    .addItemInput(<astralsorcery:itemshiftingstar>* 1) // 更替之星 x1
    .addItemInput(<minecraft:feather> * 4) // 羽毛 x4
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 8) // 星尘 x8
    .addItemInput(<astralsorcery:itemusabledust> * 2) // 辉光粉 x2
    .addEnergyPerTickInput(600) // 每 tick 输入 600 单位电力 (总电力消耗 = 600 * 30 = 18000)
    .addItemOutput(<astralsorcery:itemshiftingstar>.withTag({astralsorcery: {starAttunement: "astralsorcery.constellation.vicio"}}) * 1) // 输出：虚御座（Vicio）x1
    .addRecipeTooltip("星能转化：\n制造出虚御座（Vicio）！") // 提示信息：描述产物名称
    .build();

    // 新配方：更替之星 + 铁锭 + 星尘 + 辉光粉 制作 遁甲座（Armara）
RecipeBuilder.newBuilder("hs_armara_star", "starlight_matrix", 20) // 时间1秒，
    .addItemInput(<astralsorcery:itemshiftingstar>* 1) // 更替之星 x1
    .addItemInput(<minecraft:iron_ingot> * 4) // 铁锭 x4
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 8) // 星尘 x8
    .addItemInput(<astralsorcery:itemusabledust> * 2) // 辉光粉 x2
    .addEnergyPerTickInput(600) // 每 tick 输入 600 单位电力 (总电力消耗 = 600 * 30 = 18000)
    .addItemOutput(<astralsorcery:itemshiftingstar>.withTag({astralsorcery: {starAttunement: "astralsorcery.constellation.armara"}}) * 1) // 输出：遁甲座（Armara）x1
    .addRecipeTooltip("星能转化：\n制造出遁甲座（Armara）！") // 提示信息：描述产物名称
    .build();

    // 新配方：更替之星 + 燧石 + 星尘 + 辉光粉 制作 非攻座（Discidia）
RecipeBuilder.newBuilder("hs_discidia_star", "starlight_matrix", 20) // 时间1秒，
    .addItemInput(<astralsorcery:itemshiftingstar>* 1) // 更替之星 x1
    .addItemInput(<minecraft:flint> * 4) // 燧石 x4
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 8) // 星尘 x8
    .addItemInput(<astralsorcery:itemusabledust> * 2) // 辉光粉 x2
    .addEnergyPerTickInput(600) // 每 tick 输入 600 单位电力 (总电力消耗 = 600 * 30 = 18000)
    .addItemOutput(<astralsorcery:itemshiftingstar>.withTag({astralsorcery: {starAttunement: "astralsorcery.constellation.discidia"}}) * 1) // 输出：非攻座（Discidia）x1
    .addRecipeTooltip("星能转化：\n制造出非攻座（Discidia）！") // 提示信息：描述产物名称
    .build();

    // 新配方：木棍 + 原木（可替代）+ 海蓝宝石 制作 链接工具
RecipeBuilder.newBuilder("hs_linking_tool", "starlight_matrix", 20) // 时间调整为20 ticks (1秒)，
    .addItemInput(<minecraft:stick> * 2) // 木棍 x2
    .addInput(<ore:logWood>*2)
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:itemlinkingtool> * 1) // 输出：链接工具 x1
    .addRecipeTooltip("星能转化：\n制造出链接工具！") // 提示信息：描述产物名称
    .build();

    // 新配方：水晶石 + 玻璃板 + 玻璃透镜 + 辉光粉 + 更替之星 制作 星座核心
RecipeBuilder.newBuilder("hs_constellation_focus", "starlight_matrix", 20)
    .addItemInput(<astralsorcery:itemrockcrystalsimple> * 12) // 水晶石 x12
    .addItemInput(<minecraft:glass_pane> * 4) // 玻璃板 x4
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 2) // 星尘 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 4) // 玻璃透镜 x4
    .addItemInput(<astralsorcery:itemusabledust> * 4) // 辉光粉 x4
    .addItemInput(<astralsorcery:itemusabledust:1>* 2) // 暗夜粉 x2
    .addItemInput(<astralsorcery:itemshiftingstar> * 1) // 更替之星 x1
    .addEnergyPerTickInput(750) // 每 tick 输入 750 单位电力 (总电力消耗 = 750 * 40 = 30000)
    .addItemOutput(<packagedastral:constellation_focus> * 1) // 输出：星座核心 x1
    .addRecipeTooltip("星能转化：\n制造出星座核心！") // 提示信息：描述产物名称
    .build();

// 新配方：大理石 + 金锭 + 星能液桶 + 水晶石 制作 仪式基座
RecipeBuilder.newBuilder("hs_ritual_pedestal", "starlight_matrix", 20) // 时间1秒，
    .addItemInput(<astralsorcery:blockmarble:6> * 3) // 大理石（元数据6）x3
    .addItemInput(<astralsorcery:blockmarble:2> * 4) // 大理石（元数据2）x4
    .addItemInput(<astralsorcery:blockmarble:4> * 2) // 大理石（元数据4）x2
    .addItemInput(<minecraft:gold_ingot> * 2) // 金锭 x2
    .addInput(<liquid:astralsorcery.liquidstarlight>* 1000) // 星能液桶 x1
    .addItemInput(<astralsorcery:itemrockcrystalsimple> * 1) // 水晶石 x1
    .addEnergyPerTickInput(600) // 每 tick 输入 600 单位电力 (总电力消耗 = 600 * 30 = 18000)
    .addItemOutput(<astralsorcery:blockritualpedestal> * 1) // 输出：仪式基座 x1
    .addRecipeTooltip("星能转化：\n制造出仪式基座！") // 提示信息：描述产物名称
    .build();

    // 新配方：金锭 + 海蓝宝石 + 星能液桶 + 星尘 + 大理石 制作 星能聚合器
RecipeBuilder.newBuilder("hs_starlight_infuser", "starlight_matrix", 20) // 时间1秒，
    .addItemInput(<minecraft:gold_ingot> * 2) // 金锭 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addInput(<liquid:astralsorcery.liquidstarlight>* 1000) // 星能液桶 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 1) // 星尘 x1
    .addItemInput(<astralsorcery:blockmarble:5> * 2) // 大理石（元数据5）x2
    .addItemInput(<astralsorcery:blockmarble:2> * 6) // 大理石（元数据2）x6
    .addItemInput(<astralsorcery:blockmarble:4> * 2) // 大理石（元数据4）x2
    .addEnergyPerTickInput(600) // 每 tick 输入 600 单位电力 (总电力消耗 = 600 * 30 = 18000)
    .addItemOutput(<astralsorcery:blockstarlightinfuser> * 1) // 输出：星能聚合器 x1
    .addRecipeTooltip("星能转化：\n制造出星能聚合器！") // 提示信息：描述产物名称
    .build();

    // 新配方：大理石 + 辉光粉 + 水晶石 + 海蓝宝石 + 星尘 制作 照明星杖
RecipeBuilder.newBuilder("hs_illumination_wand", "starlight_matrix", 20) // 时间调整为20 ticks (1秒)，
    .addItemInput(<astralsorcery:blockmarble:6> * 2) // 大理石（元数据6）x2
    .addItemInput(<astralsorcery:itemusabledust> * 1) // 辉光粉 x1
    .addItemInput(<astralsorcery:itemrockcrystalsimple> * 2) // 水晶石 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 1) // 海蓝宝石 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 2) // 星尘 x2
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:itemilluminationwand>) // 输出：照明星杖 x1
    .addRecipeTooltip("星能转化：\n制造出照明星杖！") // 提示信息：描述产物名称
    .build();

    // 新配方：大理石 + 钻石 + 星尘 制作 转位星杖
RecipeBuilder.newBuilder("hs_exchange_wand", "starlight_matrix", 20)
    .addItemInput(<astralsorcery:blockmarble:6> * 3) // 大理石（元数据6）x3
    .addItemInput(<minecraft:diamond> * 2) // 钻石 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 1) // 星尘 x1
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 25 = 12500)
    .addItemOutput(<astralsorcery:itemexchangewand> * 1) // 输出：转位星杖 x1
    .addRecipeTooltip("星能转化：\n制造出转位星杖！") // 提示信息：描述产物名称
    .build();

// 新配方：大理石 + 末影珍珠 + 紫色燃料（可替代） 制作 冲击星杖
RecipeBuilder.newBuilder("hs_grapple_wand", "starlight_matrix", 20) // 时间调整为20 ticks (1秒)，
    .addItemInput(<astralsorcery:blockmarble:6> * 3) // 大理石（元数据6）x3
    .addItemInput(<minecraft:ender_pearl> * 2) // 末影珍珠 x2
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <botania:dye:10> * 1,         // Botania 紫色染料 x1
                <minecraft:dye:5> * 1,        // Minecraft 紫色染料 x1
                <thermalfoundation:dye:5> * 1 // Thermal Foundation 紫色染料 x1
            ])
    ) // 紫色染料（任意种类）x1
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:itemgrapplewand> * 1) // 输出：冲击星杖 x1
    .addRecipeTooltip("星能转化：\n制造出冲击星杖！") // 提示信息：描述产物名称
    .build();

// 新配方：大理石 + 紫色染料（可替代）+ 星尘 制作 秩序星杖
RecipeBuilder.newBuilder("hs_architect_wand", "starlight_matrix", 20) // 时间调整为20 ticks (1秒)，
    .addItemInput(<astralsorcery:blockmarble:6> * 3) // 大理石（元数据6）x3
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <botania:dye:10> * 2,         // Botania 紫色染料 x2
                <minecraft:dye:5> * 2,        // Minecraft 紫色染料 x2
                <thermalfoundation:dye:5> * 2 // Thermal Foundation 紫色染料 x2
            ])
    ) // 紫色染料（任意种类）x2
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 2) // 星尘 x2
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:itemarchitectwand> * 1) // 输出：秩序星杖 x1
    .addRecipeTooltip("星能转化：\n制造出秩序星杖！") // 提示信息：描述产物名称
    .build();

    // 新配方：大理石块（可替代）+ 海蓝宝石 + 末影珍珠 制作 共振星杖
RecipeBuilder.newBuilder("hs_resonance_wand", "starlight_matrix", 20) // 时间调整为20 ticks (1秒)，
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <astralsorcery:blockmarble:0> * 2, // 大理石块（元数据0）x2
                <astralsorcery:blockmarble:1> * 2, // 大理石块（元数据1）x2
                <astralsorcery:blockmarble:2> * 2, // 大理石块（元数据2）x2
                <astralsorcery:blockmarble:3> * 2, // 大理石块（元数据3）x2
                <astralsorcery:blockmarble:4> * 2, // 大理石块（元数据4）x2
                <astralsorcery:blockmarble:5> * 2, // 大理石块（元数据5）x2
                <astralsorcery:blockmarble:6> * 2  // 大理石块（元数据6）x2
            ])
    ) // 大理石块（任意元数据）x2
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<minecraft:ender_pearl> * 1) // 末影珍珠 x1
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:itemwand> * 1) // 输出：共鸣星杖 x1
    .addRecipeTooltip("星能转化：\n制造出共鸣星杖！") // 提示信息：描述产物名称
    .build();

    RecipeBuilder.newBuilder("hs_resonance_wand_vicio", "starlight_matrix", 20)
    .addItemInput(<astralsorcery:itemwand> * 1) // 共鸣星杖 x1（无NBT）
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 4) // 海蓝宝石 x4
    .addItemInput(<minecraft:feather> * 6) // 羽毛 x6
    .addItemInput(<minecraft:reeds> * 2) // 甘蔗 x2
    .addItemInput(<minecraft:arrow> * 2) // 箭 x2
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemwand>.withTag({astralsorcery: {AugmentName: "astralsorcery.constellation.vicio"}}) * 1)
    .addRecipeTooltip("星能转化：\n制造出共鸣星杖虚御座！")
    .build();

    RecipeBuilder.newBuilder("hs_resonance_wand_evorsio", "starlight_matrix", 20)
    .addItemInput(<astralsorcery:itemwand> * 1) // 共鸣星杖 x1（无NBT）
    .addItemInput(<minecraft:gunpowder> * 4) // 火药 x4
    .addItemInput(<minecraft:cobblestone> * 4) // 原石 x4
    .addItemInput(<minecraft:quartz> * 2) // 石英 x2
    .addItemInput(<minecraft:blaze_powder> * 2) // 烈焰粉 x2
    .addItemInput(<minecraft:flint> * 2) // 燧石 x2
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemwand>.withTag({astralsorcery: {AugmentName: "astralsorcery.constellation.evorsio"}}) * 1)
    .addRecipeTooltip("星能转化：\n制造出解离座！")
    .build();

    RecipeBuilder.newBuilder("hs_resonance_wand_discidia", "starlight_matrix", 20)
    .addItemInput(<astralsorcery:itemwand> * 1) // 共鸣星杖 x1（无NBT）
    .addItemInput(<astralsorcery:itemusabledust> * 4) // 辉光粉 x4
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<minecraft:blaze_rod> * 2) // 烈焰棒 x2
    .addItemInput(<minecraft:glowstone_dust> * 2) // 萤石粉 x2
    .addItemInput(<minecraft:flint> * 4) // 燧石 x4
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemwand>.withTag({astralsorcery: {AugmentName: "astralsorcery.constellation.discidia"}}) * 1)
    .addRecipeTooltip("星能转化：\n制造出非攻座！")
    .build();

    RecipeBuilder.newBuilder("hs_resonance_wand_armara", "starlight_matrix", 20)
    .addItemInput(<astralsorcery:itemwand> * 1) // 共鸣星杖 x1（无NBT）
    .addItemInput(<minecraft:iron_ingot> * 4) // 铁锭 x4
    .addItemInput(<minecraft:nether_brick> * 2) // 地狱砖 x2
    .addItemInput(<minecraft:leather> * 2) // 皮革 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent:1>* 2) // 星辉锭 x2
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemwand>.withTag({astralsorcery: {AugmentName: "astralsorcery.constellation.armara"}}) * 1)
    .addRecipeTooltip("星能转化：\n制造出遁甲座！")
    .build();

    RecipeBuilder.newBuilder("hs_resonance_wand_aevitas", "starlight_matrix", 20)
    .addItemInput(<astralsorcery:itemwand> * 1) // 共鸣星杖 x1（无NBT）
    .addItemInput(<minecraft:reeds> * 4) // 甘蔗 x4
    .addInput(<ore:treeSapling>*6)
    .addItemInput(<astralsorcery:itemusabledust> * 2) // 辉光粉 x2
    .addItemInput(<minecraft:prismarine_shard> * 2) // 海晶砂砾 x2
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemwand>.withTag({astralsorcery: {AugmentName: "astralsorcery.constellation.aevitas"}}) * 1)
    .addRecipeTooltip("星能转化：\n制造出生息座！")
    .build();

    // 新配方：星辉合成台 + 聚星木 + ME 封包组件 + 共鸣星杖 + 大理石块 制作 星辉封包合成器
RecipeBuilder.newBuilder("hs_discovery_crafter", "starlight_matrix", 20) // 时间1秒
    .addItemInput(<astralsorcery:blockaltar> * 1) // 星辉合成台 x1
    .addItemInput(<astralsorcery:blockinfusedwood> * 2) // 聚星木 x2
    .addItemInput(<packagedauto:me_package_component> * 1) // ME 封包组件 x1
    .addItemInput(<astralsorcery:itemwand> * 1) // 共鸣星杖 x1
    .addItemInput(<astralsorcery:blockmarble:4> * 4) // 大理石块 x4
    .addEnergyPerTickInput(600) // 每 tick 输入 600 单位电力 (总电力消耗 = 600 * 30 = 18000)
    .addItemOutput(<packagedastral:discovery_crafter> * 1) // 输出：星辉封包合成器 x1
    .addRecipeTooltip("星能转化：\n制造出星辉封包合成器！") // 提示信息：描述产物名称
    .build();

    // 新配方：海蓝宝石 + 星辉锭 + 水晶石 + 光波增幅器 + 大理石块 制作 共鸣祭坛
RecipeBuilder.newBuilder("hs_attunement_altar", "starlight_matrix", 20)
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent:1> * 2) // 星辉锭 x2
    .addItemInput(<astralsorcery:itemrockcrystalsimple> * 1) // 水晶石 x1
    .addItemInput(<astralsorcery:blockattunementrelay>* 1) // 光波增幅器 x1
    .addItemInput(<astralsorcery:blockmarble:6> * 4) // 大理石块（元数据6）x4
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 25 = 12500)
    .addItemOutput(<astralsorcery:blockattunementaltar> * 1) // 输出：共鸣祭坛 x1
    .addRecipeTooltip("星能转化：\n制造出共鸣祭坛！") // 提示信息：描述产物名称
    .build();

// 新配方：大理石 + 星能液桶 + 大理石 制作 星辉祭坛
RecipeBuilder.newBuilder("hs_starlight_altar", "starlight_matrix", 20)
    .addItemInput(<astralsorcery:blockmarble:4> * 2) // 大理石块（元数据4）x2
    .addInput(<liquid:astralsorcery.liquidstarlight>* 1000) // 星能液桶 x1
    .addItemInput(<astralsorcery:blockmarble:2> * 4) // 大理石块（元数据2）x4
    .addEnergyPerTickInput(600) // 每 tick 输入 600 单位电力 (总电力消耗 = 600 * 30 = 18000)
    .addItemOutput(<astralsorcery:blockaltar:1> * 1) // 输出：星辉祭坛 x1
    .addRecipeTooltip("星能转化：\n制造出星辉祭坛！") // 提示信息：描述产物名称
    .build();

    // 新配方：星尘 + 星辉锭 + 海蓝宝石 + 水晶石 + 大理石 制作 天辉祭坛
RecipeBuilder.newBuilder("hs_celestial_altar", "starlight_matrix", 20)
    .addItemInput(<astralsorcery:itemcraftingcomponent:1> * 1) // 星辉锭 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent:2>* 2) // 星尘 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<astralsorcery:itemrockcrystalsimple> * 1) // 水晶石 x1
    .addItemInput(<astralsorcery:blockmarble:4> * 4) // 大理石块（元数据4）x4
    .addItemInput(<astralsorcery:blockmarble:2> * 2) // 大理石块（元数据2）x2
    .addEnergyPerTickInput(700) // 每 tick 输入 700 单位电力 (总电力消耗 = 700 * 40 = 28000)
    .addItemOutput(<astralsorcery:blockaltar:2> * 1) // 输出：天辉祭坛 x1
    .addRecipeTooltip("星能转化：\n制造出天辉祭坛！") // 提示信息：描述产物名称
    .build();

    // 新配方：大理石 + 玻璃透镜 + 海蓝宝石 + 水晶石 + 熏黑大理石 制作 五彩祭坛
RecipeBuilder.newBuilder("hs_prismatic_altar", "starlight_matrix", 20)
    .addItemInput(<astralsorcery:blockmarble:6> * 8) // 大理石块（元数据6）x8
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1) // 玻璃透镜 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 4) // 海蓝宝石 x4
    .addItemInput(<astralsorcery:itemrockcrystalsimple> * 1) // 水晶石 x1
    .addItemInput(<astralsorcery:blockblackmarble> * 4) // 熏黑大理石 x4
    .addEnergyPerTickInput(800) // 每 tick 输入 800 单位电力 (总电力消耗 = 800 * 50 = 40000)
    .addItemOutput(<astralsorcery:blockaltar:3> * 1) // 输出：五彩祭坛 x1
    .addRecipeTooltip("星能转化：\n制造出五彩祭坛！") // 提示信息：描述产物名称
    .build();

    // 新配方：星辉封包合成器 + 熏黑大理石 + 星能液桶 + 星尘 + 水晶石 + 大理石 制作 星辉封包合成祭坛
RecipeBuilder.newBuilder("hs_attunement_crafter", "starlight_matrix", 20)
    .addItemInput(<packagedastral:discovery_crafter> * 1) // 星辉封包合成器 x1
    .addItemInput(<astralsorcery:blockblackmarble> * 2) // 熏黑大理石 x2
    .addInput(<liquid:astralsorcery.liquidstarlight>* 1000) // 星能液桶 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 2) // 星尘 x2
    .addItemInput(<astralsorcery:itemrockcrystalsimple> * 1) // 水晶石 x1
    .addItemInput(<astralsorcery:blockmarble:4> * 2) // 大理石块（元数据4）x2
    .addItemInput(<astralsorcery:blockmarble:2> * 4) // 大理石块（元数据5）x4
    .addEnergyPerTickInput(900) // 每 tick 输入 900 单位电力 (总电力消耗 = 900 * 60 = 54000)
    .addItemOutput(<packagedastral:attunement_crafter> * 1) // 输出：星辉封包合成祭坛 x1
    .addRecipeTooltip("星能转化：\n制造出星辉封包合成祭坛！") // 提示信息：描述产物名称
    .build();

    // 新配方：星尘 + 水晶石 + 海蓝宝石 + 共振宝石 + 熏黑大理石 + 大理石 + 红石 + 星辉锭 制作 天辉封包祭坛
RecipeBuilder.newBuilder("hs_constellation_crafter", "starlight_matrix", 20)
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 2) // 星尘 x2
    .addItemInput(<astralsorcery:itemrockcrystalsimple> * 1) // 水晶石 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent:4> * 2) // 共振宝石 x2
    .addItemInput(<astralsorcery:blockblackmarble> * 2) // 熏黑大理石 x2
    .addItemInput(<astralsorcery:blockmarble:2> * 2) // 大理石块（元数据2）x2
    .addItemInput(<astralsorcery:blockmarble:4> * 4) // 大理石块（元数据4）x4
    .addItemInput(<minecraft:redstone> * 2) // 红石 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent:1> * 1) // 星辉锭 x1
    .addEnergyPerTickInput(800) // 每 tick 输入 800 单位电力 (总电力消耗 = 800 * 50 = 40000)
    .addItemOutput(<packagedastral:constellation_crafter> * 1) // 输出：天辉封包祭坛 x1
    .addRecipeTooltip("星能转化：\n制造出天辉封包祭坛！") // 提示信息：描述产物名称
    .build();

    // 新配方：多种材料 制作 五彩封包祭坛
RecipeBuilder.newBuilder("hs_trait_crafter", "starlight_matrix", 20)
    .addItemInput(<minecraft:redstone> * 4) // 红石粉 x4
    .addItemInput(<astralsorcery:itemusabledust> * 4) // 辉光粉 x4
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 2) // 星尘 x2
    .addItemInput(<minecraft:ender_pearl> * 2) // 末影珍珠 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent:4> * 4) // 共振宝石 x4
    .addItemInput(<astralsorcery:itemusabledust:1>* 2) // 暗夜粉 x2
    .addItemInput(<astralsorcery:blockblackmarble:4> * 4) // 熏黑大理石 x4
    .addItemInput(<astralsorcery:blockmarble:6> * 8) // 大理石块（元数据6）x8
    .addItemInput(<minecraft:ender_eye> * 2) // 末影之眼 x2
    .addItemInput(<packagedastral:constellation_focus> * 1) // 星座核心 x1
    .addItemInput(<packagedastral:constellation_crafter> * 1) // 天辉封包祭坛 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 4) // 玻璃透镜 x4
    .addItemInput(<astralsorcery:itemrockcrystalsimple> * 1) // 水晶石 x1
    .addEnergyPerTickInput(1000) // 每 tick 输入 1000 单位电力 (总电力消耗 = 1000 * 70 = 70000)
    .addItemOutput(<packagedastral:trait_crafter> * 1) // 输出：五彩封包祭坛 x1
    .addRecipeTooltip("星能转化：\n制造出五彩封包祭坛！") // 提示信息：描述产物名称
    .build();
