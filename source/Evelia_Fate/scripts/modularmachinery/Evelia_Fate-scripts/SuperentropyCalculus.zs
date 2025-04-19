import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.MachineBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.MMEvents;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.RecipeModifierBuilder;

import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;

import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.research.ResearchCognitionData;

RecipeBuilder.newBuilder("SuperentropyCalculus","workshop",7200)
    .addInputs([
        <contenttweaker:arkforcefieldcontrolblock>*9,
        <avaritiaio:infinitecapacitor>*8,
        <contenttweaker:world_energy_core>*4,
        <contenttweaker:life_regeneration_core>*4,
        <contenttweaker:field_generator_v4>*32,
        <contenttweaker:level_infinity_orb>,
        <botania:specialflower>.withTag({type: "asgardandelion"})*4,
    ])
    .addInput(<contenttweaker:superluminal_core>).setChance(0)
    .requireComputationPoint(100000.0F)
    .requireResearch("SuperentropyCalculus")
    .addOutput(<modularmachinery:superentropycalculus_factory_controller>)
    .build();

MachineModifier.setMaxThreads("SuperentropyCalculus",0);
MachineModifier.setInternalParallelism("SuperentropyCalculus",262144);
MachineModifier.addCoreThread("SuperentropyCalculus", FactoryRecipeThread.createCoreThread("时空场发生器").addRecipe("common_timespace_field"));
MachineModifier.addCoreThread("SuperentropyCalculus", FactoryRecipeThread.createCoreThread("超熵演算机").addRecipe("SuperentropyCalculus_machine"));
for i in 1 to 33{
    MachineModifier.addCoreThread("SuperentropyCalculus", FactoryRecipeThread.createCoreThread("时空场区域#" + i));
}
HyperNetHelper.proxyMachineForHyperNet("SuperentropyCalculus");

RecipeBuilder.newBuilder("Y1_laser","Star_collapser",7200)
    .addInputs([
        <mekanism:machineblock2:13>*64,
        <environmentaltech:laser_core>*64,
        <contenttweaker:field_generator_v3>*8,
        <contenttweaker:arkmachineblock>*6,
        <contenttweaker:sensor_v5>*8
    ])
    .addEnergyPerTickInput(500000000000)
    .addOutput(<contenttweaker:las_yio_large_lasers>)
    .requireComputationPoint(7500.0F)
    .build();
RecipeBuilder.newBuilder("common_timespace_field","SuperentropyCalculus",2147483647)
    .addInputs([
        <avaritia:block_resource:1>*8,
        <contenttweaker:arkforcefieldcontrolblock>*32,
        <contenttweaker:universalforcefieldcontrolblock>*40,
        <avaritiatweaks:enhancement_crystal>*32,
        <avaritiaddons:avaritiaddons_chest:1>*8
    ])
    .setThreadName("时空场发生器")
    .addRecipeTooltip("以无尽箱子的无穷空间创造出一个稳定持续的时空场")
    .build();
RecipeBuilder.newBuilder("SuperentropyCalculus_machine","SuperentropyCalculus",262144)
    .addInput(<contenttweaker:hypernet_ram_max>).setChance(0)
    .addInput(<contenttweaker:hypernet_gpu_max>).setChance(0)
    .addInput(<contenttweaker:additional_component_3>*8).setChance(0)
    .addInputs(<contenttweaker:energized_fuel_v4>*16)
    .setThreadName("超熵演算机")
    .addRecipeTooltip("为时空场充能，并提供足够的算力以演算数据")
    .addRecipeTooltip("需求时空场，为其余配方前置")
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚未建立时空场！");
            return;
        }
    })
    .build();

RecipeBuilder.newBuilder("infinity_calculus","SuperentropyCalculus",600)
    .addInputs([
        <ore:dyeRed>,
        <ore:dyeOrange>,
        <ore:dyeYellow>,
        <ore:dyeGreen>,
        <ore:dyeCyan>,
        <ore:dyeBlue>,
        <ore:dyePurple>,
        <ore:ingotIron>
    ])
    .addEnergyPerTickInput(1000000000000)
    .addRecipeTooltip("是的，这就是彩虹铁")
    .addInput(<contenttweaker:rainbow_core>).setChance(0)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[1].activeRecipe)){
            event.setFailed("尚未启动超熵演算！");
            return;
        }
    })
    .addInput(<astralsorcery:blockprism>.withTag({astralsorcery: {crystalProperties: {collectiveCapability: 100, size: 900, fract: 0, purity: 100, sizeOverride: -1}}})).setChance(0)
    .addCatalystInput(<contenttweaker:superluminal_core>,
        ["超越光速之后，对寰宇之力的控制得以更加精确和彻底","耗时减少80%，需求能源输入降低50%"],
        [RecipeModifierBuilder.create("modularmachinery:duration","input",0.2,1,false).build(),RecipeModifierBuilder.create("modularmachinery:energy","input",0.5,1,false).build()]
    ).setChance(0).setParallelizeUnaffected(true)
    .addCatalystInput(<contenttweaker:ymysq>*32,
        ["强大而稳定的约束器降低了时空场的波动","耗能降低50%"],
        [RecipeModifierBuilder.create("modularmachinery:energy","input",0.5,1,false).build()]
    ).setChance(0).setParallelizeUnaffected(true)
    .addCatalystInput(<appliedenergistics2:creative_energy_cell>*4,
        ["虽然我们无法将其中的力量用于生产，但其阵列在超熵演算方面却有奇效","耗时减少50%，需求能源输入减少75%"],
        [RecipeModifierBuilder.create("modularmachinery:duration","input",0.5,1,false).build(),RecipeModifierBuilder.create("modularmachinery:energy","input",0.25,1,false).build()]
    ).setChance(0).setParallelizeUnaffected(true)
    .addOutput(<ore:ingotInfinity>)
    .addOutput(<contenttweaker:beta_matter>).setChance(0.01)
    .addOutput(<ore:blockInfinity>).setChance(0.01)
    .build();
RecipeBuilder.newBuilder("infinity_calculus_1","SuperentropyCalculus",600)
    .addInputs([
        <ore:dyeRed>,
        <ore:dyeOrange>,
        <ore:dyeYellow>,
        <ore:dyeGreen>,
        <ore:dyeCyan>,
        <ore:dyeBlue>,
        <ore:dyePurple>,
        <ore:ingotIron>
    ])
    .addFluidPerTickInput(<liquid:liquid_energy>*200)
    .addRecipeTooltip("是的，这就是彩虹铁")
    .addInput(<contenttweaker:rainbow_core>).setChance(0)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[1].activeRecipe)){
            event.setFailed("尚未启动超熵演算！");
            return;
        }
    })
    .addInput(<astralsorcery:blockprism>.withTag({astralsorcery: {crystalProperties: {collectiveCapability: 100, size: 900, fract: 0, purity: 100, sizeOverride: -1}}})).setChance(0)
    .addCatalystInput(<contenttweaker:superluminal_core>,
        ["超越光速之后，对寰宇之力的控制得以更加精确和彻底","耗时减少80%，需求能源输入降低50%"],
        [RecipeModifierBuilder.create("modularmachinery:duration","input",0.2,1,false).build(),RecipeModifierBuilder.create("modularmachinery:fluid","input",0.5,1,false).build()]
    ).setChance(0).setParallelizeUnaffected(true)
    .addCatalystInput(<contenttweaker:ymysq>*32,
        ["强大而稳定的约束器降低了时空场的波动","耗能降低50%"],
        [RecipeModifierBuilder.create("modularmachinery:fluid","input",0.5,1,false).build()]
    ).setChance(0).setParallelizeUnaffected(true)
    .addCatalystInput(<appliedenergistics2:creative_energy_cell>*4,
        ["虽然我们无法将其中的力量用于生产，但其阵列在超熵演算方面却有奇效","耗时减少50%，需求能源输入减少75%"],
        [RecipeModifierBuilder.create("modularmachinery:duration","input",0.5,1,false).build(),RecipeModifierBuilder.create("modularmachinery:fluid","input",0.25,1,false).build()]
    ).setChance(0).setParallelizeUnaffected(true)
    .addOutput(<ore:ingotInfinity>)
    .addOutput(<ore:blockInfinity>).setChance(0.01)
    .addOutput(<contenttweaker:beta_matter>).setChance(0.01)
    .build();
RecipeAdapterBuilder.create("SuperentropyCalculus", "nuclearcraft:alloy_furnace")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.01, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 5.0, 1, false).build())
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[1].activeRecipe)){
            event.setFailed("尚未启动超熵演算！");
            return;
        }
    })
    .addCatalystInput(<contenttweaker:superluminal_core>,
        ["超越光速之后，对寰宇之力的控制得以更加精确和彻底","耗时减少80%，需求能源输入降低50%"],
        [RecipeModifierBuilder.create("modularmachinery:duration","input",0.2,1,false).build(),RecipeModifierBuilder.create("modularmachinery:energy","input",0.5,1,false).build()]
    ).setChance(0).setParallelizeUnaffected(true)
    .addCatalystInput(<contenttweaker:ymysq>*32,
        ["强大而稳定的约束器降低了时空场的波动","耗能降低50%"],
        [RecipeModifierBuilder.create("modularmachinery:energy","input",0.5,1,false).build()]
    ).setChance(0).setParallelizeUnaffected(true)
    .addCatalystInput(<appliedenergistics2:creative_energy_cell>*4,
        ["虽然我们无法将其中的能量用于生产，但其阵列在超熵演算方面却有奇效","耗时减少50%，需求能源输入减少75%"],
        [RecipeModifierBuilder.create("modularmachinery:duration","input",0.5,1,false).build(),RecipeModifierBuilder.create("modularmachinery:energy","input",0.25,1,false).build()]
    ).setChance(0).setParallelizeUnaffected(true)
    .build();

var jsq=0;
function STdispose(item as IIngredient[],output as IIngredient,jsq as int){
    RecipeBuilder.newBuilder("STdispose"+jsq,"SuperentropyCalculus",20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[1].activeRecipe)){
            event.setFailed("尚未启动超熵演算！");
            return;
        }
    })
    .addCatalystInput(<contenttweaker:superluminal_core>,
        ["超越光速之后，对寰宇之力的控制得以更加精确和彻底","耗时减少50%，需求能源输入降低50%"],
        [RecipeModifierBuilder.create("modularmachinery:duration","input",0.2,1,false).build(),RecipeModifierBuilder.create("modularmachinery:energy","input",0.5,1,false).build()]
    ).setChance(0).setParallelizeUnaffected(true)
    .addCatalystInput(<contenttweaker:ymysq>*32,
        ["强大而稳定的约束器降低了时空场的波动","耗能降低50%"],
        [RecipeModifierBuilder.create("modularmachinery:energy","input",0.5,1,false).build()]
    ).setChance(0).setParallelizeUnaffected(true)
    .addCatalystInput(<appliedenergistics2:creative_energy_cell>*4,
        ["虽然我们无法将其中的力量用于生产，但其阵列在超熵演算方面却有奇效","耗时减少50%，需求能源输入减少75%"],
        [RecipeModifierBuilder.create("modularmachinery:duration","input",0.5,1,false).build(),RecipeModifierBuilder.create("modularmachinery:energy","input",0.25,1,false).build()]
    ).setChance(0).setParallelizeUnaffected(true)
    .addEnergyPerTickInput(10000)
    .addInputs(item)
    .addOutput(output)
    .build();
}
STdispose([<taiga:eezo_ingot> * 2,<taiga:abyssum_ingot> * 2,<taiga:osram_ingot> * 2,<taiga:obsidiorite_ingot> * 9],<taiga:iox_ingot>,jsq);jsq += 1;//离金锭
STdispose([<taiga:eezo_ingot> * 4,<taiga:abyssum_ingot> * 4,<taiga:osram_ingot> * 4,<ore:obsidian> * 9,<taiga:meteorite_ingot> * 18],<taiga:iox_ingot>,jsq);jsq += 1;//离金锭
STdispose([<taiga:prometheum_ingot> * 3, <taiga:palladium_ingot> * 3,<taiga:eezo_ingot>], <taiga:proxii_ingot> * 3, jsq); jsq += 1; // 普罗克希锭
STdispose([<taiga:terrax_ingot> * 3, <taiga:aurorium_ingot> * 2], <taiga:astrium_ingot> * 2,  jsq); jsq += 1; // 曜金锭
STdispose([<taiga:proxii_ingot> * 3, <taiga:abyssum_ingot>, <taiga:osram_ingot>], <taiga:nucleum_ingot> * 3, jsq); jsq += 1; // 辐光合金锭
STdispose([<taiga:imperomite_ingot> * 3, <taiga:osram_ingot>, <taiga:eezo_ingot>], <taiga:nucleum_ingot> * 3.0, jsq); jsq += 1; // 辐光合金锭
STdispose([<taiga:niob_ingot> * 3, <taiga:eezo_ingot>, <taiga:abyssum_ingot>], <taiga:nucleum_ingot> * 3,  jsq); jsq += 1; // 辐光合金锭
STdispose([<taiga:tiberium_ingot> * 5, <taiga:basalt_ingot>], <taiga:triberium_ingot>,  jsq); jsq += 1; // 泰伯利安
STdispose([<taiga:tiberium_ingot> * 5, <taiga:dilithium_ingot> * 2], <taiga:triberium_ingot>,  jsq); jsq += 1; // 泰伯利安
STdispose([<tconstruct:ingots:1> * 2, <taiga:terrax_ingot> * 2, <taiga:osram_ingot>], <taiga:ignitz_ingot> * 2,  jsq); jsq += 1; // 焰晶锭
STdispose([<taiga:karmesine_ingot>, <taiga:ovium_ingot>, <taiga:jauxum_ingot>], <taiga:terrax_ingot> * 2,  jsq); jsq += 1; // 地母锭
STdispose([<taiga:duranite_ingot> * 3, <taiga:prometheum_ingot>, <taiga:abyssum_ingot>], <taiga:imperomite_ingot> * 2,  jsq); jsq += 1; // 帝金锭
STdispose([<taiga:iox_ingot> * 3, <taiga:solarium_ingot>, <taiga:vibranium_ingot>], <taiga:adamant_ingot> * 3,  jsq); jsq += 1; // 铿金锭
STdispose([<taiga:iox_ingot> * 3, <taiga:nihilite_ingot> * 2], <taiga:adamant_ingot> * 3,  jsq); jsq += 1; // 铿金锭
STdispose([<taiga:palladium_ingot>, <taiga:terrax_ingot>], <taiga:lumix_ingot>,  jsq); jsq += 1; // 流光合金锭
STdispose([<taiga:palladium_ingot> * 3, <taiga:duranite_ingot>, <taiga:osram_ingot>], <taiga:niob_ingot> * 3,  jsq); jsq += 1; // 铌锭
STdispose([<taiga:triberium_ingot> * 6, <ore:obsidian> * 3, <taiga:abyssum_ingot> * 2], <taiga:fractum_ingot> * 4,  jsq); jsq += 1; // 碎金锭
STdispose([<taiga:valyrium_ingot> * 2, <taiga:uru_ingot> * 2, <taiga:nucleum_ingot> * 1], <taiga:solarium_ingot> * 2,  jsq); jsq += 1; // 阳光合金锭
STdispose([<tconstruct:ingots> * 3, <taiga:terrax_ingot> * 2], <taiga:tritonite_ingot> * 2,  jsq); jsq += 1; // 漩金锭
STdispose([<taiga:triberium_ingot> * 3, <taiga:fractum_ingot>, <taiga:seismum_ingot>, <taiga:osram_ingot>], <taiga:dyonite_ingot> * 3,  jsq); jsq += 1; // 烈金锭
STdispose([<taiga:tiberium_ingot> * 12, <taiga:fractum_ingot>, <taiga:seismum_ingot>, <taiga:osram_ingot>], <taiga:dyonite_ingot> * 3,  jsq); jsq += 1; // 烈金锭
STdispose([<ore:obsidian> * 2, <taiga:triberium_ingot> * 2, <taiga:eezo_ingot>], <taiga:seismum_ingot> * 4,  jsq); jsq += 1; // 地动合金锭
STdispose([<taiga:uru_ingot> * 3, <taiga:valyrium_ingot> * 3, <taiga:osram_ingot>], <taiga:yrdeen_ingot> * 3,  jsq); jsq += 1; // 原金锭
STdispose([<taiga:uru_ingot> * 3, <taiga:valyrium_ingot> * 3, <taiga:eezo_ingot>], <taiga:yrdeen_ingot> * 3,  jsq); jsq += 1; // 原金锭
STdispose([<taiga:uru_ingot> * 3, <taiga:valyrium_ingot> * 3, <taiga:abyssum_ingot>], <taiga:yrdeen_ingot> * 3,  jsq); jsq += 1; // 原金锭
STdispose([<taiga:aurorium_ingot> * 3, <tconstruct:ingots:1> * 2], <taiga:violium_ingot> * 2,  jsq); jsq += 1; // 瑟蓝锭
STdispose([<taiga:vibranium_ingot>, <taiga:solarium_ingot>], <taiga:nihilite_ingot>,  jsq); jsq += 1; // 虚金
STdispose([<tconevo:material>, <liquid:ic2uu_matter> * 72], <tconevo:metal:40>,  jsq); jsq += 1; // UU金属
STdispose([<tconevo:material> * 16, <ic2:dust:6> * 48], <tconevo:metal:35> * 16,  jsq); jsq += 1; // 能量锭
STdispose([<ore:ingotManasteel> * 2,<ore:ingotDraconium> * 2,<ore:ingotCrystallineAlloy> * 6,<ore:ingotOsmium>,<ore:ingotGold>,<ore:ingotIron>,<ore:ingotCopper>,<ore:ingotTin>], <ore:ingotAlloyT1> * 2,  jsq); jsq += 1; // 基础通用合金
STdispose([<ore:ingotAlloyT1>,<ore:ingotCrystallineAlloy> * 8,<thermalfoundation:material:134> * 12],<ore:ingotBlueAlloy> * 6,  jsq); jsq += 1; // 蓝晶合金
STdispose([<ore:ingotTinSilver> * 4,<ore:dustRedstone> * 8,<ore:ingotBoron> * 2],<modularmachinery:itemmodularium> * 6,  jsq); jsq += 1; // 模块化合金
STdispose([<ore:oreClathrateEnder>*16],<minecraft:ender_pearl> * 64,  jsq); jsq += 1; // 末影珍珠
STdispose([<ore:clathrateEnder>*16],<minecraft:ender_pearl>*16,  jsq); jsq += 1; // 末影珍珠
STdispose([<ore:dustCoal>,<ore:dustFluix>,<ore:ingotIron>],<ore:ingotFluixSteel>,  jsq); jsq += 1;//福鲁伊克斯钢
STdispose([<tconevo:material>,<draconicevolution:wyvern_core>,<ore:blockRedstone>,<ore:gemDiamond>*2],<tconevo:metal>,jsq);jsq += 1;
STdispose([<tconevo:material>,<draconicevolution:awakened_core>,<draconicevolution:wyvern_energy_core>,<minecraft:nether_star>*2],<tconevo:metal:5>,jsq);jsq += 1;
STdispose([<tconevo:material>,<ore:ingotOrichalcos>,<ore:ingotTerrasteel>],<additions:novaextended-terraalloy>,jsq);jsq += 1;
STdispose([<additions:novaextended-terraalloy>,<additions:novaextended-blue_alloy_ingot>,<additions:novaextended-psi_alloy>,<draconicevolution:chaos_shard:1>*2,<appliedenergistics2:material:45>*4],<additions:novaextended-fallen_star_alloy>,jsq);jsq += 1;
STdispose([<tconevo:material>,<draconicevolution:chaotic_core>,<draconicevolution:draconic_energy_core>,<minecraft:dragon_egg>*2],<tconevo:metal:10>,jsq);jsq += 1;
STdispose([<draconicevolution:draconium_block> * 4,<draconicevolution:dragon_heart>,<draconicevolution:draconic_core>*6,<liquid:liquid_energy>*2],<draconicevolution:draconic_block>*4,jsq);jsq += 1;