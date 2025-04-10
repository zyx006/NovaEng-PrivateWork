#loader crafttweaker reloadable

import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.MachineModifier;
import crafttweaker.item.IItemStack;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.SmartInterfaceType;
import mods.modularmachinery.RecipeCheckEvent;

MachineModifier.setMaxThreads("enderman", 4);
MachineModifier.setInternalParallelism("enderman", 4);
MachineModifier.setMaxParallelism("enderman", 512);

var recipeCounter = 1;

# 智能数据接口初始化
MachineModifier.addSmartInterfaceType("enderman",
    SmartInterfaceType.create("speed", 1)
        .setHeaderInfo("§e聚集速率设置")
        .setValueInfo("§e聚集速率：§a%.2fx")
        .setJeiTooltip("聚集速率区间：§a%.2fx§f - §a%.0fx", 2)
        .setFooterInfo("§e耗时恒取倒数，低于1时耗能线性倍减，高于1时会使耗能取1.25次方")
        .setNotEqualMessage("聚集速率过高或过低！")
);

//压缩末影珍珠
var normalPearl = <minecraft:ender_pearl>;
var pressedPearl = <minecraft:ender_pearl>.withTag({
    display: {
        Lore: [
            "§9压缩后的末影珍珠，具有一股神秘的力量",
        ],
    },
    pressedPearl: 114514
});
recipes.addShapeless(pressedPearl, [
    normalPearl, normalPearl, normalPearl,
    normalPearl, normalPearl, normalPearl, 
    normalPearl, normalPearl, normalPearl
]);

//控制器合成
recipes.addShaped(<modularmachinery:enderman_factory_controller>, [
    [<enderutilities:enderpart:16>, <modularmachinery:blockcasing:4>, <enderutilities:enderpart:16>],
    [<modularmachinery:blockcasing:4>, pressedPearl, <modularmachinery:blockcasing:4>],
    [<enderutilities:enderpart:16>, <modularmachinery:blockcasing:4>, <enderutilities:enderpart:16>]
]);

var enderTank = <thermalexpansion:tank>.withTag({Fluid: {FluidName: "ender", Amount: 16000}});
//末影珍珠
RecipeBuilder.newBuilder("enderman_ender_pearl", "enderman", 200, recipeCounter)
    .addSmartInterfaceDataInput("speed", 0.01, 40)
    .addEnergyPerTickInput(4096)
    .setDimension([1])
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
        val ctrl = event.controller;
        val nullableSpeed = ctrl.getSmartInterfaceData("speed");
        val speed = isNull(nullableSpeed) ? 1 as float : nullableSpeed.value;
        ctrl.addModifier("enerygy_modify", RecipeModifierBuilder.create("modularmachinery:energy", "input", speed >= 1 ? pow(speed, 1.25) : speed, 1, false).build());
        ctrl.addModifier("time_modify", RecipeModifierBuilder.create("modularmachinery:duration", "input", 1.0/speed, 1, false).build());
    })
    .addCatalystInput(enderTank, 
        ['工作时间 §ax0.5§f', '工作耗能 §ax0.35§f'],
        [
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.5, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:energy", "input", 0.35, 1, false).build()
        ]
    ).setParallelizeUnaffected(true).setChance(0)
    .addInputs(<minecraft:ender_pearl> * 1).setParallelizeUnaffected(true).setChance(0)
    .addOutput(<minecraft:ender_pearl> * 4)
    .build();
recipeCounter += 1;

//恶魔意志
RecipeBuilder.newBuilder("enderman_monster_soul", "enderman", 200, recipeCounter)
    .addSmartInterfaceDataInput("speed", 0.01, 20)
    .addEnergyPerTickInput(4096)
    .setDimension([1])
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
        val ctrl = event.controller;
        val nullableSpeed = ctrl.getSmartInterfaceData("speed");
        val speed = isNull(nullableSpeed) ? 1 as float : nullableSpeed.value;
        ctrl.addModifier("enerygy_modify", RecipeModifierBuilder.create("modularmachinery:energy", "input", speed >= 1 ? pow(speed, 1.25) : speed, 1, false).build());
        ctrl.addModifier("time_modify", RecipeModifierBuilder.create("modularmachinery:duration", "input", 1.0/speed, 1, false).build());
    })
    .addInputs(<bloodmagic:sentient_sword> * 1).setParallelizeUnaffected(true).setChance(0)
    .addOutputs(<bloodmagic:monster_soul>.withTag({souls: 20}) * 1)
    .build();
recipeCounter += 1;

//虚弱气血碎片
RecipeBuilder.newBuilder("enderman_blood_shard", "enderman", 200, recipeCounter)
    .addSmartInterfaceDataInput("speed", 0.01, 20)
    .addEnergyPerTickInput(4096)
    .setDimension([1])
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
        val ctrl = event.controller;
        val nullableSpeed = ctrl.getSmartInterfaceData("speed");
        val speed = isNull(nullableSpeed) ? 1 as float : nullableSpeed.value;
        ctrl.addModifier("enerygy_modify", RecipeModifierBuilder.create("modularmachinery:energy", "input", speed >= 1 ? pow(speed, 1.25) : speed, 1, false).build());
        ctrl.addModifier("time_modify", RecipeModifierBuilder.create("modularmachinery:duration", "input", 1.0/speed, 1, false).build());
    })
    .addInputs(<bloodmagic:bound_sword>.withTag({Unbreakable: 1 as byte})).setParallelizeUnaffected(true).setChance(0)
    .addOutputs(<bloodmagic:blood_shard> * 10)
    .build();
recipeCounter += 1;