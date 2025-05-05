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

RecipeBuilder.newBuilder("phantom_energy_white_hole_creator_factory_controller","ark_space_station",7200)
    .addInputs([
        <modularmachinery:xihe_star_creation_device_controller> * 1024,
        <modularmachinery:tsl_controller> * 1024,
        <contenttweaker:charging_crystal_block> * 1073741824,
        <contenttweaker:antimatter_core> * 1048576,
        <contenttweaker:arkmachineblock> * 1048576,
        <contenttweaker:arkforcefieldcontrolblock> * 1048576,
    ])
    .addEnergyPerTickInput(1600000000000)
    .addOutput(<modularmachinery:phantom_energy_white_hole_creator_factory_controller>)
    .requireResearch("aw_phantom_energy")
    .requireComputationPoint(1000.0F * 1000)
    .build();

MachineModifier.setMaxThreads("phantom_energy_white_hole_creator", 0);
MachineModifier.addCoreThread("phantom_energy_white_hole_creator", FactoryRecipeThread.createCoreThread("§5§l白洞创生"));
MachineModifier.addCoreThread("phantom_energy_white_hole_creator", FactoryRecipeThread.createCoreThread("§6§l恒星创生"));
MachineModifier.addCoreThread("phantom_energy_white_hole_creator", FactoryRecipeThread.createCoreThread("§5§l湮灭发电机"));
MachineModifier.addCoreThread("phantom_energy_white_hole_creator", FactoryRecipeThread.createCoreThread("§9§l太阳帆单元"));
MachineModifier.addCoreThread("phantom_energy_white_hole_creator", FactoryRecipeThread.createCoreThread("§5§l超维框架"));
MachineModifier.addCoreThread("phantom_energy_white_hole_creator", FactoryRecipeThread.createCoreThread("§a管理中枢链接器"));
<modularmachinery:phantom_energy_white_hole_creator_factory_controller>.addTooltip("这台机器需要/产出的RF太多!无法使用常规手段供电/输出!");
<modularmachinery:phantom_energy_white_hole_creator_factory_controller>.addTooltip("注:我不为你不绑定中枢控制器所以不产出能量的行为负责");

MMEvents.onControllerGUIRender("phantom_energy_white_hole_creator",function(event as ControllerGUIRenderEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val dData =D(data);
    val fctrl = event.controller;
    val fdata = fctrl.customData;
    val fdData = D(fdata);
    val y = fdData.getInt("y", 0);
    val blokkat_frame = dData.getLong("blokkat_frame",0);
    var info as string[] = [];
        info += "§5§l超维框架数量：" + blokkat_frame + "/64";
    event.extraInfo = info;
});

RecipeBuilder.newBuilder("blokkat_frame_input","phantom_energy_white_hole_creator",5)
    .addInputs([
        <contenttweaker:blokkat_frame>
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            val blokkat_frame =dData.getInt("blokkat_frame",0);
            if (blokkat_frame > 63) {
                    event.setFailed("超维框架到达上限");
                    return;
                }
        })
        .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val blokkat_frame =dData.getInt("blokkat_frame",0);
            val thread = event.factoryRecipeThread;
            val parallelism_num = thread.activeRecipe.parallelism;
            data.asMap()["blokkat_frame"] = blokkat_frame + 1 * parallelism_num;
            event.controller.recipeThreadList[5].addModifier("fxk_output", RecipeModifierBuilder.create("modularmachinery:item", "output",blokkat_frame, 1, false).build());
            ctrl.customData = data;
        })
    .setThreadName("§5§l超维框架")
    .addRecipeTooltip("§5§l输入1§5§l超维框架§f")
    .addRecipeTooltip("§5§l增幅白洞创生线程与恒星创生线程")
    .build();
proxyMachineForCelestialNetwork("phantom_energy_white_hole_creator");
RecipeBuilder.newBuilder("phantom_energy_white_hole_creator_create_star","phantom_energy_white_hole_creator",360000)
    .addInputs([
        <liquid:liquidfusionfuel> * 1000000000,
        <liquid:helium_3> * 1000000000
    ])
    .setParallelized(false)
    .setThreadName("§6§l恒星创生")
    .addRecipeTooltip("通过巨量物质创生一个恒星")
    .addRecipeTooltip("§5§l星体网络§f能量输出:(8 * 超维框架数量² * 10 ^ 21)RF/Tick")
    .build();
RecipeBuilder.newBuilder("phantom_energy_white_hole_creator_create_whitehole","phantom_energy_white_hole_creator",360000)
    .addInputs([
        <contenttweaker:stellaris_alloy> * 327680,
        <contenttweaker:anti_viod> * 16384
    ])
    .setParallelized(false)
    .setThreadName("§5§l白洞创生")
    .addRecipeTooltip("通过巨量物质创生数个黑洞并通过负虚空逆变中心黑洞为白洞并投放剩余黑洞")
    .addRecipeTooltip("§5§l星体网络§f能量输出:(8 * 超维框架数量² * 10 ^ 27)RF/Tick")
    .build();
RecipeBuilder.newBuilder("phantom_energy_white_hole_creator_hxsfd","phantom_energy_white_hole_creator",1200)
    .addInputs([
        <contenttweaker:hxsrlb> * 16384000
    ])
    .addOutput(<liquid:yzs> * 10000)
    .addRecipeTooltip("§6§l需创生白洞")
    .setThreadName("§5§l湮灭发电机")
    .addRecipeTooltip("§5§l星体网络§f能量输出: 4 * 超维框架数量² * 10 ^ 24")
    .build();
RecipeBuilder.newBuilder("phantom_energy_white_hole_creator_tyf","phantom_energy_white_hole_creator",1200)
    .addInputs([
        <contenttweaker:tyf3> * 1024000
    ])
    .setThreadName("§9§l太阳帆单元")
    .addRecipeTooltip("§6§l需创生恒星")
    .addRecipeTooltip("§5§l星体网络§f能量输出: 1 * 超维框架数量² * 10 ^ 21")
    .build();
RecipeBuilder.newBuilder("PEWHC_ZBK_INPUT","phantom_energy_white_hole_creator",1)
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
                            val second = cndData.getLong("second",0);
                            val blokkat_frame = dData.getInt("blokkat_frame", 0);
                            cnmap["second"] = second + 8000000 * blokkat_frame * blokkat_frame;
                            cnctrl.customData = cndata;
                        
            }
            if(event.controller.recipeThreadList[1].activeRecipe){
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
                            val second = cndData.getLong("second",0);
                            val blokkat_frame = dData.getInt("blokkat_frame", 0);
                            cnmap["second"] = second + 8 * blokkat_frame * blokkat_frame;
                            cnctrl.customData = cndata;
                        
            }
            if(event.controller.recipeThreadList[2].activeRecipe){
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
                            val second = cndData.getLong("second",0);
                            val blokkat_frame = dData.getInt("blokkat_frame", 0);
                            cnmap["second"] = second + 400 * blokkat_frame * blokkat_frame;
                            cnctrl.customData = cndata;
                        
            }
            if(event.controller.recipeThreadList[3].activeRecipe){
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
                            val second = cndData.getLong("second",0);
                            val blokkat_frame = dData.getInt("blokkat_frame", 0);
                            cnmap["second"] = second + 1 * blokkat_frame * blokkat_frame;
                            cnctrl.customData = cndata;
                        
            }
        })
        .addItemOutput(<contenttweaker:anti_viod> * 16).setIgnoreOutputCheck(true)
        .setParallelized(false)
        .addRecipeTooltip("§a坐标卡需要绑定中枢控制器")
        .addRecipeTooltip("§a吸收时空凝结体的能量,固定产出16负虚空")
        .setThreadName("§a管理中枢链接器")
        .build();