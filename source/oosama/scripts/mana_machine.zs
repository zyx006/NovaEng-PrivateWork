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
//控制器
// 添加无序合成配方
recipes.addShapeless(
    "modularmachinery:mana_machine", // 输出物品的注册名
    <modularmachinery:mana_machine_controller>, // 输出物品
    [  
    <ic2:resource:12> *1,
    <botania:petal>*1|
    <botania:petal:1> * 1|
    <botania:petal:2> * 1|
    <botania:petal:3> * 1|
    <botania:petal:4> * 1|
    <botania:petal:5> * 1|
    <botania:petal:6> * 1|
    <botania:petal:7> * 1|
    <botania:petal:8> * 1|
    <botania:petal:9> * 1|
    <botania:petal:10> * 1|
    <botania:petal:11> * 1|
    <botania:petal:12> * 1|
    <botania:petal:13> * 1|
    <botania:petal:14> * 1|
    <botania:petal:15> * 1
    ]
);

//产能花
//彼方兰
RecipeBuilder.newBuilder("gourmaryllis","mana_machine", 20)
.addItemInput(<botania:specialflower>.withTag({type: "gourmaryllis"})).setChance(0) 
.addItemInput(<minecraft:baked_potato>*1)
.addFluidOutput(<liquid:fluidedmana>*4)
.addRecipeTooltip("不愉快です")
.build();

// 新配方：光谱花与羊毛的魔力转换
RecipeBuilder.newBuilder("spectrolus_wool_mana_conversion", "mana_machine", 20)
    .addItemInput(<botania:specialflower>.withTag({type: "spectrolus"})).setChance(0)  // 输入：光谱花
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <minecraft:wool>,       // 白色羊毛
                <minecraft:wool:1>,     // 橙色羊毛
                <minecraft:wool:2>,     // 品红色羊毛
                <minecraft:wool:3>,     // 浅蓝色羊毛
                <minecraft:wool:4>,     // 黄色羊毛
                <minecraft:wool:5>,     // 绿色羊毛
                <minecraft:wool:6>,     // 粉红色羊毛
                <minecraft:wool:7>,     // 灰色羊毛
                <minecraft:wool:8>,     // 淡灰色羊毛
                <minecraft:wool:9>,     // 青色羊毛
                <minecraft:wool:10>,    // 紫色羊毛
                <minecraft:wool:11>,    // 蓝色羊毛
                <minecraft:wool:12>,    // 棕色羊毛
                <minecraft:wool:13>,    // 绿色羊毛
                <minecraft:wool:14>,    // 红色羊毛
                <minecraft:wool:15>     // 黑色羊毛
            ])
    )
    .addFluidOutput(<liquid:fluidedmana> * 4) // 输出：4 单位液态魔力
    .addRecipeTooltip("彩虹织梦：\n光谱花与缤纷羊毛交织出绚丽的魔力！") // 提示信息：描述配方功能
    .build();


    // 新配方：热百合与岩浆的魔力转换
RecipeBuilder.newBuilder("thermalily_lava_mana_conversion", "mana_machine", 20)
    .addItemInput(<botania:specialflower>.withTag({type: "thermalily"})).setChance(0)  // 输入：热百合
    .addFluidInput(<liquid:lava> * 100) // 输入：100 mb 的液态岩浆
    .addFluidOutput(<liquid:fluidedmana> * 2) // 输出：2 单位液态魔力
    .addRecipeTooltip("熔岩之心：\n热百合与滚烫的岩浆融合，释放出强大的魔力！")
    .build();



// 新配方：火红莲与多种材料的魔力转换
RecipeBuilder.newBuilder("fire_lily_multi_material_mana_conversion", "mana_machine", 20)
    .addItemInput(<botania:specialflower>.withTag({type: "endoflame"})).setChance(0)  // 输入：火红莲
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <minecraft:coal>,               // 普通煤炭
                <minecraft:coal:1>,             // 木炭
                <contenttweaker:material_part:84> // 未雕琢的煤炭
            ])
    )
    .addFluidOutput(<liquid:fluidedmana> * 3) // 输出：3 单位液态魔力
    .addRecipeTooltip("炉心融解：\n火红莲与多种材料共同点燃魔力的火花！") // 提示信息：描述配方功能
    .build();

// 新配方：露草与树叶的魔力转换
RecipeBuilder.newBuilder("munchdew_leaves_mana_conversion", "mana_machine", 20)
    .addItemInput(<botania:specialflower>.withTag({type: "munchdew"})).setChance(0)  // 输入：露草
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <minecraft:leaves>,         // 橡树树叶
                <minecraft:leaves:1>,       // 云杉树叶
                <minecraft:leaves:2>,       // 白桦树叶
                <minecraft:leaves:3>,       // 丛林树叶
                <minecraft:leaves2>,        // 橡木树叶（新版本）
                <minecraft:leaves2:1>       // 暗橡树树叶
            ])
    )
    .addFluidOutput(<liquid:fluidedmana> * 2) // 输出：2 单位液态魔力
    .addRecipeTooltip("清晨的馈赠：\n露草与各类树叶交织出纯净的魔力！") // 提示信息：描述配方功能
    .build();

// 新配方：史莱姆花与粘液球的魔力转换
RecipeBuilder.newBuilder("narslimmus_slime_mana_conversion", "mana_machine", 20)
    .addItemInput(<botania:specialflower>.withTag({type: "narslimmus"})).setChance(0)  // 输入：史莱姆花
    .addItemInput(<minecraft:slime_ball> * 4) // 输入：4 个粘液球
    .addFluidOutput(<liquid:fluidedmana> * 2) // 输出：2 单位液态魔力
    .addRecipeTooltip("弹跳的魔力：\n史莱姆花与粘液球碰撞，激发出活泼的魔力！") // 提示信息：描述配方功能
    .build();

    // 新配方：热爆花与 TNT 的魔力转换
RecipeBuilder.newBuilder("entropinnyum_tnt_mana_conversion", "mana_machine", 20)
    .addItemInput(<botania:specialflower>.withTag({type: "entropinnyum"})).setChance(0) // 输入：热爆花
    .addItemInput(<minecraft:tnt> * 1) // 输入：TNT
    .addFluidOutput(<liquid:fluidedmana> * 15) // 输出：13 单位液态魔力
    .addRecipeTooltip("狂热爆破：\n热爆花引爆 TNT，释放出炽热的魔力洪流！") // 提示信息：描述配方功能
    .build();

// 新配方：勿落草与 Shulker 灵魂瓶的魔力转换
RecipeBuilder.newBuilder("shulk_me_not_shulker_mana_conversion", "mana_machine", 200) // 200 ticks = 10 秒
    .addItemInput(<botania:specialflower>.withTag({type: "shulk_me_not"})).setChance(0) // 输入：勿落草（不消耗）
    .addItemInput(<enderio:item_soul_vial:1>.withTag({entityId: "minecraft:shulker"})).setChance(0.01) // 输入：填充了 Shulker 的灵魂瓶（不消耗）
    .addFluidOutput(<liquid:fluidedmana> * 30) // 输出：30 单位液态魔力
    .addRecipeTooltip("暗影之息：\n勿落草借助[潜影贝]的灵魂，释放出深邃的魔力！") // 提示信息：描述配方功能
    .build();

// 新配方：全色花与书的魔力转换
RecipeBuilder.newBuilder("omniviolet_book_mana_conversion", "mana_machine", 20) // 20 ticks = 1 秒
    .addItemInput(<botania:specialflower>.withTag({type: "omniviolet"})).setChance(0) // 输入：全色花（不消耗）
    .addItemInput(<minecraft:book>*1) // 输入：书（不消耗）
    .addFluidOutput(<liquid:fluidedmana> * 2) // 输出：2 单位液态魔力
    .addRecipeTooltip("知识的光辉：\n全色花与书共鸣，释放出智慧的魔力！") // 提示信息：描述配方功能
    .build();

// 新配方：阿卡纳蔷薇通过吸收经验产生魔力
RecipeBuilder.newBuilder("arcanarose_mana_conversion", "mana_machine", 20) // 每秒处理一次（20 ticks）
    .addItemInput(<botania:specialflower>.withTag({type: "arcanerose"})) .setChance(0) // 输入：阿卡纳蔷薇
    .addFluidInput(<liquid:xpjuice> * 400) // 输入：每秒需要 20 点经验，即 400 MB 液态经验 (20 点经验 * 20 MB/点)
    .addFluidOutput(<liquid:fluidedmana> * 15) // 输出：每秒 15 MB 液态魔力（50 单位魔力）
    .addRecipeTooltip("智慧之源：\n阿卡纳蔷薇吸收经验，转化为强大的魔力！") // 提示信息：描述配方功能
    .build();