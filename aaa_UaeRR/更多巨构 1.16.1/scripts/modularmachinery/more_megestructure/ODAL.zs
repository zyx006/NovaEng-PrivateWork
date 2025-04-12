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


RecipeBuilder.newBuilder("ODAL_SD1", "odal_sd",200)
        .addEnergyPerTickInput(80000000000)
        .addInput(<contenttweaker:hypernet_gpu_max> * 1).setChance(0)
        .addInput(<contenttweaker:hypernet_ram_max> * 1).setChance(0)
        .addInput(<custommc:item968> * 64).setChance(0)
        .addOutput(<contenttweaker:mm_hwjz> * 1)
        .requireResearch("dsp_4")
        .requireComputationPoint(100000.0F)
        .addRecipeTooltip([
                "§c使用寰宇能源核心驱动核心元件,使核心原件超频产出科研矩阵  §m与其他5种矩阵结合似乎会引发悖论",
            ])
        .build();

RecipeBuilder.newBuilder("ODAL_AR1", "odal_ar",200)
        .addEnergyPerTickInput(80000000000)
        .addInput(<contenttweaker:universalalloyt3> * 64)
        .addInput(<contenttweaker:carbon_nanotube> * 16384)
        .addInput(<contenttweaker:arkmachineblock> * 16)
        .addInput(<contenttweaker:arkforcefieldcontrolblock> * 4)
        .addInput(<avaritia:block_resource:2> * 64)
        .addInput(<avaritia:block_resource> *64)
        .addInput(<contenttweaker:mm_hysz> * 1024)
        .addInput(<contenttweaker:mm_jbbmc> * 256)
        .addInput(<contenttweaker:mm_ldx> * 64)
        .addInput(<contenttweaker:space_time_condensation_block> * 4)
        .addInput(<contenttweaker:universalforcefieldcontrolblock> * 16)
        .addInput(<avaritia:block_resource:1> * 4)
        .addInput(<tconevo:metal_block:0> * 512)
        .addInput(<tconevo:metal_block:1> * 128)
        .addInput(<tconevo:metal_block:2> * 64)
        .addInput(<custommc:item968> * 64).setChance(0)
        .addOutput(<contenttweaker:mm_jgjz> * 1)
        .requireResearch("dsp_4")
        .requireComputationPoint(100000.0F)
        .addRecipeTooltip([
                "§c使用原子重构单元将无穷无尽的材料压缩至四维矩阵大小,佐以寰宇能源核心对矩阵内部进行原子排列  §m与其他5种矩阵结合似乎会引发悖论",
            ])
        .build();

RecipeBuilder.newBuilder("ODAL_AR2", "odal_ar",200)
        .addEnergyPerTickInput(80000000000)
        .addInput(<contenttweaker:space_time_condensation_block> * 4)
        .addInput(<contenttweaker:universalforcefieldcontrolblock> * 16)
        .addInput(<avaritia:block_resource> * 512)
        .addInput(<contenttweaker:yltj> * 512)
        .addInput(<appliedenergistics2:material:47> * 512)
        .addInput(<eternalsingularity:eternal_singularity> * 512)
        
        .addInput(<custommc:item132> * 1).setChance(0)
        .addOutput(<contenttweaker:mm_yljz> * 1)
        .requireResearch("dsp_4")
        .requireComputationPoint(100000.0F)
        .addRecipeTooltip([
                "§c使用原子重构单元将无穷无尽的材料压缩至四维矩阵大小,佐以超光速核心对矩阵内部进行原子排列  §m与其他5种矩阵结合似乎会引发悖论",
            ])
        .build();

RecipeBuilder.newBuilder("ODAL_AR3", "odal_ar",200)
        .addEnergyPerTickInput(80000000000)
        .addInput(<contenttweaker:space_time_condensation_block> * 4)
        .addInput(<contenttweaker:universalforcefieldcontrolblock> * 16)
        .addInput(<modularmachinery:dream_energy_core_factory_controller> * 64)
        .addInput(<avaritiaio:infinitecapacitor> * 32)
        .addInput(<novaeng_core:estorage_energy_cell_l9> * 64)
        .addInput(<mekanism:basicblock:3> * 64)
        .addInput(<super_solar_panels:machines:11> * 4)
        .addInput(<draconicevolution:energy_storage_core> * 512)
        .addInput(<draconicevolution:wyvern_energy_core> * 1024)
        .addInput(<draconicevolution:draconic_energy_core> * 512)
        .addInput(<draconicadditions:chaotic_energy_core> * 256)
        
        .addInput(<custommc:item132> * 1).setChance(0)
        .addOutput(<contenttweaker:mm_nljz> * 1)
        .requireResearch("dsp_4")
        .requireComputationPoint(100000.0F)
        .addRecipeTooltip([
                "§c使用原子重构单元将无穷无尽的材料压缩至四维矩阵大小,佐以超光速核心对矩阵内部进行原子排列  §m与其他5种矩阵结合似乎会引发悖论",
            ])
        .build();

RecipeBuilder.newBuilder("ODAL_AR4", "odal_ar",200)
        .addEnergyPerTickInput(80000000000)
        .addInput(<contenttweaker:space_time_condensation_block> * 4)
        .addInput(<contenttweaker:universalforcefieldcontrolblock> * 16)
        .addInput(<modularmachinery:dream_energy_core_factory_controller> * 64)
        .addInput(<avaritiaio:infinitecapacitor> * 32)
        .addInput(<novaeng_core:estorage_energy_cell_l9> * 64)
        .addInput(<mekanism:basicblock:3> * 64)
        .addInput(<super_solar_panels:machines:11> * 4)
        .addInput(<draconicevolution:energy_storage_core> * 512)
        .addInput(<draconicevolution:wyvern_energy_core> * 1024)
        .addInput(<draconicevolution:draconic_energy_core> * 512)
        .addInput(<draconicadditions:chaotic_energy_core> * 256)
        
        .addInput(<custommc:item132> * 1).setChance(0)
        .addOutput(<contenttweaker:mm_nljz> * 1)
        .requireResearch("dsp_4")
        .requireComputationPoint(100000.0F)
        .addRecipeTooltip([
                "§c使用原子重构单元将无穷无尽的材料压缩至四维矩阵大小,佐以超光速核心对矩阵内部进行原子排列  §m与其他5种矩阵结合似乎会引发悖论",
            ])
        .build();

RecipeBuilder.newBuilder("ODAL_AR5", "odal_ar",200)
        .addEnergyPerTickInput(80000000000)
        .addInput(<contenttweaker:space_time_condensation_block> * 4)
        .addInput(<contenttweaker:universalforcefieldcontrolblock> * 16)
        .addInput(<enderio:block_alloy> * 1048576)
        
        .addInput(<custommc:item132> * 1).setChance(0)
        .addOutput(<contenttweaker:mm_dcjz> * 1)
        .requireResearch("dsp_4")
        .requireComputationPoint(100000.0F)
        .addRecipeTooltip([
                "§c使用原子重构单元将无穷无尽的材料压缩至四维矩阵大小,佐以超光速核心对矩阵内部进行原子排列  §m与其他5种矩阵结合似乎会引发悖论",
            ])
        .build();

RecipeBuilder.newBuilder("ODAL_AR6", "odal_ar",200)
        .addEnergyPerTickInput(80000000000)
        .addInput(<contenttweaker:space_time_condensation_block> * 1024)
        .addInput(<contenttweaker:arkforcefieldcontrolblock> * 1024)
        .addInput(<contenttweaker:mm_dcjz> * 1)
        .addInput(<contenttweaker:mm_nljz> * 1)
        .addInput(<contenttweaker:mm_xxjz> * 1)
        .addInput(<contenttweaker:mm_yljz> * 1)
        .addInput(<contenttweaker:mm_hwjz> * 1)
        .addInput(<contenttweaker:mm_jgjz> * 1)
        .addInput(<mekanism:antimatterpellet> * 1048576)
        
        .addInput(<custommc:item132> * 1).setChance(0)
        .addOutput(<contenttweaker:mm_yzjz> * 1)
        .addOutput(<contenttweaker:polymer_matter> * 1)
        .requireResearch("dsp_4")
        .requireComputationPoint(100000.0F)
        .addRecipeTooltip([
                "§m§a究§b极§c悖§d论",
            ])
        .build();

RecipeAdapterBuilder.create("ODAL_AR", "modularmachinery:atomic_reconstructor")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.1F, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 8.0F, 1, false).build())
    .build();

RecipeAdapterBuilder.create("ODAL_MA", "modularmachinery:machine_arm")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.1F, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 8.0F, 1, false).build())
    .build();

RecipeAdapterBuilder.create("ODAL_SD", "modularmachinery:star_collapser")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.1F, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 8.0F, 1, false).build())
    .build();
    
MachineModifier.setInternalParallelism("odal_ar", 256);
MachineModifier.setMaxThreads("odal_ar", 16);

MachineModifier.setInternalParallelism("odal_ma", 512);
MachineModifier.setMaxThreads("odal_ma", 16);

MachineModifier.setInternalParallelism("odal_sd", 1024);
MachineModifier.setMaxThreads("odal_sd", 16);

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

RecipeBuilder.newBuilder("singularity_me_item", "odal_sd",200)
        .addEnergyPerTickInput(80000000000)
        .addInput(<novaeng_core:estorage_cell_item_256m> * 16)
        .addOutput(<nae2:storage_cell_singularity> * 1)
        .requireResearch("ae_gtlite_cell")
        .requireComputationPoint(1009.0F)
        .addRecipeTooltip([
                "§c将数枚L9矩阵压缩至无限小已生产奇点",
            ])
        .build();

RecipeBuilder.newBuilder("singularity_me_fluid", "odal_sd",200)
        .addEnergyPerTickInput(80000000000)
        .addInput(<novaeng_core:estorage_cell_fluid_256m> * 16)
        .addOutput(<nae2:storage_cell_fluid_singularity> * 1)
        .requireResearch("ae_gtlite_cell")
        .requireComputationPoint(100000.0F)
        .addRecipeTooltip([
                "§c将数枚L9矩阵压缩至无限小已生产奇点",
            ])
        .build();