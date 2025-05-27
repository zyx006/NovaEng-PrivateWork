//石油化工添加
#priority 1000

#loader contenttweaker

import mods.contenttweaker.VanillaFactory;
import mods.contenttweaker.Fluid;
import mods.contenttweaker.Color;


///////石油化工//////
// 四硝基甲烷 
regFluid("oil_tetranitromethane",0x102222, 300);

// 高十六烷值柴油
regFluid("oil_cetan_eboosted_diesel",0xA2B012, 300);

// 含硫轻燃油
regFluid("oil_sulfur_rich_light_fuel",0xC3B704, 300);

//含硫重燃油
regFluid("oil_sulfur_rich_heavy_fuel",0xF6E5A9, 300);

//含硫石脑油
//regFluid("oil_sulfur_rich_naphtha",0xB4BE4C, 300);

//含硫炼油气 
regFluid("oil_sulfur_rich_refinery_gas",0xDCD9D9, 300);

// 重燃油
regFluid("oil_heavy_fuel",0xF6E5A9, 300);

// 轻燃油
regFluid("oil_light_fuel",0xC3B704, 300);

// 燃油
regFluid("oil_fuel",0x676109, 300);

// 硫化氢
regFluid("oil_h2s",0xD74D0B, 300);

// 硝酸
regFluid("oil_hno3",0xC0C125, 300);

// 乙烯酮
regFluid("oil_c2h2o",0x141437, 300);

// 乙酸
regFluid("oil_c2h4o2",0x918475, 300);

// 稀硫酸
//regFluid("oil_h2so4_dilute",0xB4BE4C, 300);

// 木炭副产
regFluid("oil_charcoal_byproducts",0x644938, 300);







function regFluid(regName as string, color as int, temperature as int) {
    var fluid = VanillaFactory.createFluid(regName, color);
    fluid.colorize = true;
    fluid.temperature = temperature;
    fluid.stillLocation = "base:fluids/liquid";
    fluid.flowingLocation = "base:fluids/liquid_flow";
    fluid.register();
}
