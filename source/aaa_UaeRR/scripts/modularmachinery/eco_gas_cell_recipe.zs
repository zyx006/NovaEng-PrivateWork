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

RecipeBuilder.newBuilder("estorage_cell_gas_16m", "board_assembly_room", 400)
    .addEnergyPerTickInput(16000)
    .addInputs([
        <contenttweaker:hypernet_cpu_t2>,
        <contenttweaker:hypernet_ram_t2> * 2,
        <ore:dustGold> * 32,
        <appliedenergistics2:material:39> * 4,
        <appliedenergistics2:material:43> * 8,
        <appliedenergistics2:material:44> * 8,
        <appliedenergistics2:material:10> * 64,
        <appliedenergistics2:material:10> * 64,
    ])
    .addOutputs(<novaeng_core:estorage_cell_gas_16m>.withTag({}))
    .requireResearch("extendable_digital_storage_subsystem_l4")
    .setParallelized(false)
    .build();
RecipeBuilder.newBuilder("estorage_cell_gas_64m", "precision_assembler", 600)
    .addEnergyPerTickInput(256000)
    .addInputs([
        <contenttweaker:hypernet_cpu_t2> * 2,
        <contenttweaker:hypernet_ram_t2> * 4,
        <ore:dustGold> * 32,
        <mets:neutron_plate> * 16,
        <appliedenergistics2:material:43> * 8,
        <appliedenergistics2:material:44> * 8,
        <ore:gemBoronNitride> * 64,
        <ore:gemBoronNitride> * 64,
        <appliedenergistics2:material:10> * 16,
    ])
    .addOutputs(<novaeng_core:estorage_cell_gas_64m>.withTag({}))
    .requireResearch("extendable_digital_storage_subsystem_l6")
    .requireComputationPoint(20.0F)
    .setParallelized(false)
    .build();
RecipeBuilder.newBuilder("estorage_cell_gas_256m", "assembly_line", 600)
    .addEnergyPerTickInput(32000000)
    .addInput(<liquid:crystalloid> * 432).setTag("fluid_input_0") // Fluid
    .addInput(<contenttweaker:exponential_level_processor> * 8).setTag("input_0")
    .addInput(<threng:material:14> * 16).setTag("input_1")
    .addInput(<appliedenergistics2:material:43> * 24).setTag("input_2")
    .addInput(<appliedenergistics2:material:44> * 24).setTag("input_3")
    .addInput(<appliedenergistics2:material:47> * 2).setTag("input_line_0")
    .addInput(<ore:dustGold> * 64).setTag("input_line_1")
    .addOutput(<novaeng_core:estorage_cell_gas_256m> * 1).setTag("output_line_end")
    .requireResearch("extendable_digital_storage_subsystem_l9")
    .requireComputationPoint(100.0F)
    .convertAssemblyLineRecipeToDefaultRecipeAndRegister("acar")
    .setParallelized(false)
    .build();