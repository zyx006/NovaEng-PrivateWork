//ALL RIGHTS RESERVED
//也许你可以对私货进行更改。

#priority 1000
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
import mods.modularmachinery.GeoMachineModel;
import mods.modularmachinery.ControllerModelAnimationEvent;

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

RecipeBuilder.newBuilder("neutron_space_force_field_constraint_framework_transverse", "workshop", 360)
    .addEnergyPerTickInput(15000)
    .addInput(<moreplates:neutronium_plate> * 64)
    .addInput(<moreplates:infinity_plate> * 8)
    .addOutput(<contenttweaker:neutron_space_force_field_constraint_framework_transverse>)
    .build();
RecipeBuilder.newBuilder("neutron_space_force_field_constraint_framework_longitudina", "workshop", 1)
    .addInput(<contenttweaker:neutron_space_force_field_constraint_framework_transverse>)
    .addOutput(<contenttweaker:neutron_space_force_field_constraint_framework_longitudinal>)
    .build();
RecipeBuilder.newBuilder("neutron_space_force_field_control_columns_longitudinal", "workshop", 360)
    .addInput(<contenttweaker:neutron_space_force_field_constraint_framework_transverse>)
    .addInput(<contenttweaker:field_generator_v4> * 8)
    .addOutput(<contenttweaker:neutron_space_force_field_control_columns_longitudinal>)
    .build();
RecipeBuilder.newBuilder("neutron_building_block", "workshop", 360)
    .addInput(<contenttweaker:neutron_space_force_field_constraint_framework_transverse>)
    .addInput(<contenttweaker:universalalloyt2> * 8)
    .addOutput(<contenttweaker:neutron_building_block>)
    .build();
RecipeBuilder.newBuilder("neutron_fiber_housing", "workshop", 360)
    .addInput(<contenttweaker:neutron_building_block>)
    .addInput(<contenttweaker:mm_ldx> * 8)
    .addOutput(<contenttweaker:neutron_fiber_housing>)
    .build();
RecipeBuilder.newBuilder("arousal_building_block", "workshop", 360)
    .addInput(<contenttweaker:neutron_building_block>)
    .addInput(<contenttweaker:mm_ldx> * 16)
    .addInput(<additions:novaextended-star_ingot> * 8)
    .addOutput(<contenttweaker:arousal_building_block>)
    .build();
RecipeBuilder.newBuilder("arousal_fiber_housing", "workshop", 360)
    .addInput(<contenttweaker:arousal_building_block>)
    .addInput(<contenttweaker:mm_ldx> * 32)
    .addInput(<contenttweaker:arkforcefieldcontrolblock> * 4)
    .addOutput(<contenttweaker:arousal_fiber_housing>)
    .build();
RecipeBuilder.newBuilder("neutron_space_force_field_control_bus", "workshop", 360)
    .addInput(<contenttweaker:neutron_space_force_field_control_columns_longitudinal>)
    .addOutput(<contenttweaker:neutron_space_force_field_control_bus>)
    .build();
RecipeBuilder.newBuilder("aw_smf_factory_controller", "workshop", 1)
    .addInput(<modularmachinery:aw_safs_factory_controller>)
    .addOutput(<modularmachinery:aw_smf_factory_controller>)
    .build();
RecipeBuilder.newBuilder("aw_safs_factory_controller", "workshop", 1)
    .addOutput(<modularmachinery:aw_safs_factory_controller>)
    .addInput(<modularmachinery:aw_smf_factory_controller>)
    .build();
RecipeBuilder.newBuilder("aw_super_machines", "ark_space_station", 3600)
    .addInput(<contenttweaker:industrial_circuit_v4> * 1024)
    .addInput(<contenttweaker:field_generator_v4> * 1024)
    .addInput(<contenttweaker:space_time_coil> * 1024)
    .addInput(<moreplates:infinity_gear> * 32)
    .addInput(<contenttweaker:coil_v5> * 16384)
    .addInput(<contenttweaker:antimatter_core> * 1024)
    .addInput(<modularmachinery:g_mt_factory_controller> * 8)
    .addInput(<modularmachinery:g_ic_factory_controller> * 8)
    .addInput(<modularmachinery:g_msm_factory_controller> * 8)
    .addInput(<modularmachinery:g_htmp_factory_controller> * 8)
    .addOutput(<modularmachinery:aw_s_msm_factory_controller>)
    .addOutput(<modularmachinery:super_compactor_factory_controller>)
    .addOutput(<modularmachinery:super_crasher_factory_controller>)
    .addOutput(<modularmachinery:aw_safs_factory_controller> * 2)
    .requireResearch("aw_start3")
    .requireComputationPoint(4000*1000.0F)
    .build();

//压缩机
RecipeBuilder.newBuilder("super_compactor_anti_viod_keeper","super_compactor",72000)
    .addInputs(<contenttweaker:anti_viod>)
    .addRecipeTooltip([
        "§9§l通过负虚空驱动复合立场发生器"
    ])
    .setParallelized(false)
    .setThreadName("§9§l复合立场发生器")
    .build();
// 合金线圈（等级 3）
RecipeBuilder.newBuilder("coil_v3_coolant_super_compactor", "super_compactor", 1)
    .addEnergyPerTickInput(64000)
    .addInput(<ore:plateDraconicMetal> * 1)
    .addOutput(<contenttweaker:coil_v3> * 3)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("§9§l尚未驱动复合立场发生器");
            return;
        }
    })
    .addRecipeTooltip([
        "§9§l通过负虚空改变物质的形态"
    ])
    .build();
// 合金线圈（等级 4）
RecipeBuilder.newBuilder("coil_v4_coolant_super_compactor", "super_compactor", 1)
    .addEnergyPerTickInput(512000)
    .addInputs(<ore:ingotFallenStarAlloy> * 1)
    .addOutputs(<contenttweaker:coil_v4> * 3)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("§9§l尚未驱动复合立场发生器");
            return;
        }
    })
    .addRecipeTooltip([
        "§9§l通过负虚空改变物质的形态"
    ])
    .build();
// 合金线圈（等级 5）
RecipeBuilder.newBuilder("coil_v5_coolant_super_compactor", "super_compactor", 1)
    .addEnergyPerTickInput(8192000)
    .addInputs(<ore:ingotArk> * 1)
    .addOutputs(<contenttweaker:coil_v5> * 3)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("§9§l尚未驱动复合立场发生器");
            return;
        }
    })
    .addRecipeTooltip([
        "§9§l通过负虚空改变物质的形态"
    ])
    .build();
RecipeAdapterBuilder.create("super_compactor", "nuclearcraft:pressurizer")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.02F, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 0.1F, 1, false).build())
    .addRecipeTooltip([
        "§9§l通过负虚空改变物质的形态"
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("§9§l尚未驱动复合立场发生器");
            return;
        }
    })
    .build();
MachineModifier.setMaxThreads("super_compactor", 0);
MachineModifier.addCoreThread("super_compactor", FactoryRecipeThread.createCoreThread("§9§l复合立场发生器").addRecipe("super_compactor_anti_viod_keeper"));
MachineModifier.addCoreThread("super_compactor", FactoryRecipeThread.createCoreThread("§9§l非接触压印系统NCI-I"));
MachineModifier.addCoreThread("super_compactor", FactoryRecipeThread.createCoreThread("§9§l非接触压印系统NCI-II"));
MachineModifier.addCoreThread("super_compactor", FactoryRecipeThread.createCoreThread("§9§l非接触压印系统NCI-III"));
MachineModifier.addCoreThread("super_compactor", FactoryRecipeThread.createCoreThread("§9§l非接触压印系统NCI-IV"));
MachineModifier.addCoreThread("super_compactor", FactoryRecipeThread.createCoreThread("§9§l非接触压印系统NCI-V"));
MachineModifier.addCoreThread("super_compactor", FactoryRecipeThread.createCoreThread("§9§l非接触压印系统NCI-VI"));
MachineModifier.addCoreThread("super_compactor", FactoryRecipeThread.createCoreThread("§9§l非接触压印系统NCI-VII"));
MachineModifier.addCoreThread("super_compactor", FactoryRecipeThread.createCoreThread("§9§l非接触压印系统NCI-VIII"));
MachineModifier.addCoreThread("super_compactor", FactoryRecipeThread.createCoreThread("§9§l非接触压印系统NCI-IX"));
MachineModifier.addCoreThread("super_compactor", FactoryRecipeThread.createCoreThread("§9§l非接触压印系统NCI-X"));
MachineModifier.addCoreThread("super_compactor", FactoryRecipeThread.createCoreThread("§9§l非接触压印系统NCI-XI"));
MachineModifier.addCoreThread("super_compactor", FactoryRecipeThread.createCoreThread("§9§l非接触压印系统NCI-XII"));
MachineModifier.addCoreThread("super_compactor", FactoryRecipeThread.createCoreThread("§9§l非接触压印系统NCI-XIII"));
MachineModifier.addCoreThread("super_compactor", FactoryRecipeThread.createCoreThread("§9§l非接触压印系统NCI-XIV"));
MachineModifier.addCoreThread("super_compactor", FactoryRecipeThread.createCoreThread("§9§l非接触压印系统NCI-XV"));
MachineModifier.addCoreThread("super_compactor", FactoryRecipeThread.createCoreThread("§9§l非接触压印系统NCI-XVI"));
MachineModifier.setInternalParallelism("super_compactor", 1073741824);
//粉碎机
RecipeBuilder.newBuilder("super_crasher_anti_viod_keeper","super_crasher",72000)
    .addInputs(<contenttweaker:anti_viod>)
    .addRecipeTooltip([
        "§9§l通过负虚空驱动奇点发生器"
    ])
    .setParallelized(false)
    .setThreadName("§9§l奇点发生器")
    .build();
# 粉碎 - 圆石
RecipeBuilder.newBuilder("super_crasher_cobblestone", "super_crasher", 2,0)
    .addEnergyPerTickInput(12800)
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0).setParallelizeUnaffected(true)
    .addItemInputs([
        <minecraft:cobblestone> * 6,
        <minecraft:cobblestone> * 6,
        <minecraft:cobblestone> * 6,
    ])
    .addOutput(<ic2:crafting:23> * 63)
    .addRecipeTooltip([
        "§9§l通过负虚空改变物质的形态"
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("§9§l尚未驱动奇点发生器");
            return;
        }
    })
    .build();

# 粉碎 - 沙子 + 海蓝宝石
RecipeBuilder.newBuilder("super_crasher_aquamarine_sandhuh", "super_crasher", 1)
    .addEnergyPerTickInput(25600)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<liquid:astralsorcery.liquidstarlight> * 16000).setChance(0)
    .addInput(<liquid:lava> * 16000).setChance(0)
    .addOutput(<minecraft:sand> * 64)
    .addOutput(<astralsorcery:itemcraftingcomponent> * 64)
    .addRecipeTooltip([
        "星能液数量和熔岩数量§c受并行影响§f，但是§a不消耗§f。",
        "§9§l通过负虚空改变物质的形态"
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("§9§l尚未驱动奇点发生器");
            return;
        }
    })
    .build();

# 粉碎 - 海蓝宝石
RecipeBuilder.newBuilder("super_crasher_aquamarine_nosand", "super_crasher", 1)
    .addEnergyPerTickInput(51200)
    .addInput(<contenttweaker:programming_circuit_c>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<liquid:astralsorcery.liquidstarlight> * 16000).setChance(0)
    .addInput(<liquid:lava> * 16000).setChance(0)
    .addOutput(<astralsorcery:itemcraftingcomponent> * 128)
    .addRecipeTooltip([
        "星能液数量和熔岩数量§c受并行影响§f，但是§a不消耗§f。",
        "§9§l通过负虚空改变物质的形态"
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("§9§l尚未驱动奇点发生器");
            return;
        }
    })
    .build();
// 基岩粉
RecipeBuilder.newBuilder("super_crasher_block_infinity", "super_crasher", 1)
    .addEnergyPerTickInput(30000)
    .addInput(<enderio:block_infinity>).setChance(0)
    .addInput(<avaritiaio:grindingballneutronium> * 32).setChance(0)
    .addOutput(<enderio:block_infinity> * 4)
    .addRecipeTooltip([
        "§9§l通过负虚空改变物质的形态"
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("§9§l尚未驱动奇点发生器");
            return;
        }
    })
    .build();

RecipeAdapterBuilder.create("super_crasher", "novaeng_core:shredder")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.025,  1, false).build())
    .addRecipeTooltip([
        "§9§l通过负虚空改变物质的形态"
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("§9§l尚未驱动奇点发生器");
            return;
        }
    })
    .build();
MachineModifier.setMaxThreads("super_crasher", 0);
MachineModifier.addCoreThread("super_crasher", FactoryRecipeThread.createCoreThread("§9§l奇点发生器").addRecipe("super_crasher_anti_viod_keeper"));
MachineModifier.addCoreThread("super_crasher", FactoryRecipeThread.createCoreThread("§9§l物质解构场MDF-I"));
MachineModifier.addCoreThread("super_crasher", FactoryRecipeThread.createCoreThread("§9§l物质解构场MDF-II"));
MachineModifier.addCoreThread("super_crasher", FactoryRecipeThread.createCoreThread("§9§l物质解构场MDF-III"));
MachineModifier.addCoreThread("super_crasher", FactoryRecipeThread.createCoreThread("§9§l物质解构场MDF-IV"));
MachineModifier.addCoreThread("super_crasher", FactoryRecipeThread.createCoreThread("§9§l物质解构场MDF-V"));
MachineModifier.addCoreThread("super_crasher", FactoryRecipeThread.createCoreThread("§9§l物质解构场MDF-VI"));
MachineModifier.addCoreThread("super_crasher", FactoryRecipeThread.createCoreThread("§9§l物质解构场MDF-VII"));
MachineModifier.addCoreThread("super_crasher", FactoryRecipeThread.createCoreThread("§9§l物质解构场MDF-VIII"));
MachineModifier.addCoreThread("super_crasher", FactoryRecipeThread.createCoreThread("§9§l物质解构场MDF-IX"));
MachineModifier.addCoreThread("super_crasher", FactoryRecipeThread.createCoreThread("§9§l物质解构场MDF-X"));
MachineModifier.addCoreThread("super_crasher", FactoryRecipeThread.createCoreThread("§9§l物质解构场MDF-XI"));
MachineModifier.addCoreThread("super_crasher", FactoryRecipeThread.createCoreThread("§9§l物质解构场MDF-XII"));
MachineModifier.addCoreThread("super_crasher", FactoryRecipeThread.createCoreThread("§9§l物质解构场MDF-XIII"));
MachineModifier.addCoreThread("super_crasher", FactoryRecipeThread.createCoreThread("§9§l物质解构场MDF-XIV"));
MachineModifier.addCoreThread("super_crasher", FactoryRecipeThread.createCoreThread("§9§l物质解构场MDF-XV"));
MachineModifier.addCoreThread("super_crasher", FactoryRecipeThread.createCoreThread("§9§l物质解构场MDF-XVI"));
MachineModifier.setInternalParallelism("super_crasher", 1073741824);
//熔化机
RecipeBuilder.newBuilder("aw_smf_anti_viod_keeper","aw_smf",72000)
    .addInputs(<contenttweaker:anti_viod>)
    .addRecipeTooltip([
        "§4§l通过负虚空驱动熵逆变引擎"
    ])
    .setParallelized(false)
    .setThreadName("§4§l熵逆变引擎")
    .build();
RecipeAdapterBuilder.create("aw_smf", "nuclearcraft:melter")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.25,  1, false).build())
    .addRecipeTooltip([
        "§4§l通过负虚空改变物质的形态"
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("§4§l尚未驱动熵逆变引擎");
            return;
        }
    })
    .addCatalystInput(<contenttweaker:mm_yzjz>,
        ["§4§l利用宇宙矩阵超越宇宙法则,或引发热寂","§9§l耗时减少50%，需求能源输入降低50%"],
        [RecipeModifierBuilder.create("modularmachinery:duration","input",0.2,1,false).build(),RecipeModifierBuilder.create("modularmachinery:energy","input",0.5,1,false).build()]
    ).setChance(0).setParallelizeUnaffected(true)
    .addCatalystInput(<forge:bucketfilled>.withTag({FluidName: "space", Amount: 1000}),
        ["§4§l宇宙之精华,内含无垠能量","§9§l耗时减少50%，需求能源输入降低50%"],
        [RecipeModifierBuilder.create("modularmachinery:duration","input",0.2,1,false).build(),RecipeModifierBuilder.create("modularmachinery:energy","input",0.5,1,false).build()]
    ).setChance(0).setParallelizeUnaffected(true)
    .build();
MachineModifier.setMaxThreads("aw_smf", 0);
MachineModifier.addCoreThread("aw_smf", FactoryRecipeThread.createCoreThread("§4§l熵逆变引擎").addRecipe("aw_smf_anti_viod_keeper"));
MachineModifier.addCoreThread("aw_smf", FactoryRecipeThread.createCoreThread("§4§l热寂模拟腔HDC-I"));
MachineModifier.addCoreThread("aw_smf", FactoryRecipeThread.createCoreThread("§4§l热寂模拟腔HDC-II"));
MachineModifier.addCoreThread("aw_smf", FactoryRecipeThread.createCoreThread("§4§l热寂模拟腔HDC-III"));
MachineModifier.addCoreThread("aw_smf", FactoryRecipeThread.createCoreThread("§4§l热寂模拟腔HDC-IV"));
MachineModifier.addCoreThread("aw_smf", FactoryRecipeThread.createCoreThread("§4§l热寂模拟腔HDC-V"));
MachineModifier.addCoreThread("aw_smf", FactoryRecipeThread.createCoreThread("§4§l热寂模拟腔HDC-VI"));
MachineModifier.addCoreThread("aw_smf", FactoryRecipeThread.createCoreThread("§4§l热寂模拟腔HDC-VII"));
MachineModifier.addCoreThread("aw_smf", FactoryRecipeThread.createCoreThread("§4§l热寂模拟腔HDC-VIII"));
MachineModifier.addCoreThread("aw_smf", FactoryRecipeThread.createCoreThread("§4§l热寂模拟腔HDC-IX"));
MachineModifier.addCoreThread("aw_smf", FactoryRecipeThread.createCoreThread("§4§l热寂模拟腔HDC-X"));
MachineModifier.addCoreThread("aw_smf", FactoryRecipeThread.createCoreThread("§4§l热寂模拟腔HDC-XI"));
MachineModifier.addCoreThread("aw_smf", FactoryRecipeThread.createCoreThread("§4§l热寂模拟腔HDC-XII"));
MachineModifier.addCoreThread("aw_smf", FactoryRecipeThread.createCoreThread("§4§l热寂模拟腔HDC-XIII"));
MachineModifier.addCoreThread("aw_smf", FactoryRecipeThread.createCoreThread("§4§l热寂模拟腔HDC-XIV"));
MachineModifier.addCoreThread("aw_smf", FactoryRecipeThread.createCoreThread("§4§l热寂模拟腔HDC-XV"));
MachineModifier.addCoreThread("aw_smf", FactoryRecipeThread.createCoreThread("§4§l热寂模拟腔HDC-XVI"));
MachineModifier.setInternalParallelism("aw_smf", 1073741824);
//高温合金枢纽
RecipeBuilder.newBuilder("aw_safs_anti_viod_keeper","aw_safs",72000)
    .addInputs(<contenttweaker:anti_viod>)
    .addRecipeTooltip([
        "§4§l通过负虚空驱动熵逆变引擎"
    ])
    .setParallelized(false)
    .setThreadName("§4§l熵逆变引擎")
    .build();
var jsq=0;
function safsRecipeBuilder(item as IIngredient[],output as IIngredient,jsq as int){
    RecipeBuilder.newBuilder("safsRecipeBuilder"+jsq,"aw_safs",20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("§4§l尚未驱动熵逆变引擎");
            return;
        }
    })
    .addCatalystInput(<contenttweaker:mm_yzjz>,
        ["§4§l利用宇宙矩阵超越宇宙法则,或引发热寂","§9§l耗时减少50%，需求能源输入降低50%"],
        [RecipeModifierBuilder.create("modularmachinery:duration","input",0.2,1,false).build(),RecipeModifierBuilder.create("modularmachinery:energy","input",1,1,false).build()]
    ).setChance(0).setParallelizeUnaffected(true)
    .addCatalystInput(<forge:bucketfilled>.withTag({FluidName: "space", Amount: 1000}),
        ["§4§l宇宙之精华,内含无垠能量","§9§l耗时减少50%，需求能源输入降低50%"],
        [RecipeModifierBuilder.create("modularmachinery:duration","input",0.2,1,false).build(),RecipeModifierBuilder.create("modularmachinery:energy","input",1,1,false).build()]
    ).setChance(0).setParallelizeUnaffected(true)
    .addInputs(item)
    .addOutput(output)
    .build();
}
safsRecipeBuilder([<taiga:eezo_ingot> * 2,<taiga:abyssum_ingot> * 2,<taiga:osram_ingot> * 2,<taiga:obsidiorite_ingot> * 9],<taiga:iox_ingot>,jsq);jsq += 1;//离金锭
safsRecipeBuilder([<taiga:eezo_ingot> * 4,<taiga:abyssum_ingot> * 4,<taiga:osram_ingot> * 4,<ore:obsidian> * 9,<taiga:meteorite_ingot> * 18],<taiga:iox_ingot>,jsq);jsq += 1;//离金锭
safsRecipeBuilder([<taiga:prometheum_ingot> * 3, <taiga:palladium_ingot> * 3,<taiga:eezo_ingot>], <taiga:proxii_ingot> * 3, jsq); jsq += 1; // 普罗克希锭
safsRecipeBuilder([<taiga:terrax_ingot> * 3, <taiga:aurorium_ingot> * 2], <taiga:astrium_ingot> * 2,  jsq); jsq += 1; // 曜金锭
safsRecipeBuilder([<taiga:proxii_ingot> * 3, <taiga:abyssum_ingot>, <taiga:osram_ingot>], <taiga:nucleum_ingot> * 3, jsq); jsq += 1; // 辐光合金锭
safsRecipeBuilder([<taiga:imperomite_ingot> * 3, <taiga:osram_ingot>, <taiga:eezo_ingot>], <taiga:nucleum_ingot> * 3.0, jsq); jsq += 1; // 辐光合金锭
safsRecipeBuilder([<taiga:niob_ingot> * 3, <taiga:eezo_ingot>, <taiga:abyssum_ingot>], <taiga:nucleum_ingot> * 3,  jsq); jsq += 1; // 辐光合金锭
safsRecipeBuilder([<taiga:tiberium_ingot> * 5, <taiga:basalt_ingot>], <taiga:triberium_ingot>,  jsq); jsq += 1; // 泰伯利安
safsRecipeBuilder([<taiga:tiberium_ingot> * 5, <taiga:dilithium_ingot> * 2], <taiga:triberium_ingot>,  jsq); jsq += 1; // 泰伯利安
safsRecipeBuilder([<tconstruct:ingots:1> * 2, <taiga:terrax_ingot> * 2, <taiga:osram_ingot>], <taiga:ignitz_ingot> * 2,  jsq); jsq += 1; // 焰晶锭
safsRecipeBuilder([<taiga:karmesine_ingot>, <taiga:ovium_ingot>, <taiga:jauxum_ingot>], <taiga:terrax_ingot> * 2,  jsq); jsq += 1; // 地母锭
safsRecipeBuilder([<taiga:duranite_ingot> * 3, <taiga:prometheum_ingot>, <taiga:abyssum_ingot>], <taiga:imperomite_ingot> * 2,  jsq); jsq += 1; // 帝金锭
safsRecipeBuilder([<taiga:iox_ingot> * 3, <taiga:solarium_ingot>, <taiga:vibranium_ingot>], <taiga:adamant_ingot> * 3,  jsq); jsq += 1; // 铿金锭
safsRecipeBuilder([<taiga:iox_ingot> * 3, <taiga:nihilite_ingot> * 2], <taiga:adamant_ingot> * 3,  jsq); jsq += 1; // 铿金锭
safsRecipeBuilder([<taiga:palladium_ingot>, <taiga:terrax_ingot>], <taiga:lumix_ingot>,  jsq); jsq += 1; // 流光合金锭
safsRecipeBuilder([<taiga:palladium_ingot> * 3, <taiga:duranite_ingot>, <taiga:osram_ingot>], <taiga:niob_ingot> * 3,  jsq); jsq += 1; // 铌锭
safsRecipeBuilder([<taiga:triberium_ingot> * 6, <ore:obsidian> * 3, <taiga:abyssum_ingot> * 2], <taiga:fractum_ingot> * 4,  jsq); jsq += 1; // 碎金锭
safsRecipeBuilder([<taiga:valyrium_ingot> * 2, <taiga:uru_ingot> * 2, <taiga:nucleum_ingot> * 1], <taiga:solarium_ingot> * 2,  jsq); jsq += 1; // 阳光合金锭
safsRecipeBuilder([<tconstruct:ingots> * 3, <taiga:terrax_ingot> * 2], <taiga:tritonite_ingot> * 2,  jsq); jsq += 1; // 漩金锭
safsRecipeBuilder([<taiga:triberium_ingot> * 3, <taiga:fractum_ingot>, <taiga:seismum_ingot>, <taiga:osram_ingot>], <taiga:dyonite_ingot> * 3,  jsq); jsq += 1; // 烈金锭
safsRecipeBuilder([<taiga:tiberium_ingot> * 12, <taiga:fractum_ingot>, <taiga:seismum_ingot>, <taiga:osram_ingot>], <taiga:dyonite_ingot> * 3,  jsq); jsq += 1; // 烈金锭
safsRecipeBuilder([<ore:obsidian> * 2, <taiga:triberium_ingot> * 2, <taiga:eezo_ingot>], <taiga:seismum_ingot> * 4,  jsq); jsq += 1; // 地动合金锭
safsRecipeBuilder([<taiga:uru_ingot> * 3, <taiga:valyrium_ingot> * 3, <taiga:osram_ingot>], <taiga:yrdeen_ingot> * 3,  jsq); jsq += 1; // 原金锭
safsRecipeBuilder([<taiga:uru_ingot> * 3, <taiga:valyrium_ingot> * 3, <taiga:eezo_ingot>], <taiga:yrdeen_ingot> * 3,  jsq); jsq += 1; // 原金锭
safsRecipeBuilder([<taiga:uru_ingot> * 3, <taiga:valyrium_ingot> * 3, <taiga:abyssum_ingot>], <taiga:yrdeen_ingot> * 3,  jsq); jsq += 1; // 原金锭
safsRecipeBuilder([<taiga:aurorium_ingot> * 3, <tconstruct:ingots:1> * 2], <taiga:violium_ingot> * 2,  jsq); jsq += 1; // 瑟蓝锭
safsRecipeBuilder([<taiga:vibranium_ingot>, <taiga:solarium_ingot>], <taiga:nihilite_ingot>,  jsq); jsq += 1; // 虚金
safsRecipeBuilder([<tconevo:material>, <liquid:ic2uu_matter> * 72], <tconevo:metal:40>,  jsq); jsq += 1; // UU金属
safsRecipeBuilder([<tconevo:material> * 16, <ic2:dust:6> * 48], <tconevo:metal:35> * 16,  jsq); jsq += 1; // 能量锭
safsRecipeBuilder([<ore:ingotManasteel> * 2,<ore:ingotDraconium> * 2,<ore:ingotCrystallineAlloy> * 6,<ore:ingotOsmium>,<ore:ingotGold>,<ore:ingotIron>,<ore:ingotCopper>,<ore:ingotTin>], <ore:ingotAlloyT1> * 2,  jsq); jsq += 1; // 基础通用合金
safsRecipeBuilder([<ore:ingotAlloyT1>,<ore:ingotCrystallineAlloy> * 8,<thermalfoundation:material:134> * 12],<ore:ingotBlueAlloy> * 6,  jsq); jsq += 1; // 蓝晶合金
safsRecipeBuilder([<ore:ingotTinSilver> * 4,<ore:dustRedstone> * 8,<ore:ingotBoron> * 2],<modularmachinery:itemmodularium> * 6,  jsq); jsq += 1; // 模块化合金
safsRecipeBuilder([<ore:oreClathrateEnder>*16],<minecraft:ender_pearl> * 64,  jsq); jsq += 1; // 末影珍珠
safsRecipeBuilder([<ore:clathrateEnder>*16],<minecraft:ender_pearl>*16,  jsq); jsq += 1; // 末影珍珠
safsRecipeBuilder([<ore:dustCoal>,<ore:dustFluix>,<ore:ingotIron>],<ore:ingotFluixSteel>,  jsq); jsq += 1;//福鲁伊克斯钢
safsRecipeBuilder([<tconevo:material>,<draconicevolution:wyvern_core>,<ore:blockRedstone>,<ore:gemDiamond>*2],<tconevo:metal>,jsq);jsq += 1;
safsRecipeBuilder([<tconevo:material>,<draconicevolution:awakened_core>,<draconicevolution:wyvern_energy_core>,<minecraft:nether_star>*2],<tconevo:metal:5>,jsq);jsq += 1;
safsRecipeBuilder([<tconevo:material>,<ore:ingotOrichalcos>,<ore:ingotTerrasteel>],<additions:novaextended-terraalloy>,jsq);jsq += 1;
safsRecipeBuilder([<additions:novaextended-terraalloy>,<additions:novaextended-blue_alloy_ingot>,<additions:novaextended-psi_alloy>,<draconicevolution:chaos_shard:1>*2,<appliedenergistics2:material:45>*4],<additions:novaextended-fallen_star_alloy>,jsq);jsq += 1;
safsRecipeBuilder([<tconevo:material>,<draconicevolution:chaotic_core>,<draconicevolution:draconic_energy_core>,<minecraft:dragon_egg>*2],<tconevo:metal:10>,jsq);jsq += 1;
safsRecipeBuilder([<draconicevolution:draconium_block> * 4,<draconicevolution:dragon_heart>,<draconicevolution:draconic_core>*6,<liquid:liquid_energy>*2],<draconicevolution:draconic_block>*4,jsq);jsq += 1;
MachineModifier.setMaxThreads("aw_safs", 0);
MachineModifier.addCoreThread("aw_safs", FactoryRecipeThread.createCoreThread("§4§l熵逆变引擎").addRecipe("aw_safs_anti_viod_keeper"));
MachineModifier.addCoreThread("aw_safs", FactoryRecipeThread.createCoreThread("§4§l热寂模拟腔HDC-I"));
MachineModifier.addCoreThread("aw_safs", FactoryRecipeThread.createCoreThread("§4§l热寂模拟腔HDC-II"));
MachineModifier.addCoreThread("aw_safs", FactoryRecipeThread.createCoreThread("§4§l热寂模拟腔HDC-III"));
MachineModifier.addCoreThread("aw_safs", FactoryRecipeThread.createCoreThread("§4§l热寂模拟腔HDC-IV"));
MachineModifier.addCoreThread("aw_safs", FactoryRecipeThread.createCoreThread("§4§l热寂模拟腔HDC-V"));
MachineModifier.addCoreThread("aw_safs", FactoryRecipeThread.createCoreThread("§4§l热寂模拟腔HDC-VI"));
MachineModifier.addCoreThread("aw_safs", FactoryRecipeThread.createCoreThread("§4§l热寂模拟腔HDC-VII"));
MachineModifier.addCoreThread("aw_safs", FactoryRecipeThread.createCoreThread("§4§l热寂模拟腔HDC-VIII"));
MachineModifier.addCoreThread("aw_safs", FactoryRecipeThread.createCoreThread("§4§l热寂模拟腔HDC-IX"));
MachineModifier.addCoreThread("aw_safs", FactoryRecipeThread.createCoreThread("§4§l热寂模拟腔HDC-X"));
MachineModifier.addCoreThread("aw_safs", FactoryRecipeThread.createCoreThread("§4§l热寂模拟腔HDC-XI"));
MachineModifier.addCoreThread("aw_safs", FactoryRecipeThread.createCoreThread("§4§l热寂模拟腔HDC-XII"));
MachineModifier.addCoreThread("aw_safs", FactoryRecipeThread.createCoreThread("§4§l热寂模拟腔HDC-XIII"));
MachineModifier.addCoreThread("aw_safs", FactoryRecipeThread.createCoreThread("§4§l热寂模拟腔HDC-XIV"));
MachineModifier.addCoreThread("aw_safs", FactoryRecipeThread.createCoreThread("§4§l热寂模拟腔HDC-XV"));
MachineModifier.addCoreThread("aw_safs", FactoryRecipeThread.createCoreThread("§4§l热寂模拟腔HDC-XVI"));
MachineModifier.setInternalParallelism("aw_safs", 1073741824);
//虚空万藏
RecipeBuilder.newBuilder("safs_xkwz", "aw_safs", 1)
    .addInput(<minecraft:book>)
    .addOutput(<extrabotany:buddhistrelics>)
    .addRecipeTooltip([
        "§9§l通过负虚空改变物质的形态",
        "§9§l补对,这是什么,你改变成什么了?,wtf?"
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("§4§l尚未驱动熵逆变引擎");
            return;
        }
    })
    .build();
//屠宰厂
RecipeBuilder.newBuilder("aw_s_msm_anti_viod_keeper","aw_s_msm",72000)
    .addInputs(<contenttweaker:anti_viod>)
    .addInputs(<botania_tweaks:compressed_tiny_potato_8>)
    .addInputs(<avaritia:ultimate_stew> * 16384)
    .addRecipeTooltip([
        "§3§l通过负虚空驱动自指核心"
    ])
    .setParallelized(false)
    .setThreadName("§3§l自指核心")
    .build();
RecipeBuilder.newBuilder("aw_s_msm", "aw_s_msm", 1)
    .addEnergyPerTickInput(1024576)
    .addInput(<eternalsingularity:eternal_singularity>)
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
    .addOutput(<botania:manaresource:5> * 64)
    .addOutput(<extrabotany:material:3>)
    .addOutput(<botania:manaresource> * 16)
    .addOutput(<botania:managlass> * 16)
    .addOutput(<botania:quartz:1> * 16)
    .addOutput(<botania:manaresource:2> * 16)
    .addOutput(<botania:manaresource:23> * 16)
    .addOutput(<botania:manaresource:1> * 16)
    .addOutput(<extrabotany:buddhistrelics>).setChance(0.1)
    .addOutput(<enderio:item_material:20> * 64)
    .addOutput(<thermalfoundation:material:770> * 64)
    .addRecipeTooltip([
        "§3§l通过展开奇点创造一个微型宇宙并给予智能自迭代"
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("§3§l尚未驱动自指核心");
            return;
        }
    })
    .build();
MachineModifier.setInternalParallelism("aw_s_msm", 8192);
MachineModifier.setMaxThreads("aw_s_msm", 0);
MachineModifier.addCoreThread("aw_s_msm", FactoryRecipeThread.createCoreThread("§3§l自指核心").addRecipe("aw_s_msm_anti_viod_keeper"));
MachineModifier.addCoreThread("aw_s_msm", FactoryRecipeThread.createCoreThread("§3§l超限训练场TTG").addRecipe("aw_s_msm"));

//----------------------------------------------------------------------------------------------------------===自递归神经网络
GeoMachineModel.registerGeoMachineModel("miniature_cosmic_resource_collector", // 自递归神经网络
    "modularmachinery:geo/miniature_cosmic_resource_collector.geo.json", // geo模型文件路径
    "modularmachinery:textures/miniature_cosmic_resource_collector.png", // 模型贴图路径
    "modularmachinery:animations/miniature_cosmic_resource_collector.animation.json" // animation模型动画路径
);

MachineModifier.setMachineGeoModel("aw_s_msm", "miniature_cosmic_resource_collector");

MMEvents.onControllerModelAnimation("aw_s_msm", function(event as ControllerModelAnimationEvent) {
    // 为"安装"状态设置动画 "installation"单次
    event.addAnimation("installation_off");
    event.addAnimation("installation_load_00");
    event.addAnimation("installation_load_01");
    event.addAnimation("installation_load_02");
    event.addAnimation("installation_load_03");
    event.addAnimation("installation_load_04");
    event.addAnimation("installation_load_00");

    val ctrl = event.controller;
    event.addAnimation("run_04", true);
});
RecipeBuilder.newBuilder("aw_super_odal", "ark_space_station", 3600)
    .addInput(<contenttweaker:industrial_circuit_v4> * 128)
    .addInput(<contenttweaker:field_generator_v4> * 64)
    .addInput(<contenttweaker:space_time_coil> * 16)
    .addInput(<moreplates:infinity_gear> * 32)
    .addInput(<contenttweaker:coil_v5> * 1024)
    .addInput(<contenttweaker:antimatter_core> * 64)
    .addInput(<modularmachinery:odal_ar_factory_controller> * 2)
    .addOutput(<modularmachinery:super_fucking_odal_factory_controller>)
    .requireResearch("aw_start3")
    .requireComputationPoint(4000*1000.0F)
    .build();
//创世
RecipeBuilder.newBuilder("aw_odal_anti_viod_keeper","super_fucking_odal",72000)
    .addInputs(<contenttweaker:anti_viod>)
    .addInputs(<botania_tweaks:compressed_tiny_potato_8>)
    .addRecipeTooltip([
        "§3§l通过负虚空驱动跨维锻造核心"
    ])
    .setParallelized(false)
    .setThreadName("§3§l跨维锻造核心")
    .build();
//力场发生器（等级 4）
RecipeBuilder.newBuilder("field_generator_v4_super_fucking_odal", "super_fucking_odal", 1)
    .addInputs([
        <contenttweaker:industrial_circuit_v4> * 2,
        <ore:circuitArk> * 2,
        <contenttweaker:coil_v5> * 4,
        <draconicevolution:chaotic_core> * 2,
        <avaritiatweaks:enhancement_crystal> * 1,
    ])
    .addRecipeTooltip([
        "§3§l通过创世之力将原子重新排列"
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("§3§l尚未驱动跨维锻造核心");
            return;
        }
    })
    .addOutputs(<contenttweaker:field_generator_v4> * 2)
    .build();

//工程控制电路（等级 4）
RecipeBuilder.newBuilder("industrial_circuit_v4_super_fucking_odal", "super_fucking_odal", 1)
    .addInputs([
        <ore:circuitArk> * 4,
        <ore:ingotInfinity> * 2,
        <ore:plateChaoticMetal> * 2,
        <avaritiatweaks:enhancement_crystal> * 1,
    ])
    .addOutputs(<contenttweaker:industrial_circuit_v4> * 4)
    .addRecipeTooltip([
        "§3§l通过创世之力将原子重新排列"
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("§3§l尚未驱动跨维锻造核心");
            return;
        }
    })
    .build();

//传感器（等级 5）
RecipeBuilder.newBuilder("sensor_v5_super_fucking_odal", "super_fucking_odal", 1)
    .addInputs([
        <ore:circuitArk> * 1,
        <contenttweaker:industrial_circuit_v4> * 1,
        <ore:stickWillowalloy> * 2,
        <ore:ingotInfinity> * 1,
        <ebwizardry:astral_diamond> * 1,
        <environmentaltech:aethium_crystal>
    ])
    .addOutputs(<contenttweaker:sensor_v5> * 2)
    .addRecipeTooltip([
        "§3§l通过创世之力将原子重新排列"
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("§3§l尚未驱动跨维锻造核心");
            return;
        }
    })
    .build();

//电动马达（等级 5）
RecipeBuilder.newBuilder("electric_motor_v5_super_fucking_odal", "super_fucking_odal", 1)
    .addInputs([
        <contenttweaker:coil_v5> * 2,
        <ore:plateChaoticMetal> * 2,
        <contenttweaker:industrial_circuit_v4> * 1,
        <ore:ingotInfinity> * 1,
    ])
    .addOutputs(<contenttweaker:electric_motor_v5> * 1)
    .addRecipeTooltip([
        "§3§l通过创世之力将原子重新排列"
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("§3§l尚未驱动跨维锻造核心");
            return;
        }
    })
    .build();

//机械臂（等级 5）
RecipeBuilder.newBuilder("robot_arm_v5_super_fucking_odal", "super_fucking_odal", 1)
    .addInputs([
        <contenttweaker:electric_motor_v5> * 2,
        <ore:ingotInfinity> * 1,
        <contenttweaker:industrial_circuit_v4> * 1,
    ])
    .addOutputs(<contenttweaker:robot_arm_v5> * 1)
    .addRecipeTooltip([
        "§3§l通过创世之力将原子重新排列"
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("§3§l尚未驱动跨维锻造核心");
            return;
        }
    })
    .build();

//方舟力场控制矩阵
RecipeBuilder.newBuilder("arkforcefieldcontrolblock_super_fucking_odal", "super_fucking_odal", 1)
    .addInput(<ore:ingotArk> * 8)
    .addInput(<contenttweaker:arkmachineblock> * 2)
    .addInput(<contenttweaker:coil_v5> * 12)
    .addInput(<contenttweaker:field_generator_v4> * 12)
    .addInput(<contenttweaker:sensor_v5> * 2)
    .addInput(<contenttweaker:infinity_wire> * 18)
    .addOutput(<contenttweaker:arkforcefieldcontrolblock> * 2)
    .addRecipeTooltip([
        "§3§l通过创世之力将原子重新排列"
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("§3§l尚未驱动跨维锻造核心");
            return;
        }
    })
    .build();

//超量子控制电路
RecipeBuilder.newBuilder("ark_circuit_super_fucking_odal", "super_fucking_odal", 1)
    .addItemInputs([
        <avaritia:resource:5> * 1,
        <contenttweaker:infinity_processor> * 8,
        <ore:ingotArk> * 2,
        <ore:ingotAlloyT2> * 1,
        <appliedenergistics2:material:47> * 2,
    ])
    .addOutput(<additions:novaextended-ark_circuit> * 8)
    .addRecipeTooltip([
        "§3§l通过创世之力将原子重新排列"
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("§3§l尚未驱动跨维锻造核心");
            return;
        }
    })
    .build();

//超级煲
RecipeBuilder.newBuilder("arc_ultimate_stew_super_fucking_odal", "super_fucking_odal", 1)
    .addInput(<avaritia:ultimate_stew>).setChance(0)
    .addOutput(<avaritia:ultimate_stew>)
    .addRecipeTooltip([
        "§3§l通过创世之力将原子重新排列"
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("§3§l尚未驱动跨维锻造核心");
            return;
        }
    })
    .build();

//终望珍珠
RecipeBuilder.newBuilder("arc_endest_pearl_super_fucking_odal", "super_fucking_odal", 1)
    .addInput(<minecraft:ender_eye> * 1)
    .addOutput(<avaritia:endest_pearl> * 1)
    .addRecipeTooltip([
        "§3§l通过创世之力将原子重新排列"
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("§3§l尚未驱动跨维锻造核心");
            return;
        }
    })
    .build();

//方舟锭
RecipeBuilder.newBuilder("arc_ark_ingot_super_fucking_odal", "super_fucking_odal", 1)
    .addItemInputs([
        <ore:ingotInfinity>
    ])
    .addInput(<contenttweaker:crystalpurple> * 1)
    .addOutput(<additions:novaextended-star_ingot> * 2)
    .addRecipeTooltip([
        "§3§l通过创世之力将原子重新排列"
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("§3§l尚未驱动跨维锻造核心");
            return;
        }
    })
    .build();

//紫色异世界水晶碎片
RecipeBuilder.newBuilder("arc_exotic_crystal_super_fucking_odal", "super_fucking_odal", 1)
    .addInput(<ore:gemCrystalRed> * 1).setChance(0)
    .addOutput(<contenttweaker:crystalpurple> * 1048576)
    .addRecipeTooltip([
        "§3§l通过创世之力将原子重新排列"
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("§3§l尚未驱动跨维锻造核心");
            return;
        }
    })
    .build();
//燃料
RecipeBuilder.newBuilder("fuel_1_super_fucking_odal", "super_fucking_odal", 1)
    .addInput(<contenttweaker:energized_fuel_v1>)
    .addOutput(<contenttweaker:energized_fuel_v2>)
    .addRecipeTooltip([
        "§3§l通过创世之力将原子重新排列"
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("§3§l尚未驱动跨维锻造核心");
            return;
        }
    })
    .build();
RecipeBuilder.newBuilder("fuel_2_super_fucking_odal", "super_fucking_odal", 1)
    .addInput(<contenttweaker:energized_fuel_v2>)
    .addOutput(<contenttweaker:energized_fuel_v3>)
    .addRecipeTooltip([
        "§3§l通过创世之力将原子重新排列"
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("§3§l尚未驱动跨维锻造核心");
            return;
        }
    })
    .build();
RecipeBuilder.newBuilder("fuel_3_super_fucking_odal", "super_fucking_odal", 1)
    .addInput(<contenttweaker:energized_fuel_v3>)
    .addOutput(<contenttweaker:energized_fuel_v4>)
    .addRecipeTooltip([
        "§3§l通过创世之力将原子重新排列"
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("§3§l尚未驱动跨维锻造核心");
            return;
        }
    })
    .build();
RecipeBuilder.newBuilder("fuel_4_super_fucking_odal", "super_fucking_odal", 1)
    .addInput(<contenttweaker:graphene>)
    .addOutput(<contenttweaker:energized_fuel_v1>)
    .addRecipeTooltip([
        "§3§l通过创世之力将原子重新排列"
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("§3§l尚未驱动跨维锻造核心");
            return;
        }
    })
    .build();
//超维度搅拌
RecipeBuilder.newBuilder("space_liquid_super_fucking_odal", "super_fucking_odal",1)
        .addInput(<contenttweaker:anti_viod> * 1)
        .addInput(<avaritia:resource:6> * 1048576)
        .addInput(<liquid:yzs> * 4000)
        .addInput(<liquid:baxwz> * 25000)
        .addInput(<liquid:haxwz> * 15000)
        .addOutput(<liquid:space> * 1000)
        .addRecipeTooltip([
            "§l能量消耗:10Zrf/tick"
        ])
        .build();
RecipeBuilder.newBuilder("bylt_liquid_super_fucking_odal", "super_fucking_odal",1)
        .addInput(<contenttweaker:anti_viod> * 1)
        .addInput(<liquid:hxwz> * 50000)
        .addInput(<liquid:space_time_fluids> * 25000)
        .addOutput(<liquid:bylt> * 1000)
        .addRecipeTooltip([
            "§l能量消耗:10Zrf/tick"
        ])
        .build();
RecipeBuilder.newBuilder("yh_liquid_super_fucking_odal", "super_fucking_odal",1)
        .addInput(<contenttweaker:anti_viod> * 4)
        .addInput(<liquid:space> * 5000)
        .addInput(<liquid:bylt> * 5000)
        .addInput(<liquid:hxwz> * 40000)
        .addOutput(<liquid:yh> * 100)
        .addRecipeTooltip([
            "§l能量消耗:40Zrf/tick"
        ])
        .build();
//卓越符文
RecipeBuilder.newBuilder("pmc_item_super_fucking_odal", "super_fucking_odal",7200)
        .addInput(<contenttweaker:anti_viod> * 72)
        .addInput(<contenttweaker:stellaris_alloy> * 1024)
        .addInput(<contenttweaker:stellaris_crystal> * 1024)
        .addInput(<contenttweaker:stellaris_gas> * 1024)
        .addInput(<contenttweaker:stellaris_darkmatter> * 16)
        .addInput(<liquid:yh> * 1)
        .addOutput(<contenttweaker:aw_pmc>)
        .addRecipeTooltip([
            "§l能量消耗:720Erf/tick",
            "§l共计:720Zrf"
        ])
        .build();
//宇宙矩阵
RecipeBuilder.newBuilder("yzjz_super_fucking_odal", "super_fucking_odal", 1)
        .addInput(<contenttweaker:anti_viod> * 1)
        .addInput(<contenttweaker:space_time_condensation_block> * 1024)
        .addInput(<avaritia:block_resource:1> * 16384)
        .addInput(<mekanism:antimatterpellet> * 1048576)
        .addOutput(<contenttweaker:mm_yzjz> * 1)
        .addOutput(<contenttweaker:polymer_matter> * 1)
        .addRecipeTooltip([
                "§m§a究§b极§c悖§d论",
                "§l能量消耗:10Zrf/tick"
            ])
        .build();
MachineModifier.setInternalParallelism("super_fucking_odal", 1048576);
MachineModifier.setMaxThreads("super_fucking_odal", 0);
MachineModifier.addCoreThread("super_fucking_odal", FactoryRecipeThread.createCoreThread("§3§l跨维锻造核心").addRecipe("aw_odal_anti_viod_keeper"));
MachineModifier.addCoreThread("super_fucking_odal", FactoryRecipeThread.createCoreThread("§3§l因果印记KI-I"));
MachineModifier.addCoreThread("super_fucking_odal", FactoryRecipeThread.createCoreThread("§3§l因果印记KI-II"));
MachineModifier.addCoreThread("super_fucking_odal", FactoryRecipeThread.createCoreThread("§3§l因果印记KI-III"));
MachineModifier.addCoreThread("super_fucking_odal", FactoryRecipeThread.createCoreThread("§3§l因果印记KI-IV"));
MachineModifier.addCoreThread("super_fucking_odal", FactoryRecipeThread.createCoreThread("§3§l因果印记KI-V"));
MachineModifier.addCoreThread("super_fucking_odal", FactoryRecipeThread.createCoreThread("§3§l因果印记KI-VI"));
MachineModifier.addCoreThread("super_fucking_odal", FactoryRecipeThread.createCoreThread("§3§l因果印记KI-VII"));
MachineModifier.addCoreThread("super_fucking_odal", FactoryRecipeThread.createCoreThread("§3§l因果印记KI-VIII"));
MachineModifier.addCoreThread("super_fucking_odal", FactoryRecipeThread.createCoreThread("§3§l因果印记KI-IX"));
MachineModifier.addCoreThread("super_fucking_odal", FactoryRecipeThread.createCoreThread("§3§l因果印记KI-X"));
MachineModifier.addCoreThread("super_fucking_odal", FactoryRecipeThread.createCoreThread("§3§l因果印记KI-XI"));
MachineModifier.addCoreThread("super_fucking_odal", FactoryRecipeThread.createCoreThread("§3§l因果印记KI-XII"));
MachineModifier.addCoreThread("super_fucking_odal", FactoryRecipeThread.createCoreThread("§3§l因果印记KI-XIII"));
MachineModifier.addCoreThread("super_fucking_odal", FactoryRecipeThread.createCoreThread("§3§l因果印记KI-XIV"));
MachineModifier.addCoreThread("super_fucking_odal", FactoryRecipeThread.createCoreThread("§3§l因果印记KI-XV"));
MachineModifier.addCoreThread("super_fucking_odal", FactoryRecipeThread.createCoreThread("§3§l因果印记KI-XVI"));
//舰载机配方
RecipeBuilder.newBuilder("aw_ship_board_ship_mk2", "ark_space_station", 3600)
    .addInput(<contenttweaker:industrial_circuit_v4> * 128)
    .addInput(<contenttweaker:field_generator_v4> * 64)
    .addInput(<contenttweaker:space_time_coil> * 16)
    .addInput(<moreplates:infinity_gear> * 32)
    .addInput(<contenttweaker:coil_v5> * 1024)
    .addInput(<contenttweaker:antimatter_core> * 64)
    .addInput(<contenttweaker:stellaris_shipboard_ship> * 2)
    .addOutput(<contenttweaker:stellaris_shipboard_ship_mk2>)
    .requireResearch("aw_start3")
    .requireComputationPoint(4000*1000.0F)
    .build();
RecipeBuilder.newBuilder("aw_ship_board_ship_mk3", "ark_space_station", 3600)
    .addInput(<contenttweaker:aw_pmc> * 2)
    .addInput(<contenttweaker:stellaris_shipboard_ship_mk2>)
    .addOutput(<contenttweaker:stellaris_shipboard_ship_mk3>)
    .requireResearch("aw_start3")
    .requireComputationPoint(4000*1000.0F)
    .build();
HyperNetHelper.proxyMachineForHyperNet("ark_space_station");
//解包
RecipeBuilder.newBuilder("super_compactor_alloy","super_compactor",1)
    .addOutput(<minecraft:gold_ingot> * 1048576)
    .addOutput(<minecraft:iron_ingot> * 1048576)
    .addOutput(<minecraft:dye:4> * 1048576)
    .addOutput(<minecraft:diamond> * 1048576)
    .addOutput(<minecraft:redstone> * 1048576)
    .addOutput(<minecraft:emerald> * 1048576)
    .addOutput(<minecraft:quartz> * 1048576)
    .addOutput(<minecraft:coal> * 1048576)
    .addOutput(<thermalfoundation:material:128> * 1048576)
    .addOutput(<thermalfoundation:material:129> * 1048576)
    .addOutput(<thermalfoundation:material:130> * 1048576)
    .addOutput(<thermalfoundation:material:131> * 1048576)
    .addOutput(<thermalfoundation:material:132> * 1048576)
    .addOutput(<thermalfoundation:material:133> * 1048576)
    .addOutput(<thermalfoundation:material:134> * 1048576)
    .addOutput(<thermalfoundation:material:135> * 1048576)
    .addOutput(<thermalfoundation:material:136> * 1048576)
    .addOutput(<ic2:ingot:8> * 1048576)
    .addOutput(<draconicevolution:draconium_ingot> * 1048576)
    .addOutput(<biomesoplenty:gem:0> * 1048576)
    .addOutput(<biomesoplenty:gem:1> * 1048576)
    .addOutput(<biomesoplenty:gem:2> * 1048576)
    .addOutput(<biomesoplenty:gem:3> * 1048576)
    .addOutput(<biomesoplenty:gem:4> * 1048576)
    .addOutput(<biomesoplenty:gem:5> * 1048576)
    .addOutput(<biomesoplenty:gem:6> * 1048576)
    .addOutput(<biomesoplenty:gem:7> * 1048576)
    .addOutput(<ore:ingotThorium> * 1048576)
    .addOutput(<ore:ingotBoron> * 1048576)
    .addOutput(<ore:ingotMagnesium> * 1048576)
    .addOutput(<ore:ingotManganese> * 1048576)
    .addOutput(<additions:novaextended-ingot8> * 1048576)
    .addOutput(<taiga:dilithium_ingot> * 1048576)
    .addOutput(<libvulpes:productingot:7> * 1048576)
    .addOutput(<tconstruct:ingots:0> * 1048576)
    .addOutput(<tconstruct:ingots:1> * 1048576)
    .addOutput(<appliedenergistics2:material:0> * 1048576)
    .addOutput(<appliedenergistics2:material:1> * 1048576)
    .addOutput(<mekanism:ingot:1> * 1048576)
    .addOutput(<mekanism:fluoriteclump> * 1048576)
    .addOutput(<futuremc:netherite_scrap> * 1048576)
    .addOutput(<rftools:dimensional_shard> * 1048576)
    .addOutput(<ore:gemQuartzBlack> * 1048576)
    .addOutput(<astralsorcery:itemcraftingcomponent:1> * 1048576)
    .addOutput(<astralsorcery:itemcraftingcomponent:0> * 1048576)
    .addOutput(<thermalfoundation:material:132> * 1048576)
    .addOutput(<taiga:aurorium_ingot> * 1048576)
    .addOutput(<taiga:palladium_ingot> * 1048576)
    .addOutput(<taiga:prometheum_ingot> * 1048576)
    .addOutput(<taiga:valyrium_ingot> * 1048576)
    .addOutput(<taiga:vibranium_ingot> * 1048576)
    .addOutput(<taiga:osram_ingot> * 1048576)
    .addOutput(<taiga:eezo_ingot> * 1048576)
    .addOutput(<taiga:uru_ingot> * 1048576)
    .addOutput(<taiga:duranite_ingot> * 1048576)
    .addOutput(<taiga:karmesine_ingot> * 1048576)
    .addOutput(<taiga:abyssum_ingot> * 1048576)
    .addOutput(<taiga:tiberium_ingot> * 1048576)
    .addOutput(<taiga:jauxum_ingot> * 1048576)
    .addOutput(<taiga:ovium_ingot> * 1048576)
    .addOutput(<taiga:obsidiorite_ingot> * 1048576)
    .addOutput(<taiga:meteorite_ingot> * 1048576)
    .addOutput(<appliedenergistics2:sky_stone_block> * 1048576)
    .addOutput(<contenttweaker:fragments_of_the_space_time_continuum> * 16384)
    .addOutput(<avaritia:resource:5> * 128)
    .addInput(<contenttweaker:stellaris_alloy> * 1)
    .build();
RecipeBuilder.newBuilder("super_compactor_crystal","super_compactor",1)
    .addOutput(<environmentaltech:litherite_crystal> * 1048576)
    .addOutput(<environmentaltech:erodium_crystal> * 1048576)
    .addOutput(<environmentaltech:lonsdaleite_crystal> * 1048576)
    .addOutput(<environmentaltech:kyronite_crystal> * 1048576)
    .addOutput(<environmentaltech:pladium_crystal> * 1048576)
    .addOutput(<environmentaltech:ionite_crystal> * 1048576)
    .addOutput(<environmentaltech:aethium_crystal> * 1048576)
    .addOutput(<ebwizardry:magic_crystal:1> * 1048576)
    .addOutput(<ebwizardry:magic_crystal:2> * 1048576)
    .addOutput(<ebwizardry:magic_crystal:3> * 1048576)
    .addOutput(<ebwizardry:magic_crystal:4> * 1048576)
    .addOutput(<ebwizardry:magic_crystal:5> * 1048576)
    .addOutput(<ebwizardry:magic_crystal:6> * 1048576)
    .addOutput(<ebwizardry:magic_crystal:7> * 1048576)
    .addOutput(<contenttweaker:fragments_of_the_space_time_continuum> * 16384)
    .addOutput(<avaritia:resource:5> * 128)
    .addInput(<contenttweaker:stellaris_crystal> * 1)
    .build();
RecipeBuilder.newBuilder("super_compactor_quasar_energy","super_compactor",1)
    .addOutput(<contenttweaker:quasar_energy> * 4000)
    .addInput(<contenttweaker:anti_viod> * 1)
    .build();
//Pt(铂)=Potato+Tomato
<thermalfoundation:material:134>.addTooltip("§ePt");
RecipeBuilder.newBuilder("pt_p_t","dptf_spc",1)
    .addOutput(<botania_tweaks:compressed_tiny_potato_8> * 1073741824)
    .addOutput(<harvestcraft:tomatoitem> * 1073741824)
    .addInput(<thermalfoundation:material:134> * 1)
    .addRecipeTooltip([
        "§9§l通过时空线圈。。。算了编不下去了",
        "那我问你那我问你",
        "Pt(铂)=Potato(土豆)+Tomato(番茄)",
    ])
    .build();
//Melons.gif(指1G西瓜) =Mg(镁)+Li(锂)+Fe(铁)+O(氧)+Sn(锡)
<nuclearcraft:ingot:7>.addTooltip("§eMg");
<nuclearcraft:ingot:6>.addTooltip("§eLi");
<minecraft:iron_ingot>.addTooltip("§eFe");
<thermalfoundation:material:129>.addTooltip("§eSn");
RecipeBuilder.newBuilder("melon_melon_fuck_you","dptf_spc",1)
    .addOutput(<minecraft:melon_block> * 1073741824)
    .addInput(<nuclearcraft:ingot:7> * 1)
    .addInput(<nuclearcraft:ingot:6> * 1)
    .addInput(<minecraft:iron_ingot> * 1)
    .addInput(<thermalfoundation:material:129> * 1)
    .addInput(<liquid:oxygen> * 1000)
    .addRecipeTooltip([
        "§9§l通过时空线圈。。。算了编不下去了",
        "那我问你那我问你",
        "Melons.gif(指1G西瓜) =Mg(镁)+Li(锂)+Fe(铁)+O(氧)+Sn(锡)",
    ])
    .build();