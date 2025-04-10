#loader crafttweaker reloadable

import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.RecipeModifierBuilder;
import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.research.ResearchCognitionData;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.IngredientArrayBuilder;

var recipeCounter = 1;

//真空干燥炉
MachineModifier.setMaxParallelism("vacuum_dryer", 16);

//真空干燥炉MKII
MachineModifier.setMaxThreads("vacuum_dryer_mkii", 8);
MachineModifier.setInternalParallelism("vacuum_dryer_mkii", 64);
MachineModifier.setMaxParallelism("vacuum_dryer_mkii", 512);

//催化剂子配方，红水晶方块（默认AR的Crystal Chasms群系自然生成）
var redstoneCrystal = <redstonearsenal:material:160>;
recipes.addShaped(<advancedrocketry:crystal:3>, [
    [null, redstoneCrystal, null],
    [redstoneCrystal,<ebwizardry:crystal_block> , redstoneCrystal],
    [null, redstoneCrystal, null]
]);

//真空干燥炉控制器合成
RecipeBuilder.newBuilder("vacuum_dryer", "mach_crafter", 600, recipeCounter, false)
    .addEnergyPerTickInput(5120)
    .addInputs([
        <immersiveengineering:material:26> * 64,
        <contenttweaker:nickel_coil> * 12,
        <contenttweaker:industrial_circuit_v1> * 8,
        <contenttweaker:sensor_v1> * 6,
        <contenttweaker:electric_motor_v2> * 4,
        <modularmachinery:blockcasing> * 1
    ])
    .addOutputs(<modularmachinery:vacuum_dryer_controller> * 1)
    .build();
recipeCounter += 1;

//真空干燥炉MKII控制器合成
RecipeBuilder.newBuilder("vacuum_dryer_mkii", "machine_arm", 600, recipeCounter, false)
    .addEnergyPerTickInput(5120)
    .addInputs([
        <modularmachinery:vacuum_dryer_controller> * 4,
        <advancedrocketry:vacuumlaser> * 4,
        <contenttweaker:robot_arm_v2> * 4,
        <contenttweaker:engineering_battery_v2> * 2,
        <modularmachinery:blockcasing:4> * 1
    ])
    .addOutputs(<modularmachinery:vacuum_dryer_mkii_factory_controller> * 1)
    .build();
recipeCounter += 1;
<modularmachinery:vacuum_dryer_mkii_factory_controller>.addTooltip("§6顶面风扇的链接材质有点神金，不用管");

//腐肉干
RecipeBuilder.newBuilder("dryed_jerky", "vacuum_dryer", 200, recipeCounter, false)
    .addEnergyPerTickInput(2560)
    .addInput(<minecraft:rotten_flesh> * 1)
    .addOutputs(<tconstruct:edible:10> * 1)
    .addCatalystInput(<advancedrocketry:vacuumlaser> * 1,
        ['工作时间 §ax0.1§f', '工作耗能 §ax10§f'],
        [
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.1, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:energy", "input", 10, 1, false).build()
        ]
    ).setChance(0)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("dryed_jerky_mkii", "vacuum_dryer_mkii", 20, recipeCounter, false)
    .addEnergyPerTickInput(5120)
    .addInput(<minecraft:rotten_flesh> * 1)
    .addOutputs(<tconstruct:edible:10> * 1)
    .build();
recipeCounter += 1;

//盐
RecipeBuilder.newBuilder("dry_salt", "vacuum_dryer", 200, recipeCounter, false)
    .addEnergyPerTickInput(5120)
    .addInput(<liquid:brine> * 15)
    .addOutputs(<mekanism:salt> * 1)
    .addCatalystInput(<advancedrocketry:vacuumlaser> * 1,
        ['工作时间 §ax0.1§f', '工作耗能 §ax10§f'],
        [
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.1, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:energy", "input", 10, 1, false).build()
        ]
    ).setChance(0)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("dry_salt_mkii", "vacuum_dryer_mkii", 20, recipeCounter, false)
    .addEnergyPerTickInput(10240)
    .addInput(<liquid:brine> * 15)
    .addOutputs(<mekanism:salt> * 1)
    .build();
recipeCounter += 1;

//硫磺
RecipeBuilder.newBuilder("dry_sulfur", "vacuum_dryer", 200, recipeCounter, false)
    .addEnergyPerTickInput(5120)
    .addInput(<liquid:liquidsulfurdioxide> * 100)
    .addOutputs(<thermalfoundation:material:771> * 1)
    .addCatalystInput(<advancedrocketry:vacuumlaser> * 1,
        ['工作时间 §ax0.1§f', '工作耗能 §ax10§f'],
        [
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.1, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:energy", "input", 10, 1, false).build()
        ]
    ).setChance(0)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("dry_sulfur_mkii", "vacuum_dryer_mkii", 20, recipeCounter, false)
    .addEnergyPerTickInput(10240)
    .addInput(<liquid:liquidsulfurdioxide> * 100)
    .addOutputs(<thermalfoundation:material:771> * 1)
    .build();
recipeCounter += 1;

//氦3
RecipeBuilder.newBuilder("dry_turfmoon", "vacuum_dryer", 200, recipeCounter, false)
    .addEnergyPerTickInput(5120)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder().addIngredients([
            <advancedrocketry:moonturf> * 1,
            <advancedrocketry:moonturf_dark> * 1
        ])
    )
    .addOutputs([<minecraft:gravel> * 1, <fluid:helium_3> * 250])
    .addCatalystInput(<advancedrocketry:vacuumlaser> * 1,
        ['工作时间 §ax0.1§f', '工作耗能 §ax10§f'],
        [
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.1, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:energy", "input", 10, 1, false).build()
        ]
    ).setChance(0)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("dry_turfmoon_mkii", "vacuum_dryer_mkii", 20, recipeCounter, false)
    .addEnergyPerTickInput(10240)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder().addIngredients([
            <advancedrocketry:moonturf> * 1,
            <advancedrocketry:moonturf_dark> * 1
        ])
    )
    .addOutputs([<minecraft:gravel> * 1, <fluid:helium_3> * 250])
    .build();
recipeCounter += 1;