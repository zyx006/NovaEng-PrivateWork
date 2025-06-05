
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


//魔力聚合机新增配方
// V姐的头
RecipeBuilder.newBuilder("mougerendehead", "bot_crafter", 20)
    .addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients([
        <contenttweaker:iridescence>*16,
        <botania:mushroom:6>*16,
        <botania:petal:6>*16
    ]))
    .addInput(<ore:seed>) // 魔力消耗
    .addOutput(<minecraft:skull:3>.withTag({SkullOwner:{Name: "Vazkii"}}))
    .build();



// 初阶符文合成表

// 水之符文 (botania:rune:0)
RecipeBuilder.newBuilder("bc_water_rune", "bot_crafter", 20)
    .addInputs([
        <minecraft:reeds>,
        <minecraft:dye:15>,
        <minecraft:fishing_rod>, // 任意耐久钓鱼竿
        <botania:manaresource:23>, // 魔力尘
        <botania:manaresource:0> // 魔力钢锭
    ])
    .addInput(<liquid:fluidedmana>*5) // 魔力消耗
    .addOutput(<botania:rune:0> * 2)
    .build();


// 火之符文 (botania:rune:1)
RecipeBuilder.newBuilder("bc_fire_rune", "bot_crafter", 20)
    .addInputs([
        <minecraft:nether_brick>,
        <minecraft:gunpowder>,
        <minecraft:nether_wart>,
        <botania:manaresource:23>, // 魔力尘
        <botania:manaresource:0> // 魔力钢锭
    ])
    .addInput(<liquid:fluidedmana>*5) // 魔力消耗
    .addOutput(<botania:rune:1> * 2)
    .build();

// 地之符文 (botania:rune:2)
RecipeBuilder.newBuilder("bc_earth_rune", "bot_crafter", 20) // 时间设置为1秒
    .addInputs([
        <minecraft:stone>,
        <minecraft:coal_block>,
        <ore:listAllmushroom>, // 任意颜色蘑菇
        <botania:manaresource:23>, // 魔力尘
        <botania:manaresource:0> // 魔力钢锭
    ])
    .addInput(<liquid:fluidedmana>*5) // 魔力消耗
    .addOutput(<botania:rune:2> * 2)
    .build();


// 风之符文 (botania:rune:3)
RecipeBuilder.newBuilder("bc_wind_rune", "bot_crafter", 20)
  .addIngredientArrayInput(
            IngredientArrayBuilder.newBuilder()
                .addIngredients([
                    <minecraft:carpet:0>, // 白色地毯
                    <minecraft:carpet:1>, // 橙色地毯
                    <minecraft:carpet:2>, // 品红色地毯
                    <minecraft:carpet:3>, // 浅蓝色地毯
                    <minecraft:carpet:4>, // 黄色地毯
                    <minecraft:carpet:5>, // 绿色地毯
                    <minecraft:carpet:6>, // 粉红色地毯
                    <minecraft:carpet:7>, // 灰色地毯
                    <minecraft:carpet:8>, // 浅灰色地毯
                    <minecraft:carpet:9>, // 青色地毯
                    <minecraft:carpet:10>, // 紫色地毯
                    <minecraft:carpet:11>, // 蓝色地毯
                    <minecraft:carpet:12>, // 棕色地毯
                    <minecraft:carpet:13>, // 绿色地毯
                    <minecraft:carpet:14>, // 红色地毯
                    <minecraft:carpet:15>  // 黑色地毯

                ])
        )
    .addInputs([
        <minecraft:feather>,
        <minecraft:string>,
        <botania:manaresource:23>, // 魔力尘
        <botania:manaresource:0> // 魔力钢锭
    ])
    .addInput(<liquid:fluidedmana>*5) // 魔力消耗
    .addOutput(<botania:rune:3> * 2)
    .build();

// 中阶符文合成表

// 春之符文 (botania:rune:4)
RecipeBuilder.newBuilder("bc_spring_rune", "bot_crafter", 20)
    .addInputs([
        <botania:grassseeds:0> * 3, // 草地之种
        <minecraft:wheat>,
        <botania:livingrock> // 活石
    ])
    .addInputs(<botania:rune:0>).setChance(0) // 水之符文（不消耗）
    .addInputs(<botania:rune:1>).setChance(0) // 火之符文（不消耗）
    .addInput(<liquid:fluidedmana>*8) // 魔力消耗
    .addOutput(<botania:rune:4>)
    .build();

// 夏之符文 (botania:rune:5)
RecipeBuilder.newBuilder("bc_summer_rune", "bot_crafter", 20)
    .addInputs([
        <ore:sand> * 2, // 任意沙子
        <ore:slimeball>, // 任意粘液球
        <minecraft:melon>,
        <botania:livingrock> // 活石
    ])
    .addInputs(<botania:rune:2>).setChance(0) // 地之符文（不消耗）
    .addInputs(<botania:rune:3>).setChance(0) // 风之符文（不消耗）
    .addInput(<liquid:fluidedmana>*8) // 魔力消耗
    .addOutput(<botania:rune:5>)
    .build();

// 秋之符文 (botania:rune:6)
RecipeBuilder.newBuilder("bc_autumn_rune", "bot_crafter", 20)
    .addInputs([
        <ore:treeLeaves> * 3, // 任意树叶
        <minecraft:spider_eye>,
        <botania:livingrock> // 活石
    ])
    .addInputs(<botania:rune:1>).setChance(0) // 火之符文（不消耗）
    .addInputs(<botania:rune:3>).setChance(0) // 风之符文（不消耗）
    .addInput(<liquid:fluidedmana>*8) // 魔力消耗
    .addOutput(<botania:rune:6>)
    .build();

// 冬之符文 (botania:rune:7)
RecipeBuilder.newBuilder("bc_winter_rune", "bot_crafter", 20)
    .addInputs([
        <minecraft:snow> * 2,
        <ore:wool>, // 任意颜色羊毛
        <minecraft:cake>,
        <botania:livingrock> // 活石
    ])
    .addInputs(<botania:rune:0>).setChance(0) // 水之符文（不消耗）
    .addInputs(<botania:rune:2>).setChance(0) // 地之符文（不消耗）
    .addInput(<liquid:fluidedmana>*8) // 魔力消耗
    .addOutput(<botania:rune:7>)
    .build();

    //魔力符文 (botania:rune:8)
RecipeBuilder.newBuilder("bc_mana_rune", "bot_crafter", 20)
    .addInputs([
        <botania:manaresource:2>, // 魔力钻石
        <botania:livingrock> // 活石
    ])
    .addInputs(<botania:rune:0>).setChance(0) // 水之符文（不消耗）
    .addInputs(<botania:rune:1>).setChance(0) // 火之符文（不消耗）
    .addInputs(<botania:rune:2>).setChance(0) // 地之符文（不消耗）
    .addInputs(<botania:rune:3>).setChance(0) // 风之符文（不消耗）
    .addInput(<liquid:fluidedmana>*16) // 魔力消耗
    .addOutput(<botania:rune:8>)
    .build();

//高级符文合成表

// 傲慢符文 (botania:rune:15)
RecipeBuilder.newBuilder("bc_pride_rune", "bot_crafter", 20)
    .addInputs([
        <botania:manaresource:2> * 2, // 魔力钻石
        <botania:livingrock> // 活石
    ])
    .addInputs(<botania:rune:5>).setChance(0) // 夏之符文（不消耗）
    .addInputs(<botania:rune:1>).setChance(0) // 火之符文（不消耗）
    .addInput(<liquid:fluidedmana>*12)// 魔力消耗
    .addOutput(<botania:rune:15>)
    .build();

// 嫉妒符文 (botania:rune:14)
RecipeBuilder.newBuilder("bc_envy_rune", "bot_crafter", 20)
    .addInputs([
        <botania:manaresource:2> * 2, // 魔力钻石
        <botania:livingrock> // 活石
    ])
    .addInputs(<botania:rune:7>).setChance(0) // 冬之符文（不消耗）
    .addInputs(<botania:rune:0>).setChance(0) // 水之符文（不消耗）
    .addInput(<liquid:fluidedmana>*12)// 魔力消耗
    .addOutput(<botania:rune:14>)
    .build();

// 暴怒符文 (botania:rune:13)
RecipeBuilder.newBuilder("bc_wrath_rune", "bot_crafter", 20)
    .addInputs([
        <botania:manaresource:2> * 2, // 魔力钻石
        <botania:livingrock> // 活石
    ])
    .addInputs(<botania:rune:7>).setChance(0) // 冬之符文（不消耗）
    .addInputs(<botania:rune:2>).setChance(0) // 地之符文（不消耗）
    .addInput(<liquid:fluidedmana>*12)// 魔力消耗
    .addOutput(<botania:rune:13>)
    .build();

//懒惰符文 (botania:rune:12)
RecipeBuilder.newBuilder("bc_sloth_rune", "bot_crafter", 20)
    .addInputs([
        <botania:manaresource:2> * 2, // 魔力钻石
        <botania:livingrock> // 活石
    ])
    .addInputs(<botania:rune:6>).setChance(0) // 秋之符文（不消耗）
    .addInputs(<botania:rune:3>).setChance(0) // 风之符文（不消耗）
    .addInput(<liquid:fluidedmana>*12)// 魔力消耗
    .addOutput(<botania:rune:12>)
    .build();

// 贪婪符文 (botania:rune:11)
RecipeBuilder.newBuilder("bc_greed_rune", "bot_crafter", 20)
    .addInputs([
        <botania:manaresource:2> * 2, // 魔力钻石
        <botania:livingrock> // 活石
    ])
    .addInputs(<botania:rune:4>).setChance(0) // 春之符文（不消耗）
    .addInputs(<botania:rune:0>).setChance(0) // 水之符文（不消耗）
    .addInput(<liquid:fluidedmana>*12)// 魔力消耗
    .addOutput(<botania:rune:11>)
    .build();

// 暴食符文 (botania:rune:10)
RecipeBuilder.newBuilder("bc_gluttony_rune", "bot_crafter", 20)
    .addInputs([
        <botania:manaresource:2> * 2, // 魔力钻石
        <botania:livingrock> // 活石
    ])
    .addInputs(<botania:rune:7>).setChance(0) // 冬之符文（不消耗）
    .addInputs(<botania:rune:1>).setChance(0) // 火之符文（不消耗）
    .addInput(<liquid:fluidedmana>*12)// 魔力消耗
    .addOutput(<botania:rune:10>)
    .build();

// 欲望符文 (botania:rune:9)
RecipeBuilder.newBuilder("bc_lust_rune", "bot_crafter", 20)
    .addInputs([
        <botania:manaresource:2> * 2, // 魔力钻石
        <botania:livingrock> // 活石
    ])
    .addInputs(<botania:rune:5>).setChance(0) // 夏之符文（不消耗）
    .addInputs(<botania:rune:3>).setChance(0) // 风之符文（不消耗）
    .addInput(<liquid:fluidedmana>*12)// 魔力消耗
    .addOutput(<botania:rune:9>)
    .build();

// 其他...

// 特殊物品 - 玩家的头
RecipeBuilder.newBuilder("player_head", "bot_crafter", 20)
    .addInputs([
        <ore:itemSkull>,
        <minecraft:golden_apple>,
        <minecraft:name_tag>,
        <minecraft:sea_lantern>, // 海晶沙砾
        <botania:manaresource:8>  // 精灵尘
    ])
    .addInput(<botania:livingrock>) // 活石
    .addInput(<liquid:fluidedmana>*22) // 魔力消耗
    .addOutput(<minecraft:skull:3>) // 注意：这里的输出可能需要根据实际需求调整
    .build();

    // Soarleander 花合成
RecipeBuilder.newBuilder("bc_soarleander_flower", "bot_crafter", 20)
    .addInputs([
        <botania:specialflower>.withTag({type: "gourmaryllis"}),
        <minecraft:chicken>*8
    ])
    .addInput(<botania:livingrock>) // 活石
    .addInput(<liquid:fluidedmana>*8) // 魔力消耗
    .addOutput(<botania:specialflower>.withTag({type: "soarleander"})) // 输出：Soarleander 花
    .build();

// 强化材质合成
RecipeBuilder.newBuilder("bc_enchanted_material", "bot_crafter", 20)
    .addInputs([
        <ore:ingotManasteel>,
        <ore:ingotTerrasteel>,
        <ore:gaiaIngot>,
        <ore:ingotElvenElementium>,
        <ore:manaDiamond>,
        <ore:elvenDragonstone>
    ])
    .addInput(<botania:livingrock>) // 活石
    .addInput(<liquid:fluidedmana>*100) // 魔力消耗
    .addOutput(<extrabotany:material:2>.withTag({
        ench: [
            {lvl: 5 as short, id: 1},
            {lvl: 5 as short, id: 4},
            {lvl: 5 as short, id: 3},
            {lvl: 5 as short, id: 0}
        ]
    })) // 输出：附魔强化材质
    .build();

// Material:2 合成
RecipeBuilder.newBuilder("bc_material_2", "bot_crafter", 20)
    .addInputs([
        <minecraft:potato>,
        <minecraft:gold_nugget>,
        <botania:livingrock> // 活石
    ])
    .addInput(<liquid:fluidedmana>*1)// 魔力消耗
    .addOutput(<extrabotany:material:2>) // 输出：Material:2
    .addRecipeTooltip("育碧服务器？育碧服务器！")
    .build();

// Froststar 合成
RecipeBuilder.newBuilder("bc_froststar", "bot_crafter", 20)
    .addInputs([
        <ore:ingotManasteel>*2,
        <minecraft:ice>*2,
        <botania:rune:0> // 魔力符文
    ])
    .addInputs(<botania:livingrock>) // 活石
    .addInput(<liquid:fluidedmana>*2)// 魔力消耗
    .addOutput(<extrabotany:froststar>) // 输出：Froststar
    .build();

// Death Ring 合成
RecipeBuilder.newBuilder("bc_death_ring", "bot_crafter", 20)
    .addInputs([
        <ore:ingotManasteel>*2,
        <ore:manaDiamond>,
        <minecraft:skull:1>,
        <botania:rune:7>, // Envy 符文
        <botania:livingrock> // 活石
    ])
    .addInput(<liquid:fluidedmana>*2)// 魔力消耗
    .addOutput(<extrabotany:deathring>) // 输出：Death Ring
    .build();


// Combat Maid Chest Darkened 合成
RecipeBuilder.newBuilder("bc_combatmaidchestdarkened", "bot_crafter", 20)
    .addInputs([
        <extrabotany:combatmaidchest>,
        <extrabotany:shadowwarriorhelm>,
        <extrabotany:shadowwarriorchest>,
        <extrabotany:shadowwarriorlegs>,
        <extrabotany:shadowwarriorboots>,
        <botania:livingrock> // 活石
    ])
    .addInput(<liquid:fluidedmana>*50) // 魔力消耗
    .addOutput(<extrabotany:combatmaidchestdarkened>) // 输出：Combat Maid Chest Darkened
    .build();

// Walljumping 合成
RecipeBuilder.newBuilder("bc_walljumping", "bot_crafter", 20)
    .addInputs([
        <ore:ingotManasteel>*2,
        <minecraft:wheat_seeds>,
        <botania:rune:4>, // Earth 符文
        <minecraft:sticky_piston>,
        <botania:livingrock> // 活石
    ])
    .addInput(<liquid:fluidedmana>*2)// 魔力消耗
    .addOutput(<extrabotany:walljumping>) // 输出：Walljumping
    .build();

// Wallrunning 合成
RecipeBuilder.newBuilder("bc_wallrunning", "bot_crafter", 20)
    .addInputs([
        <ore:ingotManasteel>*2,
        <minecraft:wheat_seeds>,
        <botania:rune:4>, // Earth 符文
        <ore:stone>,
        <botania:livingrock> // 活石
    ])
    .addInput(<liquid:fluidedmana>*2)// 魔力消耗
    .addOutput(<extrabotany:wallrunning>) // 输出：Wallrunning
    .build();

// Elvenking 合成
RecipeBuilder.newBuilder("bc_elvenking", "bot_crafter", 20)
    .addInputs([
        <ore:ingotElvenElementium>*2,
        <ore:quartzElven>*2,
        <botania:rune:8>, // Spring 符文
        <botania:livingrock> // 活石
    ])
    .addInput(<liquid:fluidedmana>*4)// 魔力消耗
    .addOutput(<extrabotany:elvenking>) // 输出：Elvenking
    .build();

// Ultimate Hammer 合成
RecipeBuilder.newBuilder("bc_ultimatehammer", "bot_crafter", 20)
    .addInputs([
        <extrabotany:terrasteelhammer>,
        <extrabotany:gildedmashedpotato>*3,
        <minecraft:gold_block>,
        <botania:livingrock> // 活石
    ])
    .addInput(<liquid:fluidedmana>*100) // 魔力消耗
    .addOutput(<extrabotany:ultimatehammer>) // 输出：Ultimate Hammer
    .build();

// Allforone 合成
RecipeBuilder.newBuilder("bc_allforone", "bot_crafter", 20)
    .addInputs([
        <extrabotany:elvenking>,
        <extrabotany:material:3>,
        <botania:rune:6>, // Lust 符文
        <botania:rune:7>, // Gluttony 符文
        <botania:rune:8>, // Greed 符文
        <botania:rune:9>, // Sloth 符文
        <botania:rune:10>, // Wrath 符文
        <botania:rune:11>, // Envy 符文
        <botania:rune:12>, // Pride 符文
        <botania:livingrock> // 活石
    ])
    .addInput(<liquid:fluidedmana>*50) // 魔力消耗
    .addOutput(<extrabotany:allforone>) // 输出：Allforone
    .build();


// Firstfractal 合成
RecipeBuilder.newBuilder("bc_firstfractal", "bot_crafter", 20)
    .addInputs([
        <extrabotany:gildedmashedpotato>,
        <extrabotany:excaliber>,
        <extrabotany:buddhistrelics>.withTag({}),
        <extrabotany:shadowkatana>.withTag({}),
        <minecraft:wooden_sword>,
        <botania:terrasword>,
        <botania:starsword>,
        <botania:elementiumsword>,
        <botania:thundersword>,
        <botania:manasteelsword>,
        <botania:livingrock> // 活石
    ])
    .addInput(<liquid:fluidedmana>*1000) // 魔力消耗
    .addOutput(<extrabotany:firstfractal>) // 输出：Firstfractal
    .build();

// Advancedrocketry Crystal 合成
RecipeBuilder.newBuilder("bc_advancedrocketry_crystal", "bot_crafter", 20)
    .addInputs([
        <ancientspellcraft:astral_diamond_shard>.withTag({"display": {"Lore": ["和除去魔力符文的15种符文一同接受一池魔力，它会焕发新生"], "Name": "某种事物的...基质？"}}),
        <botania:rune>,
        <botania:rune:1>,
        <botania:rune:2>,
        <botania:rune:3>,
        <botania:rune:4>,
        <botania:rune:5>,
        <botania:rune:6>,
        <botania:rune:7>,
        <botania:rune:9>,
        <botania:rune:10>,
        <botania:rune:11>,
        <botania:rune:12>,
        <botania:rune:13>,
        <botania:rune:14>,
        <botania:rune:15>,
        <botania:livingrock> // 活石
    ])
    .addInput(<liquid:fluidedmana>*1000) // 魔力消耗
    .addOutput(<advancedrocketry:crystal>.withTag({"display": {"Lore": ["想想怎么利用它，不如试试用铿金与它熔炼出新物质？"], "Name": "重聚而出的晶块"}})) // 输出：Advanced Rocketry Crystal
    .build();