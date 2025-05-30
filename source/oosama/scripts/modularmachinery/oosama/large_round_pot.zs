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
MachineModifier.setInternalParallelism("large_round_pot", 1024);
//设置最大线程
MachineModifier.setMaxThreads("large_round_pot", 7);
//大锅子控制器
RecipeBuilder.newBuilder("large_round_pot_1", "machine_arm",1200)
    .addEnergyPerTickInput(4096000)
    .addInputs([
        <mets:niobium_titanium_plate> * 64,
        <mets:superconducting_cable> * 32,
        <gravisuite:crafting:1> * 48,
        <mekanism:machineblock3:14> * 4,
        <advancedrocketry:intake> * 48,
        <mekanism:polyethene:2> * 16,
        <contenttweaker:carbon_nanotube> * 48,
        <nuclearcraft:alloy:13> * 16
        ])
    .addOutputs(<modularmachinery:large_round_pot_controller> * 1) 
    .build();

RecipeBuilder.newBuilder("large_round_pot_2", "machine_arm",2400)
    .addEnergyPerTickInput(8124000)
    .addInputs([
        <modularmachinery:large_round_pot_controller> ,
        <additions:novaextended-fallen_star_alloy>*16,
        <tconevo:metal:8> * 8,
        <contenttweaker:industrial_circuit_v3> * 4,
        <moreplates:neutronium_plate> * 32
        ])
    .addOutputs(<modularmachinery:large_round_pot_factory_controller> * 1) 
    .build();

//宇宙探测器配方
//MKI
recipes.addShaped( 
    <contenttweaker:space_probe_mk1>, // 输出物品
    [[<minecraft:dispenser>*64, <immersiveengineering:conveyor>*64, <minecraft:piston>*64],
    [<contenttweaker:robot_arm_v1>*64, <contenttweaker:electric_motor_v1>*64, <contenttweaker:industrial_circuit_v1>*64],
    [<contenttweaker:sensor_v1>*64, <appliedenergistics2:material:41>*64, <minecraft:string>*64]]
);

RecipeBuilder.newBuilder("yuzhouwurenjimk2", "machine_arm",10)
    .addEnergyPerTickInput(8124000)
    .addInputs([
        <contenttweaker:space_probe_mk1> ,
        <contenttweaker:robot_arm_v2>*16, 
        <contenttweaker:electric_motor_v2>*16, 
        <contenttweaker:industrial_circuit_v2>*16,
        <contenttweaker:sensor_v2>*16
        ])
    .addOutputs(<contenttweaker:space_probe_mk2> * 1) 
    .build();
RecipeBuilder.newBuilder("yuzhouwurenjimk3", "machine_arm",10)
    .addEnergyPerTickInput(8124000)
    .addInputs([
        <contenttweaker:space_probe_mk2> ,
        <contenttweaker:robot_arm_v3>*16, 
        <contenttweaker:electric_motor_v3>*16, 
        <contenttweaker:industrial_circuit_v3>*16,
        <contenttweaker:sensor_v3>*16
        ])
    .addOutputs(<contenttweaker:space_probe_mk3> * 1) 
    .build();
//星能液产出MK1
RecipeBuilder.newBuilder("lrt_xnyMKK1", "large_round_pot", 300)
    .addItemInput(<contenttweaker:programming_circuit_a>*1).setChance(0)
    .addItemInput(<contenttweaker:space_probe_mk1>).setChance(0).setParallelizeUnaffected(true)
    .addOutputs(<liquid:astralsorcery.liquidstarlight> *50)
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
        
    .addCatalystInput(<avaritia:resource:5> * 1,
        ["一即全,全即一。","工作时间 §ax0.2§f, 工作产出 §ax10§f"],
        [
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.2, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 10, 1, false).build()
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
     event.activeRecipe.maxParallelism = 32;
    })
    .addRecipeTooltip("宇宙探测器数量影响并行数量","并行数量最大为32") // 提示信息：描述配方功能
    .setMaxThreads(1)
    .build();
//星能液产出MK2
RecipeBuilder.newBuilder("lrt_xnyMK2", "large_round_pot", 300)
    .addItemInput(<contenttweaker:programming_circuit_a>*1).setChance(0)
    .addItemInput(<contenttweaker:space_probe_mk2>).setChance(0).setParallelizeUnaffected(true)
    .addOutputs(<liquid:astralsorcery.liquidstarlight> *50)
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
        
    .addCatalystInput(<avaritia:resource:5> * 1,
        ["一即全,全即一。","工作时间 §ax0.2§f, 工作产出 §ax10§f"],
        [
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.2, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 10, 1, false).build()
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
     event.activeRecipe.maxParallelism = 64;
    })
    .addRecipeTooltip("宇宙探测器数量影响并行数量","并行数量最大为64") // 提示信息：描述配方功能
    .setMaxThreads(1)
    .build();
//星能液产出MK3
RecipeBuilder.newBuilder("lrt_xnyMK3", "large_round_pot", 300)
    .addItemInput(<contenttweaker:programming_circuit_a>*1).setChance(0)
    .addItemInput(<contenttweaker:space_probe_mk3>).setChance(0).setParallelizeUnaffected(true)
    .addOutputs(<liquid:astralsorcery.liquidstarlight> *50)
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
        
    .addCatalystInput(<avaritia:resource:5> * 1,
        ["一即全,全即一。","工作时间 §ax0.2§f, 工作产出 §ax10§f"],
        [
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.2, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 10, 1, false).build()
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
     event.activeRecipe.maxParallelism = 256;
    })
    .addRecipeTooltip("宇宙探测器数量影响并行数量","并行数量最大为256") // 提示信息：描述配方功能
    .setMaxThreads(1)
    .build();

//uu物质MK1
RecipeBuilder.newBuilder("lrt_uuwzMK1", "large_round_pot", 1000)
    .addItemInput(<contenttweaker:programming_circuit_b>*1).setChance(0)
    .addItemInput(<contenttweaker:space_probe_mk1>).setChance(0).setParallelizeUnaffected(true)
    .addOutputs(<liquid:ic2uu_matter> * 1000)
    .addCatalystInput(<avaritia:resource:5> * 1,
    ["一即全,全即一。","工作时间 §ax0.2§f, 工作产出 §ax5§f"],
    [
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.2, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 5, 1, false).build()
    ]).setChance(0)

    .addPreCheckHandler(function(event as RecipeCheckEvent) {
     event.activeRecipe.maxParallelism = 32; //最大并行设置为32
    })
    .addRecipeTooltip("宇宙探测器数量影响并行数量","并行数量最大为32") // 提示信息：描述配方功能
    .setMaxThreads(1)
    .build();
//uu物质MK2
RecipeBuilder.newBuilder("lrt_uuwzMK2", "large_round_pot", 1000)
    .addItemInput(<contenttweaker:programming_circuit_b>*1).setChance(0)
    .addItemInput(<contenttweaker:space_probe_mk2>).setChance(0).setParallelizeUnaffected(true)
    .addOutputs(<liquid:ic2uu_matter> * 1000)
    .addCatalystInput(<avaritia:resource:5> * 1,
    ["一即全,全即一。","工作时间 §ax0.2§f, 工作产出 §ax5§f"],
    [
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.2, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 5, 1, false).build()
    ]).setChance(0)

    .addPreCheckHandler(function(event as RecipeCheckEvent) {
     event.activeRecipe.maxParallelism = 64; //最大并行设置为64
    })
    .addRecipeTooltip("宇宙探测器数量影响并行数量","并行数量最大为64") // 提示信息：描述配方功能
    .setMaxThreads(1)
    .build();
//uu物质MK3
RecipeBuilder.newBuilder("lrt_uuwzMK3", "large_round_pot", 1000)
    .addItemInput(<contenttweaker:programming_circuit_b>*1).setChance(0)
    .addItemInput(<contenttweaker:space_probe_mk3>).setChance(0).setParallelizeUnaffected(true)
    .addOutputs(<liquid:ic2uu_matter> * 1000)
    .addCatalystInput(<avaritia:resource:5> * 1,
    ["一即全,全即一。","工作时间 §ax0.2§f, 工作产出 §ax5§f"],
    [
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.2, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 5, 1, false).build()
    ]).setChance(0)

    .addPreCheckHandler(function(event as RecipeCheckEvent) {
     event.activeRecipe.maxParallelism = 256; //最大并行设置为256
    })
    .addRecipeTooltip("宇宙探测器数量影响并行数量","并行数量最大为256") // 提示信息：描述配方功能
    .setMaxThreads(1)
    .build();


//液态魔力MK1
RecipeBuilder.newBuilder("lrt_ytmlMK1", "large_round_pot", 1000)
    .addItemInput(<contenttweaker:programming_circuit_c>*1).setChance(0)
    .addItemInput(<contenttweaker:space_probe_mk1>).setChance(0).setParallelizeUnaffected(true)
    .addOutputs(<liquid:fluidedmana>*1000)
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
     event.activeRecipe.maxParallelism = 32; //最大并行设置为32
    })
    .addRecipeTooltip("宇宙探测器数量影响并行数量","并行数量最大为32") // 提示信息：描述配方功能
    .addCatalystInput(<avaritiaio:infinitecapacitor> * 1,  
        ["奇迹终点,世界终焉,。","工作时间 §ax0.2§f, 工作产出 §ax5§f"],
        [
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.2, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 5, 1, false).build()
        ]).setChance(0)

    .addCatalystInput(<avaritia:resource:5> * 1,
        ["一即全,全即一。","工作时间 §ax0.2§f, 工作产出 §ax5§f"],
        [
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.2, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 5, 1, false).build()
        ]).setChance(0)

        .addCatalystInput(<botania:specialflower>.withTag({type: "asgardandelion"}),
        ["如同一株泪之花。","工作时间 §ax0.2§f, 工作产出 §ax10§f"],
        [
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.2, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 10, 1, false).build()
        ]).setChance(0)
    .setMaxThreads(1)
    .build();
    
//液态魔力MK2
RecipeBuilder.newBuilder("lrt_ytmlMK2", "large_round_pot", 1000)
    .addItemInput(<contenttweaker:programming_circuit_c>*1).setChance(0)
    .addItemInput(<contenttweaker:space_probe_mk2>).setChance(0).setParallelizeUnaffected(true)
    .addOutputs(<liquid:fluidedmana>*1000)
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
     event.activeRecipe.maxParallelism = 64; //最大并行设置为64
    })
    .addRecipeTooltip("宇宙探测器数量影响并行数量","并行数量最大为64") // 提示信息：描述配方功能
    .addCatalystInput(<avaritiaio:infinitecapacitor> * 1,  
        ["奇迹终点,世界终焉,。","工作时间 §ax0.2§f, 工作产出 §ax5§f"],
        [
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.2, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 5, 1, false).build()
        ]).setChance(0)

    .addCatalystInput(<avaritia:resource:5> * 1,
        ["一即全,全即一。","工作时间 §ax0.2§f, 工作产出 §ax5§f"],
        [
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.2, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 5, 1, false).build()
        ]).setChance(0)

        .addCatalystInput(<botania:specialflower>.withTag({type: "asgardandelion"}),
        ["如同一株泪之花。","工作时间 §ax0.2§f, 工作产出 §ax10§f"],
        [
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.2, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 10, 1, false).build()
        ]).setChance(0)
    .setMaxThreads(1)
    .build();
    
//液态魔力MK3
RecipeBuilder.newBuilder("lrt_ytmlMK3", "large_round_pot", 1000)
    .addItemInput(<contenttweaker:programming_circuit_c>*1).setChance(0)
    .addItemInput(<contenttweaker:space_probe_mk3>).setChance(0).setParallelizeUnaffected(true)
    .addOutputs(<liquid:fluidedmana>*1000)
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
     event.activeRecipe.maxParallelism = 256; //最大并行设置为256
    })
    .addRecipeTooltip("宇宙探测器数量影响并行数量","并行数量最大为256") // 提示信息：描述配方功能
    .addCatalystInput(<avaritiaio:infinitecapacitor> * 1,  
        ["奇迹终点,世界终焉,。","工作时间 §ax0.2§f, 工作产出 §ax5§f"],
        [
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.2, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 5, 1, false).build()
        ]).setChance(0)

    .addCatalystInput(<avaritia:resource:5> * 1,
        ["一即全,全即一。","工作时间 §ax0.2§f, 工作产出 §ax5§f"],
        [
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.2, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 5, 1, false).build()
        ]).setChance(0)

        .addCatalystInput(<botania:specialflower>.withTag({type: "asgardandelion"}),
        ["如同一株泪之花。","工作时间 §ax0.2§f, 工作产出 §ax10§f"],
        [
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.2, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 10, 1, false).build()
        ]).setChance(0)
    .setMaxThreads(1)
    .build();

//紫晶素MK1
RecipeBuilder.newBuilder("xlrt_zjsMK1", "large_round_pot", 1)
    .addItemInput(<contenttweaker:programming_circuit_d>*1).setChance(0)
    .addInput(<contenttweaker:life_regeneration_core>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<contenttweaker:space_probe_mk3>).setChance(0)
    .addOutputs(<liquid:crystalloid> * 10)
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
     event.activeRecipe.maxParallelism = 32; //最大并行设置为32 
    })
    .addEnergyPerTickInput(500000000)
    .addRecipeTooltip("仅生命再生核心数量影响并行","并行数量最大为32") // 提示信息：描述配方功能
    .setMaxThreads(1)
    .build();

//氦三mk1
RecipeBuilder.newBuilder("xlrt_haisanmk1", "large_round_pot", 1200)
    .setDimension([-2])
    .addItemInput(<contenttweaker:programming_circuit_0>*1).setChance(0)
    .addItemInput(<contenttweaker:space_probe_mk1>).setChance(0).setParallelizeUnaffected(true)
    .addOutputs(<liquid:helium_3> * 1000)
    .addCatalystInput(<avaritia:resource:5> * 1,
        ["一即全,全即一。","工作时间 §ax0.2§f, 工作产出 §ax10§f"],
        [
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.2, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 10, 1, false).build()
        ]
    ).setChance(0)
    .addCatalystInput(<contenttweaker:dyson_cloud_pos_data_card> * 8,
        ["是一组坐标,侦测到在途的二维化打击","工作时间 §ax0.4§f, 工作产出 §ax3§f"],
        [
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.4, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 3, 1, false).build()
        ]
    ).setChance(0)
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
     event.activeRecipe.maxParallelism = 32; //最大并行设置为32
    })
    .addRecipeTooltip("§e太阳的力量！这个配方不需要任何的资源！") // 提示信息：描述配方功能
    .addRecipeTooltip("宇宙探测器数量影响并行数量","并行数量最大为32") // 提示信息：描述配方功能
    .addRecipeTooltip("§6需要在空间站维度工作")
    .setMaxThreads(1)
    .build();

//氦三mk2
RecipeBuilder.newBuilder("xlrt_haisanmk2", "large_round_pot", 1200)
    .setDimension([-2])
    .addItemInput(<contenttweaker:programming_circuit_e>*1).setChance(0)
    .addItemInput(<contenttweaker:space_probe_mk2>).setChance(0).setParallelizeUnaffected(true)
    .addOutputs(<liquid:helium_3> * 1000)
    .addCatalystInput(<avaritia:resource:5> * 1,
        ["一即全,全即一。","工作时间 §ax0.2§f, 工作产出 §ax10§f"],
        [
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.2, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 10, 1, false).build()
        ]
    ).setChance(0)
    .addCatalystInput(<contenttweaker:dyson_cloud_pos_data_card> * 8,
        ["是一组坐标,侦测到在途的二维化打击","工作时间 §ax0.4§f, 工作产出 §ax3§f"],
        [
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.4, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 3, 1, false).build()
        ]
    ).setChance(0)
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
     event.activeRecipe.maxParallelism = 64; //最大并行设置为64
    })
    .addRecipeTooltip("§e太阳的力量！这个配方不需要任何的资源！") // 提示信息：描述配方功能
    .addRecipeTooltip("宇宙探测器数量影响并行数量","并行数量最大为64") // 提示信息：描述配方功能
    .addRecipeTooltip("§6需要在空间站维度工作")
    .setMaxThreads(1)
    .build();
    
//氦三mk3
RecipeBuilder.newBuilder("xlrt_haisanmk3", "large_round_pot", 1200)
    .setDimension([-2])
    .addItemInput(<contenttweaker:programming_circuit_e>*1).setChance(0)
    .addItemInput(<contenttweaker:space_probe_mk3>).setChance(0).setParallelizeUnaffected(true)
    .addOutputs(<liquid:helium_3> * 1000)
    .addCatalystInput(<avaritia:resource:5> * 1,
        ["一即全,全即一。","工作时间 §ax0.2§f, 工作产出 §ax10§f"],
        [
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.2, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 10, 1, false).build()
        ]
    ).setChance(0)
    .addCatalystInput(<contenttweaker:dyson_cloud_pos_data_card> * 8,
        ["是一组坐标,侦测到在途的二维化打击","工作时间 §ax0.4§f, 工作产出 §ax3§f"],
        [
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.4, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 3, 1, false).build()
        ]
    ).setChance(0)
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
     event.activeRecipe.maxParallelism = 128; //最大并行设置为128
    })
    .addRecipeTooltip("§e太阳的力量！这个配方不需要任何的资源！") // 提示信息：描述配方功能
    .addRecipeTooltip("宇宙探测器数量影响并行数量","并行数量最大为128") // 提示信息：描述配方功能
    .addRecipeTooltip("§6需要在空间站维度工作")
    .setMaxThreads(1)
    .build();


