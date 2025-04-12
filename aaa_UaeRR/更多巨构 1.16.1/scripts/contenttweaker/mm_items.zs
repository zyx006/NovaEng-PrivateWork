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



//糖
regItem("mm_dcjz");
regItem("mm_nljz");
regItem("mm_xxjz");
regItem("mm_jgjz");
regItem("mm_xxjz1");
regItem("mm_yljz");
regItem("mm_hwjz");
regItem("mm_yzjz");
regItem("mm_hysz");
regItem("mm_jbbmc");
regItem("mm_ldx");
regItem("quasar_energy");
regItem("anti_viod");
regItem("rfns");
regItem("stellaris_crystal");
regItem("stellaris_gas");
regItem("stellaris_alloy");
regItem("stellaris_darkmatter");
regItem("stellaris_shipboard_ship");
var haxwz = VanillaFactory.createFluid("haxwz", Color.fromHex("000000").getIntColor());
haxwz.colorize = true;
haxwz.temperature = 6000000;
haxwz.luminosity = 5;
haxwz.stillLocation = "base:fluids/liquid";
haxwz.flowingLocation = "base:fluids/liquid_flow";
haxwz.register();

var baxwz = VanillaFactory.createFluid("baxwz", Color.fromHex("FFFFFF").getIntColor());
baxwz.colorize = true;
baxwz.temperature = 6000000;
baxwz.luminosity = 5;
baxwz.stillLocation = "base:fluids/liquid";
baxwz.flowingLocation = "base:fluids/liquid_flow";
baxwz.register();

var hxwz = VanillaFactory.createFluid("hxwz", Color.fromHex("FE0103").getIntColor());
hxwz.colorize = true;
hxwz.temperature = 6000000;
hxwz.luminosity = 5;
hxwz.stillLocation = "base:fluids/liquid";
hxwz.flowingLocation = "base:fluids/liquid_flow";
hxwz.register();

var bylt = VanillaFactory.createFluid("bylt", Color.fromHex("00f9f9").getIntColor());
bylt.colorize = true;
bylt.temperature = 6000000;
bylt.luminosity = 5;
bylt.stillLocation = "base:fluids/liquid";
bylt.flowingLocation = "base:fluids/liquid_flow";
bylt.register();

var space = VanillaFactory.createFluid("space", Color.fromHex("004cf9").getIntColor());
space.colorize = true;
space.temperature = 6000000;
space.luminosity = 5;
space.stillLocation = "base:fluids/liquid";
space.flowingLocation = "base:fluids/liquid_flow";
space.register();

var yh = VanillaFactory.createFluid("yh", Color.fromHex("00f900").getIntColor());
yh.colorize = true;
yh.temperature = 6000000;
yh.luminosity = 5;
yh.stillLocation = "base:fluids/liquid";
yh.flowingLocation = "base:fluids/liquid_flow";
yh.register();

var yzs = VanillaFactory.createFluid("yzs", Color.fromHex("FFFFFF").getIntColor());
yzs.colorize = true;
yzs.temperature = 6000000;
yzs.luminosity = 5;
yzs.stillLocation = "base:fluids/liquid";
yzs.flowingLocation = "base:fluids/liquid_flow";
yzs.register();

function regFluid(regName as string, color as int, temperature as int) {
    var fluid = VanillaFactory.createFluid(regName, color);
    fluid.colorize = true;
    fluid.temperature = temperature;
    fluid.stillLocation = "base:fluids/liquid";
    fluid.flowingLocation = "base:fluids/liquid_flow";
    fluid.register();
}

