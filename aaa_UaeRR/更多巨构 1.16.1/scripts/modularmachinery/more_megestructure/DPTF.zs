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

var recipeCount = 0;


MachineModifier.setInternalParallelism("dptf_cc_af", 32767);
MachineModifier.setInternalParallelism("dptf_cc_ef", 32767);
MachineModifier.setInternalParallelism("dptf_cc_fi", 32767);
MachineModifier.setInternalParallelism("dptf_cc", 1);
MachineModifier.setMaxThreads("dptf_cc_af", 4);
MachineModifier.setMaxThreads("dptf_cc_ef", 4);
MachineModifier.setMaxThreads("dptf_cc_fi", 4);
RecipeAdapterBuilder.create("dptf_cc_ef", "minecraft:furnace")

    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.05F, 1, false).build())
    .build();

RecipeAdapterBuilder.create("dptf_cc_af", "nuclearcraft:alloy_furnace")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.05F, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 1000, 1, false).build())
    .build();

RecipeAdapterBuilder.create("dptf_cc_fi", "nuclearcraft:infuser")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.01F, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 1000,    1, false).build())
    .build();

MachineModifier.setInternalParallelism("dptf_ic_af", 131068);
MachineModifier.setInternalParallelism("dptf_ic_ef", 131068);
MachineModifier.setInternalParallelism("dptf_ic_fi", 131068);
MachineModifier.setInternalParallelism("dptf_ic", 2);
MachineModifier.setMaxThreads("dptf_ic_af", 16);
MachineModifier.setMaxThreads("dptf_ic_ef", 16);
MachineModifier.setMaxThreads("dptf_ic_fi", 16);

RecipeAdapterBuilder.create("dptf_ic_ef", "minecraft:furnace")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.05F, 1, false).build())
    .build();

RecipeAdapterBuilder.create("dptf_ic_af", "nuclearcraft:alloy_furnace")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.05F, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 1000, 1, false).build())
    .build();

RecipeAdapterBuilder.create("dptf_ic_fi", "nuclearcraft:infuser")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.01F, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 1000,    1, false).build())
    .build();

MachineModifier.setInternalParallelism("dptf_nc_af", 524272);
MachineModifier.setInternalParallelism("dptf_nc_ef", 524272);
MachineModifier.setInternalParallelism("dptf_nc_fi", 524272);
MachineModifier.setInternalParallelism("dptf_nc", 4);
MachineModifier.setMaxThreads("dptf_nc_af", 64);
MachineModifier.setMaxThreads("dptf_nc_ef", 64);
MachineModifier.setMaxThreads("dptf_nc_fi", 64);

RecipeAdapterBuilder.create("dptf_nc_ef", "minecraft:furnace")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.05F, 1, false).build())
    .build();

RecipeAdapterBuilder.create("dptf_nc_af", "nuclearcraft:alloy_furnace")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.5F, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 1000, 1, false).build())
    .build();

RecipeAdapterBuilder.create("dptf_nc_fi", "nuclearcraft:infuser")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.01F, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 1000,    1, false).build())
    .build();

MachineModifier.setInternalParallelism("dptf_sac_af", 2097088);
MachineModifier.setInternalParallelism("dptf_sac_ef", 2097088);
MachineModifier.setInternalParallelism("dptf_sac_fi", 2097088);
MachineModifier.setInternalParallelism("dptf_sac", 8);
MachineModifier.setMaxThreads("dptf_sac_ef", 256);
MachineModifier.setMaxThreads("dptf_sac_af", 256);
MachineModifier.setMaxThreads("dptf_sac_fi", 256);

RecipeAdapterBuilder.create("dptf_sac_ef", "minecraft:furnace")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.05F, 1, false).build())
    .build();

RecipeAdapterBuilder.create("dptf_sac_af", "nuclearcraft:alloy_furnace")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.5F, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 1000, 1, false).build())
    .build();

RecipeAdapterBuilder.create("dptf_sac_fi", "nuclearcraft:infuser")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.01F, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 1000,    1, false).build())
    .build();

MachineModifier.setInternalParallelism("dptf_ifc_af", 8388352);
MachineModifier.setInternalParallelism("dptf_ifc_ef", 8388352);
MachineModifier.setInternalParallelism("dptf_ifc_fi", 8388352);
MachineModifier.setInternalParallelism("dptf_ifc", 16);
MachineModifier.setMaxThreads("dptf_ifc_af", 1024);
MachineModifier.setMaxThreads("dptf_ifc_ef", 1024);
MachineModifier.setMaxThreads("dptf_ifc_fi", 1024);

RecipeAdapterBuilder.create("dptf_ifc_ef", "minecraft:furnace")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.05F, 1, false).build())
    .build();

RecipeAdapterBuilder.create("dptf_ifc_af", "nuclearcraft:alloy_furnace")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.5F, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 1000, 1, false).build())
    .build();

RecipeAdapterBuilder.create("dptf_ifc_fi", "nuclearcraft:infuser")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.01F, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 1000,    1, false).build())
    .build();

MachineModifier.setInternalParallelism("dptf_spc_af", 536854528);
MachineModifier.setInternalParallelism("dptf_spc_ef", 1073741824);
MachineModifier.setInternalParallelism("dptf_spc_fi", 33553408);
MachineModifier.setInternalParallelism("dptf_spc", 32);
MachineModifier.setMaxThreads("dptf_spc_ef", 4096);
MachineModifier.setMaxThreads("dptf_spc_af", 4096);
MachineModifier.setMaxThreads("dptf_spc_fi", 4096);

RecipeAdapterBuilder.create("dptf_spc_ef", "minecraft:furnace")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.05F, 1, false).build())
    .build();

RecipeAdapterBuilder.create("dptf_spc_af", "nuclearcraft:alloy_furnace")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.5F, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 1000, 1, false).build())
    .build();

RecipeAdapterBuilder.create("dptf_spc_fi", "nuclearcraft:infuser")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.01F, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 1000,    1, false).build())
    .build();

RecipeBuilder.newBuilder("dptf_cc_af2", "dptf_cc_af", 1)
        .addEnergyPerTickInput(8)
        .addInput(<minecraft:coal> * 1)
        .addInput(<mets:niobium_titanium_plate> * 1).setChance(0)
        .addOutput(<contenttweaker:graphene>)
        .build();

RecipeBuilder.newBuilder("dptf_cc_af1", "dptf_cc_af", 1)
        .addEnergyPerTickInput(8)
        .addInput(<contenttweaker:graphene> * 1)
        .addInput(<mets:niobium_titanium_plate> * 1).setChance(0)
        .addOutput(<contenttweaker:carbon_nanotube>)
        .build();

RecipeBuilder.newBuilder("dptf_cc_af3", "dptf_ic_af", 1)
        .addEnergyPerTickInput(8)
        .addInput(<minecraft:coal> * 1)
        .addInput(<mets:niobium_titanium_plate> * 1).setChance(0)
        .addOutput(<contenttweaker:graphene>)
        .build();

RecipeBuilder.newBuilder("dptf_cc_af4", "dptf_ic_af", 1)
        .addEnergyPerTickInput(8)
        .addInput(<contenttweaker:graphene> * 1)
        .addInput(<mets:niobium_titanium_plate> * 1).setChance(0)
        .addOutput(<contenttweaker:carbon_nanotube>)
        .build();

RecipeBuilder.newBuilder("dptf_cc_af5", "dptf_nc_af", 1)
        .addEnergyPerTickInput(8)
        .addInput(<minecraft:coal> * 1)
        .addInput(<mets:niobium_titanium_plate> * 1).setChance(0)
        .addOutput(<contenttweaker:graphene>)
        .build();

RecipeBuilder.newBuilder("dptf_cc_af6", "dptf_nc_af", 1)
        .addEnergyPerTickInput(8)
        .addInput(<contenttweaker:graphene> * 1)
        .addInput(<mets:niobium_titanium_plate> * 1).setChance(0)
        .addOutput(<contenttweaker:carbon_nanotube>)
        .build();

RecipeBuilder.newBuilder("dptf_cc_af7", "dptf_sac_af", 1)
        .addEnergyPerTickInput(8)
        .addInput(<minecraft:coal> * 1)
        .addInput(<mets:niobium_titanium_plate> * 1).setChance(0)
        .addOutput(<contenttweaker:graphene>)
        .build();

RecipeBuilder.newBuilder("dptf_cc_af8", "dptf_sac_af", 1)
        .addEnergyPerTickInput(8)
        .addInput(<contenttweaker:graphene> * 1)
        .addInput(<mets:niobium_titanium_plate> * 1).setChance(0)
        .addOutput(<contenttweaker:carbon_nanotube>)
        .build();
    
RecipeBuilder.newBuilder("dptf_cc_af9", "dptf_ifc_af", 1)
        .addEnergyPerTickInput(8)
        .addInput(<minecraft:coal> * 1)
        .addInput(<mets:niobium_titanium_plate> * 1).setChance(0)
        .addOutput(<contenttweaker:graphene>)
        .build();

RecipeBuilder.newBuilder("dptf_cc_af10", "dptf_ifc_af", 1)
        .addEnergyPerTickInput(8)
        .addInput(<contenttweaker:graphene> * 1)
        .addInput(<mets:niobium_titanium_plate> * 1).setChance(0)
        .addOutput(<contenttweaker:carbon_nanotube>)
        .build();

RecipeBuilder.newBuilder("dptf_cc_af11", "dptf_spc_af", 1)
        .addEnergyPerTickInput(8)
        .addInput(<minecraft:coal> * 1)
        .addInput(<mets:niobium_titanium_plate> * 1).setChance(0)
        .addOutput(<contenttweaker:graphene>)
        .build();

RecipeBuilder.newBuilder("dptf_cc_af12", "dptf_spc_af", 1)
        .addEnergyPerTickInput(8)
        .addInput(<contenttweaker:graphene> * 1)
        .addInput(<mets:niobium_titanium_plate> * 1).setChance(0)
        .addOutput(<contenttweaker:carbon_nanotube>)
        .build();

RecipeBuilder.newBuilder("dptf_2", "workshop", 1)
        .addEnergyPerTickInput(1)
        .addInput(<modularmachinery:dptf_cc_fi_factory_controller> * 1)
        .addInput(<contenttweaker:programming_circuit_a> * 1)
        .addOutput(<modularmachinery:dptf_cc_factory_controller>)
        .build();
        
RecipeBuilder.newBuilder("dptf_3", "workshop", 1)
        .addEnergyPerTickInput(1)
        .addInput(<modularmachinery:dptf_cc_factory_controller> * 1)
        .addInput(<contenttweaker:programming_circuit_a> * 1)
        .addOutput(<modularmachinery:dptf_cc_af_factory_controller>)
        .build();

RecipeBuilder.newBuilder("dptf_4", "workshop", 1)
        .addEnergyPerTickInput(1)
        .addInput(<modularmachinery:dptf_cc_af_factory_controller> * 1)
        .addInput(<contenttweaker:programming_circuit_a> * 1)
        .addOutput(<modularmachinery:dptf_cc_ef_factory_controller>)
        .build();

RecipeBuilder.newBuilder("dptf_5", "workshop", 1)
        .addEnergyPerTickInput(1)
        .addInput(<modularmachinery:dptf_cc_ef_factory_controller> * 1)
        .addInput(<contenttweaker:programming_circuit_a> * 1)
        .addOutput(<modularmachinery:dptf_cc_fi_factory_controller>)
        .build();

RecipeBuilder.newBuilder("dptf_6", "workshop", 1)
        .addEnergyPerTickInput(1)
        .addInput(<modularmachinery:dptf_ic_fi_factory_controller> * 1)
        .addInput(<contenttweaker:programming_circuit_a> * 1)
        .addOutput(<modularmachinery:dptf_ic_factory_controller>)
        .build();

RecipeBuilder.newBuilder("dptf_7", "workshop", 1)
        .addEnergyPerTickInput(1)
        .addInput(<modularmachinery:dptf_ic_factory_controller> * 1)
        .addInput(<contenttweaker:programming_circuit_a> * 1)
        .addOutput(<modularmachinery:dptf_ic_af_factory_controller>)
        .build();

RecipeBuilder.newBuilder("dptf_8", "workshop", 1)
        .addEnergyPerTickInput(1)
        .addInput(<modularmachinery:dptf_ic_af_factory_controller> * 1)
        .addInput(<contenttweaker:programming_circuit_a> * 1)
        .addOutput(<modularmachinery:dptf_ic_ef_factory_controller>)
        .build();
        
RecipeBuilder.newBuilder("dptf_9", "workshop", 1)
        .addEnergyPerTickInput(1)
        .addInput(<modularmachinery:dptf_ic_ef_factory_controller> * 1)
        .addInput(<contenttweaker:programming_circuit_a> * 1)
        .addOutput(<modularmachinery:dptf_ic_fi_factory_controller>)
        .build();

RecipeBuilder.newBuilder("dptf_10", "workshop", 1)
        .addEnergyPerTickInput(1)
        .addInput(<modularmachinery:dptf_nc_fi_factory_controller> * 1)
        .addInput(<contenttweaker:programming_circuit_a> * 1)
        .addOutput(<modularmachinery:dptf_nc_factory_controller>)
        .build();

RecipeBuilder.newBuilder("dptf_11", "workshop", 1)
        .addEnergyPerTickInput(1)
        .addInput(<modularmachinery:dptf_nc_factory_controller> * 1)
        .addInput(<contenttweaker:programming_circuit_a> * 1)
        .addOutput(<modularmachinery:dptf_nc_af_factory_controller>)
        .build();

RecipeBuilder.newBuilder("dptf_12", "workshop", 1)
        .addEnergyPerTickInput(1)
        .addInput(<modularmachinery:dptf_nc_af_factory_controller> * 1)
        .addInput(<contenttweaker:programming_circuit_a> * 1)
        .addOutput(<modularmachinery:dptf_nc_ef_factory_controller>)
        .build();

RecipeBuilder.newBuilder("dptf_13", "workshop", 1)
        .addEnergyPerTickInput(1)
        .addInput(<modularmachinery:dptf_nc_ef_factory_controller> * 1)
        .addInput(<contenttweaker:programming_circuit_a> * 1)
        .addOutput(<modularmachinery:dptf_nc_fi_factory_controller>)
        .build();

RecipeBuilder.newBuilder("dptf_14", "workshop", 1)
        .addEnergyPerTickInput(1)
        .addInput(<modularmachinery:dptf_sac_fi_factory_controller> * 1)
        .addInput(<contenttweaker:programming_circuit_a> * 1)
        .addOutput(<modularmachinery:dptf_sac_factory_controller>)
        .build();

RecipeBuilder.newBuilder("dptf_15", "workshop", 1)
        .addEnergyPerTickInput(1)
        .addInput(<modularmachinery:dptf_sac_factory_controller> * 1)
        .addInput(<contenttweaker:programming_circuit_a> * 1)
        .addOutput(<modularmachinery:dptf_sac_af_factory_controller>)
        .build();

RecipeBuilder.newBuilder("dptf_16", "workshop", 1)
        .addEnergyPerTickInput(1)
        .addInput(<modularmachinery:dptf_sac_af_factory_controller> * 1)
        .addInput(<contenttweaker:programming_circuit_a> * 1)
        .addOutput(<modularmachinery:dptf_sac_ef_factory_controller>)
        .build();

RecipeBuilder.newBuilder("dptf_17", "workshop", 1)
        .addEnergyPerTickInput(1)
        .addInput(<modularmachinery:dptf_sac_ef_factory_controller> * 1)
        .addInput(<contenttweaker:programming_circuit_a> * 1)
        .addOutput(<modularmachinery:dptf_sac_fi_factory_controller>)
        .build();

RecipeBuilder.newBuilder("dptf_19", "workshop", 1)
        .addEnergyPerTickInput(1)
        .addInput(<modularmachinery:dptf_ifc_fi_factory_controller> * 1)
        .addInput(<contenttweaker:programming_circuit_a> * 1)
        .addOutput(<modularmachinery:dptf_ifc_factory_controller>)
        .build();

RecipeBuilder.newBuilder("dptf_20", "workshop", 1)
        .addEnergyPerTickInput(1)
        .addInput(<modularmachinery:dptf_ifc_factory_controller> * 1)
        .addInput(<contenttweaker:programming_circuit_a> * 1)
        .addOutput(<modularmachinery:dptf_ifc_af_factory_controller>)
        .build();

RecipeBuilder.newBuilder("dptf_21", "workshop", 1)
        .addEnergyPerTickInput(1)
        .addInput(<modularmachinery:dptf_ifc_af_factory_controller> * 1)
        .addInput(<contenttweaker:programming_circuit_a> * 1)
        .addOutput(<modularmachinery:dptf_ifc_ef_factory_controller>)
        .build();

RecipeBuilder.newBuilder("dptf_22", "workshop", 1)
        .addEnergyPerTickInput(1)
        .addInput(<modularmachinery:dptf_ifc_ef_factory_controller> * 1)
        .addInput(<contenttweaker:programming_circuit_a> * 1)
        .addOutput(<modularmachinery:dptf_ifc_fi_factory_controller>)
        .build();

RecipeBuilder.newBuilder("dptf_23", "workshop", 1)
        .addEnergyPerTickInput(1)
        .addInput(<modularmachinery:dptf_spc_fi_factory_controller> * 1)
        .addInput(<contenttweaker:programming_circuit_a> * 1)
        .addOutput(<modularmachinery:dptf_spc_factory_controller>)
        .build();

RecipeBuilder.newBuilder("dptf_24", "workshop", 1)
        .addEnergyPerTickInput(1)
        .addInput(<modularmachinery:dptf_spc_factory_controller> * 1)
        .addInput(<contenttweaker:programming_circuit_a> * 1)
        .addOutput(<modularmachinery:dptf_spc_af_factory_controller>)
        .build();

RecipeBuilder.newBuilder("dptf_25", "workshop", 1)
        .addEnergyPerTickInput(1)
        .addInput(<modularmachinery:dptf_spc_af_factory_controller> * 1)
        .addInput(<contenttweaker:programming_circuit_a> * 1)
        .addOutput(<modularmachinery:dptf_spc_ef_factory_controller>)
        .build();

RecipeBuilder.newBuilder("dptf_26", "workshop", 1)
        .addEnergyPerTickInput(1)
        .addInput(<modularmachinery:dptf_spc_ef_factory_controller> * 1)
        .addInput(<contenttweaker:programming_circuit_a> * 1)
        .addOutput(<modularmachinery:dptf_spc_fi_factory_controller>)
        .build();

RecipeBuilder.newBuilder("dptf_27", "workshop", 1)
        .addEnergyPerTickInput(1)
        .addInput(<modularmachinery:dptf_cc_factory_controller> * 1)
        .addInput(<contenttweaker:programming_circuit_b> * 1)
        .addOutput(<modularmachinery:dptf_ic_factory_controller>)
        .build();

RecipeBuilder.newBuilder("dptf_28", "workshop", 1)
        .addEnergyPerTickInput(1)
        .addInput(<modularmachinery:dptf_ic_factory_controller> * 1)
        .addInput(<contenttweaker:programming_circuit_b> * 1)
        .addOutput(<modularmachinery:dptf_nc_factory_controller>)
        .build();

RecipeBuilder.newBuilder("dptf_29", "workshop", 1)
        .addEnergyPerTickInput(1)
        .addInput(<modularmachinery:dptf_nc_factory_controller> * 1)
        .addInput(<contenttweaker:programming_circuit_b> * 1)
        .addOutput(<modularmachinery:dptf_sac_factory_controller>)
        .build();

RecipeBuilder.newBuilder("dptf_30", "workshop", 1)
        .addEnergyPerTickInput(1)
        .addInput(<modularmachinery:dptf_sac_factory_controller> * 1)
        .addInput(<contenttweaker:programming_circuit_b> * 1)
        .addOutput(<modularmachinery:dptf_ifc_factory_controller>)
        .build();

RecipeBuilder.newBuilder("dptf_31", "workshop", 1)
        .addEnergyPerTickInput(1)
        .addInput(<modularmachinery:dptf_ifc_factory_controller> * 1)
        .addInput(<contenttweaker:programming_circuit_b> * 1)
        .addOutput(<modularmachinery:dptf_spc_factory_controller>)
        .build();

RecipeBuilder.newBuilder("dptf_32", "workshop", 1)
        .addEnergyPerTickInput(1)
        .addInput(<modularmachinery:dptf_spc_factory_controller> * 1)
        .addInput(<contenttweaker:programming_circuit_b> * 1)
        .addOutput(<modularmachinery:dptf_cc_factory_controller>)
        .build();

//不写会报错
function camelToSnake(camelStr as string) as string {
    var result = "";
    var index = 0;
    while (index < camelStr.length) {
        if (camelStr.matches(".*[A-Z].*")) {
            if (index != 0 && camelStr.substring(index,index + 1).matches(".*[A-Z].*")) {
                result += "_";
            }
            result += camelStr.substring(index, index + 1).toLowerCase();
        } else {
            result += camelStr.substring(index, index + 1);
        }
            index += 1;
        }
    return result;
}
zenClass NAME {
    static name as int = 0;
}
function registerRecipe(machine as string,inputs as IIngredient[],Weightedinputs as IWeightedIngredient[],outputs as IIngredient[],Weightedoutputs as IWeightedIngredient[],time as int,energy as long){
    val recipe = RecipeBuilder.newBuilder(machine + NAME.name + energy + time,machine,time);
        if (energy > 0){
            recipe.addEnergyPerTickInput(energy);
        }
        for input in inputs{
            recipe.addInput(input);
        }
        for input in Weightedinputs{
            recipe.addInput(input.ingredient).setChance(input.percent);
        }
        for output in outputs{
            recipe.addOutput(output);
        }
        for output in Weightedoutputs{
            recipe.addOutput(output.ingredient).setChance(output.percent);
        }
        recipe.build();
    NAME.name += 1;
}
function recistermax(input as IIngredient[],output as IIngredient,input1 as IIngredient[] = null){
    val re = RecipeBuilder.newBuilder("light-speed_material_accelerator" + NAME.name,"light-speed_material_accelerator",72000);
    if (!isNull(input1)){
        re.addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients(input1));
    }
        re.addInputs(input)
        .addOutput(output)
        .addEnergyPerTickInput(100000000000)
    .build();
    NAME.name += 1;
}

RecipeBuilder.newBuilder("dptf_fluid_space1", "dptf_spc", 600)
        .addEnergyPerTickInput(1000000000000)
        .addInput(<eternalsingularity:eternal_singularity> * 1024)
        .addInput(<avaritia:resource:6> * 64)
        .addInput(<contenttweaker:fragments_of_the_space_time_continuum> * 256)
        .addOutput(<fluid:space_time_fluids> * 20)
        .build();

RecipeBuilder.newBuilder("dptf_fluid_space2", "dptf_ifc", 1200)
        .addEnergyPerTickInput(1000000000000)
        .addInput(<eternalsingularity:eternal_singularity> * 1024)
        .addInput(<avaritia:resource:6> * 64)
        .addInput(<contenttweaker:fragments_of_the_space_time_continuum> * 256)
        .addOutput(<fluid:space_time_fluids> * 20)
        .build();