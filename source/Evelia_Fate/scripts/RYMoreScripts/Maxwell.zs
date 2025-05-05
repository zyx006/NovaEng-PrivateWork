import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.FactoryRecipeThread;

MachineModifier.setInternalParallelism("electromagnetic_dissociation", 512);
MachineModifier.setMaxParallelism("electromagnetic_dissociation", 3072);
MachineModifier.setMaxThreads("electromagnetic_dissociation", 0);
for i in 1 to 9{
    MachineModifier.addCoreThread("electromagnetic_dissociation", FactoryRecipeThread.createCoreThread("空间区域" + i));
}
RecipeAdapterBuilder.create("electromagnetic_dissociation","nuclearcraft:electrolyzer")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration","input",0.02,1,false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 50, 1, false).build())
    .setMaxThreads(1)
    .build();
RecipeBuilder.newBuilder("diss_con","workshop",3600)
    .addInputs([
        <modularmachinery:large_electrolyzer_controller> * 4,
        <contenttweaker:industrial_circuit_v2> * 8,
        <contenttweaker:field_generator_v1> * 6,
        <contenttweaker:sensor_v2> * 5,
    ])
    .addEnergyPerTickInput(75000000)
    .requireComputationPoint(750.0F)
    .requireResearch("Maxwell")
    .addOutputs(<modularmachinery:electromagnetic_dissociation_factory_controller>)
    .build();
RecipeBuilder.newBuilder("fusionfuel_diss","electromagnetic_dissociation",32)
    .addInput(<liquid:liquidfusionfuel> * 2000)
    .addOutputs([
        <liquid:tritium> * 1000,
        <liquid:deuterium> * 1000
    ])
    .addEnergyPerTickInput(20000)
    .build();

MachineModifier.setInternalParallelism("structural_failure", 512);
MachineModifier.setMaxParallelism("structural_failure", 3072);
MachineModifier.setMaxThreads("structural_failure", 0);
for i in 1 to 9{
    MachineModifier.addCoreThread("structural_failure", FactoryRecipeThread.createCoreThread("空间区域" + i));
}
RecipeAdapterBuilder.create("structural_failure","novaeng_core:shredder")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration","input",0.02,1,false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 50, 1, false).build())
    .setMaxThreads(1)
    .build();
RecipeBuilder.newBuilder("bedrock_diss","structural_failure",20)
    .addInput(<avaritia:resource:2>)
    .addOutput(<enderio:block_infinity:2>)
    .addEnergyPerTickInput(500000)
    .addRecipeTooltip("这很奇怪吗？","是的，的确很奇怪")
    .setMaxThreads(1)
    .build();
RecipeBuilder.newBuilder("failure_con","workshop",3600)
    .addInputs([
        <modularmachinery:item_shredder_controller> * 4,
        <contenttweaker:industrial_circuit_v2> * 8,
        <contenttweaker:field_generator_v1> * 6,
        <contenttweaker:sensor_v2> * 5,
    ])
    .addEnergyPerTickInput(75000000)
    .requireComputationPoint(750.0F)
    .requireResearch("Maxwell")
    .addOutputs(<modularmachinery:structural_failure_factory_controller>)
    .build();
RecipeBuilder.newBuilder("iridium_housing","workshop",600)
    .addInputs([
        <ic2:resource:13> * 16,
        <mets:super_iridium_compress_plate> * 2,
        <mets:neutron_plate> * 24
    ])
    .addEnergyPerTickInput(2000000)
    .addOutput(<contenttweaker:iridium_alloy_mechanical_housing> * 4)
    .requireComputationPoint(15.0F)
    .requireResearch("Maxwell")
    .build();