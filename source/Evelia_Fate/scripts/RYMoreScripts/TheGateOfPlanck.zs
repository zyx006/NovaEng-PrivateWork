import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.MachineBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.MMEvents;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.RecipeModifierBuilder;

import crafttweaker.item.IItemStack;

import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.research.ResearchCognitionData;

HyperNetHelper.proxyMachineForHyperNet("TheGateOfPlanck");

MachineModifier.setMaxThreads("TheGateOfPlanck", 0);
MachineModifier.addCoreThread("TheGateOfPlanck",FactoryRecipeThread.createCoreThread("虫洞维持器").addRecipe("Wormhole"));
for i in 1 to 17{
        MachineModifier.addCoreThread("TheGateOfPlanck", FactoryRecipeThread.createCoreThread("探测器" + i));
}

RecipeBuilder.newBuilder("arousal_building_block","precision_assembler",3600)
    .addEnergyPerTickInput(1000000)
    .addInputs([
        <contenttweaker:extrememachineblock>*8,
        <draconicevolution:awakened_core>,
        <moreplates:awakened_draconium_plate>*2
    ])
    .addOutput(<contenttweaker:arousal_building_block>*8)
    .requireComputationPoint(100.0F)
    .build();
RecipeBuilder.newBuilder("PlancksGate","workshop",7200)
    .addEnergyPerTickInput(2000000000)
    .requireResearch("TheGateOfPlanck")
    .requireComputationPoint(30000.0F)
    .addInputs([
        <enderutilities:enderpart:17>*16,
        <extendedcrafting:storage:7>*64,
        <avaritiatweaks:enhancement_crystal>*8,
        <moreplates:infinity_plate>*4,
        <moreplates:infinity_gear>*2,
        <contenttweaker:hypernet_ram_t4>,
        <contenttweaker:hypernet_cpu_t4>*2,
        <enderio:item_material:44>*128,
    ])
    .addOutput(<modularmachinery:thegateofplanck_factory_controller>)
    .build();
RecipeBuilder.newBuilder("Wormhole","TheGateOfPlanck",72000000)
    .addInputs([
        <avaritia:resource:5>*9,
        <enderutilities:enderpart:17>*32,
    ])
    .addEnergyPerTickInput(10000000)
    .requireComputationPoint(10000.0F)
    .addRecipeTooltip("打开虫洞")
    .setThreadName("虫洞维持器")
    .build();
RecipeBuilder.newBuilder("neutron_star_mining","TheGateOfPlanck",2592)
    .addEnergyPerTickInput(129600)
    .addFluidPerTickInput(<liquid:crystal_matrix>*1)
    .addOutput(<ore:blockCosmicNeutronium>*4)
    .addRecipeTooltip("需要先打开虫洞")
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("虫洞尚未打开！");
            return;
        }
    })
    .build();