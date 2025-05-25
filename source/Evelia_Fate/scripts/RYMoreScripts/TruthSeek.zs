import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.MachineBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.MMEvents;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.RecipeFinishEvent;
import mods.modularmachinery.MachineTickEvent;
import mods.modularmachinery.FactoryRecipeStartEvent;
import mods.modularmachinery.ControllerGUIRenderEvent;
import mods.modularmachinery.SmartInterfaceType;
import mods.modularmachinery.RecipeTickEvent;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.RecipeModifierBuilder;

import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;

import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.research.ResearchCognitionData;

HyperNetHelper.proxyMachineForHyperNet("TruthSeek");
MachineModifier.setMaxThreads("TruthSeek",0);
MachineModifier.addCoreThread("TruthSeek",FactoryRecipeThread.createCoreThread("真理之门"));
MachineModifier.addCoreThread("TruthSeek",FactoryRecipeThread.createCoreThread("能源输入"));
MachineModifier.addCoreThread("TruthSeek",FactoryRecipeThread.createCoreThread("物质输入"));
MachineModifier.addCoreThread("TruthSeek",FactoryRecipeThread.createCoreThread("灵魂输入"));
MachineModifier.addCoreThread("TruthSeek",FactoryRecipeThread.createCoreThread("时空输入"));
MachineModifier.addCoreThread("TruthSeek",FactoryRecipeThread.createCoreThread("魔力输入"));
MachineModifier.addCoreThread("TruthSeek",FactoryRecipeThread.createCoreThread("计算矩阵"));

MMEvents.onControllerGUIRender("TruthSeek",function(event as ControllerGUIRenderEvent){
    val ctrl = event.controller;
    val world = ctrl.world;
    val data = ctrl.customData;
    val dData = D(data);
    val ener = dData.getLong("energy",0);
    val matt = dData.getInt("matter",0);
    val soul = dData.getInt("soul",0);
    val spti = dData.getInt("spti",0);
    val mana = dData.getInt("mana",0);
    var info as string[] = [];
    info +="§l§e真理§1之门§6监测装置";
    info +="§2能量储量:§r§l§f"+ener+"/2000";
    info +="§9物质储量:§r§l§f"+matt+"/3000";
    info +="§8时空储量:§r§l§f"+spti+"/4000";
    info +="§5灵魂储量:§r§l§f"+soul+"/5000";
    info +="§b魔力储量:§r§l§f"+mana+"/5000";
    event.extraInfo = info;
});

RecipeBuilder.newBuilder("TruthGate","TruthSeek",5)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val map = data.asMap();
        val energy = dData.getInt("energy",0);
        val matter = dData.getInt("matter",0);
        val mana = dData.getInt("mana",0);
        if(energy<5){
            event.setFailed("能量尚不足够！");
        }else if(matter<5){
            event.setFailed("物质尚不足够！");
        }else if(mana<5){
            event.setFailed("魔力尚不足够！");
        }else{
            map["energy"] = energy - 5;
            map["matter"] = matter - 5;
            map["mana"] = mana - 5;
        }
        ctrl.customData = data;
    })
    .addRecipeTooltip("每tick会消耗1能量、1物质、1魔力")
    .setThreadName("真理之门")
    .build();


RecipeBuilder.newBuilder("TruthEnergyInput","TruthSeek",5)
    .addInputs([
        <contenttweaker:charged_max_energy_containers>*20,
        <contenttweaker:fragments_of_the_space_time_continuum>*1
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val energy = dData.getInt("energy",0);
        if(energy>1600){
            event.setFailed("能量已达上限!");
        }
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val map = data.asMap();
        val energy = dData.getInt("energy",0);
        map["energy"] = energy + 400;
        ctrl.customData=data;
    })
    .addRecipeTooltip("输入400能量")
    .setThreadName("能源输入")
    .build();
RecipeBuilder.newBuilder("TruthMatterInput","TruthSeek",5)
    .addInputs([
        <contenttweaker:dark_matter>*200,
        <contenttweaker:polymer_matter>*4
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val matter = dData.getInt("matter",0);
        if(matter>2600){
            event.setFailed("物质已达上限！");
        }
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val map = data.asMap();
        val matter = dData.getInt("matter",0);
        map["matter"] = matter + 400;
        ctrl.customData = data;
    })
    .addRecipeTooltip("输入400物质")
    .setThreadName("物质输入")
    .build();
RecipeBuilder.newBuilder("TruthSptiInput","TruthSeek",5)
    .addInputs([
        <contenttweaker:fragments_of_the_space_time_continuum>*30,
        <liquid:space_time_fluids>*5120,
    ])
    .addInput(<contenttweaker:superluminal_core>).setChance(0)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val spti = dData.getInt("spti",0);
        if(spti>3500){
            event.setFailed("时空已达上限！");
        }
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val map = data.asMap();
        val spti = dData.getInt("spti",0);
        map["spti"] = spti + 500;
        ctrl.customData = data;
    })
    .addRecipeTooltip("输入500时空")
    .setThreadName("时空输入")
    .build();
RecipeBuilder.newBuilder("TruthSoulInput","TruthSeek",5)
    .addInputs(<draconicevolution:mob_soul>*20)
    .addInput(<contenttweaker:soul_core>).setChance(0)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val Soul = dData.getInt("soul",0);
        if(Soul>4000){
            event.setFailed("灵魂已达上限！");
        }
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val map = data.asMap();
        val Soul = dData.getInt("soul",0);
        map["soul"] = Soul + 1000;
        ctrl.customData = data;
    })
    .addRecipeTooltip("输入1000灵魂")
    .setThreadName("灵魂输入")
    .build();
RecipeBuilder.newBuilder("TruthManaInput","TruthSeek",5)
    .addInputs(<liquid:fluidedmana>*10000)
    .addInput(<botania:specialflower>.withTag({type: "asgardandelion"})).setChance(0)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val mana = dData.getInt("mana",0);
        if(mana > 4500){
            event.setFailed("魔力已达上限！");
        }
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val map = data.asMap();
        val mana = dData.getInt("mana",0);
        map["mana"] = mana + 500;
        ctrl.customData = data;
    })
    .setThreadName("魔力输入")
    .addRecipeTooltip("输入500魔力")
    .build();

RecipeBuilder.newBuilder("StarryOrgin","TruthSeek",1280)
    .addInputs([
        <contenttweaker:fragments_of_the_space_time_continuum>*2560,
        <contenttweaker:truthmatrix>*1280,
        <contenttweaker:purified_geocentric_quartz_crystal>*128,
    ])
    .addInput(<contenttweaker:sunrune>*4).setChance(0)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val map = data.asMap();
        val matter = dData.getInt("matter",0);
        val energy = dData.getInt("energy",0);
        val soul = dData.getInt("soul",0);
        val spti = dData.getInt("spti",0);
        if(energy<1200){
            event.setFailed("能量尚不足够！");
        }else if(matter<1200){
            event.setFailed("物质尚不足够！");
        }else if(soul < 3000){
            event.setFailed("灵魂尚不足够！");
        }else if(spti < 3000){
            event.setFailed("时空尚不足够！");
        }
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val map = data.asMap();
        val matter = dData.getInt("matter",0);
        val energy = dData.getInt("energy",0);
        val soul = dData.getInt("soul",0);
        val spti = dData.getInt("spti",0);
        map["energy"] = energy - 1200;
        map["matter"] = matter - 1200;
        map["soul"] = soul - 3000;
        map["spti"] = spti - 3000;
        ctrl.customData = data;
    })
    .addOutput(<contenttweaker:starry_orgin>)
    .addRecipeTooltip("需要消耗1200能量、1200物质、3000时空、3000灵魂")
    .setThreadName("计算矩阵")
    .build();
RecipeBuilder.newBuilder("SunRune","TruthSeek",1280)
    .addInputs([
        <extrabotany:material:8>*64,
        <extrabotany:material:5>*64,
        <contenttweaker:steady_supercritical_photons>*16777216,
        <botania:livingrock>*8192,
        <avaritia:block_resource>*27,
        <contenttweaker:charged_max_energy_containers>*8,
        <contenttweaker:mana_core>
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val map = data.asMap();
        val soul = dData.getInt("soul",0);
        val mana = dData.getInt("mana",0);
        if(soul < 700){
            event.setFailed("灵魂尚不足够！");
        }else if(mana < 800){
            event.setFailed("魔力尚不足够！");
        }
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val map = data.asMap();
        val soul = dData.getInt("soul",0);
        val mana = dData.getInt("mana",0);
        map["soul"] = soul - 700;
        map["mana"] = mana - 800;
        ctrl.customData = data;
    })
    .addOutput(<contenttweaker:sunrune>)
    .addRecipeTooltip("需要消耗700灵魂、800魔力")
    .setThreadName("计算矩阵")
    .build();

RecipeBuilder.newBuilder("UniversalCore","TruthSeek",1280)
    .addInputs([
        <contenttweaker:world_energy_core>*8,
        <contenttweaker:arkforcefieldcontrolblock>*16,
        <super_solar_panels:machines:11>*16,
        <contenttweaker:infinity_processor>*128
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val map = data.asMap();
        val matter = dData.getInt("matter",0);
        val energy = dData.getInt("energy",0);
        val spti = dData.getInt("spti",0);
        if(energy < 1300){
            event.setFailed("能量尚不足够！");
        }else if(matter < 2400){
            event.setFailed("物质尚不足够！");
        }else if(spti < 3200){
            event.setFailed("时空尚不足够！");
        }
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val map = data.asMap();
        val matter = dData.getInt("matter",0);
        val energy = dData.getInt("energy",0);
        val spti = dData.getInt("spti",0);
        map["energy"] = energy - 1300;
        map["matter"] = matter - 2400;
        map["spti"] = spti - 3200;
        ctrl.customData = data;
    })
    .addOutput(<contenttweaker:infinitycore>)
    .addRecipeTooltip("需要消耗1300能量、2400物质、3200时空")
    .setThreadName("计算矩阵")
    .build();