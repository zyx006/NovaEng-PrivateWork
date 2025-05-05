#priority 550
#loader crafttweaker reloadable

import crafttweaker.event.PlayerInteractBlockEvent;
import crafttweaker.event.PlayerRightClickItemEvent;
import crafttweaker.util.Math;
import crafttweaker.world.IWorld;
import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;
import mods.modularmachinery.RecipeEvent;
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

<contenttweaker:celestial_network_network_card>.addTooltip("无线能量网络的终端控制部分，能够简洁高效地获得星体网络中的重要信息");
<contenttweaker:celestial_network_network_card>.addTooltip("右键§5§l星体网络中枢§f集成控制器以绑定该控制器对应的无线网络");
<contenttweaker:celestial_network_network_card>.addTooltip("右键允许使用无线电网的机器的控制器以将之链接到网络之中(可以使用的机器一般会在ToolTip中指明)");
<contenttweaker:celestial_network_network_card>.addTooltip("对着空气右键能够查看无线电网已存储的电量和使用情况");
<contenttweaker:celestial_network_network_card>.addTooltip("§5§l利用中枢内部奇点的纠缠效应以瞬间传输电量");
<contenttweaker:celestial_network_network_card>.addTooltip("§5§lPS:因星体网络其特性,其最低能量单位为 10 ^ 21 (即1Zeta)");
<contenttweaker:celestial_network_network_card>.addTooltip("§5§lPSS:星体网络可存储能量高达 9.2 * 10 ^ 52能量");

MMEvents.onControllerGUIRender("celestial_network_center",function(event as ControllerGUIRenderEvent){
    val ctrl = event.controller;
    val world = ctrl.world;
    val data = ctrl.customData;
    val dData =D(data);
    val map = data.asMap();
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
        extra += celestial_network_formatNumberU(chfirst,chsecond) + "RF";
    }
    var info as string[] = [];
    info += "§b星体网络§e监测器";
    info += "§2当前能源储量:";
    info += celestial_network_formatNumberU(first,second) + "RF";
    info +=  extra;
    event.extraInfo = info;
});

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
    if(!event.world.remote&&<contenttweaker:celestial_network_network_card>.matches(item)&&!isNull(block)&&block.definition.id == "modularmachinery:celestial_network_center_factory_controller"){
        val ctrl = MachineController.getControllerAt(world, xc, yc, zc);
        val gotPlayer = ctrl.ownerPlayer;
        if(isNull(gotPlayer)||gotPlayer.name != player.name){
            player.sendMessage("§4量子密钥错误");
            if(!isNull(gotPlayer)){
                gotPlayer.sendMessage("§4您的星体网络正在被访问");
            }
            event.cancel();
        }else{
            item.mutable().updateTag({display: {Lore: ["§9能量网络控制器所在维度ID：§a" + dim,"§9x坐标：§a" + xc, "§9y坐标：§a" + yc, "§9z坐标：§a" + zc]}, x: xc, y: yc, z: zc,pos : pos, dim: dim,binding : "yes!"});
            player.sendMessage("§b已经绑定星体网络中枢");
            event.cancel();
        }
    } 
});
events.onPlayerRightClickItem(function(event as PlayerRightClickItemEvent){
    val item = event.item;
    val player = event.player;
    if(!event.world.remote&&<contenttweaker:celestial_network_network_card>.matches(item)){
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
                extra += celestial_network_formatNumberU(chfirst,chsecond) + " RF";
            }
            var info = "§3星体网络当前已有电量：";
            if((first != 0)||(second != 0)){
                info += celestial_network_formatNumberU(first,second) + " RF";
            }else{
                info = "§4你的星体网络之中还没有电量！";
            }
            player.sendMessage("§9电网拥有者:" + ownplayer);
            player.sendMessage("§9当前访问者:" + player.name);
            player.sendMessage(info);
            player.sendMessage(extra);
        }else{
            player.sendMessage("§4还未绑定星体网络！");
        }
    }
});

global celestial_network_formatNumberU as function(long,long)string = function (afirst as long,asecond as long) as string{
    var front = "";
    var back = "";
    var first = afirst;
    var second = asecond;
    if(first >= 1000000000000000){
        front += ("§e" + first / 1000000000000000 + " * 10 ^ 54§r") as string;
        first = first % 1000000000000000;
    }else if(first >= 1000000000000){
        front += ("§e" + first / 1000000000000 + " * 10 ^ 51§r") as string;
        first = first % 1000000000000;
    }else if(first >= 1000000000){
        front += ("§e" + first / 1000000000 + " * 10 ^ 48§r") as string;
        first = first % 1000000000;
    }else if(first >= 1000000){
        front += ("§e" + first / 1000000 + " * 10 ^ 45§r") as string;
        first = first % 1000000;
    }else if(first >= 1000){
        front += ("§e" + first / 1000 + " * 10 ^ 42§r") as string;
        first = first % 1000;
    }else if(first != 0){
        front += ("§e" + first + " * 10 ^ 39§r") as string;
    }else if(second >= 1000000000000000){
        back += ("§e" + second  / 1000000000000000 + " * 10 ^ 36§r") as string;
        second = second % 1000000000000000;
    }else if(second >= 1000000000000){
        back += ("§e" + second / 1000000000000 + " * 10 ^ 33§r") as string;
        second = second % 1000000000000;
    }else if(second >= 1000000000){
        back += ("§e" + second / 1000000000 + " * 10 ^ 30§r") as string;
        second = second % 1000000000;
    }else if(second >= 1000000){
        back += ("§e" + second / 1000000 + " * 10 ^ 27§r") as string;
        second = second % 1000000;
    }else if(second >= 1000){
        back += ("§e" + second / 1000 + " * 10 ^ 24§r") as string;
        second = second % 1000;
    }else if(second != 0){
        back += ("§e" + second + " * 10 ^ 21§r") as string;
    }
    val fin = (front + back) as string;
    return fin;
};

global proxyMachineForCelestialNetwork as function(string)void = function (name as string) as void{
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
        if(!event.world.remote&&<contenttweaker:celestial_network_network_card>.matches(item)){
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
                    player.sendMessage("§b已经将此机器加入星体网络！");
                }
                event.cancel();
            }
        }
    });
};
global celestial_network_checkconnected as function(RecipeEvent)bool = function (event as RecipeEvent) as bool{
    val ctrl = event.controller;
    val data = ctrl.customData;
    val dData = D(data);
    val x = dData.getInt("x",0);
    val y = dData.getInt("y",0);
    val z = dData.getInt("z",0);
    val dim = dData.getInt("dim",0);
    val world = IWorld.getFromID(dim);
    val controller = MachineController.getControllerAt(world,x,y,z);
    if(isNull(controller)||controller.blockState.block.definition.id != "modularmachinery:celestial_network_center_factory_controller"){
        return false;
    }else{
        return true;
    }
};
global celestial_network_getController as function(RecipeEvent)IMachineController = function(event as RecipeEvent) as IMachineController{
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
global celestial_network_addEnergy as function(RecipeEvent,long,long)bool = function (event as RecipeEvent,first as long,second as long) as bool{
    if(!celestial_network_checkconnected(event)){
        return false;
    }
    val ctrl = event.controller;
    val world = ctrl.world;
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
global celestial_network_CostEnergy as function(RecipeEvent,long,long)bool = function (event as RecipeEvent,first as long,second as long) as bool{
    if(!celestial_network_checkconnected(event)){
        return false;
    }
    val ctrl = event.controller;
    val world = ctrl.world;
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
global celestial_network_CheckEnergy as function(RecipeEvent,long,long)bool = function (event as RecipeEvent,first as long,second as long) as bool{
    if(!celestial_network_checkconnected(event)){
        return false;
    }
    val ctrl = event.controller;
    val world = ctrl.world;
    val data = ctrl.customData;
    val dData =D(data);
    val map = data.asMap();
    var nowFirst = dData.getLong("first",0);
    var nowSecond = dData.getLong("second",0);
    if((nowFirst < first)||((nowFirst == first)&&(nowSecond < second))){
        return false;
    }else{
        return true;
    }
};
//这个函数的原理是检测发电线程是否工作
//设置多个线程名的原因是因为一个发电机可能有不同的发电线程
/*
global proxyMachineForCelestialNetwork_RecipeSupport as function(RecipeEvent,string,long,int,string,int)bool = function (event as RecipeEvent,machinename as string,long as modifier,int as threadindex,string as threadname,int as recipenameindex) as bool{
    if(!celestial_network_checkconnected(event)){
        return true;
    }
    RecipeBuilder.newBuilder("proxyMachineForCelestialNetwork_RecipeSupport" + machinename + recipenameindex,machinename,1)
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
            if(event.controller.recipeThreadList[threadindex].activeRecipe){
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
                val thread = event.controller.recipeThreadList[threadindex];
                val parallelism_num = thread.activeRecipe.parallelism;
                val second = cndData.getLong("second",0);
                cnmap["second"] = second + 1 * modifier * para;
                cnctrl.customData = cndata;
            }
        })
        .setParallelized(false)
        .addRecipeTooltip("§a坐标卡需要绑定中枢控制器")
        .setThreadName(threadname)
        .build();
};
 */

MachineModifier.setMaxThreads("celestial_network_center",0);
MachineModifier.setInternalParallelism("celestial_network_center", 1048576);
MachineModifier.addCoreThread("celestial_network_center",FactoryRecipeThread.createCoreThread("§5§l网络监控"));
MachineModifier.addCoreThread("celestial_network_center",FactoryRecipeThread.createCoreThread("§5§l固化能源输入"));


RecipeBuilder.newBuilder("celestial_network_network_card","ark_space_station",1200)
    .addInputs([
        <avaritia:resource:6> * 1048576,
        <modularmachinery:qft_factory_controller> * 4,
        <novaeng_core:estorage_cell_item_256m> * 1024,
    ])
    .addInput(<contenttweaker:aw_pmc_pro> * 1024)
    .addInput(<contenttweaker:mm_yzjz> * 16)
    .addInput(<contenttweaker:polymer_matter> * 16)
    .addOutput(<contenttweaker:celestial_network_network_card>)
    .build();

RecipeBuilder.newBuilder("celestial_network_EnerNetCheck","celestial_network_center",20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val world = ctrl.world;
        val data = ctrl.customData;
        val dData =D(data);
        val map = data.asMap();
        map["oldfirst"] = dData.getLong("first",0);
        map["oldsecond"] = dData.getLong("second",0);
        ctrl.customData = data;
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val world = ctrl.world;
        val data = ctrl.customData;
        val dData =D(data);
        val map = data.asMap();
        map["chfirst"] = dData.getLong("first") - dData.getLong("oldfirst");
        map["chsecond"] = dData.getLong("second") - dData.getLong("oldsecond");
        ctrl.customData = data;
    })
    .setParallelized(false)
    .setThreadName("§5§l网络监控")
    .addRecipeTooltip("§5§l监视网络的运行状态，每秒更新能量交互")
    .build();
RecipeBuilder.newBuilder("celestial_network_ItemNetworkInput","celestial_network_center",1)
    .addInput(<contenttweaker:anti_viod> * 4)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val world = ctrl.world;
        val data = ctrl.customData;
        val dData =D(data);
        val map = data.asMap();
        var para = event.activeRecipe.parallelism as long;
        val first = dData.getLong("first",0);
        val second = dData.getLong("second",0);
        var willchange = second + (para * 10) as long;
        map["second"] = willchange;
        ctrl.customData = data;
    })
    .setThreadName("§5§l固化能源输入")
    .addRecipeTooltip("§5§l将负虚空'解压'并输送到星体网络中,共计输入 10 * 10 ^ 21 RF(即10Z)")
    .build();
RecipeBuilder.newBuilder("celestial_network_center_factory_controller","ark_space_station",7200)
    .addInput(<contenttweaker:celestial_network_network_card> * 4)
    .addInput(<modularmachinery:birch_world_factory_controller>)
    .addInput(<modularmachinery:dream_energy_core_factory_controller> * 8)
    .addOutput(<modularmachinery:celestial_network_center_factory_controller>)
    .build();
RecipeBuilder.newBuilder("celestial_network_uploader_factory_controller","ark_space_station",7200)
    .addInput(<modularmachinery:celestial_network_center_factory_controller>).setChance(0)
    .addOutput(<modularmachinery:celestial_network_uploader_factory_controller>)
    .build();
//proxyMachineForCelestialNetwork_RecipeSupport(event,"celestial_network_uploader",1,0,"§a管理中枢链接器",0)
MachineModifier.setInternalParallelism("celestial_network_uploader", 1048576);
MachineModifier.setMaxThreads("celestial_network_uploader",0);
MachineModifier.addCoreThread("celestial_network_uploader",FactoryRecipeThread.createCoreThread("§a管理中枢链接器"));
MachineModifier.addCoreThread("celestial_network_uploader",FactoryRecipeThread.createCoreThread("§5§l固化能源输入"));
RecipeBuilder.newBuilder("celestial_network_uploader_ItemNetworkInput","celestial_network_uploader",20)
    .addInput(<contenttweaker:anti_viod> * 80)
    .setThreadName("§5§l固化能源输入")
    .addRecipeTooltip("§5§l将负虚空'解压'并输送到星体网络中,每Tick输入 10 * 10 ^ 21 RF(即10Z)")
    .build();
RecipeBuilder.newBuilder("proxyMachineForCelestialNetwork_RecipeSupport_celestial_network_uploader_1","celestial_network_uploader",1)
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
                cnmap["second"] = second + 1 * parallelism_num;
                cnctrl.customData = cndata;
            }
        })
        .addRecipeTooltip("§a坐标卡需要绑定中枢控制器")
        .setThreadName("§a管理中枢链接器")
        .build();