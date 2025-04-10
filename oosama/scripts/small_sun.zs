import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.MMEvents;
import mods.modularmachinery.ControllerGUIRenderEvent;
import mods.modularmachinery.MachineTickEvent;
import mods.modularmachinery.RecipeStartEvent;
import mods.modularmachinery.RecipeThread;
import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.RecipeTickEvent;
import crafttweaker.block.IBlock;
import novaeng.hypernet.HyperNetHelper;
import crafttweaker.item.IItemStack;
import crafttweaker.util.Math;
import crafttweaker.world.IBlockPos;
import mods.modularmachinery.SmartInterfaceType;
import mods.modularmachinery.RecipeModifier;
import crafttweaker.item.IIngredient;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.RecipeFinishEvent;
import crafttweaker.world.IFacing;
import mods.modularmachinery.Sync;

//////////人造恒星//////////
//控制器合成
    RecipeBuilder.newBuilder("small_sun_controller", "workshop", 60)
        .addEnergyPerTickInput(100000000)
        .addInputs([
            <contenttweaker:industrial_circuit_v4> * 96,
            <contenttweaker:field_generator_v4> * 64,
            <contenttweaker:antimatter_core> * 10,
            <contenttweaker:charging_crystal_block> * 64,
            <contenttweaker:ymysq> * 64,
            <contenttweaker:world_energy_core>* 2
        ])
        .addOutput(<modularmachinery:small_sun_controller>)
        .build();
//配方运行
    RecipeBuilder.newBuilder("xiaotaiyang1", "small_sun",2000,0)
        .addInput(<contenttweaker:fwzrlb>)
        .addFluidPerTickInput(<liquid:crystalloid> * 10)
        .addItemOutput(<contenttweaker:ymysq>)
        .addEnergyPerTickOutput(200000000000).setIgnoreOutputCheck(true)
        .setParallelized(false)
    .build();
    RecipeBuilder.newBuilder("xiaotaiyang2", "small_sun",2000,0)
        .addInput(<contenttweaker:hxsrlb>)
        .addFluidPerTickInputs([<liquid:oslash_matter> * 4,<liquid:phi_matter> * 4,<liquid:crystalloid> * 100])
        .addOutputs([<contenttweaker:ymysq>,<contenttweaker:crystalgreen>*64,<contenttweaker:crystalred>*64,<contenttweaker:crystalpurple>*192,<liquid:neutronium> * 200000])
        .addEnergyPerTickOutput(1600000000000).setIgnoreOutputCheck(true)
        .setParallelized(false)
    .build();
