#priority 550
#loader crafttweaker reloadable

import crafttweaker.event.PlayerInteractBlockEvent;
import crafttweaker.event.PlayerRightClickItemEvent;
import crafttweaker.util.Math;
import crafttweaker.world.IWorld;
import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.MachineController;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.RecipeEvent;
import mods.modularmachinery.FactoryRecipeStartEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.MMEvents;
import mods.modularmachinery.ControllerGUIRenderEvent;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.MachineModifier;

<contenttweaker:network_card>.addTooltip("无线能量网络的终端控制部分，能够简洁高效地获得超维度网络中的重要信息");
<contenttweaker:network_card>.addTooltip("右键§c「§6裁光§c」§b星海§a原初§c之髓§r集成控制器以绑定该控制器对应的无线网络");
<contenttweaker:network_card>.addTooltip("右键允许使用无线电网的机器的控制器以将之链接到网络之中(可以使用的机器一般会在研究之中指明)");
<contenttweaker:network_card>.addTooltip("对着空气右键能够查看无线电网已存储的电量和使用情况");

events.onPlayerRightClickBlock(function(event as PlayerInteractBlockEvent){
    val block = event.block;
    val xc  = event.position.x;
    val yc  = event.position.y;
    val zc  = event.position.z;
    val dim = event.world.provider.dimensionID;
    val item = event.item;
    val pos as int[] = [xc,yc,zc,dim];
    val player = event.player;
    val world = IWorld.getFromID(dim);
    if(!event.world.remote&&<contenttweaker:network_card>.matches(item)&&!isNull(block)&&block.definition.id == "modularmachinery:starpith_factory_controller"){
        val ctrl = MachineController.getControllerAt(world, xc, yc, zc);
        val gotPlayer = ctrl.ownerPlayer;
        if(isNull(gotPlayer)||gotPlayer.name != player.name){
            player.sendMessage("§4这不是你的网络！");
            if(!isNull(gotPlayer)){
                gotPlayer.sendMessage("§4有人在偷你的电！");
            }
            event.cancel();
        }else{
            item.mutable().updateTag({display: {Lore: ["§9能量网络控制器所在维度ID：§a" + dim,"§9x坐标：§a" + xc, "§9y坐标：§a" + yc, "§9z坐标：§a" + zc]}, x: xc, y: yc, z: zc,pos : pos, dim: dim,binding : "yes!"});
            player.sendMessage("§b已经绑定能量网络中控！");
            event.cancel();
        }
    } 
});
events.onPlayerRightClickItem(function(event as PlayerRightClickItemEvent){
    val item = event.item;
    val player = event.player;
    if(!event.world.remote&&<contenttweaker:network_card>.matches(item)){
        if(!isNull(item.tag)&&!isNull(item.tag.pos)){
            val x = item.tag.x as int;
            val y = item.tag.y as int;
            val z = item.tag.z as int;
            val dim = item.tag.dim as int;
            val world = IWorld.getFromID(dim);
            val ctrl = MachineController.getControllerAt(world, x, y, z);
            val ownplayer = ctrl.ownerName;
            val data = ctrl.customData;
            val dData = D(data);
            val first =dData.getLong("first",0);
            val second = dData.getLong("second",0);
            var chfirst = dData.getLong("chfirst",0);
            var chsecond = dData.getLong("chsecond",0);
            var extra = "§3过去1秒内电网的交互量:";
            if((chfirst > 0)&&(chsecond < 0)){
                chfirst -= 1;
                chsecond += 1000000000000000000;
                extra += "+";
            }else if((chfirst < 0)&&(chsecond > 0)){
                chfirst += 1;
                chsecond -= 1000000000000000000;
                extra += "-";
            }else if((chfirst <= 0)&&(chsecond < 0)){
                chfirst = Math.abs(chfirst);
                chsecond = Math.abs(chsecond);
                extra += "-";
            }else if((chfirst > 0)&&(chsecond >0)){
                extra += "+";
            }
            if((chfirst == 0)&&(chsecond == 0)){
                extra = "§3网络波动平缓，暂无能量交互！";
            }else{
                extra += formatNumberU(chfirst,chsecond) + "RF";
            }
            var info = "§3电网当前已有电量：";
            if((first != 0)&&(second != 0)){
                info += formatNumberU(first,second) + "RF";
            }else{
                info = "§4你的电网之中还没有电量！";
            }
            player.sendMessage("§9电网拥有者:" + ownplayer);
            player.sendMessage("§9当前访问者:" + player.name);
            player.sendMessage(info);
            player.sendMessage(extra);
        }else{
            player.sendMessage("§4还未绑定超维度能量网络！");
        }
    }
});

global formatNumberU as function(long,long)string = function (afirst as long,asecond as long) as string{
    var front = "";
    var back = "";
    var first = afirst;
    var second = asecond;
    if(first >= 1000000){
        front += ("§e" + first / 1000000 + "Y§r") as string;
        first = first % 1000000;
    }if(first >= 1000){
        front += ("§6" + first / 1000 + "Z§r") as string;
        first = first % 1000;
    }if(first != 0){
        front += ("§2" + first + "E§r") as string;
    }
    if(second >= 1000000000000000){
        back += ("§9" + second  / 1000000000000000 + "P§r") as string;
        second = second % 1000000000000000;
    }if(second >= 1000000000000){
        back += ("§5" + second / 1000000000000 + "T§r") as string;
        second = second % 1000000000000;
    }if(second >= 1000000000){
        back += ("§4" + second / 1000000000 + "G§r") as string;
        second = second % 1000000000;
    }if(second >= 1000000){
        back += ("§a" + second / 1000000 + "M§r") as string;
        second = second % 1000000;
    }if(second >= 1000){
        back += ("§c" + second / 1000 + "K§r") as string;
        second = second % 1000;
    }if(second != 0){
        back += second as string;
    }
    val fin = (front + back) as string;
    return fin;
};

global AddEnergyMachine as function(string)void = function (name as string) as void{
    events.onPlayerRightClickBlock(function(event as PlayerInteractBlockEvent){
        val block = event.block;
        val item = event.item;
        val xc  = event.position.x;
        val yc  = event.position.y;
        val zc  = event.position.z;
        val dim = event.world.provider.dimensionID;
        val world = IWorld.getFromID(dim);
        val player = event.player;
        val addMachine = ("modularmachinery:" + name + "_factory_controller") as string;
        if(!event.world.remote&&<contenttweaker:network_card>.matches(item)){
            if(!isNull(item.tag)&&!isNull(item.tag.pos)){
                val xx = item.tag.x as int;
                val yy = item.tag.y as int;
                val zz = item.tag.z as int;
                val dim = item.tag.dim as int;
                if(!isNull(block)&&block.definition.id == addMachine){
                    val ctrl = MachineController.getControllerAt(world, xc, yc, zc);
                    val data = ctrl.customData;
                    val map = data.asMap();
                    map["x"] = xx;
                    map["y"] = yy;
                    map["z"] = zz;
                    map["dim"] = dim;
                    ctrl.customData = data;
                    player.sendMessage("§b已经将此机器加入维度能量网络！");
                }
                event.cancel();
            }
        }
    });
};
global checkconnected as function(RecipeEvent)bool = function (event as RecipeEvent) as bool{
    val ctrl = event.controller;
    val data = ctrl.customData;
    val dData = D(data);
    val x = dData.getInt("x",0);
    val y = dData.getInt("y",0);
    val z = dData.getInt("z",0);
    val dim = dData.getInt("dim",0);
    val world = IWorld.getFromID(dim);
    val controller = MachineController.getControllerAt(world,x,y,z);
    if(isNull(controller)||controller.blockState.block.definition.id != "modularmachinery:starpith_factory_controller"){
        return false;
    }else{
        return true;
    }
};
global getController as function(RecipeEvent)IMachineController = function(event as RecipeEvent) as IMachineController{
    val ctrl = event.controller;
    val data = ctrl.customData;
    val dData = D(data);
    val x = dData.getInt("x",0);
    val y = dData.getInt("y",0);
    val z = dData.getInt("z",0);
    val dim = dData.getInt("dim",0);
    val world = IWorld.getFromID(dim);
    val controller = MachineController.getControllerAt(world,x,y,z);
    return controller;
};
global addEnergy as function(RecipeEvent,long,long)bool = function (event as RecipeEvent,first as long,second as long) as bool{
    if(!checkconnected(event)){
        return false;
    }
    val ctrl = getController(event);
    val data = ctrl.customData;
    val dData =D(data);
    val map = data.asMap();
    var nowFirst = dData.getLong("first",0) + first;
    var nowSecond = dData.getLong("second",0) + second;
    if(nowSecond >= 1000000000000000000){
        nowFirst += 1;
        nowSecond -= 1000000000000000000;
    }
    map["first"] = nowFirst;
    map["second"] = nowSecond;
    ctrl.customData = data;
    return true;
};
global CostEnergy as function(RecipeEvent,long,long)bool = function (event as RecipeEvent,first as long,second as long) as bool{
    if(!checkconnected(event)){
        return false;
    }
    val ctrl = getController(event);
    val data = ctrl.customData;
    val dData =D(data);
    val map = data.asMap();
    var nowFirst = dData.getLong("first",0);
    var nowSecond = dData.getLong("second",0);
    if((nowFirst > first)||((nowFirst == first)&&(nowSecond > second))){
        if(nowSecond < second){
            nowFirst -= 1;
            nowSecond += 1000000000000000000;
        }
        map["first"] = nowFirst - first;
        map["second"] = nowSecond - second;
        ctrl.customData = data;
        return true;
    }else{
        return false;
    }
};
global CheckEnergy as function(RecipeEvent,long,long)bool = function (event as RecipeEvent,first as long,second as long) as bool{
    if(!checkconnected(event)){
        return false;
    }
    val ctrl = getController(event);
    val data = ctrl.customData;
    val dData =D(data);
    var nowFirst = dData.getLong("first",0);
    var nowSecond = dData.getLong("second",0);
    if((nowFirst < first)||((nowFirst == first)&&(nowSecond < second))){
        return false;
    }else{
        return true;
    }
};

MMEvents.onControllerGUIRender("starpith",function(event as ControllerGUIRenderEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val dData = D(data);
    val first =dData.getLong("first",0);
    val second = dData.getLong("second",0);
    var chfirst = dData.getLong("chfirst",0);
    var chsecond = dData.getLong("chsecond",0);
    var extra = "§a过去1秒内能源交互为:";
    if((chfirst > 0)&&(chsecond < 0)){
        chfirst -= 1;
        chsecond += 1000000000000000000;
        extra += "+";
    }else if((chfirst < 0)&&(chsecond > 0)){
        chfirst += 1;
        chsecond -= 1000000000000000000;
        extra += "-";
    }else if((chfirst < 0)&&(chsecond < 0)){
        chfirst = Math.abs(chfirst);
        chsecond = Math.abs(chsecond);
        extra += "-";
    }else if((chfirst > 0)&&(chsecond >0)){
        extra += "+";
    }
    if((chfirst == 0)&&(chsecond == 0)){
        extra = "§3网络波动平缓，暂无能量交互！";
    }else{
        extra += formatNumberU(chfirst,chsecond) + "RF";
    }
    var info as string[] = [];
    info += "§b无线电网§e监测器";
    info += "§2当前能源储量:";
    info += formatNumberU(first,second) + "RF";
    info +=  extra;
    event.extraInfo = info;
});

MachineModifier.setMaxThreads("starpith",0);
MachineModifier.addCoreThread("starpith",FactoryRecipeThread.createCoreThread("网络监控"));
MachineModifier.addCoreThread("starpith",FactoryRecipeThread.createCoreThread("液态能源输入"));
MachineModifier.addCoreThread("starpith",FactoryRecipeThread.createCoreThread("固化能源输入"));

RecipeBuilder.newBuilder("starpith_con","workshop",7200)
    .addInputs([
        <modularmachinery:dream_energy_core_factory_controller>,
        <avaritia:resource:5> * 16,
        <liquid:crystalloid> * 9999,
        <fluxnetworks:gargantuanfluxstorage> * 64,
        <draconicevolution:energy_storage_core>,
        <mets:te:24> * 64
    ])
    .requireComputationPoint(75000.0F)
    .requireResearch("Wireless")
    .addOutput(<modularmachinery:starpith_factory_controller>)
    .build();
RecipeBuilder.newBuilder("network_card","workshop",1200)
    .addInputs([
        <avaritia:resource:5>,
        <novaeng_core:hypernet_terminal_controller>,
        <modularmachinery:computation_center_t3_factory_controller>,
        <appliedenergistics2:material:59> * 8,
        <appliedenergistics2:storage_cell_64k> * 18,
    ])
    .addOutput(<contenttweaker:network_card>)
    .requireComputationPoint(750.0F)
    .requireResearch("Wireless")
    .build();

RecipeBuilder.newBuilder("EnerNetCheck","starpith",20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val map = data.asMap();
        map["oldfirst"] = dData.getLong("first",0);
        map["oldsecond"] = dData.getLong("second",0);
        ctrl.customData = data;
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val map = data.asMap();
        map["chfirst"] = dData.getLong("first") - dData.getLong("oldfirst");
        map["chsecond"] = dData.getLong("second") - dData.getLong("oldsecond");
        ctrl.customData = data;
    })
    .setThreadName("网络监控")
    .addRecipeTooltip("监视网络的运行状态，每秒更新能量交互")
    .build();
RecipeBuilder.newBuilder("FluidNetworkInput","starpith",5)
    .addInput(<liquid:liquid_energy>)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 536870912;
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val map = data.asMap();
        var para = event.activeRecipe.parallelism as long;
        val first = dData.getLong("first",0);
        val second = dData.getLong("second",0);
        var willchange = second + (para * 5000000000) as long;
        if(willchange > 1000000000000000000){
            map["first"] = first + (willchange / 1000000000000000000);
            willchange = willchange % 1000000000000000000;
        }
        map["second"] = willchange;
        ctrl.customData = data;
    })
    .setThreadName("液态能源输入")
    .addRecipeTooltip("将液态能量输入到无线电网之中","最大有着536870912的并行")
    .build();
RecipeBuilder.newBuilder("ItemNetworkInput","starpith",20)
    .addInput(<contenttweaker:charged_max_energy_containers>)
    .addOutput(<contenttweaker:max_energy_containers>)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 512;
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val map = data.asMap();
        var para = event.activeRecipe.parallelism as long;
        val first = dData.getLong("first",0);
        val second = dData.getLong("second",0);
        var willchange = second + (para * 1000000000000000) as long;
        if(willchange > 1000000000000000000){
            map["first"] = first + (willchange / 1000000000000000000);
            willchange = willchange % 1000000000000000000;
        }
        map["second"] = willchange;
        ctrl.customData = data;
    })
    .setThreadName("固化能源输入")
    .addRecipeTooltip("将极限能源存储器之中的电力输入到无线电网之中","最大有着512的并行")
    .build();
RecipeBuilder.newBuilder("radox","starpith",20)
    .addInputs([
        <liquid:rado> * 2560,
        <avaritia:resource:5> * 8,
        <liquid:ark> * 2304,
        <liquid:fluidedmana> * 65536,
        <liquid:oslash_matter> * 8192,
        <liquid:phi_matter> * 8192
    ])
    .addOutput(<liquid:radox> * 1280)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val first = dData.getLong("first",0);
        val second = dData.getLong("second",0);
        if((first == 0) && (second < 100000000000000)){
            event.setFailed("无线电网之中的电量不够！");
        }
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val map = data.asMap();
        val first = dData.getLong("first",0);
        val second = dData.getLong("second",0);
        if(second > 100000000000000){
            map["second"] = second - 100000000000000;
        }else{
            map["second"] = second + 1000000000000000000 - 100000000000000;
        }
        ctrl.customData = data;
    })
    .addRecipeTooltip("需要消耗电网之中" + formatNumberU(0,100000000000000) + "RF的电量")
    .build();