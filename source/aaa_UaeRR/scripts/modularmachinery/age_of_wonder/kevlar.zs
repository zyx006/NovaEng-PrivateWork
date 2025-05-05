//ALL RIGHTS RESERVED
//也许你可以对私货进行更改。

#priority 10
#loader crafttweaker reloadable

import mods.modularmachinery.MMEvents;
import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.MachineBuilder;
import mods.modularmachinery.MachineTickEvent;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.MultiblockModifierBuilder;
import mods.modularmachinery.ControllerGUIRenderEvent;
import mods.modularmachinery.BlockArrayBuilder;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.IMachineController;

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
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.research.ResearchCognitionData;
import novaeng.NovaEngUtils;

RecipeBuilder.newBuilder("oil_chemical", "chemical_complex", 2)
    .addEnergyPerTickInput(30000)
    .addInput(<liquid:crude_oil> * 1000)
    .addInput(<liquid:steam> * 1000)
    .addOutput(<liquid:ethene> * 100)  //乙烯
    .addOutput(<liquid:methane> * 100)  //甲烷
    .addOutput(<liquid:aw_acetone> * 40)  //丙酮
    .addOutput(<liquid:aw_benzene> * 80)  //苯
    .build();
RecipeBuilder.newBuilder("aw_chlorine", "large_electrolyzer", 10)
    .addInput(<mekanism:salt> * 1)  //盐
    .addOutput(<liquid:aw_chlorine> * 1000)  //氯
    .build();
RecipeBuilder.newBuilder("aw_chlorine_methane", "chemical_complex", 20)
    .addEnergyPerTickInput(30000)
    .addInput(<liquid:methane> * 1000)
    .addInput(<liquid:aw_chlorine> * 2000)
    .addOutput(<liquid:aw_chlorine_methane> * 1000)      //氯乙烯
    .addOutput(<liquid:aw_hydrochloric_acid> * 1000)      //盐酸
    .build();
RecipeBuilder.newBuilder("aw_electrolyzer_hydrochloric_acid", "large_electrolyzer", 10)
    .addInput(<liquid:aw_hydrochloric_acid> * 1000)      //盐酸
    .addOutput(<liquid:aw_chlorine> * 1000)   //氯
    .addOutput(<liquid:hydrogen> * 1000)      //氢
    .build();
RecipeBuilder.newBuilder("aw_silicon_chlorine_methane", "chemical_complex", 20)
    .addEnergyPerTickInput(30000)
    .addInput(<appliedenergistics2:material:5> * 1)  //硅
    .addInput(<liquid:aw_chlorine_methane> * 1000)      //氯乙烯
    .addOutput(<liquid:aw_silicon_chlorine_methane> * 1000)      //二甲基二氯硅烷
    .build();
RecipeBuilder.newBuilder("aw_ethylene_glycol", "chemical_complex", 20)
    .addEnergyPerTickInput(30000)
    .addInput(<liquid:aw_ethylene_oxide> * 1000)  //环氧乙烷
    .addInput(<liquid:water> * 1000)      //水
    .addOutput(<liquid:ethylene_glycol> * 1000)      //乙二醇
    .build();
RecipeBuilder.newBuilder("aw_ethylene_oxide", "chemical_complex", 20)
    .addEnergyPerTickInput(30000)
    .addInput(<liquid:ethene> * 1000)  //乙烯
    .addInput(<liquid:oxygen> * 1000)      //氧
    .addOutput(<liquid:aw_ethylene_oxide> * 1000)      //环氧乙烷
    .build();
RecipeBuilder.newBuilder("aw_ethanol_ethene", "chemical_complex", 20)
    .addEnergyPerTickInput(30000)
    .addInput(<liquid:aw_acetone> * 1000)      //丙酮
    .addInput(<liquid:oxygen> * 1000)      //氧
    .addOutput(<liquid:ethene> * 1000)  //甲醇
    .addOutput(<liquid:ethanol> * 4000)      //乙醇
    .build();
RecipeBuilder.newBuilder("aw_aw_pentaerythritol_powder", "chemical_complex", 20)
    .addEnergyPerTickInput(30000)
    .addInput(<nuclearcraft:compound:5> * 1).setChance(0)      //氢氧化钠粉
    .addInput(<liquid:ethene> * 1000)  //甲醇
    .addInput(<liquid:ethanol> * 4000)      //乙醇
    .addOutput(<contenttweaker:aw_pentaerythritol_powder> * 21)      //季戊四醇粉
    .addOutput(<liquid:carbon_monoxide> * 1000)      //一氧化碳
    .build();
RecipeBuilder.newBuilder("aw_four_four_diphenylmethane_diisocyanate_powder", "chemical_complex", 20)
    .addEnergyPerTickInput(30000)
    .addInput(<liquid:aw_diphenylmethane_diisocyanate_mixture> * 1000)  //二苯基甲烷二异氰酸脂混合物
    .addOutput(<contenttweaker:four_four_diphenylmethane_diisocyanate_powder> * 29)      //4-4-二苯基甲烷二异氰酸脂粉
    .addOutput(<liquid:aw_hydrochloric_acid> * 5000)      //盐酸
    .build();
RecipeBuilder.newBuilder("aw_diphenylmethane_diisocyanate_mixture", "chemical_complex", 20)
    .addEnergyPerTickInput(30000)
    .addInput(<liquid:aw_diphenylmethane_mixture> * 1000)  //二氨基二苯甲烷混合物
    .addInput(<liquid:aw_carbonyl_cyanide> * 1000)  //碳酰氰
    .addOutput(<liquid:aw_diphenylmethane_diisocyanate_mixture> * 1000)      //二苯基甲烷二异氰酸脂混合物
    .build();
RecipeBuilder.newBuilder("aw_diphenylmethane_mixture", "chemical_complex", 20)
    .addEnergyPerTickInput(30000)
    .addInput(<liquid:aw_hydrochloric_acid> * 1000)      //盐酸
    .addInput(<liquid:ethene> * 1000)  //甲醇
    .addInput(<liquid:aw_anilin_c6h5nh2> * 2000)  //苯胺
    .addOutput(<liquid:aw_diphenylmethane_mixture> * 1000)      //二氨基二苯甲烷混合物
    .build();
RecipeBuilder.newBuilder("aw_anilin_c6h5nh2", "chemical_complex", 20)
    .addEnergyPerTickInput(30000)
    .addInput(<liquid:aw_nitric_base_ester> * 1000)      //硝基苯
    .addInput(<liquid:hydrogen> * 3000)  //氢
    .addOutput(<liquid:aw_anilin_c6h5nh2> * 1000)  //苯胺
    .addOutput(<liquid:water> * 2000)      //水
    .build();
RecipeBuilder.newBuilder("aw_nitric_base_ester", "chemical_complex", 20)
    .addEnergyPerTickInput(30000)
    .addInput(<liquid:aw_nitric_acid_mixing> * 2000)      //硝酸混酸
    .addInput(<liquid:aw_benzene> * 5000)      //苯
    .addInput(<liquid:water> * 2000)  //水
    .addOutput(<liquid:aw_nitric_base_ester> * 8000)  //硝基苯
    .addOutput(<liquid:sulfuric_acid> * 1000)      //硫酸
    .build();
RecipeBuilder.newBuilder("aw_nitric_acid_mixing", "chemical_complex", 20)
    .addEnergyPerTickInput(30000)
    .addInput(<liquid:aw_nitric_acid> * 1000)  //硝酸
    .addInput(<liquid:sulfuric_acid> * 1000)      //硫酸
    .addOutput(<liquid:aw_nitric_acid_mixing> * 1000) //硝酸混酸
    .build();
RecipeBuilder.newBuilder("aw_nitric_acid", "chemical_complex", 20)
    .addEnergyPerTickInput(30000)
    .addInput(<liquid:oxygen> * 3000)      //氧
    .addInput(<liquid:hydrogen> * 1000)      //氢
    .addInput(<liquid:nitrogen> * 1000)      //氮
    .addOutput(<liquid:aw_nitric_acid> * 1000)  //硝酸
    .build();
RecipeBuilder.newBuilder("aw_aqua_regia", "chemical_complex", 20)
    .addEnergyPerTickInput(30000)
    .addInput(<liquid:aw_nitric_acid> * 1000)  //硝酸
    .addInput(<liquid:aw_hydrochloric_acid> * 2000)      //盐酸
    .addOutput(<liquid:aw_aqua_regia> * 1000)      //王水
    .build();
RecipeBuilder.newBuilder("aw_carbonyl_cyanide", "chemical_complex", 20)
    .addEnergyPerTickInput(30000)
    .addInput(<liquid:carbon_monoxide> * 1000)  //一氧化碳
    .addInput(<liquid:aw_chlorine> * 2000)      //氯
    .addOutput(<liquid:aw_carbonyl_cyanide> * 1000)      //碳酰氰
    .build();
RecipeBuilder.newBuilder("aw_silicon_oil", "chemical_complex", 20)
    .addEnergyPerTickInput(30000)
    .addInput(<liquid:aw_silicon_chlorine_methane> * 4000)  //二甲基二氯硅烷
    .addInput(<liquid:aw_ethylene_oxide> * 1000)  //环氧乙烷
    .addInput(<liquid:water> * 5000)      //水
    .addOutput(<liquid:aw_silicon_oil> * 1000)      //硅油
    .build();
RecipeBuilder.newBuilder("aw_polyurethane_resin", "chemical_complex", 20)
    .addEnergyPerTickInput(30000)
    .addInput(<liquid:aw_silicon_oil> * 1000)   //硅油
    .addInput(<contenttweaker:four_four_diphenylmethane_diisocyanate_powder> * 5)      //4-4-二苯基甲烷二异氰酸脂粉
    .addInput(<liquid:ethylene_glycol> * 4000)  //乙二醇
    .addInput(<contenttweaker:aw_pentaerythritol_powder> * 1)      //季戊四醇粉
    .addOutput(<liquid:aw_polyurethane_resin> * 1000)      //聚氨醇树脂 byd这东西要的都是好样的,我一个都不认识
    .build();
RecipeBuilder.newBuilder("kevlarqft1", "QFT", 1)
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0)
    .addInput(<thermalfoundation:material:768> * 1)
    .addOutput(<contenttweaker:calcium_powder> * 1)
    .build();
RecipeBuilder.newBuilder("kevlarqft2", "QFT", 1)
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0)
    .addInput(<liquid:water> * 1048576)
    .addOutput(<liquid:crude_oil> * 1048576)
    .build();
//对苯二胺粉 C6H8N2 p_p0henylenediamine_powder
//对苯二甲酰氯粉 C8H4CL2N2 terephthaloyl_chloride_powder
//N-甲基吡咯烷酮 C5H9NO aw_n_methylpyrrolidone
RecipeBuilder.newBuilder("kevlarqft3", "QFT", 1)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addInput(<thermalfoundation:material:768> * 6)
    .addInput(<liquid:oxygen> * 8000)
    .addInput(<liquid:nitrogen> * 2000)
    .addOutput(<contenttweaker:p_p0henylenediamine_powder> * 1)
    .build();
RecipeBuilder.newBuilder("kevlarqft4", "QFT", 1)
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0)
    .addInput(<thermalfoundation:material:768> * 8)
    .addInput(<liquid:nitrogen> * 2000)
    .addInput(<liquid:hydrogen> * 4000)
    .addInput(<liquid:aw_chlorine> * 2000)
    .addOutput(<contenttweaker:terephthaloyl_chloride_powder> * 1)
    .build();
RecipeBuilder.newBuilder("kevlarqft5", "QFT", 1)
    .addInput(<contenttweaker:programming_circuit_f>).setChance(0)
    .addInput(<thermalfoundation:material:768> * 5)
    .addInput(<liquid:oxygen> * 1000)
    .addInput(<liquid:hydrogen> * 9000)
    .addInput(<liquid:nitrogen> * 1000)
    .addOutput(<liquid:aw_n_methylpyrrolidone> * 1000)
    .build();
RecipeBuilder.newBuilder("chlorin_calcium_powder", "chemical_complex", 20)
    .addEnergyPerTickInput(30000)
    .addInput(<liquid:aw_chlorine> * 1000)   //氯
    .addInput(<contenttweaker:calcium_powder> * 1)      //4-4-二苯基甲烷二异氰酸脂粉
    .addOutput(<contenttweaker:chlorin_calcium_powder> * 1)      //氯化钙
    .build();
RecipeBuilder.newBuilder("aw_liquid_crystal_kevla", "chemical_complex", 20)
    .addEnergyPerTickInput(30000)
    .addInput(<contenttweaker:p_p0henylenediamine_powder> * 9)   //对苯二胺粉
    .addInput(<contenttweaker:terephthaloyl_chloride_powder> * 9)      //对苯二甲酰氯粉
    .addInput(<liquid:aw_n_methylpyrrolidone> * 1000)  //N-甲基吡咯烷酮
    .addInput(<contenttweaker:chlorin_calcium_powder> * 1)      //氯化钙
    .addOutput(<liquid:aw_liquid_crystal_kevlar> * 9000)      //液晶kevlar
    .build();
RecipeBuilder.newBuilder("kevlarqft6", "QFT", 1)
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0)
    .addInput(<liquid:aw_liquid_crystal_kevlar> * 900) //液晶kevlar
    .addOutput(<contenttweaker:kevlar_fiber> * 1)   //kevlar纤维
    .build();
RecipeBuilder.newBuilder("kevlarqft7", "odal_ar", 7200)
    .addInput(<contenttweaker:mm_ldx> * 64) //拉多x聚合物
    .addInput(<contenttweaker:anti_viod>)  //负虚空
    .addInput(<contenttweaker:kevlar_fiber> * 10) //kevlar纤维
    .addOutput(<contenttweaker:woven_kevlar> * 1) //纺织kevlar
    .build();
RecipeBuilder.newBuilder("kevlarqft8", "odal_sd", 7200)
    .addInput(<contenttweaker:arkforcefieldcontrolblock> * 32) //方舟力场
    .addInput(<liquid:aw_polyurethane_resin> * 1000) //聚氨醇树脂
    .addInput(<contenttweaker:woven_kevlar>* 10)    //纺织kevlar
    .addOutput(<contenttweaker:kevlar_plate> * 1)   //kevlar片
    .build();
RecipeBuilder.newBuilder("aw_hydrochloric_acid", "chemical_complex", 10)
    .addOutput(<liquid:aw_hydrochloric_acid> * 1000)      //盐酸
    .addInput(<liquid:aw_chlorine> * 1000)   //氯
    .addInput(<liquid:hydrogen> * 1000)      //氢
    .build();