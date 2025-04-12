//ALL RIGHTS RESERVED
//也许你可以对私货进行更改。

#priority 10
#loader crafttweaker reloadable

import mods.modularmachinery.MMEvents;
import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.MachineBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.FactoryRecipeStartEvent;
import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.MachineTickEvent;
import mods.modularmachinery.SmartInterfaceType;
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

import novaeng.NovaEngUtils;
import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.ComputationCenter;
import novaeng.hypernet.ComputationCenterType;
import novaeng.hypernet.ComputationCenterCache;

import novaeng.hypernet.upgrade.type.ProcessorModuleCPUType;
import novaeng.hypernet.upgrade.type.ProcessorModuleGPUType;
import novaeng.hypernet.upgrade.type.ProcessorModuleRAMType;

var recipeCount = 0;

// val modifier = MultiblockModifierBuilder.newBuilder("modifier_name")
//     .setBlockArray(BlockArrayBuilder.newBuilder()
//         .addBlock(0, 0, 0, <avaritia:block_resource:1>)
//         .getBlockArray())
//     .setDescriptiveStack(<avaritia:block_resource:1>)
//     .build();
// MachineBuilder.getBuilder("machine_name")
//     .addMultiBlockModifier(modifier);

MachineModifier.setInternalParallelism("ACAA", 2048);
MachineModifier.setInternalParallelism("APAC", 8192);
MachineModifier.setInternalParallelism("G_MT", 32767);
MachineModifier.setInternalParallelism("G_IC", 32767);
MachineModifier.setInternalParallelism("G_CO", 32767);
MachineModifier.setInternalParallelism("G_HTMP", 32767);
MachineModifier.setInternalParallelism("G_MA", 1024);
MachineModifier.setInternalParallelism("G_AF", 65534);

//==================================风电==============================
//风电_控制器
RecipeBuilder.newBuilder("gshag_controller", "workshop", 3600)
    .addEnergyPerTickInput(300000)
    .addInput(<contenttweaker:industrial_circuit_v3> * 6)
    .addInput(<contenttweaker:field_generator_v3> * 3)
    .addInput(<contenttweaker:charging_crystal_block> * 16)
    .addInput(<super_solar_panels:rotor_carbon3> *8)
    .addInput(<modularmachinery:blockcasing>)
    .addOutput(<modularmachinery:gshag_controller>)
    .requireComputationPoint(4000.0F)
    .requireResearch("gshag")
    .build();

//风电_集成控制器
RecipeBuilder.newBuilder("gshag_factory_controller", "workshop", 7200)
    .addEnergyPerTickInput(300000)
    .addInput(<contenttweaker:industrial_circuit_v4> * 6)
    .addInput(<contenttweaker:field_generator_v4> * 4)
    .addInput(<contenttweaker:antimatter_core>)
    .addInput(<modularmachinery:gshag_controller> * 8)
    .addInput(<contenttweaker:charging_crystal_block> * 256)
    .addInput(<modularmachinery:blockcasing>)
    .addInput(<moreplates:infinity_gear> * 8)
    .addInput(<contenttweaker:coil_v5> * 64)
    .addInput(<additions:novaextended-phocore_2>)
    .addOutput(<modularmachinery:gshag_factory_controller>)
    .requireComputationPoint(10000.0F)
    .requireResearch("gshag_factory")
    .build();

//发电
RecipeBuilder.newBuilder("GSHAG_high", "gshag", 13000, 0, true)
    .setAltitude(140, 256)
    .addEnergyPerTickOutput(800000000)
    .build();

RecipeBuilder.newBuilder("GSHAG_low", "gshag", 13000, 0, true)
    .setAltitude(0, 139)
    .addEnergyPerTickOutput(500000000)
    .build();

//==================================装配阵列==============================

HyperNetHelper.proxyMachineForHyperNet("acaa");

// 高级元件装配阵列：配方继承
# 高级元件装配 -> 高级元件装配阵列
RecipeAdapterBuilder.create("ACAA", "modularmachinery:acar")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.2F, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 8.0F, 1, false).build())
    .build();

// 精密装配机阵列
RecipeBuilder.newBuilder("apac_factory_controller", "workshop", 7200)
    .addEnergyPerTickInput(30000000)
    .addInput(<contenttweaker:industrial_circuit_v4> * 64)
    .addInput(<contenttweaker:field_generator_v4> * 32)
    .addInput(<modularmachinery:precision_assembler_factory_controller> * 64)
    .addInput(<moreplates:infinity_gear> * 4)
    .addInput(<contenttweaker:coil_v5> * 128)
    .addOutput(<modularmachinery:apac_factory_controller>)
    .addInput(<contenttweaker:programming_circuit_0> * 1)
    .addInput(<contenttweaker:programming_circuit_d> * 1)
    .requireComputationPoint(100000.0F)
    .requireResearch("APAC")
    .build();

// 高级原件阵列
RecipeBuilder.newBuilder("acaa_factory_controller", "workshop", 7200)
    .addEnergyPerTickInput(300000000)
    .addInput(<contenttweaker:industrial_circuit_v4> * 24)
    .addInput(<contenttweaker:field_generator_v4> * 12)
    .addInput(<modularmachinery:acar_factory_controller> * 64)
    .addInput(<moreplates:infinity_gear> * 8)
    .addInput(<contenttweaker:coil_v5> * 256)
    .addInput(<contenttweaker:programming_circuit_0> * 1)
    .addInput(<contenttweaker:antimatter_core>)
    .addInput(<contenttweaker:programming_circuit_c> * 1)
    .addOutput(<modularmachinery:acaa_factory_controller>)
    .requireComputationPoint(400000.0F)
    .requireResearch("ACAA")
    .build();



HyperNetHelper.proxyMachineForHyperNet("G_MT");

// 巨型压缩机：配方继承
# 数控段床(？) -> 巨型压缩机
RecipeAdapterBuilder.create("g_mt", "nuclearcraft:pressurizer")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.1F, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 50000,    1, false).build())
    .build();

// 巨型压缩机
RecipeBuilder.newBuilder("g_mt_factory_controller", "workshop", 7200)
    .addEnergyPerTickInput(30000000)
    .addInput(<contenttweaker:industrial_circuit_v4> * 24)
    .addInput(<contenttweaker:field_generator_v4> * 12)
    .addInput(<modularmachinery:numerical_control_machine_controller> * 64)
    .addInput(<contenttweaker:programming_circuit_0> * 1)
    .addInput(<contenttweaker:programming_circuit_b> * 1)
    .addInput(<moreplates:infinity_gear> * 3)
    .addInput(<contenttweaker:coil_v5> * 128)
    .addInput(<contenttweaker:antimatter_core> * 4)
    .addOutput(<modularmachinery:g_mt_factory_controller>)
    .requireComputationPoint(400000.0F)
    .requireResearch("G_MT")
    .build();

var recipeCounter = 1000;

// 合金线圈（等级 3）
RecipeBuilder.newBuilder("coil_v3_coolant", "g_mt", 1)
    .addEnergyPerTickInput(64000)
    .addInput(<ore:plateDraconicMetal> * 1)
    .addOutput(<contenttweaker:coil_v3> * 3)
    .build();


// 合金线圈（等级 4）
RecipeBuilder.newBuilder("coil_v4_coolant", "g_mt", 1)
    .addEnergyPerTickInput(512000)
    .addInputs(<ore:ingotFallenStarAlloy> * 1)
    .addOutputs(<contenttweaker:coil_v4> * 3)
    .build();


// 合金线圈（等级 5）
RecipeBuilder.newBuilder("coil_v5_coolant", "g_mt", 1)
    .addEnergyPerTickInput(8192000)
    .addInputs(<ore:ingotArk> * 1)
    .addOutputs(<contenttweaker:coil_v5> * 3)
    .build();




RecipeAdapterBuilder.create("g_ic", "novaeng_core:shredder")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.025,  1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 1000, 1, false).build())
    .build();

# 粉碎 - 圆石
RecipeBuilder.newBuilder("g_ic_cobblestone", "g_ic", 2,0)
    .addEnergyPerTickInput(12800)
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0).setParallelizeUnaffected(true)
    .addItemInputs([
        <minecraft:cobblestone> * 6,
        <minecraft:cobblestone> * 6,
        <minecraft:cobblestone> * 6,
    ])
    .addOutput(<ic2:crafting:23> * 6)
    .addOutput(<ic2:crafting:23> * 1).setChance(0.75)
    .addOutput(<ic2:crafting:23> * 1).setChance(0.5)
    .addOutput(<ic2:crafting:23> * 1).setChance(0.25)
    .build();

# 粉碎 - 沙子 + 海蓝宝石
RecipeBuilder.newBuilder("g_ic_aquamarine_sandhuh", "g_ic", 2,0)
    .addEnergyPerTickInput(25600)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<liquid:astralsorcery.liquidstarlight> * 16000).setChance(0)
    .addInput(<liquid:lava> * 16000).setChance(0)
    .addOutput(<minecraft:sand> * 64)
    .addOutput(<astralsorcery:itemcraftingcomponent> * 2).setChance(0.75)
    .addOutput(<astralsorcery:itemcraftingcomponent> * 2).setChance(0.5)
    .addOutput(<astralsorcery:itemcraftingcomponent> * 1).setChance(0.25)
    .addRecipeTooltip([
        "星能液数量和熔岩数量§c受并行影响§f，但是§a不消耗§f。",
    ])
    .build();

# 粉碎 - 海蓝宝石
RecipeBuilder.newBuilder("g_ic_aquamarine_nosand", "g_ic", 2,0)
    .addEnergyPerTickInput(51200)
    .addInput(<contenttweaker:programming_circuit_c>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<liquid:astralsorcery.liquidstarlight> * 16000).setChance(0)
    .addInput(<liquid:lava> * 16000).setChance(0)
    .addOutput(<astralsorcery:itemcraftingcomponent> * 2).setChance(0.75)
    .addOutput(<astralsorcery:itemcraftingcomponent> * 2).setChance(0.5)
    .addOutput(<astralsorcery:itemcraftingcomponent> * 1).setChance(0.25)
    .addRecipeTooltip([
        "星能液数量和熔岩数量§c受并行影响§f，但是§a不消耗§f。",
    ])
    .build();

// 巨型粉碎机
RecipeBuilder.newBuilder("g_ic_factory_controller", "workshop", 7200)
    .addEnergyPerTickInput(30000000)
    .addInput(<contenttweaker:industrial_circuit_v4> * 18)
    .addInput(<contenttweaker:field_generator_v4> * 12)
    .addInput(<modularmachinery:item_shredder_controller> * 64)
    .addInput(<moreplates:infinity_gear> * 3)
    .addInput(<contenttweaker:programming_circuit_0> * 1)
    .addInput(<contenttweaker:programming_circuit_a> * 1)
    .addInput(<contenttweaker:coil_v5> * 128)
    .addInput(<contenttweaker:antimatter_core> * 2)
    .addOutput(<modularmachinery:g_ic_factory_controller>)
    .requireComputationPoint(400000.0F)
    .requireResearch("G_MT")
    .build();

// 基岩粉
RecipeBuilder.newBuilder("enderio:block_infinity", "g_ic", 1)
    .addEnergyPerTickInput(30000)
    .addInput(<enderio:block_infinity>).setChance(0)
    .addInput(<avaritiaio:grindingballneutronium> * 32).setChance(0.001)
    .addOutput(<enderio:block_infinity>).setChance(0.9)
    .addOutput(<enderio:block_infinity>).setChance(0.75)
    .addOutput(<enderio:block_infinity>).setChance(0.5)
    .addOutput(<enderio:block_infinity>).setChance(0.25)
    .build();

HyperNetHelper.proxyMachineForHyperNet("G_CO");

// 巨型共价超载器
RecipeBuilder.newBuilder("g_co_factory_controller", "workshop", 7200)
    .addEnergyPerTickInput(30000000)
    .addInput(<contenttweaker:industrial_circuit_v4> * 24)
    .addInput(<contenttweaker:field_generator_v4> * 12)
    .addInput(<modularmachinery:covalent_overloader_controller> * 64)
    .addInput(<moreplates:infinity_gear> * 2)
    .addInput(<contenttweaker:programming_circuit_f> * 1)
    .addInput(<contenttweaker:coil_v5> * 128)
    .addInput(<contenttweaker:antimatter_core> * 4)
    .addOutput(<modularmachinery:g_co_factory_controller>)
    .requireComputationPoint(400000.0F)
    .requireResearch("G_MT")
    .build();

// 注入机：配方继承
RecipeAdapterBuilder.create("g_co", "nuclearcraft:infuser")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.1F, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 25000,    1, false).build())
    .build();

HyperNetHelper.proxyMachineForHyperNet("G_MSM");
MachineModifier.setMaxThreads("G_MSM", 128);

// 巨型屠宰场
RecipeBuilder.newBuilder("g_msm_factory_controller", "workshop", 7200)
    .addEnergyPerTickInput(30000000)
    .addInput(<contenttweaker:industrial_circuit_v4> * 256)
    .addInput(<contenttweaker:field_generator_v4> * 256)
    .addInput(<moreplates:infinity_gear> * 8)
    .addInput(<contenttweaker:coil_v5> * 192)
    .addInput(<contenttweaker:antimatter_core> * 8)
    .addOutput(<modularmachinery:g_msm_factory_controller>)
    .requireComputationPoint(400000.0F)
    .build();

RecipeBuilder.newBuilder("draconicevolution:chaos_shard", "g_msm", 100)
    .addEnergyPerTickInput(80000000)
    .addInput(<contenttweaker:antimatter_core> * 4).setChance(0)
    .addInput(<contenttweaker:arkforcefieldcontrolblock> * 4).setChance(0)
    .addInput(<contenttweaker:data_model_emerald> * 1).setChance(0)
    .addInput(<contenttweaker:data_model_iridium> * 1).setChance(0)
    .addInput(<avaritiatweaks:enhancement_crystal> * 64).setChance(0)
    .addOutput(<draconicevolution:chaos_shard> * 4)
    .addOutput(<deepmoblearning:living_matter_overworldian> * 16)
    .addOutput(<deepmoblearning:living_matter_hellish> * 16)
    .addOutput(<deepmoblearning:living_matter_extraterrestrial> * 16)
    .addOutput(<deepmoblearning:living_matter_legend> * 16)
    .addOutput(<contenttweaker:hxs> * 8)
    .addOutput(<deepmoblearning:pristine_matter_thermal_elemental> * 8)
    .addOutput(<minecraft:slime_ball> * 32)
    .addOutput(<minecraft:ghast_tear> * 8)
    .addOutput(<minecraft:coal> * 64)
    .addOutput(<minecraft:dragon_breath> * 32)
    .addOutput(<minecraft:dragon_egg> * 1)
    .addOutput(<draconicevolution:draconium_dust> * 64)
    .addOutput(<draconicevolution:dragon_heart> * 1)
    .addOutput(<minecraft:bone> * 64)
    .addOutput(<minecraft:nether_star> * 5)
    .addOutput(<deepmoblearning:pristine_matter_tinker_slime> * 8)
    .addOutput(<deepmoblearning:glitch_heart> * 2)
    .addOutput(<minecraft:redstone> * 32)
    .addOutput(<minecraft:glowstone_dust> * 32)
    .addOutput(<minecraft:sugar> * 64)
    .addOutput(<minecraft:rotten_flesh> * 64)
    .addOutput(<minecraft:iron_ingot> * 16)
    .addOutput(<minecraft:carrot> * 32)
    .addOutput(<minecraft:potato> * 32)
    .addOutput(<minecraft:spider_eye> * 16)
    .addOutput(<minecraft:string> * 64)
    .addOutput(<minecraft:ender_pearl> * 64)
    .addOutput(<enderio:block_enderman_skull> * 2)
    .addOutput(<minecraft:end_crystal> * 1)
    .addOutput(<minecraft:blaze_rod> * 32)
    .addOutput(<deepmoblearning:pristine_matter_blaze> * 8)
    .addOutput(<minecraft:shulker_shell> * 16)
    .addOutput(<minecraft:diamond> * 2)
    .addOutput(<minecraft:prismarine_shard> * 32)
    .addOutput(<minecraft:prismarine_crystals> * 32)
    .addOutput(<minecraft:fish> * 64)
    .addOutput(<minecraft:gunpowder> * 64)
    .requireComputationPoint(32.0F)
    .build();

HyperNetHelper.proxyMachineForHyperNet("g_htmp");

RecipeAdapterBuilder.create("g_htmp", "nuclearcraft:melter")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.1F, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 25000,    1, false).build())
    .build();

    RecipeBuilder.newBuilder("se_workshop1", "workshop", 20000)
        .addEnergyPerTickInput(80000000000)
        .addInput(<contenttweaker:industrial_circuit_v4> * 256)
        .addInput(<contenttweaker:field_generator_v4> * 512)
        .addInput(<modularmachinery:dream_energy_core_factory_controller> * 1)
        .addInput(<modularmachinery:space_generator_factory_controller> * 4)
        .addInput(<moreplates:infinity_gear> * 32)
        .addInput(<contenttweaker:coil_v5> * 512)
        .addInput(<contenttweaker:antimatter_core> * 32)
        .addInput(<modularmachinery:acaa_factory_controller> * 4)
        .addInput(<modularmachinery:apac_factory_controller> * 4)
        .addInput(<contenttweaker:programming_circuit_e> * 1)
        .addOutput(<modularmachinery:space_elevator_factory_controller>)
        .requireResearch("SE_tech5")
        .requireComputationPoint(400000.0F)
        .build();

    RecipeBuilder.newBuilder("se_workshop2", "workshop", 20000)
        .addEnergyPerTickInput(80000000000)
        .addInput(<contenttweaker:industrial_circuit_v4> * 256)
        .addInput(<contenttweaker:field_generator_v4> * 512)
        .addInput(<moreplates:infinity_gear> * 32)
        .addInput(<contenttweaker:coil_v5> * 512)
        .addInput(<modularmachinery:space_elevator_factory_controller>)
        .addInput(<contenttweaker:antimatter_core> * 32)
        .addOutput(<modularmachinery:space_elevatormk2_factory_controller>)
        .requireResearch("SE_tech6")
        .requireComputationPoint(400000.0F)
        .build();

    RecipeBuilder.newBuilder("se_workshop3", "workshop", 20000)
        .addEnergyPerTickInput(80000000000)
        .addInput(<contenttweaker:industrial_circuit_v4> * 256)
        .addInput(<modularmachinery:ark_space_station_factory_controller>)
        .addInput(<modularmachinery:space_elevatormk2_factory_controller>)
        .addInput(<contenttweaker:field_generator_v4> * 512)
        .addInput(<novaeng_core:geocentric_drill_controller> * 6)
        .addInput(<moreplates:infinity_gear> * 32)
        .addInput(<contenttweaker:coil_v5> * 512)
        .addInput(<contenttweaker:antimatter_core> * 32)
        .addOutput(<modularmachinery:space_elevatormk3_factory_controller>)
        .requireResearch("SE_tech7")
        .requireComputationPoint(400000.0F)
        .build();

    RecipeBuilder.newBuilder("se_workshop4", "workshop", 20000)
        .addEnergyPerTickInput(80000000000)
        .addInput(<contenttweaker:industrial_circuit_v4> * 256)
        .addInput(<contenttweaker:field_generator_v4> * 512)
        .addInput(<modularmachinery:ark_space_station_factory_controller>)
        .addInput(<modularmachinery:space_elevatormk2_factory_controller> * 2)
        .addInput(<moreplates:infinity_gear> * 32)
        .addInput(<contenttweaker:coil_v5> * 512)
        .addInput(<contenttweaker:antimatter_core> * 32)
        .addInput(<modularmachinery:acaa_factory_controller> * 16)
        .addInput(<modularmachinery:apac_factory_controller> * 16)
        .addOutput(<modularmachinery:space_elevatormk4_factory_controller>)
        .requireResearch("SE_tech8")
        .requireComputationPoint(400000.0F)
        .build();

RecipeBuilder.newBuilder("se_ore", "space_elevator",200)
    .addEnergyPerTickInput(100000000000)
    .addOutput(<minecraft:gold_ingot> * 262144)
    .addOutput(<minecraft:iron_ingot> * 262144)
    .addOutput(<minecraft:dye:4> * 262144)
    .addOutput(<minecraft:diamond> * 262144)
    .addOutput(<minecraft:redstone> * 262144)
    .addOutput(<minecraft:emerald> * 262144)
    .addOutput(<minecraft:quartz> * 262144)
    .addOutput(<minecraft:coal> * 262144)
    .addOutput(<thermalfoundation:material:128> * 262144)
    .addOutput(<thermalfoundation:material:129> * 262144)
    .addOutput(<thermalfoundation:material:130> * 262144)
    .addOutput(<thermalfoundation:material:131> * 262144)
    .addOutput(<thermalfoundation:material:132> * 262144)
    .addOutput(<thermalfoundation:material:133> * 262144)
    .addOutput(<thermalfoundation:material:134> * 262144)
    .addOutput(<thermalfoundation:material:135> * 262144)
    .addOutput(<thermalfoundation:material:136> * 262144)
    .addOutput(<ic2:ingot:8> * 262144)
    .addOutput(<draconicevolution:draconium_ingot> * 262144)
    .addOutput(<biomesoplenty:gem:0> * 262144)
    .addOutput(<biomesoplenty:gem:1> * 262144)
    .addOutput(<biomesoplenty:gem:2> * 262144)
    .addOutput(<biomesoplenty:gem:3> * 262144)
    .addOutput(<biomesoplenty:gem:4> * 262144)
    .addOutput(<biomesoplenty:gem:5> * 262144)
    .addOutput(<biomesoplenty:gem:6> * 262144)
    .addOutput(<biomesoplenty:gem:7> * 262144)
    .addOutput(<ore:ingotThorium> * 262144)
    .addOutput(<ore:ingotBoron> * 262144)
    .addOutput(<ore:ingotMagnesium> * 262144)
    .addOutput(<ore:ingotManganese> * 262144)
    .addOutput(<additions:novaextended-ingot8> * 262144)
    .addOutput(<taiga:dilithium_ingot> * 262144)
    .addOutput(<libvulpes:productingot:7> * 262144)
    .addOutput(<tconstruct:ingots:0> * 262144)
    .addOutput(<tconstruct:ingots:1> * 262144)
    .addOutput(<appliedenergistics2:material:0> * 262144)
    .addOutput(<appliedenergistics2:material:1> * 262144)
    .addOutput(<mekanism:ingot:1> * 262144)
    .addOutput(<mekanism:fluoriteclump> * 262144)
    .addOutput(<futuremc:netherite_scrap> * 262144)
    .addOutput(<rftools:dimensional_shard> * 262144)
    .addOutput(<ore:gemQuartzBlack> * 262144)
    .addOutput(<astralsorcery:itemcraftingcomponent:1> * 262144)
    .addOutput(<astralsorcery:itemcraftingcomponent:0> * 262144)
    .addOutput(<thermalfoundation:material:132> * 262144)
    .addOutput(<taiga:aurorium_ingot> * 262144)
    .addOutput(<taiga:palladium_ingot> * 262144)
    .addOutput(<taiga:prometheum_ingot> * 262144)
    .addOutput(<taiga:valyrium_ingot> * 262144)
    .addOutput(<taiga:vibranium_ingot> * 262144)
    .addOutput(<taiga:osram_ingot> * 262144)
    .addOutput(<taiga:eezo_ingot> * 262144)
    .addOutput(<taiga:uru_ingot> * 262144)
    .addOutput(<taiga:duranite_ingot> * 262144)
    .addOutput(<taiga:karmesine_ingot> * 262144)
    .addOutput(<taiga:abyssum_ingot> * 262144)
    .addOutput(<taiga:tiberium_ingot> * 262144)
    .addOutput(<taiga:jauxum_ingot> * 262144)
    .addOutput(<taiga:ovium_ingot> * 262144)
    .addOutput(<ebwizardry:magic_crystal:1> * 262144)
    .addOutput(<ebwizardry:magic_crystal:2> * 262144)
    .addOutput(<ebwizardry:magic_crystal:3> * 262144)
    .addOutput(<ebwizardry:magic_crystal:4> * 262144)
    .addOutput(<ebwizardry:magic_crystal:5> * 262144)
    .addOutput(<ebwizardry:magic_crystal:6> * 262144)
    .addOutput(<ebwizardry:magic_crystal:7> * 262144)
    .addOutput(<taiga:obsidiorite_ingot> * 262144)
    .addOutput(<taiga:meteorite_ingot> * 262144)
    .addOutput(<appliedenergistics2:sky_stone_block> * 262144)
    .addOutput(<environmentaltech:litherite_crystal> * 262144)
    .addOutput(<environmentaltech:erodium_crystal> * 262144)
    .addOutput(<environmentaltech:lonsdaleite_crystal> * 262144)
    .addOutput(<environmentaltech:kyronite_crystal> * 262144)
    .addOutput(<environmentaltech:pladium_crystal> * 262144)
    .addOutput(<environmentaltech:ionite_crystal> * 262144)
    .addOutput(<environmentaltech:aethium_crystal> * 262144)
    .addRecipeTooltip([
                "§r由§2异星矿机单元§r运行",
            ])
    .build();

RecipeBuilder.newBuilder("se_ore2", "space_elevatormk2",200)
    .addEnergyPerTickInput(100000000000)
    .addOutput(<minecraft:gold_ingot> * 262144)
    .addOutput(<minecraft:iron_ingot> * 262144)
    .addOutput(<minecraft:dye:4> * 262144)
    .addOutput(<minecraft:diamond> * 262144)
    .addOutput(<minecraft:redstone> * 262144)
    .addOutput(<minecraft:emerald> * 262144)
    .addOutput(<minecraft:quartz> * 262144)
    .addOutput(<minecraft:coal> * 262144)
    .addOutput(<thermalfoundation:material:128> * 262144)
    .addOutput(<thermalfoundation:material:129> * 262144)
    .addOutput(<thermalfoundation:material:130> * 262144)
    .addOutput(<thermalfoundation:material:131> * 262144)
    .addOutput(<thermalfoundation:material:132> * 262144)
    .addOutput(<thermalfoundation:material:133> * 262144)
    .addOutput(<thermalfoundation:material:134> * 262144)
    .addOutput(<thermalfoundation:material:135> * 262144)
    .addOutput(<thermalfoundation:material:136> * 262144)
    .addOutput(<ic2:ingot:8> * 262144)
    .addOutput(<draconicevolution:draconium_ingot> * 262144)
    .addOutput(<biomesoplenty:gem:0> * 262144)
    .addOutput(<biomesoplenty:gem:1> * 262144)
    .addOutput(<biomesoplenty:gem:2> * 262144)
    .addOutput(<biomesoplenty:gem:3> * 262144)
    .addOutput(<biomesoplenty:gem:4> * 262144)
    .addOutput(<biomesoplenty:gem:5> * 262144)
    .addOutput(<biomesoplenty:gem:6> * 262144)
    .addOutput(<biomesoplenty:gem:7> * 262144)
    .addOutput(<ore:ingotThorium> * 262144)
    .addOutput(<ore:ingotBoron> * 262144)
    .addOutput(<ore:ingotMagnesium> * 262144)
    .addOutput(<ore:ingotManganese> * 262144)
    .addOutput(<additions:novaextended-ingot8> * 262144)
    .addOutput(<taiga:dilithium_ingot> * 262144)
    .addOutput(<libvulpes:productingot:7> * 262144)
    .addOutput(<tconstruct:ingots:0> * 262144)
    .addOutput(<tconstruct:ingots:1> * 262144)
    .addOutput(<appliedenergistics2:material:0> * 262144)
    .addOutput(<appliedenergistics2:material:1> * 262144)
    .addOutput(<mekanism:ingot:1> * 262144)
    .addOutput(<mekanism:fluoriteclump> * 262144)
    .addOutput(<futuremc:netherite_scrap> * 262144)
    .addOutput(<rftools:dimensional_shard> * 262144)
    .addOutput(<ore:gemQuartzBlack> * 262144)
    .addOutput(<astralsorcery:itemcraftingcomponent:1> * 262144)
    .addOutput(<astralsorcery:itemcraftingcomponent:0> * 262144)
    .addOutput(<thermalfoundation:material:132> * 262144)
    .addOutput(<taiga:aurorium_ingot> * 262144)
    .addOutput(<taiga:palladium_ingot> * 262144)
    .addOutput(<taiga:prometheum_ingot> * 262144)
    .addOutput(<taiga:valyrium_ingot> * 262144)
    .addOutput(<taiga:vibranium_ingot> * 262144)
    .addOutput(<taiga:osram_ingot> * 262144)
    .addOutput(<taiga:eezo_ingot> * 262144)
    .addOutput(<taiga:uru_ingot> * 262144)
    .addOutput(<taiga:duranite_ingot> * 262144)
    .addOutput(<taiga:karmesine_ingot> * 262144)
    .addOutput(<taiga:abyssum_ingot> * 262144)
    .addOutput(<taiga:tiberium_ingot> * 262144)
    .addOutput(<taiga:jauxum_ingot> * 262144)
    .addOutput(<taiga:ovium_ingot> * 262144)
    .addOutput(<ebwizardry:magic_crystal:1> * 262144)
    .addOutput(<ebwizardry:magic_crystal:2> * 262144)
    .addOutput(<ebwizardry:magic_crystal:3> * 262144)
    .addOutput(<ebwizardry:magic_crystal:4> * 262144)
    .addOutput(<ebwizardry:magic_crystal:5> * 262144)
    .addOutput(<ebwizardry:magic_crystal:6> * 262144)
    .addOutput(<ebwizardry:magic_crystal:7> * 262144)
    .addOutput(<taiga:obsidiorite_ingot> * 262144)
    .addOutput(<taiga:meteorite_ingot> * 262144)
    .addOutput(<appliedenergistics2:sky_stone_block> * 262144)
    .addOutput(<environmentaltech:litherite_crystal> * 262144)
    .addOutput(<environmentaltech:erodium_crystal> * 262144)
    .addOutput(<environmentaltech:lonsdaleite_crystal> * 262144)
    .addOutput(<environmentaltech:kyronite_crystal> * 262144)
    .addOutput(<environmentaltech:pladium_crystal> * 262144)
    .addOutput(<environmentaltech:ionite_crystal> * 262144)
    .addOutput(<environmentaltech:aethium_crystal> * 262144)
    .addRecipeTooltip([
                "§r由§2异星矿机单元§r运行",
            ])
    .build();

RecipeBuilder.newBuilder("se_ore3", "space_elevatormk3",200)
    .addEnergyPerTickInput(100000000000)
    .addOutput(<minecraft:gold_ingot> * 262144)
    .addOutput(<minecraft:iron_ingot> * 262144)
    .addOutput(<minecraft:dye:4> * 262144)
    .addOutput(<minecraft:diamond> * 262144)
    .addOutput(<minecraft:redstone> * 262144)
    .addOutput(<minecraft:emerald> * 262144)
    .addOutput(<minecraft:quartz> * 262144)
    .addOutput(<minecraft:coal> * 262144)
    .addOutput(<thermalfoundation:material:128> * 262144)
    .addOutput(<thermalfoundation:material:129> * 262144)
    .addOutput(<thermalfoundation:material:130> * 262144)
    .addOutput(<thermalfoundation:material:131> * 262144)
    .addOutput(<thermalfoundation:material:132> * 262144)
    .addOutput(<thermalfoundation:material:133> * 262144)
    .addOutput(<thermalfoundation:material:134> * 262144)
    .addOutput(<thermalfoundation:material:135> * 262144)
    .addOutput(<thermalfoundation:material:136> * 262144)
    .addOutput(<ic2:ingot:8> * 262144)
    .addOutput(<draconicevolution:draconium_ingot> * 262144)
    .addOutput(<biomesoplenty:gem:0> * 262144)
    .addOutput(<biomesoplenty:gem:1> * 262144)
    .addOutput(<biomesoplenty:gem:2> * 262144)
    .addOutput(<biomesoplenty:gem:3> * 262144)
    .addOutput(<biomesoplenty:gem:4> * 262144)
    .addOutput(<biomesoplenty:gem:5> * 262144)
    .addOutput(<biomesoplenty:gem:6> * 262144)
    .addOutput(<biomesoplenty:gem:7> * 262144)
    .addOutput(<ore:ingotThorium> * 262144)
    .addOutput(<ore:ingotBoron> * 262144)
    .addOutput(<ore:ingotMagnesium> * 262144)
    .addOutput(<ore:ingotManganese> * 262144)
    .addOutput(<additions:novaextended-ingot8> * 262144)
    .addOutput(<taiga:dilithium_ingot> * 262144)
    .addOutput(<libvulpes:productingot:7> * 262144)
    .addOutput(<tconstruct:ingots:0> * 262144)
    .addOutput(<tconstruct:ingots:1> * 262144)
    .addOutput(<appliedenergistics2:material:0> * 262144)
    .addOutput(<appliedenergistics2:material:1> * 262144)
    .addOutput(<mekanism:ingot:1> * 262144)
    .addOutput(<mekanism:fluoriteclump> * 262144)
    .addOutput(<futuremc:netherite_scrap> * 262144)
    .addOutput(<rftools:dimensional_shard> * 262144)
    .addOutput(<ore:gemQuartzBlack> * 262144)
    .addOutput(<astralsorcery:itemcraftingcomponent:1> * 262144)
    .addOutput(<astralsorcery:itemcraftingcomponent:0> * 262144)
    .addOutput(<thermalfoundation:material:132> * 262144)
    .addOutput(<taiga:aurorium_ingot> * 262144)
    .addOutput(<taiga:palladium_ingot> * 262144)
    .addOutput(<taiga:prometheum_ingot> * 262144)
    .addOutput(<taiga:valyrium_ingot> * 262144)
    .addOutput(<taiga:vibranium_ingot> * 262144)
    .addOutput(<taiga:osram_ingot> * 262144)
    .addOutput(<taiga:eezo_ingot> * 262144)
    .addOutput(<taiga:uru_ingot> * 262144)
    .addOutput(<taiga:duranite_ingot> * 262144)
    .addOutput(<taiga:karmesine_ingot> * 262144)
    .addOutput(<taiga:abyssum_ingot> * 262144)
    .addOutput(<taiga:tiberium_ingot> * 262144)
    .addOutput(<taiga:jauxum_ingot> * 262144)
    .addOutput(<taiga:ovium_ingot> * 262144)
    .addOutput(<ebwizardry:magic_crystal:1> * 262144)
    .addOutput(<ebwizardry:magic_crystal:2> * 262144)
    .addOutput(<ebwizardry:magic_crystal:3> * 262144)
    .addOutput(<ebwizardry:magic_crystal:4> * 262144)
    .addOutput(<ebwizardry:magic_crystal:5> * 262144)
    .addOutput(<ebwizardry:magic_crystal:6> * 262144)
    .addOutput(<ebwizardry:magic_crystal:7> * 262144)
    .addOutput(<taiga:obsidiorite_ingot> * 262144)
    .addOutput(<taiga:meteorite_ingot> * 262144)
    .addOutput(<appliedenergistics2:sky_stone_block> * 262144)
    .addOutput(<environmentaltech:litherite_crystal> * 262144)
    .addOutput(<environmentaltech:erodium_crystal> * 262144)
    .addOutput(<environmentaltech:lonsdaleite_crystal> * 262144)
    .addOutput(<environmentaltech:kyronite_crystal> * 262144)
    .addOutput(<environmentaltech:pladium_crystal> * 262144)
    .addOutput(<environmentaltech:ionite_crystal> * 262144)
    .addOutput(<environmentaltech:aethium_crystal> * 262144)
    .addRecipeTooltip([
                "§r由§2异星矿机单元§r运行",
            ])
    .build();

RecipeBuilder.newBuilder("se_ore4", "space_elevatormk4",200)
    .addEnergyPerTickInput(100000000000)
    .addOutput(<minecraft:gold_ingot> * 262144)
    .addOutput(<minecraft:iron_ingot> * 262144)
    .addOutput(<minecraft:dye:4> * 262144)
    .addOutput(<minecraft:diamond> * 262144)
    .addOutput(<minecraft:redstone> * 262144)
    .addOutput(<minecraft:emerald> * 262144)
    .addOutput(<minecraft:quartz> * 262144)
    .addOutput(<minecraft:coal> * 262144)
    .addOutput(<thermalfoundation:material:128> * 262144)
    .addOutput(<thermalfoundation:material:129> * 262144)
    .addOutput(<thermalfoundation:material:130> * 262144)
    .addOutput(<thermalfoundation:material:131> * 262144)
    .addOutput(<thermalfoundation:material:132> * 262144)
    .addOutput(<thermalfoundation:material:133> * 262144)
    .addOutput(<thermalfoundation:material:134> * 262144)
    .addOutput(<thermalfoundation:material:135> * 262144)
    .addOutput(<thermalfoundation:material:136> * 262144)
    .addOutput(<ic2:ingot:8> * 262144)
    .addOutput(<draconicevolution:draconium_ingot> * 262144)
    .addOutput(<biomesoplenty:gem:0> * 262144)
    .addOutput(<biomesoplenty:gem:1> * 262144)
    .addOutput(<biomesoplenty:gem:2> * 262144)
    .addOutput(<biomesoplenty:gem:3> * 262144)
    .addOutput(<biomesoplenty:gem:4> * 262144)
    .addOutput(<biomesoplenty:gem:5> * 262144)
    .addOutput(<biomesoplenty:gem:6> * 262144)
    .addOutput(<biomesoplenty:gem:7> * 262144)
    .addOutput(<ore:ingotThorium> * 262144)
    .addOutput(<ore:ingotBoron> * 262144)
    .addOutput(<ore:ingotMagnesium> * 262144)
    .addOutput(<ore:ingotManganese> * 262144)
    .addOutput(<additions:novaextended-ingot8> * 262144)
    .addOutput(<taiga:dilithium_ingot> * 262144)
    .addOutput(<libvulpes:productingot:7> * 262144)
    .addOutput(<tconstruct:ingots:0> * 262144)
    .addOutput(<tconstruct:ingots:1> * 262144)
    .addOutput(<appliedenergistics2:material:0> * 262144)
    .addOutput(<appliedenergistics2:material:1> * 262144)
    .addOutput(<mekanism:ingot:1> * 262144)
    .addOutput(<mekanism:fluoriteclump> * 262144)
    .addOutput(<futuremc:netherite_scrap> * 262144)
    .addOutput(<rftools:dimensional_shard> * 262144)
    .addOutput(<ore:gemQuartzBlack> * 262144)
    .addOutput(<astralsorcery:itemcraftingcomponent:1> * 262144)
    .addOutput(<astralsorcery:itemcraftingcomponent:0> * 262144)
    .addOutput(<thermalfoundation:material:132> * 262144)
    .addOutput(<taiga:aurorium_ingot> * 262144)
    .addOutput(<taiga:palladium_ingot> * 262144)
    .addOutput(<taiga:prometheum_ingot> * 262144)
    .addOutput(<taiga:valyrium_ingot> * 262144)
    .addOutput(<taiga:vibranium_ingot> * 262144)
    .addOutput(<taiga:osram_ingot> * 262144)
    .addOutput(<taiga:eezo_ingot> * 262144)
    .addOutput(<taiga:uru_ingot> * 262144)
    .addOutput(<taiga:duranite_ingot> * 262144)
    .addOutput(<taiga:karmesine_ingot> * 262144)
    .addOutput(<taiga:abyssum_ingot> * 262144)
    .addOutput(<taiga:tiberium_ingot> * 262144)
    .addOutput(<taiga:jauxum_ingot> * 262144)
    .addOutput(<taiga:ovium_ingot> * 262144)
    .addOutput(<ebwizardry:magic_crystal:1> * 262144)
    .addOutput(<ebwizardry:magic_crystal:2> * 262144)
    .addOutput(<ebwizardry:magic_crystal:3> * 262144)
    .addOutput(<ebwizardry:magic_crystal:4> * 262144)
    .addOutput(<ebwizardry:magic_crystal:5> * 262144)
    .addOutput(<ebwizardry:magic_crystal:6> * 262144)
    .addOutput(<ebwizardry:magic_crystal:7> * 262144)
    .addOutput(<taiga:obsidiorite_ingot> * 262144)
    .addOutput(<taiga:meteorite_ingot> * 262144)
    .addOutput(<appliedenergistics2:sky_stone_block> * 262144)
    .addOutput(<environmentaltech:litherite_crystal> * 262144)
    .addOutput(<environmentaltech:erodium_crystal> * 262144)
    .addOutput(<environmentaltech:lonsdaleite_crystal> * 262144)
    .addOutput(<environmentaltech:kyronite_crystal> * 262144)
    .addOutput(<environmentaltech:pladium_crystal> * 262144)
    .addOutput(<environmentaltech:ionite_crystal> * 262144)
    .addOutput(<environmentaltech:aethium_crystal> * 262144)
    .addRecipeTooltip([
                "§r由§2异星矿机单元§r运行",
                "§r啊啊啊啊L9塞不下了啊",
                "§2【[新星工程]64台eco-L9和eco-C9】BV19FXoY9ERa 建议你学习这个视频做存储",
            ])
    .build();

    RecipeBuilder.newBuilder("se_gas", "space_elevator",20)
        .addEnergyPerTickInput(10000000000)
        .addFluidOutput(<liquid:jfh> * 10000)
        .addFluidOutput(<liquid:helium_3> * 1000000)
        .addFluidOutput(<liquid:unsteady_plasma> * 100000)
        .addFluidOutput(<liquid:liquidfusionfuel> * 1000000)
        .addOutput(<liquid:crystalloid> * 20000)
        .addOutput(<liquid:plasma> * 100000)
        .addRecipeTooltip([
                "§r由§2异星钻机单元§r运行",
            ])
        .build();
    
    RecipeBuilder.newBuilder("se_gas2", "space_elevatormk2",10)
        .addEnergyPerTickInput(10000000000)
        .addFluidOutput(<liquid:jfh> * 10000)
        .addFluidOutput(<liquid:helium_3> * 1000000)
        .addFluidOutput(<liquid:unsteady_plasma> * 100000)
        .addFluidOutput(<liquid:liquidfusionfuel> * 1000000)
        .addOutput(<liquid:crystalloid> * 20000)
        .addOutput(<liquid:plasma> * 100000)
        .addRecipeTooltip([
                "§r由§2异星钻机单元§r运行",
            ])
        .build();
    
    RecipeBuilder.newBuilder("se_gas3", "space_elevatormk3",5)
        .addEnergyPerTickInput(10000000000)
        .addFluidOutput(<liquid:jfh> * 10000)
        .addFluidOutput(<liquid:helium_3> * 1000000)
        .addFluidOutput(<liquid:unsteady_plasma> * 100000)
        .addFluidOutput(<liquid:liquidfusionfuel> * 1000000)
        .addOutput(<liquid:crystalloid> * 20000)
        .addOutput(<liquid:plasma> * 100000)
        .addRecipeTooltip([
                "§r由§2异星钻机单元§r运行",
            ])
        .build();

    RecipeBuilder.newBuilder("se_gas4", "space_elevatormk4",5)
        .addEnergyPerTickInput(10000000000)
        .addFluidOutput(<liquid:jfh> * 10000)
        .addFluidOutput(<liquid:helium_3> * 1000000)
        .addFluidOutput(<liquid:unsteady_plasma> * 100000)
        .addFluidOutput(<liquid:liquidfusionfuel> * 1000000)
        .addOutput(<liquid:crystalloid> * 20000)
        .addOutput(<liquid:plasma> * 100000)
        .addRecipeTooltip([
                "§r由§2异星钻机单元§r运行",
            ])
        .build();

    RecipeBuilder.newBuilder("se_item", "space_elevator",200)
        .addEnergyPerTickInput(10000000000)
        .addOutput(<contenttweaker:fragments_of_the_space_time_continuum> * 10)
        .addOutput(<contenttweaker:space_time_condensation_block> * 1)
        .addOutput(<avaritia:resource:5> * 16)
        .addOutput(<avaritia:block_resource> * 64)
        .addOutput(<mekanism:antimatterpellet> * 128)
        .addOutput(<avaritia:block_resource:2> * 32)
        .addOutput(<eternalsingularity:eternal_singularity> * 256)
        .addOutput(<additions:novaextended-crystal4> * 4)
        .addRecipeTooltip([
                "§r由§2异次元入侵单元§r运行",
            ])
        .build();

    RecipeBuilder.newBuilder("se_item2", "space_elevatormk2",100)
        .addEnergyPerTickInput(20000000000)
        .addOutput(<contenttweaker:fragments_of_the_space_time_continuum> * 50)
        .addOutput(<contenttweaker:space_time_condensation_block> * 2)
        .addOutput(<avaritia:resource:5> * 32)
        .addOutput(<avaritia:block_resource> * 128)
        .addOutput(<mekanism:antimatterpellet> * 256)
        .addOutput(<eternalsingularity:eternal_singularity> * 256)
        .addOutput(<avaritia:block_resource:2> * 64)
        .addOutput(<additions:novaextended-crystal4> * 4)
        .addRecipeTooltip([
                "§r由§2异次元入侵单元§r运行",
            ])
        .build();

    RecipeBuilder.newBuilder("se_item3", "space_elevatormk3",50)
        .addEnergyPerTickInput(40000000000)
        .addOutput(<contenttweaker:fragments_of_the_space_time_continuum> * 100)
        .addOutput(<contenttweaker:space_time_condensation_block> * 4)
        .addOutput(<avaritia:resource:5> * 64)
        .addOutput(<avaritia:block_resource> * 256)
        .addOutput(<mekanism:antimatterpellet> * 512)
        .addOutput(<avaritia:block_resource:2> * 128)
        .addOutput(<eternalsingularity:eternal_singularity> * 256)
        .addOutput(<additions:novaextended-crystal4> * 4)
        .addRecipeTooltip([
                "§r由§2异次元入侵单元§r运行",
            ])
        .build();

    RecipeBuilder.newBuilder("se_item4", "space_elevatormk4",25)
        .addEnergyPerTickInput(80000000000)
        .addOutput(<contenttweaker:fragments_of_the_space_time_continuum> * 1000)
        .addOutput(<contenttweaker:space_time_condensation_block> * 8)
        .addOutput(<avaritia:resource:5> * 128)
        .addOutput(<avaritia:block_resource> * 512)
        .addOutput(<mekanism:antimatterpellet> * 1024)
        .addOutput(<avaritia:block_resource:2> * 256)
        .addOutput(<eternalsingularity:eternal_singularity> * 256)
        .addOutput(<contenttweaker:mm_xxjz> * 1).setChance(0.001)
        .addOutput(<additions:novaextended-crystal4> * 4)
        .addRecipeTooltip([
                "§r由§2异次元入侵单元§r运行",
            ])
        .build();

    RecipeBuilder.newBuilder("ast_assembly", "workshop", 20000)
        .addEnergyPerTickInput(80000000000)
        .addInput(<contenttweaker:industrial_circuit_v4> * 512)
        .addInput(<contenttweaker:field_generator_v4> * 1024)
        .addInput(<advancedrocketry:warpcore> * 64)
        .addInput(<modularmachinery:dream_energy_core_factory_controller> * 1)
        .addInput(<moreplates:infinity_gear> * 64)
        .addInput(<contenttweaker:coil_v5> * 1024)
        .addInput(<contenttweaker:antimatter_core> * 64)
        .addInput(<contenttweaker:space_time_coil> * 4)
        .addOutput(<modularmachinery:ark_space_station_factory_controller>)
        .requireComputationPoint(400000.0F)
        .build();


    RecipeBuilder.newBuilder("se_timespace_coil_assembly1", "space_elevator",20000)
        .addInput(<contenttweaker:coil_v5> * 1024)
        .addInput(<contenttweaker:infinite_coil> * 64)
        .addInput(<contenttweaker:fragments_of_the_space_time_continuum> * 16384)
        .addOutput(<contenttweaker:space_time_coil>)
        .requireComputationPoint(400000.0F)
        .addRecipeTooltip([
                "§r由§2异星装配单元§r运行",
            ])
        .addEnergyPerTickInput(80000000000)
        .build();
    
    RecipeBuilder.newBuilder("se_timespace_coil_assembly2", "space_elevatormk2",10000)
        .addInput(<contenttweaker:coil_v5> * 1024)
        .addInput(<contenttweaker:infinite_coil> * 64)
        .addInput(<contenttweaker:fragments_of_the_space_time_continuum> * 16384)
        .addOutput(<contenttweaker:space_time_coil>)
        .requireComputationPoint(400000.0F)
        .addRecipeTooltip([
                "§r由§2异星装配单元§r运行",
            ])
        .addEnergyPerTickInput(160000000000)
        .build();
    
    RecipeBuilder.newBuilder("se_timespace_coil_assembly3", "space_elevatormk3",5000)
        .addInput(<contenttweaker:coil_v5> * 1024)
        .addInput(<contenttweaker:infinite_coil> * 64)
        .addInput(<contenttweaker:fragments_of_the_space_time_continuum> * 16384)
        .addOutput(<contenttweaker:space_time_coil>)
        .requireComputationPoint(400000.0F)
        .addRecipeTooltip([
                "§r由§2异星装配单元§r运行",
            ])
        .addEnergyPerTickInput(320000000000)
        .build();
    
    RecipeBuilder.newBuilder("se_timespace_coil_assembly4", "space_elevatormk4",2500)
        .addInput(<contenttweaker:coil_v5> * 1024)
        .addInput(<contenttweaker:infinite_coil> * 64)
        .addInput(<contenttweaker:fragments_of_the_space_time_continuum> * 16384)
        .addOutput(<contenttweaker:space_time_coil>)
        .requireComputationPoint(400000.0F)
        .addRecipeTooltip([
                "§r由§2异星装配单元§r运行",
            ])
        .addEnergyPerTickInput(640000000000)
        .build();

    RecipeBuilder.newBuilder("se_energy", "space_elevator",100)
        .addEnergyPerTickOutput(5000000000)
        .addRecipeTooltip([
                "§r由§2气态行星采集燃烧集成单元§r运行",
            ])
        .build();
    RecipeBuilder.newBuilder("se_energy4", "space_elevatormk4",100)
        .addEnergyPerTickOutput(80000000000)
        .addRecipeTooltip([
                "§r由§2气态行星采集燃烧集成单元§r运行",
            ])
        .build();
    RecipeBuilder.newBuilder("se_energy2", "space_elevatormk2",100)
        .addEnergyPerTickOutput(20000000000)
        .addRecipeTooltip([
                "§r由§2气态行星采集燃烧集成单元§r运行",
            ])
        .build();
    RecipeBuilder.newBuilder("se_energy3", "space_elevatormk3",100)
        .addEnergyPerTickOutput(40000000000)
        .addRecipeTooltip([
                "§r由§2气态行星采集燃烧集成单元§r运行",
            ])
        .build();
    RecipeBuilder.newBuilder("dptf_assembly", "workshop",25000)
        .addInput(<contenttweaker:arkforcefieldcontrolblock> * 64)
        .addInput(<contenttweaker:infinite_coil> * 64)
        .addInput(<modularmachinery:melodic_smelting_plant_factory_controller> * 64)
        .addInput(<contenttweaker:engineering_battery_v4> * 64)
        .addInput(<contenttweaker:industrial_circuit_v4> * 64)
        .addInput(<moreplates:infinity_gear> *64)
        .addInput(<contenttweaker:coil_v5> * 512)
        .addInput(<contenttweaker:antimatter_core> * 128)
        .addInput(<contenttweaker:universalalloyt3> * 1024)
        .addOutput(<modularmachinery:dptf_cc_factory_controller>)
        .requireResearch("DPTF_8")
        .requireComputationPoint(400000.0F)
        .addEnergyPerTickInput(640000000000)
        .build();

HyperNetHelper.proxyMachineForHyperNet("space_elevator");
MachineModifier.setMaxThreads("space_elevator", 0);
MachineModifier.addCoreThread("space_elevator", FactoryRecipeThread.createCoreThread("§2异星矿机单元").addRecipe("se_ore"));
MachineModifier.addCoreThread("space_elevator", FactoryRecipeThread.createCoreThread("§2异星钻机单元").addRecipe("se_gas"));
MachineModifier.addCoreThread("space_elevator", FactoryRecipeThread.createCoreThread("§2异次元入侵单元").addRecipe("se_item"));
MachineModifier.addCoreThread("space_elevator", FactoryRecipeThread.createCoreThread("§2异星装配单元#1").addRecipe("se_timespace_coil_assembly1"));
MachineModifier.addCoreThread("space_elevator", FactoryRecipeThread.createCoreThread("§2异星装配单元#2").addRecipe("se_timespace_coil_assembly1"));
MachineModifier.addCoreThread("space_elevator", FactoryRecipeThread.createCoreThread("§2异星装配单元#3").addRecipe("se_timespace_coil_assembly1"));
MachineModifier.addCoreThread("space_elevator", FactoryRecipeThread.createCoreThread("§2异星装配单元#4").addRecipe("se_timespace_coil_assembly1"));
MachineModifier.addCoreThread("space_elevator", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#1").addRecipe("se_energy"));
MachineModifier.addCoreThread("space_elevator", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#2").addRecipe("se_energy"));
MachineModifier.addCoreThread("space_elevator", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#3").addRecipe("se_energy"));
MachineModifier.addCoreThread("space_elevator", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#4").addRecipe("se_energy"));

HyperNetHelper.proxyMachineForHyperNet("space_elevatormk2");
MachineModifier.setMaxThreads("space_elevatormk2", 0);
MachineModifier.addCoreThread("space_elevatormk2", FactoryRecipeThread.createCoreThread("§2异星矿机单元#1").addRecipe("se_ore2"));
MachineModifier.addCoreThread("space_elevatormk2", FactoryRecipeThread.createCoreThread("§2异星钻机单元#1").addRecipe("se_gas2"));
MachineModifier.addCoreThread("space_elevatormk2", FactoryRecipeThread.createCoreThread("§2异星矿机单元#2").addRecipe("se_ore2"));
MachineModifier.addCoreThread("space_elevatormk2", FactoryRecipeThread.createCoreThread("§2异星钻机单元#2").addRecipe("se_gas2"));
MachineModifier.addCoreThread("space_elevatormk2", FactoryRecipeThread.createCoreThread("§2异次元入侵单元#1").addRecipe("se_item2"));
MachineModifier.addCoreThread("space_elevatormk2", FactoryRecipeThread.createCoreThread("§2异次元入侵单元#2").addRecipe("se_item2"));
MachineModifier.addCoreThread("space_elevatormk2", FactoryRecipeThread.createCoreThread("§2异星装配单元#1").addRecipe("se_timespace_coil_assembly2"));
MachineModifier.addCoreThread("space_elevatormk2", FactoryRecipeThread.createCoreThread("§2异星装配单元#2").addRecipe("se_timespace_coil_assembly2"));
MachineModifier.addCoreThread("space_elevatormk2", FactoryRecipeThread.createCoreThread("§2异星装配单元#3").addRecipe("se_timespace_coil_assembly2"));
MachineModifier.addCoreThread("space_elevatormk2", FactoryRecipeThread.createCoreThread("§2异星装配单元#4").addRecipe("se_timespace_coil_assembly2"));
MachineModifier.addCoreThread("space_elevatormk2", FactoryRecipeThread.createCoreThread("§2异星装配单元#5").addRecipe("se_timespace_coil_assembly2"));
MachineModifier.addCoreThread("space_elevatormk2", FactoryRecipeThread.createCoreThread("§2异星装配单元#6").addRecipe("se_timespace_coil_assembly2"));
MachineModifier.addCoreThread("space_elevatormk2", FactoryRecipeThread.createCoreThread("§2异星装配单元#7").addRecipe("se_timespace_coil_assembly2"));
MachineModifier.addCoreThread("space_elevatormk2", FactoryRecipeThread.createCoreThread("§2异星装配单元#8").addRecipe("se_timespace_coil_assembly2"));
MachineModifier.addCoreThread("space_elevatormk2", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#1").addRecipe("se_energy2"));
MachineModifier.addCoreThread("space_elevatormk2", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#2").addRecipe("se_energy2"));
MachineModifier.addCoreThread("space_elevatormk2", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#3").addRecipe("se_energy2"));
MachineModifier.addCoreThread("space_elevatormk2", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#4").addRecipe("se_energy2"));
MachineModifier.addCoreThread("space_elevatormk2", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#5").addRecipe("se_energy2"));
MachineModifier.addCoreThread("space_elevatormk2", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#6").addRecipe("se_energy2"));
MachineModifier.addCoreThread("space_elevatormk2", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#7").addRecipe("se_energy2"));
MachineModifier.addCoreThread("space_elevatormk2", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#8").addRecipe("se_energy2"));

HyperNetHelper.proxyMachineForHyperNet("space_elevatormk3");
MachineModifier.setMaxThreads("space_elevator", 0);
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2异星矿机单元#1").addRecipe("se_ore3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2异星钻机单元#1").addRecipe("se_gas3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2异星矿机单元#2").addRecipe("se_ore3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2异星钻机单元#2").addRecipe("se_gas3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2异次元入侵单元#1").addRecipe("se_item3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2异次元入侵单元#2").addRecipe("se_item3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2异次元入侵单元#3").addRecipe("se_item3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2异次元入侵单元#4").addRecipe("se_item3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2异星装配单元#1").addRecipe("se_timespace_coil_assembly3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2异星装配单元#2").addRecipe("se_timespace_coil_assembly3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2异星装配单元#3").addRecipe("se_timespace_coil_assembly3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2异星装配单元#4").addRecipe("se_timespace_coil_assembly3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2异星装配单元#5").addRecipe("se_timespace_coil_assembly3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2异星装配单元#6").addRecipe("se_timespace_coil_assembly3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2异星装配单元#7").addRecipe("se_timespace_coil_assembly3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2异星装配单元#8").addRecipe("se_timespace_coil_assembly3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2异星装配单元#9").addRecipe("se_timespace_coil_assembly3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2异星装配单元#10").addRecipe("se_timespace_coil_assembly3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2异星装配单元#11").addRecipe("se_timespace_coil_assembly3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2异星装配单元#12").addRecipe("se_timespace_coil_assembly3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2异星装配单元#13").addRecipe("se_timespace_coil_assembly3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2异星装配单元#14").addRecipe("se_timespace_coil_assembly3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2异星装配单元#15").addRecipe("se_timespace_coil_assembly3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2异星装配单元#16").addRecipe("se_timespace_coil_assembly3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#1").addRecipe("se_energy3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#2").addRecipe("se_energy3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#3").addRecipe("se_energy3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#4").addRecipe("se_energy3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#5").addRecipe("se_energy3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#6").addRecipe("se_energy3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#7").addRecipe("se_energy3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#8").addRecipe("se_energy3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#9").addRecipe("se_energy3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#10").addRecipe("se_energy3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#11").addRecipe("se_energy3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#12").addRecipe("se_energy3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#13").addRecipe("se_energy3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#14").addRecipe("se_energy3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#15").addRecipe("se_energy3"));
MachineModifier.addCoreThread("space_elevatormk3", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#16").addRecipe("se_energy3"));

HyperNetHelper.proxyMachineForHyperNet("space_elevatormk4");
MachineModifier.setMaxThreads("space_elevatormk4", 0);
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星矿机单元#1").addRecipe("se_ore4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星钻机单元#1").addRecipe("se_gas4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星矿机单元#2").addRecipe("se_ore4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星钻机单元#2").addRecipe("se_gas4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星矿机单元#3").addRecipe("se_ore4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星钻机单元#3").addRecipe("se_gas4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星矿机单元#4").addRecipe("se_ore4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星钻机单元#4").addRecipe("se_gas4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星矿机单元#5").addRecipe("se_ore4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星钻机单元#5").addRecipe("se_gas4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星矿机单元#6").addRecipe("se_ore4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星钻机单元#6").addRecipe("se_gas4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星矿机单元#7").addRecipe("se_ore4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星钻机单元#7").addRecipe("se_gas4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星矿机单元#8").addRecipe("se_ore4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星钻机单元#8").addRecipe("se_gas4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异次元入侵单元#1").addRecipe("se_item4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异次元入侵单元#2").addRecipe("se_item4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异次元入侵单元#3").addRecipe("se_item4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异次元入侵单元#4").addRecipe("se_item4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异次元入侵单元#5").addRecipe("se_item4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异次元入侵单元#6").addRecipe("se_item4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异次元入侵单元#7").addRecipe("se_item4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异次元入侵单元#8").addRecipe("se_item4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星装配单元#1").addRecipe("se_timespace_coil_assembly4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星装配单元#2").addRecipe("se_timespace_coil_assembly4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星装配单元#3").addRecipe("se_timespace_coil_assembly4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星装配单元#4").addRecipe("se_timespace_coil_assembly4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星装配单元#5").addRecipe("se_timespace_coil_assembly4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星装配单元#6").addRecipe("se_timespace_coil_assembly4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星装配单元#7").addRecipe("se_timespace_coil_assembly4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星装配单元#8").addRecipe("se_timespace_coil_assembly4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星装配单元#9").addRecipe("se_timespace_coil_assembly4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星装配单元#10").addRecipe("se_timespace_coil_assembly4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星装配单元#11").addRecipe("se_timespace_coil_assembly4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星装配单元#12").addRecipe("se_timespace_coil_assembly4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星装配单元#13").addRecipe("se_timespace_coil_assembly4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星装配单元#14").addRecipe("se_timespace_coil_assembly4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星装配单元#15").addRecipe("se_timespace_coil_assembly4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星装配单元#16").addRecipe("se_timespace_coil_assembly4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星装配单元#17").addRecipe("se_timespace_coil_assembly4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星装配单元#18").addRecipe("se_timespace_coil_assembly4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星装配单元#19").addRecipe("se_timespace_coil_assembly4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星装配单元#20").addRecipe("se_timespace_coil_assembly4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星装配单元#21").addRecipe("se_timespace_coil_assembly4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星装配单元#22").addRecipe("se_timespace_coil_assembly4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星装配单元#23").addRecipe("se_timespace_coil_assembly4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星装配单元#24").addRecipe("se_timespace_coil_assembly4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星装配单元#25").addRecipe("se_timespace_coil_assembly4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星装配单元#26").addRecipe("se_timespace_coil_assembly4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星装配单元#27").addRecipe("se_timespace_coil_assembly4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星装配单元#28").addRecipe("se_timespace_coil_assembly4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星装配单元#29").addRecipe("se_timespace_coil_assembly4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星装配单元#30").addRecipe("se_timespace_coil_assembly4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星装配单元#31").addRecipe("se_timespace_coil_assembly4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2异星装配单元#32").addRecipe("se_timespace_coil_assembly4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#1").addRecipe("se_energy4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#2").addRecipe("se_energy4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#3").addRecipe("se_energy4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#4").addRecipe("se_energy4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#5").addRecipe("se_energy4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#6").addRecipe("se_energy4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#7").addRecipe("se_energy4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#8").addRecipe("se_energy4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#9").addRecipe("se_energy4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#10").addRecipe("se_energy4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#11").addRecipe("se_energy4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#12").addRecipe("se_energy4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#13").addRecipe("se_energy4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#14").addRecipe("se_energy4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#15").addRecipe("se_energy4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#16").addRecipe("se_energy4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#17").addRecipe("se_energy4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#18").addRecipe("se_energy4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#19").addRecipe("se_energy4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#20").addRecipe("se_energy4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#21").addRecipe("se_energy4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#22").addRecipe("se_energy4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#23").addRecipe("se_energy4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#24").addRecipe("se_energy4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#25").addRecipe("se_energy4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#26").addRecipe("se_energy4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#27").addRecipe("se_energy4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#28").addRecipe("se_energy4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#29").addRecipe("se_energy4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#30").addRecipe("se_energy4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#31").addRecipe("se_energy4"));
MachineModifier.addCoreThread("space_elevatormk4", FactoryRecipeThread.createCoreThread("§2气态行星采集燃烧集成单元#32").addRecipe("se_energy4"));

//==============================巨型魔力聚合机==============================
MachineModifier.setMaxThreads("g_ma", 16);
RecipeBuilder.newBuilder("g_ma", "workshop", 20000)
        .addEnergyPerTickInput(80000000000)
        .addInput(<contenttweaker:industrial_circuit_v4> * 64)
        .addInput(<contenttweaker:field_generator_v4> * 64)
        .addInput(<modularmachinery:bot_crafter_factory_controller> * 1)
        .addInput(<moreplates:infinity_gear> * 4)
        .addInput(<contenttweaker:coil_v5> * 64)
        .addInput(<contenttweaker:programming_circuit_d> * 1)
        .addInput(<contenttweaker:antimatter_core> * 4)
        .addOutput(<modularmachinery:g_ma_factory_controller>)
        .requireResearch("G_MA")
        .requireComputationPoint(400000.0F)
        .build();

registerRecipe(
        "g_ma",
        [<liquid:fluidedmana>*5,<extrabotany:nightmarefuel>*3,<extrabotany:gildedmashedpotato>,<botania:manaresource:7>,<botania:livingrock:0>],
        [],
        [<extrabotany:material:5>],
        [],
        2,2560
    );
    //奥利哈钢
    registerRecipe(
        "g_ma",
        [<liquid:fluidedmana>*150,<botania:manaresource:14>*2,<botania:manaresource:5>*4,<extrabotany:material:3>],
        [],
        [<extrabotany:material:1>],
        [],
        20,12800
    );
    //镀金土豆泥
    registerRecipe(
        "g_ma",
        [<liquid:fluidedmana>*5,<minecraft:potato>,<botania:livingrock:0>],
        [],
        [<extrabotany:gildedmashedpotato>],
        [],
        5,2560
    );
    //光子锭
    registerRecipe(
        "g_ma",
        [<liquid:fluidedmana>*5,<extrabotany:material:0>*3,<extrabotany:gildedmashedpotato>,<botania:manaresource:7>,<botania:livingrock:0>],
        [],
        [<extrabotany:material:8>],
        [],
        20,2560
    );
    //精神碎片
    registerRecipe(
        "g_ma",
        [<liquid:fluidedmana>*5,<minecraft:coal>],
        [],
        [<extrabotany:material:0>],
        [],
        5,2560
    );
    //泰拉钢
    registerRecipe(
        "g_ma",
        [<liquid:fluidedmana>*500,<botania:manaresource:0>,<botania:manaresource:1>,<botania:manaresource:2>],
        [],
        [<botania:manaresource:4>],
        [],
        20,2560
    );
    //异世界水晶_3
    registerRecipe(
        "g_ma",
        [<liquid:fluidedmana>*1000,<ore:gemCrystalPurple>],
        [],
        [],
        [<contenttweaker:crystalgreen>],
        12,0
    );

MachineModifier.setMaxThreads("g_af", 64);
RecipeBuilder.newBuilder("g_af", "workshop", 20000)
        .addEnergyPerTickInput(80000000000)
        .addInput(<contenttweaker:industrial_circuit_v4> * 64)
        .addInput(<contenttweaker:field_generator_v4> * 64)
        .addInput(<modularmachinery:large_metallurgical_complex_controller> * 64)
        .addInput(<moreplates:infinity_gear> * 4)
        .addInput(<contenttweaker:coil_v5> * 64)
        .addInput(<contenttweaker:programming_circuit_c> * 1)
        .addInput(<contenttweaker:antimatter_core> * 4)
        .addOutput(<modularmachinery:g_af_factory_controller>)
        .requireResearch("G_AF")
        .requireComputationPoint(400000.0F)
        .build();

RecipeAdapterBuilder.create("g_af", "nuclearcraft:alloy_furnace")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.1,  1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 100000, 1, false).build())
    .build();

                                                                                                 // *基础*能量消耗
 RegistryHyperNet.addComputationCenterType(ComputationCenterType.create("networkcenter_mk4", 100 * 1000 * 1000,
         // 最大连接数 单次最大算力支持 电路板耐久 最低电路板耐久消耗 最高电路板耐久消耗 电路板耐久消耗概率
         1000,        8000000,  640000,  -1000,         1000,          0.02F)
         .addFixIngredient(950, <contenttweaker:industrial_circuit_v1>)
         .addFixIngredient(3950, <contenttweaker:industrial_circuit_v2>)
         .addFixIngredient(150000, <contenttweaker:industrial_circuit_v3>)
        .addFixIngredient(600000, <contenttweaker:industrial_circuit_v4>)
 );
RegistryHyperNet.addComputationCenter("networkcenter_mk4");
MachineModifier.setMaxThreads("networkcenter_mk4", 0);


//不写会报错
function camelToSnake(camelStr as string) as string {
    var result = "";
    var index = 0;
    while (index < camelStr.length) {
        if (camelStr.matches(".*[A-Z].*")) {
            if (index != 0 && camelStr.substring(index,index + 1).matches(".*[A-Z].*")) {
                result += "_";
            }
            result += camelStr.substring(index, index + 1).toLowerCase();
        } else {
            result += camelStr.substring(index, index + 1);
        }
            index += 1;
        }
    return result;
}
zenClass NAME {
    static name as int = 0;
}
function registerRecipe(machine as string,inputs as IIngredient[],Weightedinputs as IWeightedIngredient[],outputs as IIngredient[],Weightedoutputs as IWeightedIngredient[],time as int,energy as long){
    val recipe = RecipeBuilder.newBuilder(machine + NAME.name + energy + time,machine,time);
        if (energy > 0){
            recipe.addEnergyPerTickInput(energy);
        }
        for input in inputs{
            recipe.addInput(input);
        }
        for input in Weightedinputs{
            recipe.addInput(input.ingredient).setChance(input.percent);
        }
        for output in outputs{
            recipe.addOutput(output);
        }
        for output in Weightedoutputs{
            recipe.addOutput(output.ingredient).setChance(output.percent);
        }
        recipe.build();
    NAME.name += 1;
}
function recistermax(input as IIngredient[],output as IIngredient,input1 as IIngredient[] = null){
    val re = RecipeBuilder.newBuilder("light-speed_material_accelerator" + NAME.name,"light-speed_material_accelerator",72000);
    if (!isNull(input1)){
        re.addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients(input1));
    }
        re.addInputs(input)
        .addOutput(output)
        .addEnergyPerTickInput(100000000000)
    .build();
    NAME.name += 1;
}

RecipeBuilder.newBuilder("ncmk4_assembly", "workshop", 20000)
        .addEnergyPerTickInput(80000000000)
        .addInput(<contenttweaker:industrial_circuit_v4> * 256)
        .addInput(<contenttweaker:field_generator_v4> * 512)
        .addInput(<modularmachinery:dream_energy_core_factory_controller> * 1)
        .addInput(<moreplates:infinity_gear> * 32)
        .addInput(<contenttweaker:coil_v5> * 512)
        .addInput(<contenttweaker:antimatter_core> * 32)
        .addInput(<contenttweaker:programming_circuit_b> * 1)
        .addInput(<modularmachinery:acaa_factory_controller> * 4)
        .addInput(<modularmachinery:apac_factory_controller> * 4)
        .addOutput(<modularmachinery:networkcenter_mk4_factory_controller>)
        .requireResearch("networkcenter_mk4")
        .requireComputationPoint(400000.0F)
        .build();

RecipeBuilder.newBuilder("odal_assembly", "workshop", 20000)
        .addEnergyPerTickInput(80000000000)
        .addInput(<contenttweaker:industrial_circuit_v4> * 256)
        .addInput(<contenttweaker:field_generator_v4> * 512)
        .addInput(<contenttweaker:space_time_coil> * 1)
        .addInput(<moreplates:infinity_gear> * 32)
        .addInput(<contenttweaker:coil_v5> * 512)
        .addInput(<contenttweaker:antimatter_core> * 32)
        .addInput(<modularmachinery:acaa_factory_controller> * 4)
        .addInput(<modularmachinery:apac_factory_controller> * 4)
        .addInput(<contenttweaker:programming_circuit_a> * 2)
        .addOutput(<modularmachinery:odal_ar_factory_controller>)
        .requireResearch("ODAL_2")
        .requireComputationPoint(400000.0F)
        .build();

RecipeBuilder.newBuilder("odal_exchange01", "workshop", 10)
        .addInput(<modularmachinery:odal_ar_factory_controller>)
        .addOutput(<modularmachinery:odal_sd_factory_controller>)
        .requireResearch("ODAL_2")
        .build();

RecipeBuilder.newBuilder("odal_exchange02", "workshop", 10)
        .addInput(<modularmachinery:odal_sd_factory_controller>)
        .addOutput(<modularmachinery:odal_ma_factory_controller>)
        .requireResearch("ODAL_2")
        .build();

RecipeBuilder.newBuilder("odal_exchange03", "workshop", 10)
        .addInput(<modularmachinery:odal_ma_factory_controller>)
        .addOutput(<modularmachinery:odal_ar_factory_controller>)
        .requireResearch("ODAL_2")
        .build();

RecipeBuilder.newBuilder("qft_assembly", "workshop", 20000)
        .addEnergyPerTickInput(80000000000)
        .addInput(<contenttweaker:industrial_circuit_v4> * 1024)
        .addInput(<contenttweaker:field_generator_v4> * 521)
        .addInput(<contenttweaker:space_time_coil> * 16)
        .addInput(<moreplates:infinity_gear> * 64)
        .addInput(<contenttweaker:coil_v5> * 768)
        .addInput(<contenttweaker:antimatter_core> * 64)
        .addOutput(<modularmachinery:qft_factory_controller>)
        .requireResearch("qft_4")
        .requireComputationPoint(400000.0F)
        .build();

RecipeBuilder.newBuilder("se_assembly111", "workshop", 20000)
        .addEnergyPerTickInput(80000000000)
        .addInput(<contenttweaker:industrial_circuit_v4> * 256)
        .addInput(<contenttweaker:field_generator_v4> * 512)
        .addInput(<contenttweaker:space_time_coil> * 8)
        .addInput(<moreplates:infinity_gear> * 32)
        .addInput(<contenttweaker:coil_v5> * 512)
        .addInput(<contenttweaker:antimatter_core> * 64)
        .addInput(<contenttweaker:programming_circuit_0> * 1)
        .addOutput(<modularmachinery:tsl_controller>)
        .requireResearch("dsp_4")
        .requireComputationPoint(400000.0F)
        .build();

RecipeBuilder.newBuilder("tsl", "tsl", 20000)
        .addEnergyPerTickOutput(20000000000000)
        .addInput(<mekanism:antimatterpellet> * 1)
        .requireResearch("dsp_4")
        .requireComputationPoint(100000.0F)
        .build();

RecipeBuilder.newBuilder("kysn_assembly", "ark_space_station", 20000)
        .addEnergyPerTickInput(1000000000000)
        
        .addInput(<fluid:space_time_fluids> * 100)
        .addInput(<contenttweaker:industrial_circuit_v4> * 256)
        .addInput(<contenttweaker:field_generator_v4> * 512)
        .addInput(<contenttweaker:space_time_coil> * 8)
        .addInput(<moreplates:infinity_gear> * 32)
        .addInput(<contenttweaker:coil_v5> * 512)
        .addInput(<contenttweaker:antimatter_core> * 64)
        .addInput(<contenttweaker:polymer_matter> * 1)
        .addInput(<modularmachinery:data_processor_t4_factory_controller> * 4)
        .addInput(<modularmachinery:networkcenter_mk4_factory_controller> * 4)
        .addInput(<modularmachinery:research_station_t3_factory_controller> * 4)
        .addOutput(<modularmachinery:kysn_core_factory_controller>)
        .addOutput(<modularmachinery:kysn_research_factory_controller>)
        .addOutput(<modularmachinery:kysn_database_factory_controller>)
        .addOutput(<modularmachinery:qzxc_factory_controller>)
        .requireResearch("xhqj_kysn")
        .requireComputationPoint(4000*1000.0F)
        .build();

RecipeBuilder.newBuilder("kysn_assembly2", "ark_space_station", 20000)
        .addEnergyPerTickInput(1000000000000)
        
        .addInput(<fluid:space_time_fluids> * 400)
        .addInput(<contenttweaker:industrial_circuit_v4> * 256)
        .addInput(<contenttweaker:field_generator_v4> * 512)
        .addInput(<contenttweaker:space_time_coil> * 8)
        .addInput(<moreplates:infinity_gear> * 32)
        .addInput(<contenttweaker:coil_v5> * 512)
        .addInput(<contenttweaker:antimatter_core> * 64)
        .addInput(<contenttweaker:polymer_matter> * 1)
        .addInput(<modularmachinery:space_elevatormk4_factory_controller> * 8)
        .addOutput(<modularmachinery:jxz_factory_controller>)
        .addOutput(<modularmachinery:wzjyq_factory_controller>)
        .addOutput(<modularmachinery:haxsbjsq_factory_controller>)
        .requireResearch("xhqj")
        .requireComputationPoint(4000*1000.0F)
        .build();

RecipeBuilder.newBuilder("mega_v4_qjdd", "ark_space_station", 20000)
        
        .addInput(<fluid:yh> * 100)
        .addInput(<contenttweaker:industrial_circuit_v4> * 1024)
        .addInput(<contenttweaker:field_generator_v4> * 1024)
        .addInput(<contenttweaker:space_time_coil> * 1024)
        .addInput(<moreplates:infinity_gear> * 32)
        .addInput(<contenttweaker:coil_v5> * 16384)
        .addInput(<contenttweaker:antimatter_core> * 1024)
        .addInput(<contenttweaker:mm_yzjz> * 1)
        .addOutput(<modularmachinery:miracle_top_controller>)
        .requireResearch("final_tech")
        .requireComputationPoint(4000*1000.0F)
        .build();

RecipeBuilder.newBuilder("mega_v4_machines", "ark_space_station", 20000)
        
        .addInput(<contenttweaker:industrial_circuit_v4> * 1024)
        .addInput(<contenttweaker:field_generator_v4> * 1024)
        .addInput(<contenttweaker:space_time_coil> * 1024)
        .addInput(<moreplates:infinity_gear> * 32)
        .addInput(<contenttweaker:coil_v5> * 16384)
        .addInput(<contenttweaker:antimatter_core> * 1024)
        .addInput(<contenttweaker:mm_yzjz> * 1)
        .addOutput(<modularmachinery:odm_megav4_controller>)
        .addOutput(<modularmachinery:tc_star_weaver_factory_controller>)
        .addOutput(<modularmachinery:stellar_firmament_anchor_controller>)
        .requireResearch("final_tech_test")
        .requireComputationPoint(4000*1000.0F)
        .build();

RecipeBuilder.newBuilder("infinite_cell2", "miracle_top", 1)
        .addRecipeTooltip("§l§d将创造me元件分裂为其他创造物品,等等。。。这是什么?")
        .addInput(<appliedenergistics2:creative_storage_cell> * 1)
        .addOutput(<thermalexpansion:reservoir:32000> * 1)
        .addOutput(<yabba:upgrade_creative> * 1)
        .addOutput(<mekanism:gastank>.withTag({tier: 4}) * 1)
        .addOutput(<draconicevolution:creative_rf_source> * 1)
        .addOutput(<botania:pool:1> * 1)
        .addOutput(<mekanism:machineblock2:11>.withTag({tier: 4}) * 1)
        .addOutput(<thermalexpansion:satchel:32000> * 1)
        .addOutput(<thermalexpansion:capacitor:32000> * 1)
        .addOutput(<contenttweaker:suicide> * 1)
        .build();

RecipeBuilder.newBuilder("stellaris_shipboard_ship", "ark_space_station",2000)
        .addInput(<contenttweaker:anti_viod> * 2000)
        .addInput(<contenttweaker:stellaris_alloy> * 4000)
        .addInput(<contenttweaker:stellaris_gas> * 2000)
        .addInput(<contenttweaker:stellaris_crystal> * 2000)
        .addOutput(<contenttweaker:stellaris_shipboard_ship> * 1)
        .requireResearch("final_tech")
        .requireComputationPoint(100000.0F)
        
        .build();

// 合金线圈（等级 3）
RecipeBuilder.newBuilder("coil_v3_coolant_g_mt", "G_MT", 1)
    .addEnergyPerTickInput(64000)
    .addInput(<ore:plateDraconicMetal> * 1)
    .addOutput(<contenttweaker:coil_v3> * 3)
    .build();

// 合金线圈（等级 4）
RecipeBuilder.newBuilder("coil_v4_coolant_g_mt", "G_MT", 1)
    .addEnergyPerTickInput(512000)
    .addInputs(<ore:ingotFallenStarAlloy> * 1)
    .addOutputs(<contenttweaker:coil_v4> * 3)
    .build();

// 合金线圈（等级 5）
RecipeBuilder.newBuilder("coil_v5_coolant_g_mt", "G_MT", 1)
    .addEnergyPerTickInput(8192000)
    .addInputs(<ore:ingotArk> * 1)
    .addOutputs(<contenttweaker:coil_v5> * 3)
    .build();

RecipeBuilder.newBuilder("g_htmp_factory_controller", "workshop", 7200)
    .addEnergyPerTickInput(30000000)
    .addInput(<contenttweaker:industrial_circuit_v4> * 24)
    .addInput(<contenttweaker:field_generator_v4> * 12)
    .addInput(<modularmachinery:high_temp_melting_factory_controller> * 64)
    .addInput(<moreplates:infinity_gear> * 2)
    .addInput(<contenttweaker:programming_circuit_f> * 1)
    .addInput(<contenttweaker:coil_v5> * 128)
    .addInput(<contenttweaker:antimatter_core> * 4)
    .addOutput(<modularmachinery:g_htmp_factory_controller>)
    .requireComputationPoint(400000.0F)
    .requireResearch("G_HTMP")
    .build();

MachineModifier.setInternalParallelism("mach_crafter", 512);