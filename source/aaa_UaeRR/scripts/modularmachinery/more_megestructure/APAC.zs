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
RecipeAdapterBuilder.create("APAC", "modularmachinery:precision_assembler").build();

// CPU 模块（等级 1）
RecipeBuilder.newBuilder("hypernet_cpu_t1_APAC", "APAC", 1)
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
RecipeBuilder.newBuilder("hypernet_ram_t1_APAC", "APAC", 1)
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
RecipeBuilder.newBuilder("industrial_circuit_v1_APAC", "APAC", 1)
    .addEnergyPerTickInput(9600)
    .addInputs([
        <liquid:redstone> * 800,
        <ore:circuitAdvanced> * 3,
        <ic2:crafting:4> * 1,
    ])
    .addOutput(<contenttweaker:industrial_circuit_v1> * 3)
    .build();


//传感器（等级 1）
RecipeBuilder.newBuilder("sensor_v1_APAC", "APAC", 1)
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
RecipeBuilder.newBuilder("electric_motor_v1_APAC", "APAC", 1)
    .addEnergyPerTickInput(4800)
    .addInputs([
        <ic2:crafting:5> * 2,
        <ore:plateTin> * 2,
        <ore:stickIron> * 1,
    ])
    .addOutputs(<contenttweaker:electric_motor_v1> * 1)
    .build();


//电动马达（等级 2）
RecipeBuilder.newBuilder("electric_motor_v2_APAC", "APAC", 1)
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
RecipeBuilder.newBuilder("robot_arm_v1_APAC", "APAC", 1)
    .addEnergyPerTickInput(4800)
    .addInputs([
        <contenttweaker:electric_motor_v1> * 2,
        <ore:stickIron> * 2,
        <ore:circuitAdvanced> * 1,
    ])
    .addOutputs(<contenttweaker:robot_arm_v1> * 1)
    .build();


//机械臂（等级 2）
RecipeBuilder.newBuilder("robot_arm_v2_APAC", "APAC", 1)
    .addEnergyPerTickInput(9600)
    .addInputs([
        <contenttweaker:electric_motor_v2> * 2,
        <ore:stickWillowalloy> * 2,
        <contenttweaker:industrial_circuit_v1> * 1,
    ])
    .addOutputs(<contenttweaker:robot_arm_v2> * 1)
    .build();


//工程电池（等级 1）
RecipeBuilder.newBuilder("engineering_battery_v1_APAC", "APAC", 1)
    .addEnergyPerTickInput(4800)
    .addInputs([
        <liquid:redstone> * 450,
        <ore:plateTin> * 2,
        <ore:circuitAdvanced> * 1,
    ])
    .addOutputs(<contenttweaker:engineering_battery_v1> * 1)
    .build();


//工程电池（等级 2）
RecipeBuilder.newBuilder("engineering_battery_v2_APAC", "APAC", 1)
    .addEnergyPerTickInput(9600)
    .addInputs([
        <ore:dustLithium> * 16,
        <ore:dustGraphite> * 4,
        <ic2:crafting:4> * 1,
        <contenttweaker:industrial_circuit_v1> * 1,
    ])
    .addOutputs(<contenttweaker:engineering_battery_v2> * 1)
    .build();


RecipeBuilder.newBuilder("assembly_basic_1A_APAC", "APAC", 1)
    .addEnergyPerTickInput(600)
    .addInputs([
        <liquid:redstone> * 10,
        <ore:plateOsmium>
    ])
    .addOutput(<mekanism:controlcircuit>)
    .build();



RecipeBuilder.newBuilder("assembly_basic_2A_APAC", "APAC", 1)
    .addEnergyPerTickInput(600)
    .addInputs([
        <ore:plateIron>,
        <ore:plateCopper>,
        <liquid:redstone> * 10,
    ])
    .addOutput(<ic2:crafting:1>)
    .build();



RecipeBuilder.newBuilder("assembly_basic_3A_APAC", "APAC", 1)
    .addEnergyPerTickInput(1200)
    .addInputs([
        <ore:circuitBasic>,
        <ore:gemLapis>,
        <ore:dustRedstone>,
        <ore:dustGlowstone>,
    ])
    .addOutput(<ic2:crafting:2>)
    .build();



RecipeBuilder.newBuilder("assembly_basic_4A_APAC", "APAC", 1)
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
RecipeBuilder.newBuilder("hypernet_cpu_t2_APAC", "APAC", 1)
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
RecipeBuilder.newBuilder("hypernet_gpu_t1_APAC", "APAC", 1)
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
RecipeBuilder.newBuilder("hypernet_ram_t2_APAC", "APAC", 1)
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


RecipeBuilder.newBuilder("assembly_basic_1_APAC", "APAC", 1)
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



RecipeBuilder.newBuilder("assembly_basic_2_APAC", "APAC", 1)
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



RecipeBuilder.newBuilder("assembly_basic_3_APAC", "APAC", 1)
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



RecipeBuilder.newBuilder("assembly_basic_4_APAC", "APAC", 1)
    .addEnergyPerTickInput(8000)
    .addInputs([
        <mekanism:controlcircuit:3>,
        <mets:living_circuit>,
        <super_solar_panels:crafting:23>,
        <mets:super_iridium_compress_plate>,
    ])
    .addOutput(<super_solar_panels:crafting:44> * 3)
    .build();



RecipeBuilder.newBuilder("assembly_basic_5_APAC", "APAC", 1)
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
RecipeBuilder.newBuilder("assembly_basic_6_APAC", "APAC", 1)
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
RecipeBuilder.newBuilder("assembly_alloy_1_APAC", "APAC", 1)
    .addEnergyPerTickInput(1200)
    .addInput(<ore:ingotIron>)
    .addInput(<liquid:redstone> * 10)
    .addOutput(<mekanism:enrichedalloy>)
    .build();
RecipeBuilder.newBuilder("assembly_alloy_2_APAC", "APAC", 1)
    .addEnergyPerTickInput(1200)
    .addInput(<ore:alloyAdvanced>)
    .addInput(<liquid:diamond> * 10)
    .addOutput(<mekanism:reinforcedalloy>)
    .build();
RecipeBuilder.newBuilder("assembly_alloy_3_APAC", "APAC", 1)
    .addEnergyPerTickInput(1200)
    .addInput(<ore:alloyElite>)
    .addInput(<liquid:obsidian> * 10)
    .addOutput(<mekanism:atomicalloy>)
    .build();
# 玄钢线圈盘
RecipeBuilder.newBuilder("dark_steel_wire_reel_APAC", "APAC", 1)
    .addEnergyPerTickInput(1600)
    .addInput(<ore:gearDarkSteel> * 2)
    .addInput(<ore:plateDarkSteel> * 4)
    .addInput(<ore:itemInfinityRod> * 1)
    .addOutput(<contenttweaker:dark_steel_wire_reel>)
    .build();
# 镍导线
RecipeBuilder.newBuilder("nickel_wire_APAC", "APAC", 1)
    .addEnergyPerTickInput(800)
    .addInput(<ore:plateNickel> * 1)
    .addOutput(<contenttweaker:nickel_wire> * 2)
    .build();