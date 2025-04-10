#priority 10
#loader crafttweaker reloadable

import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.MachineBuilder;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.MultiblockModifierBuilder;
import mods.modularmachinery.BlockArrayBuilder;

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




//内置并行设置
MachineModifier.setInternalParallelism("twist_space_technology", 16);

//工厂线程设置
MachineModifier.setMaxThreads("twist_space_technology", 8);

//最大并行数 512
MachineModifier.setMaxParallelism("twist_space_technology", 512);

//扭集成控制器
RecipeBuilder.newBuilder("twist_space_technology_controller", "machine_arm", 1800)
    .addEnergyPerTickInput(96000)
    .addInputs([
        <contenttweaker:industrial_circuit_v3> * 8,
        <contenttweaker:electric_motor_v3> * 8,
        <contenttweaker:sensor_v3> * 16,
        <modularmachinery:chemical_complex_controller> * 2,
        <modularmachinery:blockcasing:4>,
    ])
    .addOutput(<modularmachinery:twist_space_technology_factory_controller>)
    .build();

//扭配方继承虽然来说似乎都没有用的
RecipeAdapterBuilder.create("twist_space_technology", "nuclearcraft:chemical_reactor")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.025, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 4000, 1, false).build())
    .build();


//硫酸3.0
    RecipeBuilder.newBuilder("liusuan30", "twist_space_technology",480)
        .addEnergyPerTickInput(3200000)
        .addCatalystInput(<avaritia:resource:5>,
        ["催化配方以2倍速度运行"],
        [RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.5F, 1, false).build()]).setChance(0).setParallelizeUnaffected(true)
        .addInput(<extendedcrafting:material:11>).setPreViewNBT({display: {Lore: ["§a数量决定并行"]}}).setChance(0).setParallelizeUnaffected(true)
        .addInputs([
            <ore:dustSulphur> * 32,
            <liquid:oxygen> * 48000,
            <liquid:water> * 32000,])
        .addOutput(<liquid:sulfuric_acid> * 32000)
    .build();

//碳纳米管 集成 替代 上位
RecipeBuilder.newBuilder("carbon_nanotube", "twist_space_technology", 80)
    .addEnergyPerTickInput(40000)
    .addInputs(<contenttweaker:graphene> * 2)
    .addInput(<mets:niobium_titanium_plate> * 1).setChance(0)
    .addOutputs(<contenttweaker:carbon_nanotube> * 1)
    .build();

//生产营养精华液-普通配方
RecipeBuilder.newBuilder("nutrient_distillation_0", "twist_space_technology", 200)
    .addEnergyPerTickInput(28800)
    .addFluidInputs(<liquid:water> * 4000)
    .addIngredientArrayInput(
     IngredientArrayBuilder.newBuilder()
        .addIngredients([
            <minecraft:skull>,  
            <minecraft:skull:1>, 
            <minecraft:skull:2>,  
            <minecraft:skull:4>,  
            <enderio:block_enderman_skull>,  
        ])
    .build()
)
    .addIngredientArrayInput(
     IngredientArrayBuilder.newBuilder()
        .addIngredients([
            <minecraft:nether_wart>, 
            <minecraft:brown_mushroom>, 
            <minecraft:red_mushroom>,  
        ])
    .build()
)
    .addFluidOutput(<liquid:nutrient_distillation>* 1000)
    .build();

//生产营养精华液-低级配方
RecipeBuilder.newBuilder("nutrient_distillation_1", "twist_space_technology", 200)
    .addEnergyPerTickInput(28800)
    .addFluidInputs(<liquid:water> * 4000)
    .addIngredientArrayInput(
     IngredientArrayBuilder.newBuilder()
        .addIngredients([
            <minecraft:skull>, 
            <minecraft:skull:1>,
            <minecraft:skull:2>,
            <minecraft:skull:4>,
            <enderio:block_enderman_skull>,
        ])
    .build()
)
   .addInputs( <minecraft:sugar>)
    .addFluidOutput(<liquid:nutrient_distillation> * 500)
    .build();

//生产营养精华液-高级配方
RecipeBuilder.newBuilder("nutrient_distillation_2", "twist_space_technology", 200)
    .addEnergyPerTickInput(28800)
    .addFluidInputs(<liquid:water> * 4000)
    .addIngredientArrayInput(
     IngredientArrayBuilder.newBuilder()
        .addIngredients([
            <minecraft:skull>,
            <minecraft:skull:1>,
            <minecraft:skull:2>,
            <minecraft:skull:4>,
            <enderio:block_enderman_skull>,
        ])
    .build()
)
    .addInputs([<minecraft:fermented_spider_eye>])
    .addFluidOutput(<liquid:nutrient_distillation> * 1500)
    .build();
    
//营养糊剂生产营养精华液-顶级配方
RecipeBuilder.newBuilder("nutrient_distillation_3","twist_space_technology", 200)
    .addEnergyPerTickInput(28800)
    .addFluidInputs(<liquid:water> * 4000) 
    .addInputs(<minecraft:skull:5>)
    .addInputs(<minecraft:fermented_spider_eye>)
    .addFluidOutput(<liquid:nutrient_distillation> * 2000) 
    .build();

//扭冷却液
RecipeBuilder.newBuilder("lengqueyan_niu","twist_space_technology",10)
   .addEnergyPerTickInput(54000)
   .addInputs(<ic2:dust:9>*9)
   .addFluidInputs(<liquid:water>* 1000) 
   .addFluidOutput(<liquid:ic2coolant> * 1000)
    .build();

    //扭DT燃料的D
RecipeBuilder.newBuilder("mekdtranliaoded_niu", "twist_space_technology", 10)
    .addEnergyPerTickInput(1024000)
    .addFluidInputs(<liquid:heavywater>* 1000) 
    .addFluidOutput(<liquid:deuterium>* 1000)
    .build();

    //扭DT燃料的T
RecipeBuilder.newBuilder("mekdtranliaodet_niu", "twist_space_technology", 10)
    .addEnergyPerTickInput(1024000)
    .addFluidInputs(<liquid:liquidlithium>* 1000) 
    .addFluidOutput(<liquid:tritium>* 1000)
    .build();

    //扭红石水晶
RecipeBuilder.newBuilder("hongshishuijing_niu", "twist_space_technology", 10)
    .addEnergyPerTickInput(1024000)
    .addInputs(<minecraft:diamond>) 
    .addFluidInputs(<liquid:redstone>* 500) 
    .addOutputs(<redstonearsenal:material:160>)
    .build();

    //扭极寒水晶
RecipeBuilder.newBuilder("jihanshuijing_niu", "twist_space_technology", 10)
    .addEnergyPerTickInput(1024000)
    .addInputs(<minecraft:emerald>) 
    .addFluidInputs(<liquid:cryotheum>* 1000) 
    .addOutputs(<redstonerepository:material:5>)
    .build();

    //扭极寒末影锭
RecipeBuilder.newBuilder("jihanmoyinding_niu", "twist_space_technology", 10)
    .addEnergyPerTickInput(1024000)
    .addInputs(<thermalfoundation:material:167>) 
    .addFluidInputs(<liquid:cryotheum>* 1000) 
    .addOutputs(<redstonerepository:material:1>)
    .build();

  
  