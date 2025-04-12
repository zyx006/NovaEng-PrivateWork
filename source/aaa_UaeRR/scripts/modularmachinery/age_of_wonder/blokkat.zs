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
import mods.modularmachinery.ControllerGUIRenderEvent;

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

MMEvents.onControllerGUIRender("blokkat",function(event as ControllerGUIRenderEvent){
    val ctrl = event.controller;
    val world = ctrl.world;
    val data = ctrl.customData;
    val dData = D(data);
    val frame = dData.getInt("frame",0);
    val strike = dData.getInt("strike",0);
    val system = dData.getInt("system",0);
    var info as string[] = [];
    info += "§a§lECO-R'收割行动'控制台";
    info += "§5§l超维框架§f数量    ："+frame+"§5§l/64§f"+"|§a§lECO-D§f数量:"+strike+"§a§l/1048576§f";
    info += "§c§l已收割星系§f数量    ："+system+"§c§l/1073741824";
    info += "§8§lAge of Wonder Reap Action Controller V1.0.";
    event.extraInfo = info;
});
<modularmachinery:blokkat_factory_controller>.addTooltip("§a§l关于收割:");
<modularmachinery:blokkat_factory_controller>.addTooltip("§a§l‘收割’是一种将任何星体通过'ECO-QD(Quasar Destroyer)'将星体降维指0维并收纳至超维框架");
<modularmachinery:blokkat_factory_controller>.addTooltip("§a§l关于ECO-QD");
<modularmachinery:blokkat_factory_controller>.addTooltip("§a§lECO-QD是ECO实验室在星海10721年研发出的基于内置类星体及开采者的武器");
<modularmachinery:blokkat_factory_controller>.addTooltip("§a§l通过类星体的巨大引力施加至敌方舰船或星体至上,这股能量也被工作人员成为'亿万烈阳之怒'");
<modularmachinery:blokkat_factory_controller>.addTooltip("§l创造me元件jei标记控制器获取");
<contenttweaker:stellaris_shipboard_ship_mk3>.addTooltip("§a§l归墟引弦MK-IV:您无权查看ECO-T22及以上档案");
<contenttweaker:stellaris_shipboard_ship_mk3>.addTooltip("§a§l'你要相信我,收割这个概念绝对不是从群星mod订阅量第二名里的最强天灾获得的'————芙提雅如是说");
MachineModifier.addCoreThread("blokkat", FactoryRecipeThread.createCoreThread("§a§lECO-D格纳库"));
MachineModifier.addCoreThread("blokkat", FactoryRecipeThread.createCoreThread("§a§l'收割行动'船坞"));
MachineModifier.addCoreThread("blokkat", FactoryRecipeThread.createCoreThread("§a§l'收割行动'监控"));
MachineModifier.addCoreThread("blokkat", FactoryRecipeThread.createCoreThread("§a§l'收割行动'物资接收器"));
MachineModifier.setMaxThreads("blokkat",0);
MachineModifier.setInternalParallelism("blokkat", 1073741824);
RecipeBuilder.newBuilder("aw_ship_board_ship_mk4", "ark_space_station", 3600)
    .addInput(<contenttweaker:aw_pmc_pro> * 2)
    .addInput(<contenttweaker:stellaris_shipboard_ship_mk3> * 2)
    .addInput(<contenttweaker:mm_yzjz> * 4)
    .addInput(<contenttweaker:polymer_matter> * 4)
    .addOutput(<contenttweaker:stellaris_shipboard_ship_mk4>)
    .requireResearch("aw_start3")
    .requireComputationPoint(4000*1000.0F)
    .build();
RecipeBuilder.newBuilder("blokkat_frame", "ark_space_station", 3600)
    .addInput(<contenttweaker:aw_pmc_pro> * 4)
    .addInput(<contenttweaker:tyf3> * 2)
    .addInput(<contenttweaker:mm_jgjz>)
    .addInput(<contenttweaker:mm_yzjz> * 2)
    .addInput(<contenttweaker:polymer_matter> * 2)
    .addOutput(<contenttweaker:blokkat_frame>)
    .requireResearch("aw_start3")
    .requireComputationPoint(4000*1000.0F)
    .build();
RecipeBuilder.newBuilder("blokkat_input1","blokkat",20)
    .addInputs([
        <contenttweaker:stellaris_shipboard_ship_mk4>
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            val nowframe =dData.getInt("frame",0);
            val nowstrike =dData.getInt("strike",0);
            if(nowstrike > 1048577){
                event.setFailed("§c§lECO-D数量达到上限");
            }
        })
        .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val strike =dData.getInt("strike",0);
            val thread = event.factoryRecipeThread;
            val parallelism_num = thread.activeRecipe.parallelism;
            data.asMap()["strike"] = strike + 1 * parallelism_num;
            ctrl.customData = data;
        })
    .addRecipeTooltip("§a§l输入1ECO-D§f")
    .addRecipeTooltip("§a§l注:ECO-D数量上线为1048576§f")
    .setThreadName("§a§lECO-D格纳库")
    .build();
RecipeBuilder.newBuilder("blokkat_input2","blokkat",20)
    .addInputs([
        <contenttweaker:blokkat_frame>
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            val nowframe =dData.getInt("frame",0);
            if(nowframe > 64){
                event.setFailed("§5§l超维框架数量§c§l达到上限");
            }
        })
        .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val frame =dData.getInt("frame",0);
            val thread = event.factoryRecipeThread;
            val parallelism_num = thread.activeRecipe.parallelism;
            data.asMap()["frame"] = frame + 1 * parallelism_num;
            ctrl.customData = data;
        })
    .addRecipeTooltip("§a§l输入1§5§l超维框架§f")
    .addRecipeTooltip("§a§l注:§5§l超维框架§a§l数量上线为64§f")
    .setThreadName("§a§lECO-D格纳库")
    .build();
RecipeBuilder.newBuilder("blokkat_build","blokkat",12000)
    .addInputs([
        <contenttweaker:aw_pmc_pro>
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            val nowframe =dData.getInt("frame",0);
            val nowstrike =dData.getInt("strike",0);
            if(nowframe == 0){
                event.setFailed("§a§l尚未输入§5§l超维框架§f");
            }
            if(nowstrike == 0){
                event.setFailed("§a§l尚未输入ECO-D");
            }
            if(nowstrike > 1048577){
                event.setFailed("§c§lECO-D数量达到上限");
            }
        })
        .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val strike =dData.getInt("strike",0);
            val frame =dData.getInt("frame",0);
            val thread = event.factoryRecipeThread;
            val parallelism_num = thread.activeRecipe.parallelism;
            data.asMap()["strike"] = strike + 1 * frame * strike;
            ctrl.customData = data;
        })
    .setParallelized(false)
    .addRecipeTooltip("§a§l通过符文驱动'收割行动'船坞,使用'收割行动'所产出的资源建造'超维框架数量 * ECO-D数量'艘新的ECO-D§f")
    .addRecipeTooltip("§a§l注:ECO-D数量上线为1048576§f")
    .setThreadName("§a§l'收割行动'船坞")
    .build();
RecipeBuilder.newBuilder("blokkat_kill","blokkat",1200)
    .addInputs([
        <contenttweaker:programming_circuit_0>
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            val nowframe =dData.getInt("frame",0);
            val nowstrike =dData.getInt("strike",0);
            val nowsystem =dData.getInt("system",0);
            if(nowframe == 0){
                event.setFailed("§a§l尚未输入§5§l超维框架§f");
            }
            if(nowstrike == 0){
                event.setFailed("§a§l尚未输入ECO-D");
            }
            if(nowsystem > 1073741823){
                event.setFailed("§c§l已收割星系数量达到上限");
            }
        })
        .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val system =dData.getInt("system",0);
            val strike =dData.getInt("strike",0);
            data.asMap()["system"] = system + strike;
            ctrl.customData = data;
        })
    .setParallelized(false)
    .addRecipeTooltip("§a§l下达收割指令,每次收割ECO-D数量个星系§f")
    .addRecipeTooltip("§a§l注:§c§l已收割星系§a§l数量上线为1073741824§f")
    .setThreadName("§a§l'收割行动'监控")
    .build();
RecipeBuilder.newBuilder("blokkat_recive","blokkat",1)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            val nowsystem =dData.getInt("system",0);
            if(nowsystem == 0){
                event.setFailed("§c§l尚未收割星系");
            }
            event.activeRecipe.maxParallelism = nowsystem;
        })
    .addOutputs([
        <contenttweaker:stellaris_alloy> * 4096,
        <contenttweaker:stellaris_crystal> * 4096,
        <contenttweaker:stellaris_gas> * 4096,
        <contenttweaker:stellaris_darkmatter> * 4096,
        <contenttweaker:anti_viod> * 4096,
        <contenttweaker:aw_pmc_pro>
    ])
    .addRecipeTooltip("§a§l将收割星系的资源接收,并行数取决于§c§l已收割星系§a§l数量§f")
    .setThreadName("§a§l'收割行动'物资接收器")
    .build();