import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.MachineBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.MMEvents;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.FactoryRecipeStartEvent;
import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.MachineTickEvent;
import mods.modularmachinery.SmartInterfaceType;

import crafttweaker.item.IItemStack;

import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.research.ResearchCognitionData;

HyperNetHelper.proxyMachineForHyperNet("SongofSuperstring");

MachineModifier.setMaxThreads("SongofSuperstring", 0);
for i in 1 to 25{
        MachineModifier.addCoreThread("SongofSuperstring", FactoryRecipeThread.createCoreThread("空间区域" + i));
}

RecipeBuilder.newBuilder("SongofSuperstring","workshop",7200)
    .addEnergyPerTickInput(3000000000)
    .addInputs(
        <contenttweaker:hypernet_cpu_t4>*8,
        <additions:novaextended-crystal4>*4,
        <novaeng_core:estorage_cell_item_256m>*16,
        <novaeng_core:estorage_cell_fluid_256m>*16,
        <avaritiaio:infinitecapacitor>*2
    )
    .requireComputationPoint(12600)
    .requireResearch("SuperString")
    .addOutput(<modularmachinery:songofsuperstring_factory_controller>)
    .build();
RecipeAdapterBuilder.create("SongofSuperstring","modularmachinery:atomic_reconstructor")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration","input",0.1,1,false).build())
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 4;
    })
    .build();
RecipeBuilder.newBuilder("infinite_craft","SongofSuperstring",160)
    .addInputs(
        <avaritia:resource:5>*11,
        <avaritia:resource:1>*10,
        <avaritia:resource:4>*24,
        <liquid:crystalloidneutron>*72
    )
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 6;
    })
    .addEnergyPerTickInput(36000000)
    .requireComputationPoint(1000.0F)
    .addOutput(<avaritia:resource:6>*2)
    .build();