import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.IngredientArrayBuilder;
import novaeng.hypernet.HyperNetHelper;
import mods.modularmachinery.MachineModifier;
import crafttweaker.item.IIngredient;

RecipeBuilder.newBuilder("particlecontrol","workshop",3600)
    .addInputs([
        <modularmachinery:reactor_ic2_2_factory_controller>,
        <nuclearcraft:fission_monitor>*16,
        <contenttweaker:hypernet_gpu_t2>*4,
        <contenttweaker:hypernet_ram_t3>*12,
        <mets:advanced_heat_vent>*16,
        <mets:advanced_oc_heat_vent>*16
    ])
    .requireComputationPoint(20000.0F)
    .addEnergyPerTickInput(200000000)
    .addOutput(<modularmachinery:particlecontrol_controller>)
    .build();

HyperNetHelper.proxyMachineForHyperNet("particlecontrol");
MachineModifier.setInternalParallelism("particlecontrol",16);

function radiation(name as int,input as IIngredient[],output as IIngredient[]){
    RecipeBuilder.newBuilder("radiation"+name,"particlecontrol",200)
        .addInputs(input)
        .addOutputs(output)
        .requireComputationPoint(100.0F)
        .build();
}
radiation(1,[<nuclearcraft:uranium:10>,<super_solar_panels:crafting:26>,<contenttweaker:programming_circuit_0>],[<nuclearcraft:neptunium:5>,<avaritia:resource:2>]);
radiation(2,[<nuclearcraft:uranium:10>,<super_solar_panels:crafting:26>*2,<avaritia:resource:2>*2,<contenttweaker:programming_circuit_a>],[<nuclearcraft:plutonium:15>]);
radiation(3,[<nuclearcraft:uranium:10>,<super_solar_panels:crafting:26>*3,<avaritia:resource:2>*2,<contenttweaker:programming_circuit_b>],[<nuclearcraft:americium:10>]);
radiation(4,[<nuclearcraft:uranium:10>,<super_solar_panels:crafting:26>*6,<avaritia:resource:2>*8,<contenttweaker:programming_circuit_c>],[<nuclearcraft:californium:15>]);