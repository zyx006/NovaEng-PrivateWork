//也许你可以对私货进行更改。
#priority 1000

#loader contenttweaker

import mods.contenttweaker.VanillaFactory;
import mods.contenttweaker.Fluid;
import mods.contenttweaker.Color;
import mods.contenttweaker.Item;

function regItem(name as string) {
    val item as Item = VanillaFactory.createItem(name);
    item.creativeTab = <creativetab:misc>;
    item.register();
}
function regItemWithStackSize(name as string, maxStackSize as int) {
    val item as Item = VanillaFactory.createItem(name);
    item.creativeTab = <creativetab:misc>;
    item.maxStackSize = maxStackSize;
    item.register();
}
function regFluid(regName as string, color as int, temperature as int) {
    var fluid = VanillaFactory.createFluid(regName, color);
    fluid.colorize = true;
    fluid.temperature = temperature;
    fluid.stillLocation = "base:fluids/liquid";
    fluid.flowingLocation = "base:fluids/liquid_flow";
    fluid.register();
}

//奇观拓展物品
regItem("aw_pmc");
regItem("aw_pmc_pro");
regItem("stellaris_shipboard_ship_mk2");
regItem("stellaris_shipboard_ship_mk3");
regItem("blokkat_frame");
regItem("stellaris_shipboard_ship_mk4");
regItem("celestial_network_network_card");
regItem("aw_pentaerythritol_powder");//季戊四醇粉
regItem("four_four_diphenylmethane_diisocyanate_powder");//4-4-二苯基甲烷二异氰酸脂粉
regItem("kevlar_plate");//凯夫拉片
regItem("woven_kevlar");//编织凯夫拉
regItem("kevlar_fiber");//凯夫拉纤维
regItem("calcium_powder");//钙粉
regItem("chlorin_calcium_powder");//氯化钙
regItem("terephthaloyl_chloride_powder");//对苯二甲酰氯粉 C8H4CL2N2
regItem("p_p0henylenediamine_powder");//对苯二胺粉 C6H8N2
regFluid("aw_chlorine", 0x1FF01F, 300); // 氯 - 黄绿色（氯气标准色）
regFluid("aw_hydrochloric_acid", 0xF0F0FF, 300); // 盐酸 - 淡蓝色（浓盐酸发烟特性）
regFluid("aw_nitric_acid", 0xFFF8A0, 300); // 硝酸 - 淡黄色（发烟硝酸颜色）
regFluid("aw_aqua_regia", 0xFFD700, 300); // 王水 - 金色（溶解黄金时的颜色）
regFluid("aw_chlorine_methane", 0x80FFFF, 300); // 氯甲烷 - 淡青色（低温液化气体）
regFluid("aw_silicon_chlorine_methane", 0xE6E6FA, 300); // 二甲基二氯硅烷 - 淡紫色
regFluid("aw_ethylene_oxide", 0xFFEEEE, 300); // 环氧乙烷 - 极淡粉（剧毒警示）
regFluid("aw_acetone", 0xE6FFE6, 300); // 丙酮 - 淡绿色（工业级溶剂）
regFluid("aw_benzene", 0xFFF5EE, 300); // 苯 - 淡乳白（芳香烃典型色）
regFluid("aw_anilin_c6h5nh2", 0xC8B560, 300); // 苯胺 - 淡棕黄（油状液体）
regFluid("aw_nitric_base_ester", 0xE6D5B8, 300); // 硝基苯 - 淡黄棕（杏仁油色）
regFluid("aw_nitric_acid_mixing", 0xFFE4B5, 300); // 硝酸混酸 - 米黄色
regFluid("aw_diphenylmethane_diisocyanate_mixture", 0xD2B48C, 300); // MDI混合物 - 淡棕
regFluid("aw_diphenylmethane_mixture", 0xF5DEB3, 300); // 二氨基二苯甲烷 - 小麦色
regFluid("aw_carbonyl_cyanide", 0x98FF98, 300); // 碳酰氰 - 淡绿（剧毒气体）
regFluid("aw_polyurethane_resin", 0xFFFFE0, 300); // 聚氨酯树脂 - 淡黄
regFluid("aw_silicon_oil", 0xE6F5FD, 300); // 硅油 - 淡蓝白（透明液体反光）
regFluid("aw_liquid_crystal_kevlar", 0xF0E68C, 300); // 液晶凯夫拉 - 卡其黄
regFluid("aw_n_methylpyrrolidone", 0xE6E6FA, 300); // NMP - 淡紫（极性溶剂）
regItem("stellaris_food");
regItem("fty_toy_car");
regItem("fty_toy_car_fibre_plastic");
regItem("fty_toy_car_plastic");
regItem("fty_toy_car_wheel");
regItem("fty_toy_car_handle_bar");
regItem("ftyingot");