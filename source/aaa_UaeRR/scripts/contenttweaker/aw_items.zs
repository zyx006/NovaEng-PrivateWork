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



//奇观拓展物品
regItem("aw_pmc");
regItem("aw_pmc_pro");
regItem("stellaris_shipboard_ship_mk2");
regItem("stellaris_shipboard_ship_mk3");
regItem("blokkat_frame");
regItem("stellaris_shipboard_ship_mk4");