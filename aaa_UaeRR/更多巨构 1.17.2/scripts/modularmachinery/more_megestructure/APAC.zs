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

HyperNetHelper.proxyMachineForHyperNet("apac");
// 精密装配机阵列：配方继承
# 精密装配机 -> 精密装配机阵列
RecipeAdapterBuilder.create("APAC", "modularmachinery:precision_assembler")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.1F, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 8.0F, 1, false).build())
    .build();

// CPU 模块（等级 1）
RecipeBuilder.newBuilder("hypernet_cpu_t1", "APAC", 80)
    .addEnergyPerTickInput(4800)
    .addInputs([
        <liquid:redstone> * 800,
        <appliedenergistics2:material:23> * 2,
        <ore:platePalisEmpowered> * 2,
    ])
    .addOutput(<contenttweaker:hypernet_cpu_t1> * 1)
    .requireResearch("cpu_t1")
    .build();


// 内存模块（等级 1）
RecipeBuilder.newBuilder("hypernet_ram_t1", "APAC", 80)
    .addEnergyPerTickInput(4800)
    .addInputs([
        <liquid:gold> * 432,
        <appliedenergistics2:material:23> * 1,
        <appliedenergistics2:material:22> * 1,
        <ore:platePalisEmpowered> * 2,
    ])
    .addOutput(<contenttweaker:hypernet_ram_t1> * 1)
    .requireResearch("cpu_t1")
    .build();


//工程控制电路（等级 1）
RecipeBuilder.newBuilder("industrial_circuit_v1", "APAC", 40)
    .addEnergyPerTickInput(9600)
    .addInputs([
        <liquid:redstone> * 800,
        <ore:circuitAdvanced> * 3,
        <ic2:crafting:4> * 1,
    ])
    .addOutput(<contenttweaker:industrial_circuit_v1> * 3)
    .build();


//传感器（等级 1）
RecipeBuilder.newBuilder("sensor_v1", "APAC", 200)
    .addEnergyPerTickInput(4800)
    .addInputs([
        <ore:circuitElite> * 1,
        <contenttweaker:industrial_circuit_v1> * 1,
        <ore:stickTin> * 2,
        <ic2:crafting:4> * 1,
        <environmentaltech:litherite_crystal>
    ])
    .addOutputs(<contenttweaker:sensor_v1> * 2)
    .build();


//电动马达（等级 1）
RecipeBuilder.newBuilder("electric_motor_v1", "APAC", 20)
    .addEnergyPerTickInput(4800)
    .addInputs([
        <ic2:crafting:5> * 2,
        <ore:plateTin> * 2,
        <ore:stickIron> * 1,
    ])
    .addOutputs(<contenttweaker:electric_motor_v1> * 1)
    .build();


//电动马达（等级 2）
RecipeBuilder.newBuilder("electric_motor_v2", "APAC", 20)
    .addEnergyPerTickInput(9600)
    .addInputs([
        <contenttweaker:coil_v2> * 4,
        <ore:plateWillowalloy> * 4,
        <contenttweaker:industrial_circuit_v1> * 2,
        <ic2:crafting:30> * 1,
    ])
    .addOutputs(<contenttweaker:electric_motor_v2> * 2)
    .build();


//机械臂（等级 1）
RecipeBuilder.newBuilder("robot_arm_v1", "APAC", 20)
    .addEnergyPerTickInput(4800)
    .addInputs([
        <contenttweaker:electric_motor_v1> * 2,
        <ore:stickIron> * 2,
        <ore:circuitAdvanced> * 1,
    ])
    .addOutputs(<contenttweaker:robot_arm_v1> * 1)
    .build();


//机械臂（等级 2）
RecipeBuilder.newBuilder("robot_arm_v2", "APAC", 20)
    .addEnergyPerTickInput(9600)
    .addInputs([
        <contenttweaker:electric_motor_v2> * 2,
        <ore:stickWillowalloy> * 2,
        <contenttweaker:industrial_circuit_v1> * 1,
    ])
    .addOutputs(<contenttweaker:robot_arm_v2> * 1)
    .build();


//工程电池（等级 1）
RecipeBuilder.newBuilder("engineering_battery_v1", "APAC", 20)
    .addEnergyPerTickInput(4800)
    .addInputs([
        <liquid:redstone> * 450,
        <ore:plateTin> * 2,
        <ore:circuitAdvanced> * 1,
    ])
    .addOutputs(<contenttweaker:engineering_battery_v1> * 1)
    .build();


//工程电池（等级 2）
RecipeBuilder.newBuilder("engineering_battery_v2", "APAC", 40)
    .addEnergyPerTickInput(9600)
    .addInputs([
        <ore:dustLithium> * 16,
        <ore:dustGraphite> * 4,
        <ic2:crafting:4> * 1,
        <contenttweaker:industrial_circuit_v1> * 1,
    ])
    .addOutputs(<contenttweaker:engineering_battery_v2> * 1)
    .build();


RecipeBuilder.newBuilder("assembly_basic_1A", "APAC", 2)
    .addEnergyPerTickInput(600)
    .addInputs([
        <liquid:redstone> * 10,
        <ore:plateOsmium>
    ])
    .addOutput(<mekanism:controlcircuit>)
    .build();



RecipeBuilder.newBuilder("assembly_basic_2A", "APAC", 2)
    .addEnergyPerTickInput(600)
    .addInputs([
        <ore:plateIron>,
        <ore:plateCopper>,
        <liquid:redstone> * 10,
    ])
    .addOutput(<ic2:crafting:1>)
    .build();



RecipeBuilder.newBuilder("assembly_basic_3A", "APAC", 4)
    .addEnergyPerTickInput(1200)
    .addInputs([
        <ore:circuitBasic>,
        <ore:gemLapis>,
        <ore:dustRedstone>,
        <ore:dustGlowstone>,
    ])
    .addOutput(<ic2:crafting:2>)
    .build();



RecipeBuilder.newBuilder("assembly_basic_4A", "APAC", 4)
    .addEnergyPerTickInput(1200)
    .addInputs([
        <ore:circuitAdvanced> * 2,
        <mekanism:reinforcedalloy> * 2,
        <appliedenergistics2:material:20> * 2,
        <ore:plateSignalum> * 1,
        <mets:superconducting_cable> * 2,
        <ore:crystalLitherite> * 2
    ])
    .addOutput(<mekanism:controlcircuit:2>)
    .build();


// CPU 模块（等级 2）
RecipeBuilder.newBuilder("hypernet_cpu_t2", "APAC", 120)
    .addEnergyPerTickInput(9600)
    .addInputs([
        <liquid:redstone> * 1600,
        <appliedenergistics2:material:23> * 8,
        <threng:material:5> * 6,
        <ic2:heat_vent> * 2,
        <ore:plateEnergium> * 2,
    ])
    .addOutput(<contenttweaker:hypernet_cpu_t2> * 1)
    .requireResearch("cpu_t2")
    .build();


// GPU 模块（等级 1）
RecipeBuilder.newBuilder("hypernet_gpu_t1", "APAC", 160)
    .addEnergyPerTickInput(14400)
    .addInputs([
        <liquid:redstone> * 2400,
        <appliedenergistics2:material:23> * 16,
        <threng:material:5> * 12,
        <ore:plateEnergium> * 6,
        <ic2:component_heat_vent> * 2,
        <contenttweaker:hypernet_ram_t2> * 2,
    ])
    .addOutput(<contenttweaker:hypernet_gpu_t1> * 1)
    .requireResearch("cpu_t2")
    .build();


// 内存模块（等级 2）
RecipeBuilder.newBuilder("hypernet_ram_t2", "APAC", 120)
    .addEnergyPerTickInput(9600)
    .addInputs([
        <liquid:gold> * 864,
        <appliedenergistics2:material:23> * 4,
        <appliedenergistics2:material:22> * 4,
        <ic2:heat_vent> * 2,
        <ore:plateEnergium> * 2,
    ])
    .addOutput(<contenttweaker:hypernet_ram_t2> * 1)
    .requireResearch("cpu_t2")
    .build();


RecipeBuilder.newBuilder("assembly_basic_1", "APAC", 8)
    .addEnergyPerTickInput(3600)
    .addInputs([
        <mets:superconducting_cable> * 4,
        <ic2:crafting:2> * 2,
        <ore:ingotPlatinum> * 2,
        <minecraft:diamond>,
        <ore:crystalLitherite> * 2
    ])
    .addOutput(<mets:super_circuit> * 2)
    .build();



RecipeBuilder.newBuilder("assembly_basic_2", "APAC", 8)
    .addEnergyPerTickInput(4800)
    .addInputs([
        <ore:circuitElite> * 2,
        <mekanism:atomicalloy> * 2,
        <appliedenergistics2:material:20> * 2,
        <gravisuite:crafting> * 1,
        <ore:plateEnderium> * 1,
        <environmentaltech:erodium_crystal> * 2
    ])
    .addOutput(<mekanism:controlcircuit:3> * 2)
    .build();



RecipeBuilder.newBuilder("assembly_basic_3", "APAC", 10)
    .addEnergyPerTickInput(6200)
    .addInputs([
        <mets:super_circuit> * 2,
        <mets:super_iridium_compress_plate>,
        <mets:nano_living_metal> * 2,
        <gravisuite:crafting:1> * 2,
        <environmentaltech:erodium_crystal> * 2
    ])
    .addOutput(<mets:living_circuit> * 2)
    .build();



RecipeBuilder.newBuilder("assembly_basic_4", "APAC", 10)
    .addEnergyPerTickInput(8000)
    .addInputs([
        <mekanism:controlcircuit:3>,
        <mets:living_circuit>,
        <super_solar_panels:crafting:23>,
        <mets:super_iridium_compress_plate>,
    ])
    .addOutput(<super_solar_panels:crafting:44> * 3)
    .build();



RecipeBuilder.newBuilder("assembly_basic_5", "APAC", 20)
    .addEnergyPerTickInput(10000)
    .addInputs([
        <deepmoblearning:soot_covered_redstone> * 16,
        <ore:circuitElite> * 8,
        <ore:ingotEnergium> * 8,
        <ore:ingotTerraAlloy>,
    ])
    .addOutput(<deepmoblearning:data_model_blank> * 8)
    .build();



# 生命源质处理器
RecipeBuilder.newBuilder("assembly_basic_6", "APAC", 20)
    .addEnergyPerTickInput(12000)
    .addInputs([
        <ore:circuitAdvanced> * 4,
        <ore:ingotElvenElementium> * 2,
        <mets:nano_living_metal> * 1,
        <bloodmagic:slate:2> * 1,
        <liquid:astralsorcery.liquidstarlight> * 200,
    ])
    .addOutput(<contenttweaker:lifesense_processor> * 4)
    .build();

# MEK 合金
RecipeBuilder.newBuilder("assembly_alloy_1", "APAC", 2)
    .addEnergyPerTickInput(1200)
    .addInput(<ore:ingotIron>)
    .addInput(<liquid:redstone> * 10)
    .addOutput(<mekanism:enrichedalloy>)
    .build();



RecipeBuilder.newBuilder("assembly_alloy_2", "APAC", 3)
    .addEnergyPerTickInput(1200)
    .addInput(<ore:alloyAdvanced>)
    .addInput(<liquid:diamond> * 10)
    .addOutput(<mekanism:reinforcedalloy>)
    .build();



RecipeBuilder.newBuilder("assembly_alloy_3", "APAC", 4)
    .addEnergyPerTickInput(1200)
    .addInput(<ore:alloyElite>)
    .addInput(<liquid:obsidian> * 10)
    .addOutput(<mekanism:atomicalloy>)
    .build();



# 玄钢线圈盘
RecipeBuilder.newBuilder("dark_steel_wire_reel", "APAC", 10)
    .addEnergyPerTickInput(1600)
    .addInput(<ore:gearDarkSteel> * 2)
    .addInput(<ore:plateDarkSteel> * 4)
    .addInput(<ore:itemInfinityRod> * 1)
    .addOutput(<contenttweaker:dark_steel_wire_reel>)
    .build();


# 镍导线
RecipeBuilder.newBuilder("nickel_wire", "APAC", 4)
    .addEnergyPerTickInput(800)
    .addInput(<ore:plateNickel> * 1)
    .addOutput(<contenttweaker:nickel_wire> * 2)
    .build();
//精密配方
//力场发生器（等级 1）
RecipeBuilder.newBuilder("field_generator_v1", "precision_assembler", 400)
    .addEnergyPerTickInput(512000)
    .addInputs([
        <ore:circuitUltimate> * 1,
        <contenttweaker:industrial_circuit_v2> * 1,
        <contenttweaker:coil_v2> * 2,
        <ore:netherStar> * 1,
    ])
    .addOutput(<contenttweaker:field_generator_v1> * 1)
    .requireComputationPoint(10.0F)
    .requireResearch("field_generator_v1")
    .build();


//工程控制电路（等级 2）
RecipeBuilder.newBuilder("industrial_circuit_v2", "precision_assembler", 800)
    .addEnergyPerTickInput(256000)
    .addInputs([
        <ore:circuitUltimate> * 4,
        <ore:ingotEnergium> * 2,
        <ore:plateWillowalloy> * 2,
    ])
    .addOutput(<contenttweaker:industrial_circuit_v2> * 4)
    .requireComputationPoint(4.0F)
    .build();


//传感器（等级 2）
RecipeBuilder.newBuilder("sensor_v2", "precision_assembler", 400)
    .addEnergyPerTickInput(128000)
    .addInputs([
        <contenttweaker:lifesense_processor> * 1,
        <contenttweaker:industrial_circuit_v2> * 1,
        <ore:stickWillowalloy> * 2,
        <mets:neutron_plate> * 2,
        <ore:gemGelidCrystal> * 1,
    ])
    .addOutputs(<contenttweaker:sensor_v2> * 2)
    .requireComputationPoint(6.0F)
    .build();


//传感器（等级 3）
RecipeBuilder.newBuilder("sensor_v3", "precision_assembler", 400)
    .addEnergyPerTickInput(128000)
    .addInputs([
        <contenttweaker:exponential_level_processor> * 1,
        <contenttweaker:industrial_circuit_v2> * 1,
        <ore:stickWillowalloy> * 2,
        <mets:neutron_plate> * 2,
        <enderutilities:enderpart:12> * 1,
    ])
    .addOutputs(<contenttweaker:sensor_v3> * 2)
    .requireComputationPoint(30.0F)
    .build();


//电动马达（等级 3）
RecipeBuilder.newBuilder("electric_motor_v3", "precision_assembler", 400)
    .addEnergyPerTickInput(128000)
    .addInputs([
        <contenttweaker:coil_v3> * 2,
        <mets:neutron_plate> * 2,
        <contenttweaker:industrial_circuit_v2> * 1,
        <ore:ingotWillowalloy> * 1,
    ])
    .addOutputs(<contenttweaker:electric_motor_v3> * 1)
    .requireComputationPoint(15.0F)
    .build();


//机械臂（等级 3）
RecipeBuilder.newBuilder("robot_arm_v3", "precision_assembler", 400)
    .addEnergyPerTickInput(128000)
    .addInputs([
        <contenttweaker:electric_motor_v3> * 2,
        <ore:stickWillowalloy> * 2,
        <contenttweaker:industrial_circuit_v2> * 1,
    ])
    .addOutputs(<contenttweaker:robot_arm_v3> * 1)
    .requireComputationPoint(20.0F)
    .build();


//工程电池（等级 3）
RecipeBuilder.newBuilder("engineering_battery_v3", "precision_assembler", 400)
    .addEnergyPerTickInput(128000)
    .addInputs([
        <enderio:item_capacitor_melodic> * 8,
        <mets:neutron_plate> * 2,
        <contenttweaker:industrial_circuit_v2> * 1,
    ])
    .addOutputs(<contenttweaker:engineering_battery_v3> * 1)
    .requireComputationPoint(20.0F)
    .build();


//恒星合金导线
RecipeBuilder.newBuilder("stellar_alloy_wire", "precision_assembler", 40)
    .addEnergyPerTickInput(128000)
    .addInput(<ore:plateStellarAlloy> * 1)
    .addOutput(<contenttweaker:stellar_alloy_wire> * 2)
    .build();


//无尽导线
RecipeBuilder.newBuilder("infinity_wire", "precision_assembler", 80)
    .addEnergyPerTickInput(4096000)
    .addInput(<ore:plateInfinity> * 1)
    .addOutput(<contenttweaker:infinity_wire> * 2)
    .requireResearch("beyond_limits")
    .build();


//中子素线圈盘
RecipeBuilder.newBuilder("neutron_coil_discs", "precision_assembler", 200)
    .addEnergyPerTickInput(512000)
    .addInput(<ore:gearCosmicNeutronium> * 2)
    .addInput(<ore:plateCosmicNeutronium> * 4)
    .addInput(<ore:itemInfinityRod> * 4)
    .addOutput(<contenttweaker:neutron_coil_discs>)
    .build();


//水晶矩阵力场控制矩阵
RecipeBuilder.newBuilder("crystalmatrixforcefieldcontrolblock", "precision_assembler", 400)
    .addEnergyPerTickInput(768000)
    .addInput(<ore:blockCrystalMatrix> * 1)
    .addInput(<contenttweaker:extrememachineblock> * 2)
    .addInput(<contenttweaker:coil_v3> * 12)
    .addInput(<contenttweaker:field_generator_v1> * 12)
    .addInput(<contenttweaker:sensor_v2> * 2)
    .addInput(<gravisuite:crafting> * 4)
    .addOutput(<contenttweaker:crystalmatrixforcefieldcontrolblock> * 2)
    .build();


//中子矩阵力场控制矩阵
RecipeBuilder.newBuilder("neutronforcefieldcontrolblock", "precision_assembler", 400)
    .addEnergyPerTickInput(768000)
    .addInput(<mets:neutron_plate> * 12)
    .addInput(<contenttweaker:extrememachineblock> * 2)
    .addInput(<contenttweaker:coil_v3> * 12)
    .addInput(<contenttweaker:field_generator_v1> * 12)
    .addInput(<contenttweaker:sensor_v2> * 2)
    .addInput(<gravisuite:crafting> * 4)
    .addOutput(<contenttweaker:neutronforcefieldcontrolblock> * 2)
    .build();


//精密装配机-控制器
RecipeBuilder.newBuilder("controller_precision_assembler", "machine_arm", 2400)
    .addEnergyPerTickInput(768000)
    .addInput(<contenttweaker:industrial_circuit_v1> * 24)
    .addInput(<contenttweaker:robot_arm_v2> * 20)
    .addInput(<contenttweaker:electric_motor_v2> * 20)
    .addInput(<contenttweaker:sensor_v1> * 12)
    .addInput(<ore:circuitUltimate> * 30)
    .addInput(<avaritia:resource:1> * 8)
    .addInput(<ore:plateWillowalloy> * 30)
    .addOutput(<modularmachinery:precision_assembler_factory_controller>)
    .requireResearch("precision_assembler")
    .build();

//通用数据存储卡
RecipeBuilder.newBuilder("general_data_card", "precision_assembler", 400)
    .addEnergyPerTickInput(64000)
    .addItemInputs([
        <ore:circuitElite> * 8,
        <mets:neutron_plate> * 4,
        <avaritia:resource:1> * 4,
        <appliedenergistics2:material:43> * 8,
        <appliedenergistics2:material:44> * 8,
    ])
    .addOutput(<contenttweaker:general_data_card> * 12)
    .requireComputationPoint(25.0F)
    .build();


// //指数级处理器
// RecipeBuilder.newBuilder("exponential_level_processor", "precision_assembler", 1200)
//     .addEnergyPerTickInput(96000)
//     .addInputs([
//         <liquid:neutron> * 100,
//         <threng:material:14> * 2,
//         <contenttweaker:lifesense_processor> * 4,
//         <ore:ingotCrystalMatrix> * 2,
//         <ore:ingotWillowalloy> * 1,
//     ])
//     .addOutput(<contenttweaker:exponential_level_processor> * 6)
//     .build();
// 

//高级数据模型存储卡
RecipeBuilder.newBuilder("data_model_card", "precision_assembler", 60)
    .addEnergyPerTickInput(128000)
    .addInput(<liquid:crystalloid> * 5)
    .addInput(<liquid:crystalloidneutron> * 72)
    .addInput(<deepmoblearning:data_model_blank> * 1)
    .addOutput(<contenttweaker:data_model_card> * 1)
    .requireComputationPoint(100.0F)
    .build();


//僵尸数据模型
RecipeBuilder.newBuilder("data_model_zombie", "precision_assembler", 600)
    .addEnergyPerTickInput(128000)
    .addInput(<deepmoblearning:data_model_blank>)
    .addInput(<minecraft:rotten_flesh> * 16)
    .addInput(<ore:cropCarrot> * 64)
    .addInput(<ore:cropPotato> * 64)
    .addInput(<ore:ingotIron> * 64)
    .addOutput(<deepmoblearning:data_model_zombie>)
    .requireComputationPoint(50.0F)
    .build();


//骷髅数据模型
RecipeBuilder.newBuilder("data_model_skeleton", "precision_assembler", 600)
    .addEnergyPerTickInput(128000)
    .addInput(<deepmoblearning:data_model_blank>)
    .addInput(<ore:bone> * 64)
    .addInput(<minecraft:arrow> * 64)
    .addInput(<minecraft:skull> * 64)
    .addOutput(<deepmoblearning:data_model_skeleton>)
    .requireComputationPoint(50.0F)
    .build();


//苦力怕数据模型
RecipeBuilder.newBuilder("data_model_creeper", "precision_assembler", 900)
    .addEnergyPerTickInput(128000)
    .addInput(<deepmoblearning:data_model_blank>)
    .addInput(<ore:gunpowder> * 64)
    .addInput(<minecraft:skull:4> * 64)
    .addOutput(<deepmoblearning:data_model_creeper>)
    .requireComputationPoint(75.0F)
    .build();


//蜘蛛数据模型
RecipeBuilder.newBuilder("data_model_spider", "precision_assembler", 600)
    .addEnergyPerTickInput(128000)
    .addInput(<deepmoblearning:data_model_blank>)
    .addInput(<minecraft:spider_eye> * 64)
    .addInput(<ore:string> * 64)
    .addInput(<minecraft:web> * 64)
    .addOutput(<deepmoblearning:data_model_spider>)
    .requireComputationPoint(75.0F)
    .build();


//史莱姆数据模型
RecipeBuilder.newBuilder("data_model_slime", "precision_assembler", 900)
    .addEnergyPerTickInput(128000)
    .addInput(<deepmoblearning:data_model_blank>)
    .addInput(<ore:slimeballGreen> * 64)
    .addOutput(<deepmoblearning:data_model_slime>)
    .requireComputationPoint(150.0F)
    .build();


//女巫数据模型
RecipeBuilder.newBuilder("data_model_witch", "precision_assembler", 1200)
    .addEnergyPerTickInput(256000)
    .addInput(<deepmoblearning:data_model_blank>)
    .addInput(<ore:listAllsugar> * 64)
    .addInput(<ore:dustGlowstone> * 64)
    .addInput(<ore:dustRedstone> * 64)
    .addOutput(<deepmoblearning:data_model_witch>)
    .requireComputationPoint(200.0F)
    .build();


//烈焰人数据模型
RecipeBuilder.newBuilder("data_model_blaze", "precision_assembler", 1200)
    .addEnergyPerTickInput(256000)
    .addInput(<deepmoblearning:data_model_blank>)
    .addInput(<ore:itemBlazeRod> * 64)
    .addInput(<ore:dustSulfur> * 64)
    .addOutput(<deepmoblearning:data_model_blaze>)
    .requireComputationPoint(300.0F)
    .build();


//恶魂数据模型
RecipeBuilder.newBuilder("data_model_ghast", "precision_assembler", 1500)
    .addEnergyPerTickInput(512000)
    .addInput(<deepmoblearning:data_model_blank>)
    .addInput(<ore:itemGhastTear> * 64)
    .addInput(<ore:gunpowder> * 64)
    .addOutput(<deepmoblearning:data_model_ghast>)
    .requireComputationPoint(400.0F)
    .build();


//凋灵骷髅数据模型
RecipeBuilder.newBuilder("data_model_wither_skeleton", "precision_assembler", 1500)
    .addEnergyPerTickInput(512000)
    .addInput(<deepmoblearning:data_model_blank>)
    .addInput(<minecraft:skull:1> * 64)
    .addInput(<ore:itemCoal> * 64)
    .addOutput(<deepmoblearning:data_model_wither_skeleton>)
    .requireComputationPoint(800.0F)
    .build();


//末影人数据模型
RecipeBuilder.newBuilder("data_model_enderman", "precision_assembler", 1200)
    .addEnergyPerTickInput(512000)
    .addInput(<deepmoblearning:data_model_blank>)
    .addInput(<minecraft:ender_pearl> * 16)
    .addInput(<minecraft:end_crystal> * 64)
    .addInput(<enderio:block_enderman_skull> * 64)
    .addOutput(<deepmoblearning:data_model_enderman>)
    .requireComputationPoint(600.0F)
    .build();


//潜影贝数据模型
RecipeBuilder.newBuilder("data_model_shulker", "precision_assembler", 1500)
    .addEnergyPerTickInput(512000)
    .addInput(<deepmoblearning:data_model_blank>)
    .addInput(<minecraft:shulker_shell> * 64)
    .addOutput(<deepmoblearning:data_model_shulker>)
    .requireComputationPoint(800.0F)
    .build();


//守卫者数据模型
RecipeBuilder.newBuilder("data_model_guardian", "precision_assembler", 1200)
    .addEnergyPerTickInput(512000)
    .addInput(<deepmoblearning:data_model_blank>)
    .addInput(<ore:shardPrismarine> * 64)
    .addInput(<ore:dustPrismarine> * 64)
    .addInput(<minecraft:fish> * 64)
    .addOutput(<deepmoblearning:data_model_guardian>)
    .requireComputationPoint(700.0F)
    .build();


//热力膨胀数据模型
RecipeBuilder.newBuilder("data_model_thermal_elemental", "precision_assembler", 1500)
    .addEnergyPerTickInput(512000)
    .addInput(<deepmoblearning:data_model_blank>)
    .addInput(<ore:rodBlizz> * 64)
    .addInput(<ore:rodBasalz> * 64)
    .addInput(<ore:rodBlitz> * 64)
    .addInput(<minecraft:snowball> * 16)
    .addInput(<ore:dustObsidian> * 64)
    .addInput(<ore:dustNiter> * 64)
    .addOutput(<deepmoblearning:data_model_thermal_elemental>)
    .requireComputationPoint(700.0F)
    .build();


//蓝色史莱姆数据模型
RecipeBuilder.newBuilder("data_model_tinker_slime", "precision_assembler", 1500)
    .addEnergyPerTickInput(512000)
    .addInput(<deepmoblearning:data_model_blank>)
    .addInput(<ore:slimeballBlue> * 64)
    .addInput(<ore:slimeballPurple> * 64)
    .addInput(<ore:slimeballMagma> * 64)
    .addInput(<tconstruct:slime_sapling> * 64)
    .addInput(<tconstruct:slime_sapling:1> * 64)
    .addInput(<tconstruct:slime_sapling:2> * 64)
    .addOutput(<deepmoblearning:data_model_tinker_slime>)
    .requireComputationPoint(600.0F)
    .build();


//凋灵数据模型
RecipeBuilder.newBuilder("data_model_wither", "precision_assembler", 1800)
    .addEnergyPerTickInput(1024000)
    .addInput(<deepmoblearning:data_model_blank>)
    .addInput(<ore:netherStar> * 64)
    .addOutput(<deepmoblearning:data_model_wither>.withTag({tier: 0}))
    .requireComputationPoint(2000.0F)
    .build();


//末影龙数据模型
RecipeBuilder.newBuilder("data_model_dragon", "precision_assembler", 1800)
    .addEnergyPerTickInput(1024000)
    .addInput(<deepmoblearning:data_model_blank>)
    .addInput(<minecraft:dragon_egg> * 8)
    .addInput(<draconicevolution:draconium_dust> * 32)
    .addInput(<draconicevolution:dragon_heart>)
    .addInput(<minecraft:skull:5> * 4)
    .addOutput(<deepmoblearning:data_model_dragon>.withTag({tier: 0}))
    .requireComputationPoint(3000.0F)
    .build();

