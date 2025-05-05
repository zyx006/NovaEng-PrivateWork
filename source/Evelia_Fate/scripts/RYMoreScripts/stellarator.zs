#priority 1

import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.RecipeCheckEvent;

import crafttweaker.item.IItemStack;

import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.research.ResearchCognitionData;

//仿星器
RecipeBuilder.newBuilder("stellarator_controller", "workshop", 3600, 20)
    .addEnergyPerTickInput(8192000)
    .addInputs([
        <appliedenergistics2:material:47> * 16,
        <contenttweaker:industrial_circuit_v3> * 48,
        <mekanism:controlcircuit:3> * 16,
        <contenttweaker:field_generator_v1> * 64,
        <appliedenergistics2:controller>,
    ])
    .addOutput(<modularmachinery:stellarator_controller>*1)
    .requireComputationPoint(3000.0F)
    .requireResearch("stellarator_1")
    .build();

RecipeBuilder.newBuilder("Helium-3","stellarator",20)
    .addEnergyPerTickInput(5000000)
    .addInput(<liquid:hydrogen>*1000)
    .addInput(<avaritia:resource:2>).setChance(0.1)
    .addOutput(<liquid:helium_3>*500)
    .addEnergyPerTickOutput(15000000)
    .build();
MachineModifier.setInternalParallelism("stellarator", 20);

//压缩仿星器
RecipeBuilder.newBuilder("compressed_stellarator_con","workshop",3600)
    .addInputs([
        <modularmachinery:stellarator_controller> * 64,
        <contenttweaker:field_generator_v2> * 18,
        <contenttweaker:industrial_circuit_v3> * 9,
        <moreplates:infinity_plate> *4,
        <tconevo:metal:13> * 32,
        <liquid:crystalloid> * 8192
    ])
    .addOutput(<modularmachinery:compressed_stellarator_factory_controller>)
    .addEnergyPerTickInput(200000000)
    .requireResearch("compressed_stellarator")
    .requireComputationPoint(9000.0F)
    .build();
MachineModifier.setMaxThreads("compressed_stellarator",5);
RecipeBuilder.newBuilder("matrix_fussion","compressed_stellarator",200)
    .addEnergyPerTickInput(500000)
    .addInputs([
        <ore:netherStar> * 4,
        <liquid:diamond> * 1440
    ])
    .addOutput(<liquid:crystal_matrix> * 1440)
    .addOutput(<mekanism:antimatterpellet>).setChance(0.02)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 64;
    })
    .addRecipeTooltip("最大并行为64")
    .setMaxThreads(1)
    .build();
RecipeBuilder.newBuilder("oslash_matter_fussion","compressed_stellarator",200)
    .addEnergyPerTickInput(5000000)
    .addInputs([
        <liquid:obsidian> * 720,
        <liquid:diamond> * 100,
        <liquid:osmium> * 720,
        <liquid:crystalloid> * 40
    ])
    .addOutput(<liquid:oslash_matter> * 100)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 32;
    })
    .addOutput(<mekanism:antimatterpellet>).setChance(0.01)
    .addRecipeTooltip("最大并行为32")
    .setMaxThreads(1)
    .build();
RecipeBuilder.newBuilder("phi_matter_fussion","compressed_stellarator",200)
    .addEnergyPerTickInput(5000000)
    .addInputs([
        <liquid:glowstone> * 2500,
        <liquid:osmium> * 720,
        <liquid:pyrotheum> * 4000
    ])
    .addOutput(<liquid:phi_matter> * 100)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 32;
    })
    .addOutput(<mekanism:antimatterpellet>).setChance(0.01)
    .addRecipeTooltip("最大并行为32")
    .setMaxThreads(1)
    .build();
RecipeBuilder.newBuilder("netherite_fussion","compressed_stellarator",20)
    .addEnergyPerTickInput(2000000)
    .addInputs([
        <liquid:phi_matter> * 100,
        <liquid:oslash_matter> * 100
    ])
    .addOutput(<liquid:ancient_debris> * 144)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 64;
    })
    .addOutput(<mekanism:antimatterpellet>).setChance(0.01)
    .addRecipeTooltip("最大并行为64")
    .setMaxThreads(1)
    .build();
RecipeBuilder.newBuilder("Helium-3_fussion","compressed_stellarator",20)
    .addEnergyPerTickInput(50000000)
    .addInput(<liquid:hydrogen>*10000)
    .addInput(<avaritia:resource:2>).setChance(0.1)
    .addOutput(<liquid:helium_3>*5000)
    .addEnergyPerTickOutput(450000000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 64;
    })
    .addOutput(<mekanism:antimatterpellet>).setChance(0.005)
    .addRecipeTooltip("最大并行为64")
    .addRecipeTooltip("25.6GRF/t的发电量！但是这么多的氦-3有什么用呢？","你会用上它们的")
    .setMaxThreads(1)
    .build();

//进阶压缩仿星器
RecipeBuilder.newBuilder("advaced_stellarator_control","workshop",7200)
    .addInputs([
        <additions:novaextended-ark_circuit> * 16,
        <contenttweaker:field_generator_v3> * 4,
        <contenttweaker:industrial_circuit_v4> * 6,
        <super_solar_panels:machines:7> * 3,
        <modularmachinery:compressed_stellarator_factory_controller>
    ])
    .addOutput(<modularmachinery:advanced_stellarator_factory_controller>)
    .requireResearch("advaced_stellarator")
    .requireComputationPoint(7500.0F)
    .addEnergyPerTickInput(25000000000)
    .build();
MachineModifier.setMaxThreads("advanced_stellarator",2);
RecipeBuilder.newBuilder("Helium-3_Generation","advanced_stellarator",100)
    .addEnergyPerTickInput(1000000)
    .addInputs([
        <liquid:helium_3> * 500,
        <liquid:ic2uu_matter> * 20
    ])
    .addOutput(<liquid:plasma> * 1500)
    .addEnergyPerTickOutput(2000000000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 10;
    })
    .setMaxThreads(1)
    .addRecipeTooltip("最大并行为10")
    .build();
RecipeBuilder.newBuilder("infinity_fussion","advanced_stellarator",10000)
    .addEnergyPerTickInput(1000000000)
    .addInputs([
        <avaritia:resource:5>,
        <liquid:crystal_matrix> * 150,
        <liquid:neutronium> * 320
    ])
    .addOutput(<liquid:infinity_metal> * 16)
    .addOutput(<mekanism:antimatterpellet>).setChance(0.55)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 6;
    })
    .addEnergyPerTickOutput(8000000000)
    .setMaxThreads(1)
    .addRecipeTooltip("最大并行为6，相应的发电量为42GRF/tick","这的确很酷")
    .build();
RecipeBuilder.newBuilder("arousal_fiber","workshop",600)
    .addInputs([
        <contenttweaker:arousal_building_block> * 16,
        <draconicadditions:vampiric_shirt>,
        <draconicevolution:dragon_heart>
    ])
    .addOutputs(<contenttweaker:arousal_fiber_housing> * 16)
    .requireComputationPoint(20.0F)
    .requireResearch("advaced_stellarator")
    .build();

// 仿星器原型机MK-II
MachineModifier.setMaxThreads("prototype",3);
RecipeBuilder.newBuilder("prototype_con","workshop",7200)
    .addEnergyPerTickInput(20000000000)
    .addInputs([
        <liquid:infinity_metal>  * 1152,
        <liquid:crystalloid> * 5120,
        <contenttweaker:coil_v5> * 8,
        <avaritiaio:infinitecapacitor> * 2,
        <moreplates:infinity_plate> * 7,
        <contenttweaker:field_generator_v3> * 6,
        <contenttweaker:industrial_circuit_v4> * 3,
        <contenttweaker:arkmachineblock>
    ])
    .addOutput(<modularmachinery:prototype_factory_controller>)
    .requireComputationPoint(4200.0F)
    .requireResearch("stellarator_prototype")
    .build();
RecipeBuilder.newBuilder("ark_fussion","prototype",180)
    .addEnergyPerTickInput(50000000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 10;
    })
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder().addIngredients([
            <ore:ingotStellarAlloy>,
            <ore:ingotGelidEnderium>,
            <ore:ingotBoundMetal> * 2,
            <ore:ingotSentientMetal> * 2,
        ])
    )
    .addItemInputs([
        <ore:ingotAdamant>,
        <ore:ingotChaoticMetal>,
        <ore:ingotTerraAlloy>,
        <ore:ingotInfinity>
    ])
    .addOutput(<liquid:ark> * 1152)
    .setMaxThreads(1)
    .addRecipeTooltip("最大并行为10")
    .build();

//极限仿星器
RecipeBuilder.newBuilder("extreme_con","workshop",7200)
    .addEnergyPerTickInput(90000000000)
    .addInputs([
        <modularmachinery:prototype_factory_controller>,
        <contenttweaker:arkforcefieldcontrolblock> * 4,
        <contenttweaker:tyf3> * 128,
        <contenttweaker:arkmachineblock> * 27
    ])
    .addOutput(<modularmachinery:extreme_stellarator_factory_controller>)
    .requireComputationPoint(9999.0F)
    .requireResearch("extreme_stellartor")
    .build();
MachineModifier.setMaxThreads("extreme_stellarator",2);
RecipeBuilder.newBuilder("AnWorld_Fussion","extreme_stellarator",10000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 10;
    })
    .addInputs([
        <liquid:crystalloidneutron> * 288000,
        <liquid:fluidedmana> * 1000,
        <ore:gemCrystalRed> * 6,
        <ore:gemCrystalGreen> * 6,
        <ore:gemCrystalPurple> * 6,
    ])
    .addOutput(<additions:novaextended-crystal4>)
    .setMaxThreads(1)
    .addRecipeTooltip("最大并行为10")
    .addEnergyPerTickOutput(10000000000)
    .build();

//永恒循环
RecipeBuilder.newBuilder("eternity_fussion","prototype",360)
    .addEnergyPerTickInput(64000000000)
    .addInputs([
        <eternalsingularity:eternal_singularity> * 64,
        <additions:novaextended-crystal4> * 4,
        <liquid:infinity_metal> * 288,
        <liquid:ark> * 288,
    ])
    .addOutput(<contenttweaker:eternity_nova>)
    .setMaxThreads(1)
    .build();
RecipeBuilder.newBuilder("eternity_loop","prototype",720)
    .addEnergyPerTickInput(64000000)
    .addInputs([
        <contenttweaker:shirabon>,
        <eternalsingularity:eternal_singularity>,
        <contenttweaker:eternity_nova>,
        <liquid:ark> * 16
    ])
    .addEnergyPerTickOutput(80000000000)
    .addOutput(<contenttweaker:eternity_nova> * 4)
    .setMaxThreads(1)
    .build();
RecipeBuilder.newBuilder("elternity_shredder","structural_failure",120)
    .addEnergyPerTickInput(500000000)
    .addInputs(<contenttweaker:eternity_nova>)
    .addInputs(<additions:novaextended-crystal4>).setChance(0.02)
    .addOutputs([
        <additions:novaextended-star_ingot> * 4,
        <eternalsingularity:eternal_singularity> * 32,
    ])
    .addOutput(<mekanism:antimatterpellet> * 4).setChance(0.5)
    .addOutput(<draconicevolution:chaos_shard> * 16).setChance(0.4)
    .setMaxThreads(1)
    .build();
RecipeBuilder.newBuilder("shirabon_fussion","extreme_stellarator",180)
    .addInputs([
        <additions:novaextended-star_ingot>,
        <contenttweaker:crystalpurple>,
        <draconicevolution:chaos_shard>,
        <mekanism:antimatterpellet> * 2
    ])
    .addOutput(<contenttweaker:shirabon>)
    .setMaxThreads(1)
    .addEnergyPerTickOutput(10000000000)
    .build();