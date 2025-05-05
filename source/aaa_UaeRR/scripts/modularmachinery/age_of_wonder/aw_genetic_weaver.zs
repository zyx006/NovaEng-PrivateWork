//ALL RIGHTS RESERVED
//也许你可以对私货进行更改。

#priority 10
#loader crafttweaker reloadable

import crafttweaker.util.Math;
import crafttweaker.world.IWorld;
import crafttweaker.world.IBlockPos;
import crafttweaker.item.IItemStack;
import crafttweaker.event.PlayerInteractBlockEvent;

import mods.modularmachinery.Sync;
import mods.modularmachinery.MMEvents;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.RecipeTickEvent;
import mods.modularmachinery.MachineTickEvent;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.MachineController;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.SmartInterfaceType;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.FactoryRecipeStartEvent;
import mods.modularmachinery.ControllerGUIRenderEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;

MachineModifier.setMaxThreads("aw_genetic_weaver",0);
MachineModifier.addCoreThread("aw_genetic_weaver",FactoryRecipeThread.createCoreThread("§a管理中枢链接器"));
MachineModifier.addCoreThread("aw_genetic_weaver",FactoryRecipeThread.createCoreThread("§6时空农场"));
RecipeBuilder.newBuilder("aw_genetic_weaver_foodoutput","aw_genetic_weaver",1)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("§a管理中枢链接器§f尚未运行");
            return;
        }
    })
    .addOutput(<contenttweaker:stellaris_food> * 1)
    .setThreadName("§6时空农场")
    .build();
RecipeBuilder.newBuilder("proxyMachineForCelestialNetwork_RecipeSupport_aw_genetic_weaver_1","aw_genetic_weaver",1)
        .addInputs([
            <contenttweaker:zbk>
        ]).setChance(0)
        .setNBTChecker(function(ctrl as IMachineController, item as IItemStack) {
                val data = ctrl.customData;
                val x = D(item.tag).getInt("x", 0);
                val y = D(item.tag).getInt("y", 0);
                val z = D(item.tag).getInt("z", 0);
                val dim = D(item.tag).getInt("dim", 0);
                val map = data.asMap();

                map["lx"] = x;
                map["ly"] = y;
                map["lz"] = z;
                map["ldim"] = dim;
                ctrl.customData = data;
                return true;
        })
    .addPostCheckHandler(function(event as RecipeCheckEvent) {
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val lx = dData.getInt("lx", 0);
            val ly = dData.getInt("ly", 0);
            val lz = dData.getInt("lz", 0);
            val ldim = dData.getInt("ldim", 0);
            val world = IWorld.getFromID(ldim);
            val zsctrl = MachineController.getControllerAt(world, lx, ly, lz);
            if (!world.remote) {
                if(isNull(zsctrl)) {
                    event.setFailed("坐标未找到中枢,或者在已加载区块之外");
                    return;
                }else{
                    val controllerId = zsctrl.blockState.block.definition.id;
                    if (isNull(controllerId)||controllerId != "modularmachinery:celestial_network_center_factory_controller") {
                        event.setFailed("绑定的方块错误,请绑定中枢控制器");
                        return;
                    } else {
                        if (!zsctrl.isWorking){
                            event.setFailed("中枢处于未工作状态，无法链接");
                        }
                    }
                }
            }
        })
        .addFactoryStartHandler(function (event as FactoryRecipeStartEvent) {
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            val lx = dData.getInt("lx", 0);
            val ly = dData.getInt("ly", 0);
            val lz = dData.getInt("lz", 0);
            val ldim = dData.getInt("ldim", 0);
            map["x"] = lx;
            map["y"] = ly;
            map["z"] = lz;
            map["dim"] = ldim;
            ctrl.customData = data;
        })
        .addFactoryPreTickHandler(function(event as FactoryRecipeTickEvent) {
            if(event.controller.recipeThreadList[0].activeRecipe){
                val ctrl = event.controller;
                val data = ctrl.customData;
                val dData = D(data);
                val dim = dData.getInt("dim", 0);
                val x = dData.getInt("x", 0);
                val y = dData.getInt("y", 0);
                val z = dData.getInt("z", 0);
                val world = IWorld.getFromID(dim);
                val cnctrl = MachineController.getControllerAt(world, x, y, z);
                val cndata = cnctrl.customData;
                val cndData = D(cndata);
                val cnmap = cndata.asMap();
                val thread = event.controller.recipeThreadList[0];
                val parallelism_num = thread.activeRecipe.parallelism;
                val second = cndData.getLong("second",0);
                cnmap["second"] = second - 10000 * parallelism_num;
                cnctrl.customData = cndata;
            }
        })
        .setParallelized(false)
        .addRecipeTooltip("§a坐标卡需要绑定中枢控制器")
        .addRecipeTooltip("§5§l星体网络§f能量输入 10 * 10 ^ 24 RF/Tick")
        .setThreadName("§a管理中枢链接器")
        .build();
