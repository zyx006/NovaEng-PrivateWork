#reloadable

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

RecipeBuilder.newBuilder("artificial_star_con","workshop",7200)
    .addInputs([
        <modularmachinery:extreme_stellarator_factory_controller> * 4,
        <modularmachinery:prototype_factory_controller> * 2,
        <contenttweaker:charging_crystal_block> * 128,
        <contenttweaker:antimatter_core> * 6,
        <contenttweaker:arkmachineblock> * 37,
        <contenttweaker:arkforcefieldcontrolblock> * 61
    ])
    .addEnergyPerTickInput(1600000000000)
    .addOutput(<modularmachinery:artificial_star_factory_controller>)
    .requireResearch("artificial_star")
    .requireComputationPoint(9999.0F)
    .build();

MachineModifier.addSmartInterfaceType("artificial_star",
    SmartInterfaceType.create("maxstorage", 1)
        .setHeaderInfo("恒星大小设置")
        .setValueInfo("上限：§a%.0f ")
        .setFooterInfo("恒星存在时修改此数值无效")
        .setJeiTooltip("大小范围：最低 §a%.0f 倍§f，最高 §a%.0f 倍", 2)
        .setNotEqualMessage("§a过大或过小！")
);
MMEvents.onMachinePostTick("artificial_star", function(event as MachineTickEvent) {
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    val nullable = ctrl.getSmartInterfaceData("maxstorage");
    var maxstorage = isNull(nullable) ? 1.0f : nullable.value;
    //检查数据正确性
    if (maxstorage < 1) {
        nullable.value = 1;
    }else if(maxstorage > 10){
        nullable.value = 10;
    }
    if(!isNull(ctrl.recipeThreadList[0].activeRecipe)){
        maxstorage = D(data).getInt("maxstorage",1) as float;
    }
    map["maxstorage"] = maxstorage;
    ctrl.customData = data;
});

MachineModifier.setMaxThreads("artificial_star", 0);
MachineModifier.addCoreThread("artificial_star", FactoryRecipeThread.createCoreThread("恒星维护"));
MachineModifier.addCoreThread("artificial_star", FactoryRecipeThread.createCoreThread("氢气输入"));
MachineModifier.addCoreThread("artificial_star", FactoryRecipeThread.createCoreThread("氦-3输入"));
MachineModifier.addCoreThread("artificial_star", FactoryRecipeThread.createCoreThread("中子输入"));
MachineModifier.addCoreThread("artificial_star", FactoryRecipeThread.createCoreThread("星能注入"));
MachineModifier.addCoreThread("artificial_star", FactoryRecipeThread.createCoreThread("氘输入"));
MachineModifier.addCoreThread("artificial_star", FactoryRecipeThread.createCoreThread("氚输入"));

MMEvents.onControllerGUIRender("artificial_star",function(event as ControllerGUIRenderEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val dData =D(data);
    val maxstorage = dData.getInt("maxstorage",1) - 1;
    val hydrogen = dData.getLong("hydrogen",0);
    val photos = dData.getLong("photos",0);
    val helium = dData.getLong("helium",0);
    val ftl = dData.getBool("ftl",false);
    val neutron = dData.getInt("neutron",0);
    val tritium = dData.getLong("tritium",0);
    val deuterium = dData.getLong("deuterium",0);
    val MaxH = expo(3,(maxstorage  + 1)) * 1000000;
    val MaxHe = expo(2,(maxstorage + 1)) * 2000000;
    var timemagn = 1.0f / expo(2,maxstorage);
    var itemmagn = 1.0f * expo(4,maxstorage);
    var enermagn = (1.0f * expo(4,maxstorage) + (1.0f + (0.2f * tritium/100000) * (0.2f * deuterium/10000))) * (1.0f + (0.01f * photos));
    if(neutron == (maxstorage + 1)){
        timemagn *= 5.0f;
        itemmagn *= 5.0f;
        enermagn *= 5.0f;
    }
    if(ftl){
        timemagn *= 0.25f;
        enermagn *= 5.0f;
    }
    var info as string[] = [];
    if(isNull(ctrl.recipeThreadList[0].activeRecipe)){
        info += "………………恒星预备中………………";
        info += "氢气量：" + hydrogen + "/" + MaxH +"mb";
        info += "氦气量：" + helium + "/" + MaxHe + "mb";
        info += "氘含量：" + deuterium + "mb";
        info += "氚含量：" + tritium + "mb";
        info += "星能含量：" + photos + "";
        info += "当前中子素等级：" + neutron + "/" + (maxstorage + 1);
    }else{
        info += "——————恒星监测装置——————";
        info += "当前恒星级别：" + (maxstorage + 1);
        info += "物品倍率：" + itemmagn;
        info += "能量倍率：" + enermagn;
        info += "时间倍率：" + timemagn;
    }
    if(dData.getBool("ftl",false)){
        info += "已启用§c超§6光§e速§a核§b心";
    }
    event.extraInfo = info;
});

RecipeBuilder.newBuilder("hydrogen_input","artificial_star",5)
    .addInput(<liquid:hydrogen> * 1000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val dData =D(data);
        val maxstorage = dData.getInt("maxstorage",1);
        val hydrogen = dData.getLong("hydrogen",0);
        val hydrogen_max =  expo(3,maxstorage) * 1000000;
        val needhydrogen = hydrogen_max - hydrogen;
        if(hydrogen >= hydrogen_max){
            event.setFailed("氢气存储已达极限！");
        }else if(!isNull(ctrl.recipeThreadList[0].activeRecipe)){
            event.setFailed("恒星已经存在！");
        }
        if(needhydrogen > 8192000){
            event.activeRecipe.maxParallelism = 8192;
        }else{
            event.activeRecipe.maxParallelism = (needhydrogen / 1000) as int;
        }
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val dData =D(data);
        val hydrogen = dData.getLong("hydrogen",0);
        val para = event.activeRecipe.parallelism;
        map["hydrogen"] = hydrogen + (1000 * para);
        ctrl.customData = data;
    })
    .setThreadName("氢气输入")
    .addRecipeTooltip("将输入仓之中的氢存储到机器内部","上限取决于智能数据接口之中的设置，最大有8192的并行")
    .build();
RecipeBuilder.newBuilder("helium_input","artificial_star",5)
    .addInput(<liquid:helium_3> * 1000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val dData =D(data);
        val maxstorage = dData.getInt("maxstorage",1);
        val helium = dData.getLong("helium",0);
        val helium_max = expo(2,maxstorage) * 2000000;
        val needhelium = helium_max - helium;
        if(helium >= helium_max){
            event.setFailed("氦气存储已达极限！");
        }else if(!isNull(ctrl.recipeThreadList[0].activeRecipe)){
            event.setFailed("恒星已经存在！");
        }
        if(needhelium > 8192000){
            event.activeRecipe.maxParallelism = 8192;
        }else{
            event.activeRecipe.maxParallelism = (needhelium / 1000) as int;
        }
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val dData =D(data);
        val helium = dData.getLong("helium",0);
        val para = event.activeRecipe.parallelism;
        map["helium"] = helium + (1000 * para);
        ctrl.customData = data;
    })
    .setThreadName("氦-3输入")
    .addRecipeTooltip("将输入仓之中的氦存储到机器内部","上限取决于智能数据接口之中的设置，最大有8192的并行")
    .build();
RecipeBuilder.newBuilder("neutron_input","artificial_star",20)
    .addInput(<avaritia:block_resource> * 128)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData =D(data);
        val map = data.asMap();
        val maxstorage = dData.getInt("maxstorage",1);
        val neutron = dData.getInt("neutron",0);
        if(neutron == maxstorage){
            event.setFailed("已经添加了中子素！");
        }
        if(!isNull(ctrl.recipeThreadList[0].activeRecipe)){
            event.setFailed("恒星已经存在！");
        }
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData =D(data);
        val map = data.asMap();
        val neutron = dData.getInt("neutron",0);
        map["neutron"] = neutron + 1;
        ctrl.customData = data;
    })
    .setThreadName("中子输入")
    .addRecipeTooltip("将中子素添加到预备恒星之中","需求数量可阅读控制器的tooltips")
    .build();
RecipeBuilder.newBuilder("photons_input","artificial_star",5)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <contenttweaker:steady_supercritical_photons> * 1024,
                <contenttweaker:ljgz> * 1048576
            ])
    )
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 1024;
        if(!isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("恒星已经存在！");
        }
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val dData =D(data);
        val photos = dData.getLong("photos",0);
        val para = event.activeRecipe.parallelism;
        map["photos"] = photos + para;
        ctrl.customData = data;
    })
    .setThreadName("星能注入")
    .addRecipeTooltip("为恒星注入星能，最大1024并行","每1并行完成提供1%能量倍率")
    .build();
RecipeBuilder.newBuilder("tritium_input","artificial_star",5)
    .addInput(<liquid:tritium> * 1000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        event.activeRecipe.maxParallelism = 512;
        if(!isNull(ctrl.recipeThreadList[0].activeRecipe)){
            event.setFailed("恒星已经存在！");
        }
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val dData =D(data);
        val tritium = dData.getLong("tritium",0);
        val para = event.activeRecipe.parallelism;
        map["tritium"] = tritium + (para * 1000);
        ctrl.customData = data;
    })
    .addRecipeTooltip("将氚添加到预备恒星之中，加成可查看控制器的tooltips","最大有着512并行")
    .setThreadName("氚输入")
    .build();
RecipeBuilder.newBuilder("deuterium_input","artificial_star",5)
    .addInput(<liquid:deuterium> * 1000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        event.activeRecipe.maxParallelism = 512;
        if(!isNull(ctrl.recipeThreadList[0].activeRecipe)){
            event.setFailed("恒星已经存在！");
        }
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val dData =D(data);
        val deuterium = dData.getLong("deuterium",0);
        val para = event.activeRecipe.parallelism;
        map["deuterium"] = deuterium + (para * 1000);
        ctrl.customData = data;
    })
    .addRecipeTooltip("将氘添加到预备恒星之中，加成可查看控制器的tooltips","最大有着512并行")
    .setThreadName("氘输入")
    .build();

AddEnergyMachine("artificial_star");
RecipeBuilder.newBuilder("artificial_star","artificial_star",360000)
    .addInputs([
        <contenttweaker:fwzrlb> * 1,
        <additions:novaextended-crystal4> * 8,
        <liquid:crystalloid> * 3600000
    ])
    .addOutputs([
        <avaritia:resource:5> * 64,
        <contenttweaker:crystalred> * 256,
        <contenttweaker:crystalpurple> * 320,
        <contenttweaker:crystalgreen> * 256
    ])
    .addFluidPerTickOutput(<liquid:liquid_energy>)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData =D(data);
        val world = ctrl.world;
        var pos = rotate(ctrl.pos,ctrl.facing.name);
        val star = dData.getBool("star",false);
        val maxstorage = dData.getInt("maxstorage",1) - 1;
        val hydrogen = dData.getLong("hydrogen",0);
        val helium = dData.getLong("helium",0);
        val ReqH = expo(3,maxstorage) * 1000000;
        val reqHe = expo(2,maxstorage) * 2000000;
        var EnerCost = 1000000000000000 as long;
        var magn = 2 * expo(4,maxstorage);
        var first = 0;
        if(magn > 1000){
            first = magn / 1000;
            magn = magn % 1000;
        }
        EnerCost *= magn;
        if(hydrogen < ReqH){
            event.setFailed("氢储量不够！");
        }else if(helium < reqHe){
            event.setFailed("氦储量不够！");
        }else if(!CheckEnergy(event,first,EnerCost)){
            event.setFailed("电网中的电量不够！");
        }
        if(isNull(ctrl.recipeThreadList[0].activeRecipe)){
            Sync.addSyncTask(function(){
                if (!world.remote) {
                    world.setBlockState(<blockstate:minecraft:air>,pos);
                }
            });
        }
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val world = ctrl.world;
        val map = data.asMap();
        map["star"] = true;
        val photos = dData.getLong("photos",0);
        val neutron = dData.getInt("neutron",0);
        val maxstorage = dData.getInt("maxstorage",1) - 1;
        val tritium = dData.getLong("tritium",0);
        val deuterium = dData.getLong("deuterium",0);
        val ftl = dData.getBool("ftl",false);
        var EnerCost = 1000000000000000 as long;
        var magn = 2 * expo(4,maxstorage);
        var first = 0;
        if(magn > 1000){
            first = magn / 1000;
            magn = magn % 1000;
        }
        EnerCost *= magn;
        CostEnergy(event,first,EnerCost);
        var timemagn = 1.0f / expo(2,maxstorage);
        var itemmagn = 1.0f * expo(4,maxstorage);
        var enermagn = (1.0f * expo(4,maxstorage)) * (1.0f + (0.2f * tritium/100000) * (0.2f * deuterium/10000)) * (1.0f + (0.01f * photos));
        if(neutron == (maxstorage + 1)){
            timemagn *= 5.0f;
            itemmagn *= 5.0f;
            enermagn *= 5.0f;
        }
        if(ftl){
            timemagn *= 0.25f;
            enermagn *= 5.0f;
        }
        event.factoryRecipeThread.addModifier("AS_itemoutput",RecipeModifierBuilder.create("modularmachinery:item", "output",itemmagn, 1, false).build());
        event.factoryRecipeThread.addModifier("AS_energyoutput",RecipeModifierBuilder.create("modularmachinery:fluid", "output",enermagn, 1, false).build());
        event.factoryRecipeThread.addModifier("AS_timemagn",RecipeModifierBuilder.create("modularmachinery:duration", "input",timemagn, 1, false).build());
    })
    .addFactoryPreTickHandler(function (event as FactoryRecipeTickEvent) {
        val tick = event.factoryRecipeThread.activeRecipe.tick;
        if (tick % 150 == 0){
            val ctrl = event.controller;
            val world = ctrl.world;
            var pos = rotate(ctrl.pos,ctrl.facing.name);
            Sync.addSyncTask(function(){
                if (!world.remote) {
                    world.setBlockState(<blockstate:draconicevolution:reactor_core>,{BCManagedData: {reactorState: 0 as byte, reactableFuel: 1300000.0,explosionCountdown:-1,temperature:18000.0,maxSaturation:0,maxShieldCharge: 0}},pos);
                }
            });
        }
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData =D(data);
        val world = ctrl.world;
        val map = data.asMap();
        var pos = rotate(ctrl.pos,ctrl.facing.name);
        val neutron = dData.getInt("neutron",0);
        val photos = dData.getLong("photos",0);
        val maxstorage = dData.getInt("maxstorage",1) - 1;
        val tritium = dData.getLong("tritium",0) / 100000;
        val deuterium = dData.getLong("deuterium",0) / 100000;
        var enermagn = (1.0f * expo(4,maxstorage) + (1.0f + (0.2f * tritium/100000) * (0.2f * deuterium/10000))) * (1.0f + (0.01f * photos));
        if(neutron == (maxstorage + 1)) enermagn *= 4.0f;
        var first = 0;
        var magn = 4 * enermagn;
        if(magn > 1000){
            first = magn / 1000;
            magn = magn % 1000; 
        }
        var EnerCost = 1000000000000000 as long;
        EnerCost = EnerCost * magn;
        addEnergy(event,first,EnerCost);
        map["tritium"] = 0;
        map["deuterium"] = 0;
        map["hydrogen"] = 0;
        map["helium"] = 0;
        map["neutron"] = 0;
        map["photos"] = 0;
        ctrl.customData = data;
        Sync.addSyncTask(function(){
            if (!world.remote) {
                world.setBlockState(<blockstate:minecraft:air>,pos);
            }
        });
    })
    .setThreadName("恒星维护")
    .addRecipeTooltip("借助于反物质所蕴含着的庞大能量引爆异世界水晶","大量的紫晶素会稳定爆炸时的时空，令恒星得以产生星能")
    .build();

events.onPlayerRightClickBlock(function(event as PlayerInteractBlockEvent){
    val block = event.block;
    val item = event.item;
    val xc  = event.position.x;
    val yc  = event.position.y;
    val zc  = event.position.z;
    val dim = event.world.provider.dimensionID;
    val world = IWorld.getFromID(dim);
    val player = event.player;
    if(!event.world.remote&&<contenttweaker:superluminal_core>.matches(item)){
        if(!isNull(block)&&block.definition.id == "modularmachinery:artificial_star_factory_controller"){
            val ctrl = MachineController.getControllerAt(world, xc, yc, zc);
            val data =ctrl.customData;
            val ftl = D(data).getBool("ftl",false);
            if(!ftl){
                data.asMap()["ftl"] = true;
                ctrl.customData = data;
                player.sendMessage("§b成功安装超光速核心！");
                event.cancel();
            }else{
                player.sendMessage("§b已经安装过超光速核心了！");
                event.cancel();
            }
        }
    }
});

function expo(a as int,b as int) as long{
    var answer = 1 as long;
    if(b == 0){
        return a as long;
    }
    for i in 0 to b{
        answer = answer * a;
    }
    return answer;
}
function rotate(pos as IBlockPos,facing as string) as IBlockPos{
    var x = pos.x;
    var y = pos.y - 59;
    var z = pos.z;
    if(facing == "NORTH"){
        z = pos.z + 21;
    }else if(facing == "SOUTH"){
        z = pos.z - 21;
    }else if(facing == "EAST"){
        x = pos.x - 21;
    }else if(facing == "WEST"){
        x = pos.x + 21;
    }
    val mpos = IBlockPos.create(x,y,z);
    return mpos;
}