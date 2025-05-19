#loader crafttweaker reloadable

import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.RecipeModifierBuilder;
import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.research.ResearchCognitionData;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.SmartInterfaceType;

var recipeCounter = 1;

MachineModifier.setMaxThreads("shanxi_coal", 8);
MachineModifier.setInternalParallelism("shanxi_coal", 1);
MachineModifier.setMaxParallelism("shanxi_coal", 64);

//控制器合成
recipes.addShaped(<modularmachinery:shanxi_coal_controller>, [
    [<minecraft:soul_sand>, <minecraft:skull:1>, <futuremc:soul_soil>],
    [<minecraft:skull:1>, <enderio:item_material:53>, <minecraft:skull:1>],
    [<futuremc:soul_soil>, <minecraft:skull:1>, <minecraft:soul_sand>]
]);
RecipeBuilder.newBuilder("shanxi_coal", "mach_crafter", 600, recipeCounter, false)
    .addEnergyPerTickInput(5120)
    .addInputs([
        <modularmachinery:shanxi_coal_controller> * 8,
        <enderio:item_soul_vial:1>.withTag({entityId: "minecraft:wither_skeleton"}) * 1,
        <futuremc:wither_rose> * 16,
        <modularmachinery:blockcasing:0> * 16
    ])
    .addOutputs(<modularmachinery:shanxi_coal_factory_controller> * 1)
    .build();
recipeCounter += 1;

# 智能数据接口初始化
MachineModifier.addSmartInterfaceType("shanxi_coal",
        SmartInterfaceType.create("mode", 0)
            .setHeaderInfo("§a模式设置")
            .setValueInfo("当前模式：§a%.0f")
            .setFooterInfo("§a模式1为输出全物品(支持血魔法产出)，模式2为输出钻石奇点，模式3为发电")
    );

//配方1-产出全物品-额外产出恶魔意志、气血碎片、生命源质
RecipeBuilder.newBuilder("shanxi_coal_all_4", "shanxi_coal", 200, recipeCounter, false)
    .addSmartInterfaceDataInput("mode", 1)
    .addEnergyPerTickInput(2560)
    .addInput(<enderio:item_soul_vial:1>.withTag({entityId: "minecraft:wither_skeleton"}) * 1).setChance(0)
    .addInput(<bloodmagic:bound_sword>.withTag({Unbreakable: 1 as byte}) * 1).setChance(0)
    .addInput(<bloodmagic:sentient_sword> * 1).setChance(0)
    .addOutputs([
        <minecraft:coal> * 8,
        <minecraft:bone> * 4,
        <bloodmagic:monster_soul>.withTag({souls: 10}) * 1,
        <bloodmagic:blood_shard> * 5,
        <liquid:lifeessence> * 200
    ])
    .addOutput(<futuremc:wither_rose> * 2).setChance(0.18)
    .addOutput(<minecraft:skull:1> * 4).setChance(0.09)
    .addCatalystInput(<enderio:block_powered_spawner>.withTag({entityId: "minecraft:wither_skeleton"}) * 1,
        ['工作时间 §ax0.1§f', '工作耗能 §ax10§f', '物品产出 §ax10§f'],
        [
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.1, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:energy", "input", 10, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:item", "output", 10, 1, false).build(),
        ]
    ).setChance(0)
    .build();
recipeCounter += 1;

//配方2-产出全物品-额外产出恶魔意志
RecipeBuilder.newBuilder("shanxi_coal_all_2", "shanxi_coal", 200, recipeCounter, false)
    .addSmartInterfaceDataInput("mode", 1)
    .addEnergyPerTickInput(2560)
    .addInput(<enderio:item_soul_vial:1>.withTag({entityId: "minecraft:wither_skeleton"}) * 1).setChance(0)
    .addInput(<bloodmagic:sentient_sword> * 1).setChance(0)
    .addOutputs([
        <minecraft:coal> * 8,
        <minecraft:bone> * 4,
        <bloodmagic:monster_soul>.withTag({souls: 10}) * 1
    ])
    .addOutput(<futuremc:wither_rose> * 2).setChance(0.18)
    .addOutput(<minecraft:skull:1> * 4).setChance(0.09)
    .addCatalystInput(<enderio:block_powered_spawner>.withTag({entityId: "minecraft:wither_skeleton"}) * 1,
        ['工作时间 §ax0.1§f', '工作耗能 §ax10§f', '物品产出 §ax10§f'],
        [
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.1, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:energy", "input", 10, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:item", "output", 10, 1, false).build(),
        ]
    ).setChance(0)
    .build();
recipeCounter += 1;

//配方3-产出全物品-额外产出气血碎片
RecipeBuilder.newBuilder("shanxi_coal_all_3", "shanxi_coal", 200, recipeCounter, false)
    .addSmartInterfaceDataInput("mode", 1)
    .addEnergyPerTickInput(2560)
    .addInput(<enderio:item_soul_vial:1>.withTag({entityId: "minecraft:wither_skeleton"}) * 1).setChance(0)
    .addInput(<bloodmagic:bound_sword>.withTag({Unbreakable: 1 as byte}) * 1).setChance(0)
    .addOutputs([
        <minecraft:coal> * 8,
        <minecraft:bone> * 4,
        <bloodmagic:blood_shard> * 5
    ])
    .addOutput(<futuremc:wither_rose> * 2).setChance(0.18)
    .addOutput(<minecraft:skull:1> * 4).setChance(0.09)
    .addCatalystInput(<enderio:block_powered_spawner>.withTag({entityId: "minecraft:wither_skeleton"}) * 1,
        ['工作时间 §ax0.1§f', '工作耗能 §ax10§f', '物品产出 §ax10§f'],
        [
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.1, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:energy", "input", 10, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:item", "output", 10, 1, false).build(),
        ]
    ).setChance(0)
    .build();
recipeCounter += 1;

//配方4-产出全物品-无血魔法
RecipeBuilder.newBuilder("shanxi_coal_all_1", "shanxi_coal", 200, recipeCounter, false)
    .addSmartInterfaceDataInput("mode", 1)
    .addEnergyPerTickInput(2560)
    .addInput(<enderio:item_soul_vial:1>.withTag({entityId: "minecraft:wither_skeleton"}) * 1).setChance(0)
    .addOutputs([
        <minecraft:coal> * 8,
        <minecraft:bone> * 4
    ])
    .addOutput(<futuremc:wither_rose> * 2).setChance(0.18)
    .addOutput(<minecraft:skull:1> * 4).setChance(0.09)
    .addCatalystInput(<enderio:block_powered_spawner>.withTag({entityId: "minecraft:wither_skeleton"}) * 1,
        ['工作时间 §ax0.1§f', '工作耗能 §ax10§f', '物品产出 §ax10§f'],
        [
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.1, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:energy", "input", 10, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:item", "output", 10, 1, false).build(),
        ]
    ).setChance(0)
    .build();
recipeCounter += 1;

//配方5-产出钻石奇点
RecipeBuilder.newBuilder("shanxi_coal_qidian", "shanxi_coal", 1900, recipeCounter, false)
    .addSmartInterfaceDataInput("mode", 2)
    .addEnergyPerTickInput(102400)
    .addInput(<enderio:item_soul_vial:1>.withTag({entityId: "minecraft:wither_skeleton"}) * 1).setChance(0)
    .addInput(<enderio:block_powered_spawner>.withTag({entityId: "minecraft:wither_skeleton"}) * 1).setChance(0)
    .addOutputs([
        <avaritia:singularity:10> * 1
    ])
    .addOutput(<futuremc:wither_rose> * 32).setChance(0.6)
    .addOutput(<minecraft:skull:1> * 64).setChance(0.4)
    .build();
recipeCounter += 1;

//配方6-产能
RecipeBuilder.newBuilder("shanxi_coal_energey", "shanxi_coal", 200, recipeCounter, false)
    .addSmartInterfaceDataInput("mode", 3)
    .addEnergyPerTickOutput(10240)
    .addInput(<enderio:item_soul_vial:1>.withTag({entityId: "minecraft:wither_skeleton"})).setChance(0)
    .addOutput(<futuremc:wither_rose> * 2).setChance(0.18)
    .addOutput(<minecraft:skull:1> * 4).setChance(0.09)
    .addCatalystInput(<enderio:block_powered_spawner>.withTag({entityId: "minecraft:wither_skeleton"}) * 1,
        ['工作时间 §ax0.1§f', '能量产出 §ax16§f', '物品产出 §ax4§f'],
        [
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.1, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:energy", "output", 16, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:item", "output", 4, 1, false).build(),
        ]
    ).setChance(0).setParallelizeUnaffected(true)
    .build();
recipeCounter += 1;