
#loader crafttweaker reloadable

import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.FactoryRecipeStartEvent;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.RecipeModifierBuilder;

import crafttweaker.block.IBlock;
import crafttweaker.item.IItemStack;

recipes.addShaped("labell",<modularmachinery:shadow_factory_controller>,
    [
        [<botania:livingrock:4>,<botania:runealtar>,<botania:livingrock:4>],
        [<extrabotany:elfjar>,<botania:specialflower>.withTag({type: "jadedAmaranthus"}),<extrabotany:pedestal>],
        [<botania:pool:3>,<botania:pylon:2>,<botania:pool:3>]
    ]
);

MachineModifier.setMaxThreads("shadow",0);
MachineModifier.addCoreThread("shadow",FactoryRecipeThread.createCoreThread("结构检测"));
MachineModifier.addCoreThread("shadow",FactoryRecipeThread.createCoreThread("物品产出"));
RecipeBuilder.newBuilder("check_elfjar","shadow",20)
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val world = ctrl.world;
        val facing = ctrl.facing.name;
        val pos = ctrl.pos;
        val data = ctrl.customData;
        val dData = D(data);
        val map = data.asMap();
        var x = pos.x;
        var y = pos.y + 2;
        var z = pos.z;
        if(facing == "NORTH"){
            z = pos.z + 4;
        }else if(facing == "SOUTH"){
            z = pos.z - 4;
        }else if(facing == "EAST"){
            x = pos.x - 4;
        }else if(facing == "WEST"){
            x = pos.x + 4;
        }
        val block = world.getBlock(x,y,z);
        val liquid  = "water";
        val amount = block.data.Fluid.Amount as int / 1000;
        val basemagn = 1.0f;
        val fluid = block.data.Fluid.FluidName as string;
        if(fluid == "fluidedmana"){
            map["para"] = amount * 4;
            map["magn"] = basemagn - (0.02f * amount);
        }else if(fluid == "terrasteel"){
            map["para"] = amount * 6;
            map["magn"] = basemagn - (0.03f * amount);
        }else if(fluid == "crystalloid"){
            map["para"] = amount * 12;
            map["magn"] = basemagn - (0.04f * amount);
        }else if(fluid == "unsteady_plasma"){
            map["para"] = amount * 16;
            map["magn"] = basemagn - (0.05f * amount);
        }else if(fluid == "infinity_metal"){
            map["para"] = amount * 32;
            map["magn"] = basemagn - (0.06f * amount);
        }else{
            map["para"] = amount * 2;
            map["magn"] = basemagn - (0.01f * amount);
        }
        ctrl.customData = data;
    })
    .addRecipeTooltip("每秒检测一次活石桶之中的流体")
    .setThreadName("结构检测")
    .build();

val petal as IItemStack[] = [<botania:petal:14>,<botania:petal:1>,<botania:petal:4>,<botania:petal:13>,
    <botania:petal:9>,<botania:petal:11>,<botania:petal:10>,<botania:petal:5>,
    <botania:petal>,<botania:petal:2>,<botania:petal:3>,<botania:petal:6>,
    <botania:petal:7>,<botania:petal:8>,<botania:petal:12>,<botania:petal:15>,
    <contenttweaker:iridescence>,
];
var match = 
    RecipeBuilder.newBuilder("common_petal","shadow",100)
        .addInput(<liquid:water> * 50)
        .addPreCheckHandler(function(event as RecipeCheckEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val para = dData.getInt("para",1);
            val magn = dData.getFloat("magn",1.0f);
            event.activeRecipe.maxParallelism = para;
            ctrl.addModifier("labell", RecipeModifierBuilder.create("modularmachinery:duration", "input", magn, 1, false).build());
        })
        .setThreadName("物品产出");
for i in 0 to 17{
    match.addOutput(petal[i] * 6).setChance(0.05);
}
match.build();

RecipeBuilder.newBuilder("common_dye","shadow",100)
    .addInputs(<minecraft:sand>)
    .addCatalystInput(<packagedastral:constellation_focus>,
        ["千百星辰之光，聚而不散","产出翻倍"],
        [RecipeModifierBuilder.create("modularmachinery:item","output",2,1,false).build()]
    ).setChance(0)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val para = dData.getInt("para",1);
        val magn = dData.getFloat("magn",1.0f);
        event.activeRecipe.maxParallelism = para;
        ctrl.addModifier("labell", RecipeModifierBuilder.create("modularmachinery:duration", "input", magn, 1, false).build());
    })
    .addOutputs([
        <botania:dye:14> * 6,
        <botania:dye:1> * 6,
        <botania:dye:4> * 6,
        <botania:dye:13> * 6,
        <botania:dye:9> * 6,
        <botania:dye:11> * 6,
        <botania:dye:10> * 6
    ])
    .setThreadName("物品产出")
    .build();
RecipeBuilder.newBuilder("crystalgreen_shadow","shadow",1800)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        var para = dData.getInt("para",1);
        var magn = dData.getFloat("magn",1.0f);
        if(para < 97){
            event.setFailed("等级不够！");
        }else{
            para = 1 + (para - 96) / 16;
        }
        if(magn < 0.5){
            magn = magn * 2;
        }else{
            magn = 1.0f;
        }
        event.activeRecipe.maxParallelism = para;
        ctrl.addModifier("labell", RecipeModifierBuilder.create("modularmachinery:duration", "input", magn, 1, false).build());
    })
    .addInputs([
        <liquid:fluidedmana>*1000,
        <ore:gemCrystalPurple>
    ])
    .addOutput(<contenttweaker:crystalgreen>)
    .addRecipeTooltip("需要机器本身的并行数大于96才可运行","每额外的8并行会给本配方提供1并行","时间倍率为其余配方享受倍率的2倍,至多为1")
    .setThreadName("物品产出")
    .build();
RecipeBuilder.newBuilder("moretreelog","shadow",20)
    .addInput(<minecraft:sapling>).setChance(0).setParallelizeUnaffected(true)
    .addOutput(<minecraft:log>)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val para = dData.getInt("para",1);
        val magn = dData.getFloat("magn",1.0f);
        event.activeRecipe.maxParallelism = para;
        ctrl.addModifier("labell", RecipeModifierBuilder.create("modularmachinery:duration", "input", magn, 1, false).build());
    })
    .build();