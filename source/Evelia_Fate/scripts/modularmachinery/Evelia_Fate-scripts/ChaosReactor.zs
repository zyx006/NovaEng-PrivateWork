import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.MachineBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.FactoryRecipeThread;

import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.research.ResearchCognitionData;

MachineModifier.setMaxThreads("ChaosReactor",0);
for i in 1 to 5{
    MachineModifier.addCoreThread("ChaosReactor", FactoryRecipeThread.createCoreThread("反应区间" + i));
}
RecipeBuilder.newBuilder("chaosreactor","workshop",7200)
    .addInputs([
        <draconicadditions:chaos_stabilizer_core>*4,
        <draconicevolution:reactor_component>*16,
        <contenttweaker:field_generator_v2>*64,
        <contenttweaker:industrial_circuit_v3>*32,
        <contenttweaker:robot_arm_v4>*16,
    ])
    .addEnergyPerTickInput(10000000)
    .requireResearch("chaos_reactor")
    .requireComputationPoint(5000.0F)
    .addOutput(<modularmachinery:chaosreactor_factory_controller>)
    .build();
RecipeBuilder.newBuilder("chaos_produce_1","ChaosReactor",2000)
    .addEnergyPerTickInput(3000000)
    .addInput(<draconicevolution:draconic_ingot>)
    .addFluidPerTickInput(<liquid:ic2uu_matter>*5)
    .addOutput(<draconicevolution:chaos_shard>)
    .addEnergyPerTickOutput(10000000)
    .build();
RecipeBuilder.newBuilder("chaos_produce_2","ChaosReactor",2000)
    .addEnergyPerTickInput(30000000)
    .addInput(<draconicevolution:draconic_block>)
    .addFluidPerTickInput(<liquid:ic2uu_matter>*50)
    .addOutput(<draconicevolution:chaos_shard>*10)
    .addEnergyPerTickOutput(100000000)
    .build();