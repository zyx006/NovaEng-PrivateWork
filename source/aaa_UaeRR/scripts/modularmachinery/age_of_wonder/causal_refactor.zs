//ALL RIGHTS RESERVED
//也许你可以对私货进行更改。

#priority 10
#loader crafttweaker reloadable

import mods.modularmachinery.MMEvents;
import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.MachineBuilder;
import mods.modularmachinery.MachineTickEvent;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.MultiblockModifierBuilder;
import mods.modularmachinery.ControllerGUIRenderEvent;
import mods.modularmachinery.BlockArrayBuilder;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.IMachineController;

import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.RecipeTickEvent;
import mods.modularmachinery.Sync;

import crafttweaker.world.IBlockPos;
import crafttweaker.world.IWorld;
import crafttweaker.item.IItemStack;
import crafttweaker.data.IData;
import crafttweaker.item.IIngredient;
import crafttweaker.oredict.IOreDictEntry;
import crafttweaker.liquid.ILiquidStack;
import crafttweaker.item.WeightedItemStack;
import mod.mekanism.gas.IGasStack;
import mods.astralsorcery.Altar;
import crafttweaker.item.IWeightedIngredient;

import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.research.ResearchCognitionData;
import novaeng.NovaEngUtils;

//cot things
RecipeBuilder.newBuilder("processor1", "causal_refactor", 1)
        .addInput(<contenttweaker:lifesense_processor>)
        .addOutput(<contenttweaker:exponential_level_processor>)
        .addRecipeTooltip([
                "§6§l终焉的造物,'更多巨构'产能的极限"
            ])
        .build();
RecipeBuilder.newBuilder("processor2", "causal_refactor", 1)
        .addInput(<contenttweaker:exponential_level_processor>)
        .addOutput(<contenttweaker:infinity_processor>)
        .addRecipeTooltip([
                "§6§l终焉的造物,'更多巨构'产能的极限"
            ])
        .build();
RecipeBuilder.newBuilder("processor3", "causal_refactor", 1)
        .addInput(<contenttweaker:infinity_processor>)
        .addOutput(<contenttweaker:antimatter_core>)
        .addRecipeTooltip([
                "§6§l终焉的造物,'更多巨构'产能的极限"
            ])
        .build();
RecipeBuilder.newBuilder("cr_coil_v3", "causal_refactor", 1)
    .addInput(<contenttweaker:coil_v2>)
    .addOutput(<contenttweaker:coil_v3>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
        ])
    .build();
RecipeBuilder.newBuilder("cr_coil_v4", "causal_refactor", 1)
    .addInput(<contenttweaker:coil_v3>)
    .addOutput(<contenttweaker:coil_v4>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
        ])
    .build();
RecipeBuilder.newBuilder("cr_coil_v5", "causal_refactor", 1)
    .addInput(<contenttweaker:coil_v4>)
    .addOutput(<contenttweaker:coil_v5>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
        ])
    .build();
RecipeBuilder.newBuilder("cr_electric_motor_v2", "causal_refactor", 1)
    .addInput(<contenttweaker:electric_motor_v1>)
    .addOutput(<contenttweaker:electric_motor_v2>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
    ])
    .build();
RecipeBuilder.newBuilder("cr_electric_motor_v3", "causal_refactor", 1)
    .addInput(<contenttweaker:electric_motor_v2>)
    .addOutput(<contenttweaker:electric_motor_v3>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
    ])
    .build();
RecipeBuilder.newBuilder("cr_electric_motor_v4", "causal_refactor", 1)
    .addInput(<contenttweaker:electric_motor_v3>)
    .addOutput(<contenttweaker:electric_motor_v4>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
    ])
    .build();
RecipeBuilder.newBuilder("cr_electric_motor_v5", "causal_refactor", 1)
    .addInput(<contenttweaker:electric_motor_v4>)
    .addOutput(<contenttweaker:electric_motor_v5>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
    ])
    .build();
RecipeBuilder.newBuilder("cr_sensor_v2", "causal_refactor", 1)
    .addInput(<contenttweaker:sensor_v1>)
    .addOutput(<contenttweaker:sensor_v2>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
        ])
    .build();
RecipeBuilder.newBuilder("cr_sensor_v3", "causal_refactor", 1)
    .addInput(<contenttweaker:sensor_v2>)
    .addOutput(<contenttweaker:sensor_v3>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
        ])
    .build();
RecipeBuilder.newBuilder("cr_sensor_v4", "causal_refactor", 1)
    .addInput(<contenttweaker:sensor_v3>)
    .addOutput(<contenttweaker:sensor_v4>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
        ])
    .build();
RecipeBuilder.newBuilder("cr_sensor_v5", "causal_refactor", 1)
    .addInput(<contenttweaker:sensor_v4>)
    .addOutput(<contenttweaker:sensor_v5>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
        ])
    .build();
RecipeBuilder.newBuilder("cr_robot_arm_v2", "causal_refactor", 1)
    .addInput(<contenttweaker:robot_arm_v1>)
    .addOutput(<contenttweaker:robot_arm_v2>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
        ])
    .build();
RecipeBuilder.newBuilder("cr_robot_arm_v3", "causal_refactor", 1)
    .addInput(<contenttweaker:robot_arm_v2>)
    .addOutput(<contenttweaker:robot_arm_v3>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
        ])
    .build();
RecipeBuilder.newBuilder("cr_robot_arm_v4", "causal_refactor", 1)
    .addInput(<contenttweaker:robot_arm_v3>)
    .addOutput(<contenttweaker:robot_arm_v4>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
        ])
    .build();
RecipeBuilder.newBuilder("cr_robot_arm_v5", "causal_refactor", 1)
    .addInput(<contenttweaker:robot_arm_v4>)
    .addOutput(<contenttweaker:robot_arm_v5>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
        ])
    .build();
RecipeBuilder.newBuilder("cr_field_generator_v2", "causal_refactor", 1)
    .addInput(<contenttweaker:field_generator_v1>)
    .addOutput(<contenttweaker:field_generator_v2>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
        ])
    .build();
RecipeBuilder.newBuilder("cr_field_generator_v3", "causal_refactor", 1)
    .addInput(<contenttweaker:field_generator_v2>)
    .addOutput(<contenttweaker:field_generator_v3>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
        ])
    .build();
RecipeBuilder.newBuilder("cr_field_generator_v4", "causal_refactor", 1)
    .addInput(<contenttweaker:field_generator_v3>)
    .addOutput(<contenttweaker:field_generator_v4>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
        ])
    .build();
RecipeBuilder.newBuilder("cr_field_generator_v5", "causal_refactor", 1)
    .addInput(<contenttweaker:field_generator_v4>)
    .addOutput(<contenttweaker:field_generator_v5>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
        ])
    .build();
RecipeBuilder.newBuilder("cr_industrial_circuit_v2", "causal_refactor", 1)
    .addInput(<contenttweaker:industrial_circuit_v1>)
    .addOutput(<contenttweaker:industrial_circuit_v2>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
        ])
    .build();
RecipeBuilder.newBuilder("cr_industrial_circuit_v3", "causal_refactor", 1)
    .addInput(<contenttweaker:industrial_circuit_v2>)
    .addOutput(<contenttweaker:industrial_circuit_v3>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
        ])
    .build();
RecipeBuilder.newBuilder("cr_industrial_circuit_v4", "causal_refactor", 1)
    .addInput(<contenttweaker:industrial_circuit_v3>)
    .addOutput(<contenttweaker:industrial_circuit_v4>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
        ])
    .build();
RecipeBuilder.newBuilder("cr_industrial_circuit_v5", "causal_refactor", 1)
    .addInput(<contenttweaker:industrial_circuit_v4>)
    .addOutput(<contenttweaker:industrial_circuit_v5>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
        ])
    .build();
RecipeBuilder.newBuilder("cr_energized_fuel_v2", "causal_refactor", 1)
    .addInput(<contenttweaker:energized_fuel_v1>)
    .addOutput(<contenttweaker:energized_fuel_v2>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
        ])
    .build();
RecipeBuilder.newBuilder("cr_energized_fuel_v3", "causal_refactor", 1)
    .addInput(<contenttweaker:energized_fuel_v2>)
    .addOutput(<contenttweaker:energized_fuel_v3>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
        ])
    .build();
RecipeBuilder.newBuilder("cr_energized_fuel_v4", "causal_refactor", 1)
    .addInput(<contenttweaker:energized_fuel_v3>)
    .addOutput(<contenttweaker:energized_fuel_v4>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
        ])
    .build();
RecipeBuilder.newBuilder("cr_engineering_battery_v2", "causal_refactor", 1)
    .addInput(<contenttweaker:engineering_battery_v1>)
    .addOutput(<contenttweaker:engineering_battery_v2>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
        ])
    .build();
RecipeBuilder.newBuilder("cr_engineering_battery_v3", "causal_refactor", 1)
    .addInput(<contenttweaker:engineering_battery_v2>)
    .addOutput(<contenttweaker:engineering_battery_v3>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
        ])
    .build();
RecipeBuilder.newBuilder("cr_engineering_battery_v4", "causal_refactor", 1)
    .addInput(<contenttweaker:engineering_battery_v3>)
    .addOutput(<contenttweaker:engineering_battery_v4>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
        ])
    .build();
RecipeBuilder.newBuilder("cr_robot_arm_first","causal_refactor", 1)
        .addInput(<minecraft:iron_ingot>)
        .addOutput(<contenttweaker:robot_arm_v1>)
        .addRecipeTooltip([
                "§6§l终焉的造物,'更多巨构'产能的极限"
            ])
        .build();
RecipeBuilder.newBuilder("cr_coil_first","causal_refactor", 1)
        .addInput(<thermalfoundation:material:128>)
        .addOutput(<contenttweaker:coil_v2>)
        .addRecipeTooltip([
                "§6§l终焉的造物,'更多巨构'产能的极限"
            ])
        .build();
RecipeBuilder.newBuilder("cr_electric_motorfirst" ,"causal_refactor", 1)
        .addInput(<minecraft:gold_ingot>)
        .addOutput(<contenttweaker:electric_motor_v1>)
        .addRecipeTooltip([
                "§6§l终焉的造物,'更多巨构'产能的极限"
            ])
        .build();
RecipeBuilder.newBuilder("cr_sensor_first" ,"causal_refactor", 1)
        .addInput(<thermalfoundation:material:130>)
        .addOutput(<contenttweaker:sensor_v2>)
        .addRecipeTooltip([
                "§6§l终焉的造物,'更多巨构'产能的极限"
            ])
        .build();
RecipeBuilder.newBuilder("cr_field_generator_first", "causal_refactor", 1)
        .addInput(<thermalfoundation:material:136>)
        .addOutput(<contenttweaker:field_generator_v2>)
        .addRecipeTooltip([
                "§6§l终焉的造物,'更多巨构'产能的极限"
            ])
        .build();
RecipeBuilder.newBuilder("cr_industrial_circuit_first" ,"causal_refactor", 1)
        .addInput(<thermalfoundation:material:129>)
        .addOutput(<contenttweaker:industrial_circuit_v2>)
        .addRecipeTooltip([
                "§6§l终焉的造物,'更多巨构'产能的极限"
            ])
        .build();
RecipeBuilder.newBuilder("cr_energized_fuel_first" ,"causal_refactor", 1)
        .addInput(<minecraft:coal>)
        .addOutput(<contenttweaker:energized_fuel_v2>)
        .addRecipeTooltip([
                "§6§l终焉的造物,'更多巨构'产能的极限"
            ])
        .build();
RecipeBuilder.newBuilder("cr_engineering_battery_first", "causal_refactor", 1)
        .addInput(<thermalfoundation:material:132>)
        .addOutput(<contenttweaker:engineering_battery_v2>)
        .addRecipeTooltip([
                "§6§l终焉的造物,'更多巨构'产能的极限"
            ])
        .build();
RecipeBuilder.newBuilder("cr_darkmatter", "causal_refactor", 1)
        .addInput(<mekanism:antimatterpellet>)
        .addOutput(<contenttweaker:stellaris_darkmatter>)
        .addRecipeTooltip([
                "§6§l终焉的造物,'更多巨构'产能的极限"
            ])
        .build();
RecipeBuilder.newBuilder("cr_hxsrlb", "causal_refactor", 1)
        .addInput(<contenttweaker:stellaris_darkmatter>)
        .addOutput(<contenttweaker:hxsrlb>)
        .addRecipeTooltip([
                "§6§l终焉的造物,'更多巨构'产能的极限"
            ])
        .build();
RecipeBuilder.newBuilder("cr_super_solar_panels_machines_2", "causal_refactor", 1)
        .addInput(<super_solar_panels:machines:1>)
        .addOutput(<super_solar_panels:machines:1>)
        .addRecipeTooltip([
                "§6§l终焉的造物,'更多巨构'产能的极限"
            ])
        .build();
RecipeBuilder.newBuilder("cr_super_solar_panels_machines_3", "causal_refactor", 1)
    .addInput(<super_solar_panels:machines:2>)
    .addOutput(<super_solar_panels:machines:3>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
        ])
    .build();
RecipeBuilder.newBuilder("cr_super_solar_panels_machines_4", "causal_refactor", 1)
    .addInput(<super_solar_panels:machines:3>)
    .addOutput(<super_solar_panels:machines:4>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
        ])
    .build();
RecipeBuilder.newBuilder("cr_super_solar_panels_machines_5", "causal_refactor", 1)
    .addInput(<super_solar_panels:machines:4>)
    .addOutput(<super_solar_panels:machines:5>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
        ])
    .build();
RecipeBuilder.newBuilder("cr_super_solar_panels_machines_6", "causal_refactor", 1)
    .addInput(<super_solar_panels:machines:5>)
    .addOutput(<super_solar_panels:machines:6>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
        ])
    .build();
RecipeBuilder.newBuilder("cr_super_solar_panels_machines_7", "causal_refactor", 1)
    .addInput(<super_solar_panels:machines:6>)
    .addOutput(<super_solar_panels:machines:7>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
        ])
    .build();
RecipeBuilder.newBuilder("cr_super_solar_panels_machines_8", "causal_refactor", 1)
    .addInput(<super_solar_panels:machines:7>)
    .addOutput(<super_solar_panels:machines:8>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
        ])
    .build();
RecipeBuilder.newBuilder("cr_super_solar_panels_machines_9", "causal_refactor", 1)
    .addInput(<super_solar_panels:machines:8>)
    .addOutput(<super_solar_panels:machines:9>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
        ])
    .build();
RecipeBuilder.newBuilder("cr_super_solar_panels_machines_10", "causal_refactor", 1)
    .addInput(<super_solar_panels:machines:9>)
    .addOutput(<super_solar_panels:machines:10>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
        ])
    .build();
RecipeBuilder.newBuilder("cr_super_solar_panels_machines_11", "causal_refactor", 1)
    .addInput(<super_solar_panels:machines:10>)
    .addOutput(<super_solar_panels:machines:11>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
        ])
    .build();
RecipeBuilder.newBuilder("cr_super_solar_panels_machines_1", "causal_refactor", 1)
    .addInput(<appliedenergistics2:material:5>)
    .addOutput(<super_solar_panels:machines:1>)
    .addRecipeTooltip([
            "§6§l终焉的造物,'更多巨构'产能的极限"
        ])
    .build();
RecipeBuilder.newBuilder("causal_refactor_factory_controller", "ark_space_station", 72000)
    .addInput(<contenttweaker:industrial_circuit_v4> * 16384)
    .addInput(<contenttweaker:field_generator_v4> * 16384)
    .addInput(<contenttweaker:space_time_coil> * 16384)
    .addInput(<moreplates:infinity_gear> * 16384)
    .addInput(<contenttweaker:coil_v5> * 1048576)
    .addInput(<contenttweaker:antimatter_core> * 16384)
    .addInput(<modularmachinery:qft_factory_controller> * 64)
    .addOutput(<novaeng_core:singularity_core_controller>)
    .addOutput(<modularmachinery:causal_refactor_factory_controller>)
    .requireResearch("aw_start3")
    .requireComputationPoint(4000*1000.0F)
    .build();
MachineModifier.setMaxThreads("causal_refactor", 1024);
MachineModifier.setInternalParallelism("causal_refactor", 1073741824);
<novaeng_core:singularity_core_controller>.addTooltip("§c§l用于装饰因果重塑者,可选,请保证放置在因果重塑者能源输出仓下方并与因果重塑者控制器朝向一致");
<modularmachinery:causal_refactor_factory_controller>.addTooltip("§5§l终焉的造物,游戏毕业物品之一");
RecipeBuilder.newBuilder("darkmatter_super_fucking_odal", "super_fucking_odal", 1)
        .addInput(<mekanism:antimatterpellet> * 1048576)
        .addInput(<contenttweaker:mm_yzjz> * 1)
        .addInput(<contenttweaker:polymer_matter> * 1)
        .addOutput(<contenttweaker:stellaris_darkmatter>)
        .addRecipeTooltip([
                "§m§a究§b极§c悖§d论",
                "§l能量消耗:10Zrf/tick"
            ])
        .build();