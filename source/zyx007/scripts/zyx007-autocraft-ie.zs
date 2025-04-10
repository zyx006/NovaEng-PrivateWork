import mods.modularmachinery.MachineStructureFormedEvent;
import mods.modularmachinery.MMEvents;
import mods.modularmachinery.Sync;
import crafttweaker.item.IIngredient;

//斗轮式挖掘机自动搭建
recipes.addShaped(<modularmachinery:auto_excavator_controller>, [
    [<immersiveengineering:tool:3>.reuse(), null, null],
    [null, null, null],
    [null, null, null]
]);
MMEvents.onStructureFormed("auto_excavator", function(event as MachineStructureFormedEvent) {
    Sync.addSyncTask(function(){
    val ctrl = event.controller;
    val pos = ctrl.pos;
    val world = ctrl.world;
        if (!world.remote) {
        world.setBlockState(<blockstate:minecraft:air>, pos);
    }
    });
});
<modularmachinery:auto_excavator_controller>.addTooltip("§6结构成型后自动拆除控制器");

//自动化工程师装配台自动搭建
recipes.addShaped(<modularmachinery:auto_autoworkbench_controller>, [
    [null, <immersiveengineering:tool:3>.reuse(), null],
    [null, null, null],
    [null, null, null]
]);
MMEvents.onStructureFormed("auto_autoworkbench", function(event as MachineStructureFormedEvent) {
    Sync.addSyncTask(function(){
    val ctrl = event.controller;
    val pos = ctrl.pos;
    val world = ctrl.world;
        if (!world.remote) {
        world.setBlockState(<blockstate:minecraft:air>, pos);
    }
    });
});
<modularmachinery:auto_autoworkbench_controller>.addTooltip("§6需要自己放置传送带！");
<modularmachinery:auto_autoworkbench_controller>.addTooltip("§6结构成型后自动拆除控制器");

//粉碎机自动搭建
recipes.addShaped(<modularmachinery:auto_crusher_controller>, [
    [null, null, <immersiveengineering:tool:3>.reuse()],
    [null, null, null],
    [null, null, null]
]);
MMEvents.onStructureFormed("auto_crusher", function(event as MachineStructureFormedEvent) {
    Sync.addSyncTask(function(){
    val ctrl = event.controller;
    val pos = ctrl.pos;
    val world = ctrl.world;
        if (!world.remote) {
        world.setBlockState(<blockstate:minecraft:air>, pos);
    }
    });
});
<modularmachinery:auto_crusher_controller>.addTooltip("§6结构成型后自动拆除控制器");

//电弧炉自动搭建
recipes.addShaped(<modularmachinery:auto_arcfurnace_controller>, [
    [null, null, null],
    [<immersiveengineering:tool:3>.reuse(), null, null],
    [null, null, null]
]);
MMEvents.onStructureFormed("auto_arcfurnace", function(event as MachineStructureFormedEvent) {
    Sync.addSyncTask(function(){
    val ctrl = event.controller;
    val pos = ctrl.pos;
    val world = ctrl.world;
        if (!world.remote) {
        world.setBlockState(<blockstate:minecraft:air>, pos);
    }
    });
});
<modularmachinery:auto_arcfurnace_controller>.addTooltip("§6结构成型后自动拆除控制器");