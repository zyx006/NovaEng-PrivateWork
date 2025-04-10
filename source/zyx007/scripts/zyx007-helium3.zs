#loader crafttweaker reloadable
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;

//空间站/戴森球收集氦3
MachineModifier.setMaxThreads("solar_wind_collector", 8);
//太阳风收集器控制器
RecipeBuilder.newBuilder("solar_wind", "machine_arm", 1200)
    .addEnergyPerTickInput(4096000)
    .addInputs([
        <mets:niobium_titanium_plate> * 64,
        <mets:superconducting_cable> * 32,
        <gravisuite:crafting:1> * 48,
        <mekanism:machineblock3:14> * 4,
        <advancedrocketry:intake> * 48,
        <mekanism:polyethene:2> * 16,
        <contenttweaker:carbon_nanotube> * 48,
        <nuclearcraft:alloy:13> * 16,
        <ic2:plate:14> * 16
    ])
    .addOutput(<modularmachinery:solar_wind_collector_controller> * 1)
    .build();
//太阳风收集器集成控制器
RecipeBuilder.newBuilder("solar_wind_fac", "workshop", 4800)
    .addEnergyPerTickInput(40960000)
    .addInputs([
        <modularmachinery:solar_wind_collector_controller> * 4,
        <tconevo:metal:8> * 8,
        <avaritia:resource:5> * 1,
        <contenttweaker:industrial_circuit_v3> * 4,
        <moreplates:neutronium_plate> * 32
    ])
    .addOutput(<modularmachinery:solar_wind_collector_factory_controller> * 1)
    .build();

//太阳风收集器产出氦3，仅限空间站维度
/*
托卡满载消耗  5000mb/s
催化剂情况	          单线程产出	  8线程产出(集成控制器)
无催化剂 (60s)	      16.67 mb/s	133.33 mb/s
仅无尽催化剂 (12s)	  833.33 mb/s	6666.67 mb/s
仅戴森云坐标卡 (24s)   125 mb/s	    1000 mb/s
双催化剂 (4.8s)	      6250 mb/s	    50000 mb/s
 */
RecipeBuilder.newBuilder("collect_he3", "solar_wind_collector", 1200)
    .setDimension([-2])
    .addOutputs(<liquid:helium_3> * 1000)
    .addCatalystInput(<avaritia:resource:5> * 2,
        ['工作时间 §ax0.2§f', '工作产出 §ax10§f'],
        [
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.2, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 10, 1, false).build()
        ]
    ).setChance(0)
    .addCatalystInput(<contenttweaker:dyson_cloud_pos_data_card> * 8,
        ['工作时间 §ax0.4§f', '工作产出 §ax3§f'],
        [
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.4, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 3, 1, false).build()
        ]
    ).setChance(0)
    .addRecipeTooltip("§6需要在空间站维度工作")
    .build();

var riers = 1600000000;
//托卡2生产氦3
RecipeBuilder.newBuilder("mk2_helium3", "mk2", 100, 2)
    .addEnergyPerTickInput(100000000)
    .addInputs([
        <liquid:hydrogen> * 6250,
        <liquid:deuterium> * 6250
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val ccl = dData.getInt("ccl", 0);
        val bh = dData.getInt("bh", 0);
        if(bh < riers){
            if (ccl < riers) {
                event.setFailed("§6启动能量缓存不足，无法开始配方！");
                return;
            }
        }
    })
    .addFactoryFinishHandler(function (event as FactoryRecipeFinishEvent) {
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val map = data.asMap();
        val ccl = dData.getInt("ccl", 0);
        val bh = dData.getInt("bh", 0);

        if(bh < riers){
            map["ccl"] = ccl - riers;
            map["bh"] = riers;
            ctrl.customData = data;
        } else {
            map["ccl"] = ccl - 0;
            ctrl.customData = data;
        }
    })
    .addOutput(<liquid:helium_3> * 6250)
    .addRecipeTooltip("§6此配方启动能量消耗为" + riers)
    .addRecipeTooltip("§6持续运行中不消耗第二次启动能量，")
    .addRecipeTooltip("§6若是运行中断将会导致重新扣除能量")
    .addRecipeTooltip("§6中途切换为其他配方若启动能量相同或更低时不需要重新启动")
    .setThreadName("聚变反应模块")
    .requireResearch("tokmak_reactor")
.build();