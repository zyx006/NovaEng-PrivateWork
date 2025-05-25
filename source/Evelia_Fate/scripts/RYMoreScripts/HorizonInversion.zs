import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.MachineBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.MMEvents;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.RecipeFinishEvent;
import mods.modularmachinery.MachineController;
import mods.modularmachinery.MachineTickEvent;
import mods.modularmachinery.FactoryRecipeStartEvent;
import mods.modularmachinery.ControllerGUIRenderEvent;
import mods.modularmachinery.SmartInterfaceType;
import mods.modularmachinery.RecipeTickEvent;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.RecipeModifierBuilder;

import crafttweaker.world.IWorld;
import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;
import crafttweaker.event.PlayerInteractBlockEvent;

import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.research.ResearchCognitionData;

MMEvents.onControllerGUIRender("Inversion",function(event as ControllerGUIRenderEvent){
    val ctrl = event.controller;
    val world = ctrl.world;
    val data = ctrl.customData;
    val dData = D(data);
    val BlueGiant = dData.getInt("BlueGiant",0);
    val RedSupergiant = dData.getInt("RedSupergiant",0);
    val BlueSupergiant = dData.getInt("BlueSupergiant",0);
    val NearSuperNova = dData.getInt("NearSuperNova",0);
    val BigBlackHole = dData.getInt("BigBlackHole",0);
    val Quasar = dData.getInt("Quasar",0);
    val mode = dData.getInt("mode",0);
    var info as string[] = [];
    info += "§l§c「§e巡天§c」§b寰宇§6监测器";
    info += "§b蓝巨星§f数量        ："+BlueGiant+"|§l§c红超巨星§f数量:"+RedSupergiant;
    info += "§l§3蓝超巨星§f数量    ："+BlueSupergiant+"|§f§l近超新星§r§f数量："+NearSuperNova;
    info += "§l§6大质量黑洞§r§f数量："+BigBlackHole+"|§6§l类星体§r§f数量："+Quasar;
    if(mode == 0){
        info += "§l§c未定位到合适的星体!";
    }else{
        info += "§f§l当前定位的星体为："+change(mode);  
    }
    event.extraInfo = info;
});

function change(mode as int) as string{
    if (mode == 1){
        return "§b蓝巨星";
    }else if(mode == 2){
        return "§l§c红超巨星";
    }else if(mode == 3){
        return "§l§3蓝超巨星";
    }else if(mode == 4){
        return "§f§l近超新星";
    }else if(mode == 5){
        return "§l§6大质量黑洞";
    }else if(mode == 6){
        return "§6§l类星体";
    }
}

HyperNetHelper.proxyMachineForHyperNet("Inversion");
MachineModifier.setMaxThreads("Inversion",0);
MachineModifier.addCoreThread("Inversion",FactoryRecipeThread.createCoreThread("视界反演操纵仪"));
MachineModifier.addCoreThread("Inversion",FactoryRecipeThread.createCoreThread("星体定位器"));
MachineModifier.addCoreThread("Inversion",FactoryRecipeThread.createCoreThread("天体规约器"));
MachineModifier.addCoreThread("Inversion",FactoryRecipeThread.createCoreThread("蓝巨星物质接收器"));
MachineModifier.addCoreThread("Inversion",FactoryRecipeThread.createCoreThread("红超巨星物质接收器"));
MachineModifier.addCoreThread("Inversion",FactoryRecipeThread.createCoreThread("蓝超巨星物质接收器"));
MachineModifier.addCoreThread("Inversion",FactoryRecipeThread.createCoreThread("近超新星物质接收器"));
MachineModifier.addCoreThread("Inversion",FactoryRecipeThread.createCoreThread("大质量黑洞物质接收器"));
MachineModifier.addCoreThread("Inversion",FactoryRecipeThread.createCoreThread("类星体物质接收器"));

RecipeBuilder.newBuilder("ArkBlockHole","Inversion",2147483647)
    .addInputs([
        <contenttweaker:polymer_matter>*8,
        <avaritia:block_resource>*512,
        <additions:novaextended-star_ingot>*16
    ])
    .addEnergyPerTickInput(6000000000000)
    .addRecipeTooltip("制造出一个稳定的黑洞，并对之约束以完成视界反演")
    .setThreadName("视界反演操纵仪")
    .build();

function check(name as int,cnname as string,input as IIngredient[]){
    RecipeBuilder.newBuilder("check"+name,"Inversion",360)
        .addInputs([
            <contenttweaker:charged_max_energy_containers>*4,
            <contenttweaker:world_energy_core>,
            <contenttweaker:polymer_matter>
        ])
        .addInputs(input)
        .addPreCheckHandler(function(event as RecipeCheckEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            val nowmode = dData.getInt("mode",0);
            if(nowmode != 0){
                event.setFailed("已经完成探测！");
            }
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
                event.setFailed("尚不存在完成视界反演的黑洞!");
            }
            if(dData.getBool("ftl",false)){
                ctrl.addModifier("extract", RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.2, 1, false).build());
            }
        })
        .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            map["mode"] = name;
            ctrl.customData = data;
        })
        .setThreadName("星体定位器")
        .addRecipeTooltip("以"+cnname+"为目标进行搜索")
        .addRecipeTooltip("需要完成视界反演的黑洞")
        .addOutput(<contenttweaker:max_energy_containers>*4)
        .build();
}
check(1,"蓝巨星",[<additions:novaextended-ark_circuit>*16,<contenttweaker:charging_crystal_block>*8,<super_solar_panels:crafting:25>*16]);
check(2,"红超巨星",[<mekanism:controlcircuit:4>*2,<super_solar_panels:crafting:25>*18,<super_solar_panels:machines:11>*8]);
check(3,"蓝超巨星",[<environmentaltech:solar_cont_6>*32,<additions:novaextended-star_ingot>*64,<astralsorcery:itemcraftingcomponent:1>*128]);
check(4,"近超新星",[<avaritia:block_resource>*64,<additions:novaextended-crystal4>*48,<contenttweaker:additional_component_3>*32]);
check(5,"大质量黑洞",[<eternalsingularity:eternal_singularity>*128,<moreplates:neutronium_plate>*640,<super_solar_panels:spectral_battery>*8]);
check(6,"类星体",[<super_solar_panels:machines:47>*4,<contenttweaker:tyf3>*128,<contenttweaker:arkforcefieldcontrolblock>*8]);

function starlauncher(mode as int,name as string,cnname as string,time as int,input as IIngredient[]){
    RecipeBuilder.newBuilder(name,"Inversion",time)
        .addInput(<contenttweaker:charged_max_energy_containers>*8)
        .addInputs(input)
        .addOutput(<contenttweaker:max_energy_containers>*8)
        .addPreCheckHandler(function(event as RecipeCheckEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            val nowmode =dData.getInt("mode",0);
            if(nowmode != mode){
                event.setFailed("尚未探测到"+cnname+"!");
            }
            if(dData.getBool("ftl",false)){
                ctrl.addModifier("ftlspeed", RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.2, 1, false).build());
            }
            ctrl.customData = data;
        })
        .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            val star = dData.getInt(name,0);
            map[name] = star + 1;
            map["mode"] = 0;
            ctrl.customData = data;
        })
        .setThreadName("天体规约器")
        .addRecipeTooltip("向"+cnname+"发射太阳帆，需要先探测到"+cnname)
        .build();
}
starlauncher(1,"BlueGiant","蓝巨星",540,
    [
        <avaritiaio:infinitecapacitor>*16,
        <contenttweaker:charging_crystal_block>*32,
        <contenttweaker:tyf3>*4096,
        <contenttweaker:arkforcefieldcontrolblock>*16,
        <additions:novaextended-star_ingot>*256,
        <contenttweaker:antimatter_core>*8,
    ]
);
starlauncher(2,"RedSupergiant","红超巨星",1200,
    [
        <avaritiaio:infinitecapacitor>*64,
        <contenttweaker:charging_crystal_block>*192,
        <contenttweaker:tyf3>*32768,
        <contenttweaker:arkforcefieldcontrolblock>*48,
        <additions:novaextended-star_ingot>*1024,
        <contenttweaker:antimatter_core>*36,
    ]
);
starlauncher(3,"BlueSupergiant","蓝超巨星",1800,
    [
        <avaritiaio:infinitecapacitor>*128,
        <contenttweaker:charging_crystal_block>*256,
        <contenttweaker:tyf3>*65536,
        <contenttweaker:arkforcefieldcontrolblock>*96,
        <additions:novaextended-star_ingot>*2560,
        <contenttweaker:antimatter_core>*96,
    ]
);
starlauncher(4,"NearSuperNova","近超新星",1100,
    [
        <novaeng_core:geocentric_drill_controller>,
        <environmentaltech:void_res_miner_cont_6>*12,
        <environmentaltech:structure_frame_6>*1024,
        <environmentaltech:modifier_speed>*64,
        <moreplates:neutronium_plate>*256
    ]
);
starlauncher(5,"BigBlackHole","大质量黑洞",800,
    [
        <contenttweaker:additional_component_3>*64,
        <additions:novaextended-star_ingot>*512,
        <contenttweaker:industrial_circuit_v4>*32,
        <avaritia:block_resource:1>*64,
        <modularmachinery:star_collapser_controller>
    ]
);
starlauncher(6,"Quasar","类星体",2400,
    [
        <contenttweaker:world_energy_core>*8,
        <contenttweaker:space_time_condensation_block>*64,
        <contenttweaker:industrial_circuit_v4>*64,
        <contenttweaker:field_generator_v4>*128,
        <contenttweaker:arkforcefieldcontrolblock>*128
    ]
);

RecipeBuilder.newBuilder("BlueGiantRe","Inversion",20)
    .addInput(<contenttweaker:max_energy_containers>*4)
    .addOutputs([
        <contenttweaker:charged_max_energy_containers>*4,
        <mekanism:antimatterpellet>*128,
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val BlueGiantNum = dData.getInt("BlueGiant",0);
        if(BlueGiantNum == 0){
            event.setFailed("尚不存在已规约的蓝巨星!");
        }else{
            event.activeRecipe.maxParallelism = BlueGiantNum;
        }
    })
    .addRecipeTooltip("接受规约后的蓝巨星的物质以及能源")
    .setThreadName("蓝巨星物质接收器")
    .build();
RecipeBuilder.newBuilder("RedSupergiantRe","Inversion",20)
    .addInput(<contenttweaker:max_energy_containers>*20)
    .addOutput(<contenttweaker:charged_max_energy_containers>*20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val map = data.asMap();
        val RedSupergiantNum = dData.getInt("RedSupergiant",0);
        if(RedSupergiantNum == 0){
            event.setFailed("尚不存在已规约的红超巨星!");
        }else{
            event.activeRecipe.maxParallelism = RedSupergiantNum;
        }
    })
    .addRecipeTooltip("接受规约后的红超巨星的物质以及能源")
    .setThreadName("红超巨星物质接收器")
    .build();
RecipeBuilder.newBuilder("BlueSupergiantRe","Inversion",20)
    .addInput(<contenttweaker:max_energy_containers>*20)
    .addOutputs([
        <contenttweaker:charged_max_energy_containers>*20,
        <contenttweaker:steady_supercritical_photons>*65536,
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val BlueSupergiantNum = dData.getInt("BlueSupergiant",0);
        if(BlueSupergiantNum == 0){
            event.setFailed("尚不存在已规约的蓝超巨星！");
        }else{
            event.activeRecipe.maxParallelism = BlueSupergiantNum;
        }
    })
    .addRecipeTooltip("接受规约后的蓝超巨星的物质以及能源")
    .setThreadName("蓝超巨星物质接收器")
    .build();
RecipeBuilder.newBuilder("NearSuperNovaRe","Inversion",3600)
    .addInputs([
        <contenttweaker:ark_launch_vehicle>*64,
        <contenttweaker:max_energy_containers>*1280,
        <contenttweaker:arkforcefieldcontrolblock>*16
    ])
    .addOutputs([
        <contenttweaker:ark_launch_vehicle>*16,
        <contenttweaker:charged_max_energy_containers>*1280,
        <avaritia:block_resource>*16384,
        <contenttweaker:arkforcefieldcontrolblock>*8
    ])
    .addOutput(<contenttweaker:ark_launch_vehicle>*16).setChance(0.5)
    .addOutput(<contenttweaker:arkforcefieldcontrolblock>*8).setChance(0.8)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val NearSuperNovaNum =dData.getInt("NearSuperNova",0);
        if(NearSuperNovaNum == 0){
            event.setFailed("尚不存在已规约的近超新星！");
        }
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val map = data.asMap();
        val NearSuperNovaNum =dData.getInt("NearSuperNova",0);
        map["NearSuperNova"] = NearSuperNovaNum - 1;
        ctrl.customData = data;
    })
    .addRecipeTooltip("接受规约后的近超新星的物质以及能源")
    .setThreadName("近超新星物质接收器")
    .build();
RecipeBuilder.newBuilder("BigBlackHoleRe","Inversion",20)
    .addInputs([
        <contenttweaker:ark_launch_vehicle>*16,
        <contenttweaker:max_energy_containers>*8
    ])
    .addOutputs([
        <contenttweaker:ark_launch_vehicle>*16,
        <contenttweaker:charged_max_energy_containers>*16,
        <contenttweaker:max_energy_containers>*32,
        <contenttweaker:fragments_of_the_space_time_continuum>*32,
        <contenttweaker:dark_matter>*8,
        <contenttweaker:space_time_condensation_block>*8,
        <liquid:space_time_fluids>*512
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val BigBlackHoleNum = dData.getInt("BigBlackHole",0);
        if(BigBlackHoleNum == 0){
            event.setFailed("尚不存在已规约的大质量黑洞");
        }else{
            event.activeRecipe.maxParallelism = BigBlackHoleNum;
        }
    })
    .addRecipeTooltip("接受规约后的大质量黑洞的物质以及能源")
    .setThreadName("大质量黑洞物质接收器")
    .build();
RecipeBuilder.newBuilder("QuasarRe","Inversion",20)
    .addInputs([
        <contenttweaker:ark_launch_vehicle>*64,
        <contenttweaker:arkforcefieldcontrolblock>*64,
        <contenttweaker:tyf3>*128,
        <contenttweaker:max_energy_containers>*32
    ])
    .addOutputs([
        <contenttweaker:ark_launch_vehicle>*32,
        <contenttweaker:arkforcefieldcontrolblock>*48,
        <contenttweaker:tyf3>*64,
        <contenttweaker:truthmatrix>*16,
        <contenttweaker:charged_max_energy_containers>*32,
        <contenttweaker:polymer_matter>,
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val QuasarNum = dData.getInt("Quasar",0);
        if(QuasarNum == 0){
            event.setFailed("尚不存在已规约的类星体部分");
        }else{
            event.activeRecipe.maxParallelism = QuasarNum;
        }
    })
    .addRecipeTooltip("接受规约后的类星体的物质以及能源")
    .setThreadName("类星体物质接收器")
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
        if(!isNull(block)&&block.definition.id == "modularmachinery:inversion_factory_controller"){
            val ctrl = MachineController.getControllerAt(world, xc, yc, zc);
            val data =ctrl.customData;
            val ftl = D(data).getBool("ftl",false);
            if(!ftl){
                data.asMap()["ftl"] = true;
                ctrl.customData = data;
                item.mutable().shrink(1);
                player.sendMessage("§b成功安装超光速核心！");
                event.cancel();
            }else{
                player.sendMessage("§b已经安装过超光速核心了！");
                event.cancel();
            }
        }
    }
});
