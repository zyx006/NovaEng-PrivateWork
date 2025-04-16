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

MMEvents.onControllerGUIRender("birch_world",function(event as ControllerGUIRenderEvent){
    val ctrl = event.controller;
    val world = ctrl.world;
    val data = ctrl.customData;
    val dData = D(data);
    val alloy = dData.getInt("alloy",0);
    val crystal = dData.getInt("crystal",0);
    val gas = dData.getInt("gas",0);
    val darkmatter = dData.getInt("darkmatter",0);
    val colony = dData.getInt("colony",0);
    val birch = dData.getInt("birch",0);
    val birch_pro = dData.getInt("birch_pro",0);
    val scouting_point = dData.getInt("scouting_point",0);
    val builder = dData.getInt("builder",0);
    val transporter = dData.getInt("transporter",0);
    var info as string[] = [];
    info += "§1§lECO-C殖民地控制台";
    info += "§1§l合金§f数量        ："+alloy+"|§1§l异性天然气§f数量:"+gas;
    info += "§1§l稀有水晶§f数量    ："+crystal+"|§8§l暗物质§f数量："+darkmatter;
    info += "§a§l卓越长城§f数量："+colony+"|§6§l伯奇世界§f数量："+birch;
    info += "§5§l寰宇星界§f数量："+birch_pro+"|§6§l侦查点§f数量：" +scouting_point;
    info += "§a§l建造无人机§f数量："+builder+"|§6§l运输无人机§f数量："+transporter;
    info += "§8§lAge of Wonder Colony Controller V1.0.";
    event.extraInfo = info;
});
<modularmachinery:birch_world_factory_controller>.addTooltip("§5§l成为星海霸主的基本,走向多元宇宙航行的开端");
<modularmachinery:birch_world_factory_controller>.addTooltip("§5§l通过巨量资源建立殖民地");
<modularmachinery:birch_world_factory_controller>.addTooltip("§5§l关于殖民地:");
<modularmachinery:birch_world_factory_controller>.addTooltip("§5§l殖民地一般为人工4维现实在3维的投影,在恒星,超大质量黑洞或类星体上投影以保证能量摄取");
<modularmachinery:birch_world_factory_controller>.addTooltip("§5§l关于侦查&建造&运输:");
<modularmachinery:birch_world_factory_controller>.addTooltip("§1§l归墟引弦MK-I§5§l因其强大的推进能力与轻便的体型成为侦察机,注:为保证侦查迅速,本型号的舰载机并未搭配武器");
<modularmachinery:birch_world_factory_controller>.addTooltip("§5§l§c§l归墟引弦MK-II§5§l因其内部的奇点仓库成为运输机,注:为保证运输顺利,本型号的舰载机搭配ECO-QD(小型)以保证货物安全");
<modularmachinery:birch_world_factory_controller>.addTooltip("§5§l归墟引弦MK-III档案损坏");
<contenttweaker:stellaris_shipboard_ship_mk2>.addTooltip("§c§l归墟引弦MK-II通过时空线圈与立场发生器驱动奇点仓库,结合卓越科技之精华");
<contenttweaker:stellaris_shipboard_ship_mk3>.addTooltip("§5§l归墟引弦MK-III:您无权查看ECO-T22及以上档案");
MachineModifier.setMaxThreads("birch_world",0);
MachineModifier.setInternalParallelism("birch_world", 1073741824);
MachineModifier.addCoreThread("birch_world", FactoryRecipeThread.createCoreThread("§6§l寰宇能源核心").addRecipe("birch_energy"));
MachineModifier.addCoreThread("birch_world", FactoryRecipeThread.createCoreThread("§6§l物资运输单元-I"));
MachineModifier.addCoreThread("birch_world", FactoryRecipeThread.createCoreThread("§6§l物资运输单元-II"));
MachineModifier.addCoreThread("birch_world", FactoryRecipeThread.createCoreThread("§6§l物资运输单元-III"));
MachineModifier.addCoreThread("birch_world", FactoryRecipeThread.createCoreThread("§6§l物资运输单元-IV"));
MachineModifier.addCoreThread("birch_world", FactoryRecipeThread.createCoreThread("§6§l舰载机建造单元"));
MachineModifier.addCoreThread("birch_world", FactoryRecipeThread.createCoreThread("§6§l舰载机格纳库-I型"));
MachineModifier.addCoreThread("birch_world", FactoryRecipeThread.createCoreThread("§6§l舰载机格纳库-II型"));
MachineModifier.addCoreThread("birch_world", FactoryRecipeThread.createCoreThread("§6§l舰载机侦查单元"));
MachineModifier.addCoreThread("birch_world", FactoryRecipeThread.createCoreThread("§6§l卓越长城交通枢纽"));
MachineModifier.addCoreThread("birch_world", FactoryRecipeThread.createCoreThread("§6§l伯奇世界交通枢纽"));
MachineModifier.addCoreThread("birch_world", FactoryRecipeThread.createCoreThread("§6§l寰宇星界交通枢纽"));
RecipeBuilder.newBuilder("birch_energy","birch_world",1200)
    .addInputs([
        <contenttweaker:anti_viod> * 4,
    ])
    .addRecipeTooltip("§6§l使用负虚空驱动寰宇能源核心并开辟§5虚境超空间航道§f")
    .setThreadName("§6§l寰宇能源核心")
    .setParallelized(false)
    .build();
RecipeBuilder.newBuilder("birch_world_input1","birch_world",20)
    .addInputs([
        <contenttweaker:stellaris_alloy>,
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            val nowtransporter =dData.getInt("transporter",0);
            if(nowtransporter == 0){
                event.setFailed("§6§l尚未输入运输无人机");
            }
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
                event.setFailed("§6§l尚未开辟§5虚境超空间航道§f");
            }
            event.activeRecipe.maxParallelism = nowtransporter;
        })
        .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            val alloy =dData.getInt("alloy",0);
            val gas =dData.getInt("gas",0);
            val crystal =dData.getInt("crystal",0);
            val darkmatter =dData.getInt("darkmatter",0);
            val builder =dData.getInt("builder",0);
            val scouting_point =dData.getInt("scouting_point",0);
            val thread = event.factoryRecipeThread;
            val parallelism_num = thread.activeRecipe.parallelism;
            data.asMap()["alloy"] = alloy + 1 * parallelism_num;
            ctrl.customData = data;
        })
    .addRecipeTooltip("§6§l输入1合金,并行取决于运输无人机数量,需开辟§5虚境超空间航道§f")
    .setThreadName("§6§l物资运输单元-I")
    .build();
RecipeBuilder.newBuilder("birch_world_input2","birch_world",20)
    .addInputs([
        <contenttweaker:stellaris_gas>,
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            val nowtransporter =dData.getInt("transporter",0);
            if(nowtransporter == 0){
                event.setFailed("§6§l尚未输入运输无人机");
            }
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
                event.setFailed("§6§l尚未开辟§5虚境超空间航道§f");
            }
            event.activeRecipe.maxParallelism = nowtransporter;
        })
        .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            val alloy =dData.getInt("alloy",0);
            val gas =dData.getInt("gas",0);
            val crystal =dData.getInt("crystal",0);
            val darkmatter =dData.getInt("darkmatter",0);
            val builder =dData.getInt("builder",0);
            val scouting_point =dData.getInt("scouting_point",0);
            val thread = event.factoryRecipeThread;
            val parallelism_num = thread.activeRecipe.parallelism;
            data.asMap()["gas"] = gas + 1 * parallelism_num;
            ctrl.customData = data;
        })
    .addRecipeTooltip("§6§l输入1异星天然气,并行取决于运输无人机数量,需开辟§5虚境超空间航道§f")
    .setThreadName("§6§l物资运输单元-II")
    .build();
RecipeBuilder.newBuilder("birch_world_input3","birch_world",20)
    .addInputs([
        <contenttweaker:stellaris_crystal>
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            val nowtransporter =dData.getInt("transporter",0);
            if(nowtransporter == 0){
                event.setFailed("§6§l尚未输入运输无人机");
            }
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
                event.setFailed("§6§l尚未开辟§5虚境超空间航道§f");
            }
            event.activeRecipe.maxParallelism = nowtransporter;
        })
        .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            val alloy =dData.getInt("alloy",0);
            val gas =dData.getInt("gas",0);
            val crystal =dData.getInt("crystal",0);
            val darkmatter =dData.getInt("darkmatter",0);
            val builder =dData.getInt("builder",0);
            val scouting_point =dData.getInt("scouting_point",0);
            val thread = event.factoryRecipeThread;
            val parallelism_num = thread.activeRecipe.parallelism;
            data.asMap()["crystal"] = crystal + 1 * parallelism_num;
            ctrl.customData = data;
        })
    .addRecipeTooltip("§6§l输入1稀有水晶,并行取决于运输无人机数量,需开辟§5虚境超空间航道§f")
    .setThreadName("§6§l物资运输单元-III")
    .build();
RecipeBuilder.newBuilder("birch_world_input4","birch_world",20)
    .addInputs([
        <contenttweaker:stellaris_darkmatter>,
        <contenttweaker:anti_viod>
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            val nowtransporter =dData.getInt("transporter",0);
            if(nowtransporter == 0){
                event.setFailed("§6§l尚未输入运输无人机");
            }
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
                event.setFailed("§6§l尚未开辟§5虚境超空间航道§f");
            }
            event.activeRecipe.maxParallelism = nowtransporter;
        })
        .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            val alloy =dData.getInt("alloy",0);
            val gas =dData.getInt("gas",0);
            val crystal =dData.getInt("crystal",0);
            val darkmatter =dData.getInt("darkmatter",0);
            val builder =dData.getInt("builder",0);
            val scouting_point =dData.getInt("scouting_point",0);
            val thread = event.factoryRecipeThread;
            val parallelism_num = thread.activeRecipe.parallelism;
            data.asMap()["darkmatter"] = darkmatter + 1 * parallelism_num;
            ctrl.customData = data;
        })
    .addRecipeTooltip("§6§l输入1暗物质,并行取决于运输无人机数量,需开辟§5虚境超空间航道§f")
    .setThreadName("§6§l物资运输单元-IV")
    .build();
RecipeBuilder.newBuilder("birch_world_input5","birch_world",20)
    .addInputs([
        <contenttweaker:stellaris_shipboard_ship>
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
                event.setFailed("§6§l尚未开辟§5虚境超空间航道§f");
            }
        })
        .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            val alloy =dData.getInt("alloy",0);
            val gas =dData.getInt("gas",0);
            val crystal =dData.getInt("crystal",0);
            val darkmatter =dData.getInt("darkmatter",0);
            val builder =dData.getInt("builder",0);
            val scouting_point =dData.getInt("scouting_point",0);
            val thread = event.factoryRecipeThread;
            val parallelism_num = thread.activeRecipe.parallelism;
            data.asMap()["scouting_point"] = scouting_point + 1 * parallelism_num;
            ctrl.customData = data;
        })
    .addRecipeTooltip("§6§l获得1侦查点,需开辟§5虚境超空间航道§f")
    .setThreadName("§6§l舰载机侦查单元")
    .build();
RecipeBuilder.newBuilder("birch_world_input6","birch_world",20)
    .addInputs([
        <contenttweaker:stellaris_shipboard_ship_mk2>
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
                event.setFailed("§6§l尚未开辟§5虚境超空间航道§f");
            }
        })
        .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            val alloy =dData.getInt("alloy",0);
            val gas =dData.getInt("gas",0);
            val crystal =dData.getInt("crystal",0);
            val darkmatter =dData.getInt("darkmatter",0);
            val builder =dData.getInt("builder",0);
            val scouting_point =dData.getInt("scouting_point",0);
            val transporter =dData.getInt("transporter",0);
            val thread = event.factoryRecipeThread;
            val parallelism_num = thread.activeRecipe.parallelism;
            data.asMap()["transporter"] = transporter + 1 * parallelism_num;
            ctrl.customData = data;
        })
    .addRecipeTooltip("§6§l获得1运输无人机,需开辟§5虚境超空间航道§f")
    .setThreadName("§6§l舰载机格纳库-I型")
    .build();
RecipeBuilder.newBuilder("birch_world_input7","birch_world",20)
    .addInputs([
        <contenttweaker:stellaris_shipboard_ship_mk3>
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
                event.setFailed("§6§l尚未开辟§5虚境超空间航道§f");
            }
        })
        .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            val alloy =dData.getInt("alloy",0);
            val gas =dData.getInt("gas",0);
            val crystal =dData.getInt("crystal",0);
            val darkmatter =dData.getInt("darkmatter",0);
            val builder =dData.getInt("builder",0);
            val scouting_point =dData.getInt("scouting_point",0);
            val thread = event.factoryRecipeThread;
            val parallelism_num = thread.activeRecipe.parallelism;
            data.asMap()["builder"] = builder + 1 * parallelism_num;
            ctrl.customData = data;
        })
    .addRecipeTooltip("§6§l获得1建造无人机,需开辟§5虚境超空间航道§f")
    .setThreadName("§6§l舰载机格纳库-II型")
    .build();
RecipeBuilder.newBuilder("birch_world_build1","birch_world",20)
    .addInputs([
        <contenttweaker:programming_circuit_0>,
        <contenttweaker:aw_pmc>
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            val nowalloy =dData.getInt("alloy",0);
            val nowgas =dData.getInt("gas",0);
            val nowcrystal =dData.getInt("crystal",0);
            val nowdarkmatter =dData.getInt("darkmatter",0);
            val nowbuilder =dData.getInt("builder",0);
            val nowscouting_point =dData.getInt("scouting_point",0);
            if(nowalloy < 4000){
                event.setFailed("§6§l缺少材料输入");
            }
            if(nowgas < 4000){
                event.setFailed("§6§l缺少材料输入");
            }
            if(nowcrystal < 4000){
                event.setFailed("§6§l缺少材料输入");
            }
            if(nowdarkmatter < 100){
                event.setFailed("§6§l缺少材料输入");
            }
            if(nowbuilder < 1){
                event.setFailed("§6§l尚未输入建造无人机");
            }
            if(nowscouting_point < 1){
                event.setFailed("§6§l尚未侦查星系");
            }
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
                event.setFailed("§6§l尚未驱动寰宇能源核心§f");
            }
            event.activeRecipe.maxParallelism = nowbuilder;
        })
        .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            val alloy =dData.getInt("alloy",0);
            val gas =dData.getInt("gas",0);
            val crystal =dData.getInt("crystal",0);
            val darkmatter =dData.getInt("darkmatter",0);
            val builder =dData.getInt("builder",0);
            val scouting_point =dData.getInt("scouting_point",0);
            val colony =dData.getInt("colony",0);
            val thread = event.factoryRecipeThread;
            val parallelism_num = thread.activeRecipe.parallelism;
            data.asMap()["colony"] = colony + 1 * parallelism_num;
            data.asMap()["scouting_point"] = scouting_point - 1 * parallelism_num;
            data.asMap()["alloy"] = alloy - 4000 * parallelism_num;
            data.asMap()["gas"] = gas - 4000 * parallelism_num;
            data.asMap()["crystal"] = crystal - 4000 * parallelism_num;
            data.asMap()["darkmatter"] = darkmatter - 100 * parallelism_num;
            ctrl.customData = data;
        })
    .addRecipeTooltip("§6§l获得1卓越长城,消耗4000合金,4000异星天然气§f")
    .addRecipeTooltip("§6§l4000稀有水晶,100暗物质与1侦查点§f")
    .addRecipeTooltip("§6§l至少需要1建造无人机(不消耗),并行取决于建造无人机数量,需驱动寰宇能源核心§f")
    .setThreadName("§6§l舰载机建造单元")
    .build();
RecipeBuilder.newBuilder("birch_world_build2","birch_world",20)
    .addInputs([
        <contenttweaker:programming_circuit_a>,
        <contenttweaker:aw_pmc> * 2
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            val nowalloy =dData.getInt("alloy",0);
            val nowgas =dData.getInt("gas",0);
            val nowcrystal =dData.getInt("crystal",0);
            val nowdarkmatter =dData.getInt("darkmatter",0);
            val nowbuilder =dData.getInt("builder",0);
            val nowscouting_point =dData.getInt("scouting_point",0);
            val birch =dData.getInt("birch",0);
            if(nowalloy < 40000){
                event.setFailed("§6§l缺少材料输入");
            }
            if(nowgas < 40000){
                event.setFailed("§6§l缺少材料输入");
            }
            if(nowcrystal < 40000){
                event.setFailed("§6§l缺少材料输入");
            }
            if(nowdarkmatter < 200){
                event.setFailed("§6§l缺少材料输入");
            }
            if(nowbuilder < 1){
                event.setFailed("§6§l尚未输入建造无人机");
            }
            if(nowscouting_point < 4){
                event.setFailed("§6§l尚未侦查星系");
            }
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
                event.setFailed("§6§l尚未驱动寰宇能源核心§f");
            }
            event.activeRecipe.maxParallelism = nowbuilder;
        })
        .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            val alloy =dData.getInt("alloy",0);
            val gas =dData.getInt("gas",0);
            val crystal =dData.getInt("crystal",0);
            val darkmatter =dData.getInt("darkmatter",0);
            val builder =dData.getInt("builder",0);
            val scouting_point =dData.getInt("scouting_point",0);
            val birch =dData.getInt("birch",0);
            val thread = event.factoryRecipeThread;
            val parallelism_num = thread.activeRecipe.parallelism;
            data.asMap()["birch"] = birch + 1 * parallelism_num;
            data.asMap()["scouting_point"] = scouting_point - 4 * parallelism_num;
            data.asMap()["alloy"] = alloy - 40000 * parallelism_num;
            data.asMap()["gas"] = gas - 40000 * parallelism_num;
            data.asMap()["crystal"] = crystal - 40000 * parallelism_num;
            data.asMap()["darkmatter"] = darkmatter - 200 * parallelism_num;
            ctrl.customData = data;
        })
    .addRecipeTooltip("§6§l获得1伯奇世界,消耗40000合金,40000异星天然气§f")
    .addRecipeTooltip("§6§l40000稀有水晶,200暗物质与4侦查点§f")
    .addRecipeTooltip("§6§l至少需要1建造无人机(不消耗),并行取决于建造无人机数量,需驱动寰宇能源核心§f")
    .setThreadName("§6§l舰载机建造单元")
    .build();
RecipeBuilder.newBuilder("birch_world_build3","birch_world",20)
    .addInputs([
        <contenttweaker:programming_circuit_b>,
        <contenttweaker:aw_pmc> * 4
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            val nowalloy =dData.getInt("alloy",0);
            val nowgas =dData.getInt("gas",0);
            val nowcrystal =dData.getInt("crystal",0);
            val nowdarkmatter =dData.getInt("darkmatter",0);
            val nowbuilder =dData.getInt("builder",0);
            val nowscouting_point =dData.getInt("scouting_point",0);
            val nowbirch =dData.getInt("birch",0);
            if(nowalloy < 40000){
                event.setFailed("§6§l缺少材料输入");
            }
            if(nowgas < 40000){
                event.setFailed("§6§l缺少材料输入");
            }
            if(nowcrystal < 40000){
                event.setFailed("§6§l缺少材料输入");
            }
            if(nowdarkmatter < 200){
                event.setFailed("§6§l缺少材料输入");
            }
            if(nowbuilder < 1){
                event.setFailed("§6§l尚未输入建造无人机");
            }
            if(nowscouting_point < 8){
                event.setFailed("§6§l尚未侦查星系");
            }
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
                event.setFailed("§6§l尚未驱动寰宇能源核心§f");
            }
            if(nowbirch < 1){
                event.setFailed("§6§l缺少伯奇世界");
            }
            event.activeRecipe.maxParallelism = nowbuilder;
        })
        .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            val alloy =dData.getInt("alloy",0);
            val gas =dData.getInt("gas",0);
            val crystal =dData.getInt("crystal",0);
            val darkmatter =dData.getInt("darkmatter",0);
            val builder =dData.getInt("builder",0);
            val scouting_point =dData.getInt("scouting_point",0);
            val birch_pro =dData.getInt("birch_pro",0);
            val birch =dData.getInt("birch",0);
            val thread = event.factoryRecipeThread;
            val parallelism_num = thread.activeRecipe.parallelism;
            data.asMap()["birch_pro"] = birch_pro + 1 * parallelism_num;
            data.asMap()["birch"] = birch - 1 * parallelism_num;
            data.asMap()["scouting_point"] = scouting_point - 8 * parallelism_num;
            data.asMap()["alloy"] = alloy - 40000 * parallelism_num;
            data.asMap()["gas"] = gas - 40000 * parallelism_num;
            data.asMap()["crystal"] = crystal - 40000 * parallelism_num;
            data.asMap()["darkmatter"] = darkmatter - 200 * parallelism_num;
            ctrl.customData = data;
        })
    .addRecipeTooltip("§6§l获得1寰宇星界,消耗40000合金,40000异星天然气§f")
    .addRecipeTooltip("§6§l40000稀有水晶,200暗物质,1伯奇世界与8侦查点§f")
    .addRecipeTooltip("§6§l至少需要1建造无人机(不消耗),并行取决于建造无人机数量,需驱动寰宇能源核心§f")
    .setThreadName("§6§l舰载机建造单元")
    .build();
RecipeBuilder.newBuilder("birch_world_reception1","birch_world",10)
    .addOutputs([
        <contenttweaker:stellaris_alloy> * 1024,
        <contenttweaker:stellaris_crystal> * 1024,
        <contenttweaker:stellaris_gas> * 1024,
        <contenttweaker:stellaris_darkmatter> * 16,
        <contenttweaker:anti_viod> * 16
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            val nowcolony =dData.getInt("colony",0);
            if(nowcolony < 1){
                event.setFailed("§6§l缺少卓越长城");
            }
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
                event.setFailed("§6§l尚未驱动寰宇能源核心§f");
            }
            event.activeRecipe.maxParallelism = nowcolony;
        })
    .addRecipeTooltip("§6§l接收卓越长城产出的资源,需驱动寰宇能源核心§f")
    .setThreadName("§6§l卓越长城交通枢纽")
    .build();
RecipeBuilder.newBuilder("birch_world_reception2","birch_world",10)
    .addOutputs([
        <contenttweaker:stellaris_alloy> * 2048,
        <contenttweaker:stellaris_crystal> * 2048,
        <contenttweaker:stellaris_gas> * 2048,
        <contenttweaker:stellaris_darkmatter> * 32,
        <contenttweaker:anti_viod> * 32
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            val nowbirch =dData.getInt("birch",0);
            if(nowbirch < 1){
                event.setFailed("§6§l缺少伯奇世界");
            }
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
                event.setFailed("§6§l尚未驱动寰宇能源核心§f");
            }
            event.activeRecipe.maxParallelism = nowbirch;
        })
    .addRecipeTooltip("§6§l接收伯奇世界产出的资源,需驱动寰宇能源核心§f")
    .setThreadName("§6§l伯奇世界交通枢纽")
    .build();
RecipeBuilder.newBuilder("birch_world_reception3","birch_world",10)
    .addOutputs([
        <contenttweaker:stellaris_alloy> * 4096,
        <contenttweaker:stellaris_crystal> * 4096,
        <contenttweaker:stellaris_gas> * 4096,
        <contenttweaker:stellaris_darkmatter> * 64,
        <contenttweaker:anti_viod> * 64
    ])
    .addOutput(<contenttweaker:aw_pmc_pro>).setChance(0.01)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            val nowbirch_pro =dData.getInt("birch_pro",0);
            if(nowbirch_pro < 1){
                event.setFailed("§6§l缺少寰宇星界");
            }
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
                event.setFailed("§6§l尚未驱动寰宇能源核心§f");
            }
            event.activeRecipe.maxParallelism = nowbirch_pro;
        })
    .addRecipeTooltip("§6§l接收寰宇星界产出的资源,需驱动寰宇能源核心§f")
    .setThreadName("§6§l寰宇星界交通枢纽")
    .build();
RecipeBuilder.newBuilder("birch_world_factory_controller", "ark_space_station", 3600)
    .addInput(<contenttweaker:industrial_circuit_v4> * 128)
    .addInput(<contenttweaker:field_generator_v4> * 64)
    .addInput(<contenttweaker:space_time_coil> * 16)
    .addInput(<moreplates:infinity_gear> * 32)
    .addInput(<contenttweaker:coil_v5> * 1024)
    .addInput(<contenttweaker:antimatter_core> * 64)
    .addInput(<contenttweaker:aw_pmc> * 2)
    .addInput(<contenttweaker:polymer_matter> * 1)
    .addInput(<contenttweaker:mm_yzjz> * 1)
    .addOutput(<modularmachinery:birch_world_factory_controller>)
    .requireResearch("aw_start3")
    .requireComputationPoint(4000*1000.0F)
    .build();