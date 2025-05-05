#priority 999
import mods.modularmachinery.RecipeBuilder;
import mods.extendedcrafting.CombinationCrafting;

//电磁发电翻倍
RecipeBuilder.newBuilder("dici_0", "di_ci", 24000)
    .setAltitude(0, 32)
    .addEnergyPerTickOutput(160000000)
    .build();
RecipeBuilder.newBuilder("dici_1", "di_ci", 24000)
    .setAltitude(33, 96)
    .addEnergyPerTickOutput(140000000)
    .build();
RecipeBuilder.newBuilder("dici_2", "di_ci", 24000)
    .setAltitude(97, 192)
    .addEnergyPerTickOutput(110000000)
    .build();
RecipeBuilder.newBuilder("dici_3", "di_ci", 24000)
    .setAltitude(193, 256)
    .addEnergyPerTickOutput(80000000)
    .build();

//移除微缩宇宙产出时空碎片
RecipeBuilder.newBuilder("a6_miniature_Cosmic_resource_collector_04", "a6_miniature_Cosmic_resource_collector", 3)
    .addEnergyPerTickInput(32000)
    // .addItemInput(<contenttweaker:miniature_universe_resource_collector_space_time_collapses_modecard> * 1).setChance(0)//时空塌陷模式卡
    .addInputs([
        <contenttweaker:supermassive_singularity> * 1,//超质量临界奇点
    ])
    .build();

CombinationCrafting.addRecipe(<actuallyadditions:block_crystal_empowered>,20000000,20000000,<actuallyadditions:block_crystal>,[
    <ore:ingotBrick>,
    <ore:dyeRed>,
    <ore:ingotBrickNether>,
    <ore:dustRedstone>,
]);
CombinationCrafting.addRecipe(<actuallyadditions:block_crystal_empowered:1>,20000000,20000000,<actuallyadditions:block_crystal:1>,[
    <ore:dyeCyan>,
    <minecraft:prismarine_shard>,
    <minecraft:prismarine_shard>,
    <minecraft:prismarine_shard>,
]);
CombinationCrafting.addRecipe(<actuallyadditions:block_crystal_empowered:2>,30000000,30000000,<actuallyadditions:block_crystal:2>,[
    <minecraft:clay_ball>,
    <minecraft:clay_ball>,
    <minecraft:clay>,
    <ore:dyeLightBlue>,
]);
CombinationCrafting.addRecipe(<actuallyadditions:block_crystal_empowered:3>,30000000,30000000,<actuallyadditions:block_crystal:3>,[
    <minecraft:coal:1>,
    <minecraft:flint>,
    <minecraft:stone>,
    <ore:dyeBlack>,
]);
CombinationCrafting.addRecipe(<actuallyadditions:block_crystal_empowered:4>,50000000,50000000,<actuallyadditions:block_crystal:4>,[
    <minecraft:tallgrass:1>,
    <minecraft:sapling>,
    <ore:slimeball>,
    <ore:dyeLime>,
]);
CombinationCrafting.addRecipe(<actuallyadditions:block_crystal_empowered:5>,40000000,40000000,<actuallyadditions:block_crystal:5>,[
    <minecraft:stone_button>,
    <minecraft:snowball>,
    <ore:dyeGray>,
    <ore:cobblestone>,
]);