//ALL RIGHTS RESERVED
//也许你可以对私货进行更改。
//你妈的科学枢纽全几把是bugsbgt还要做铂处理
//好魔怔,但是群星
//并非魔怔

#priority 10
#loader crafttweaker reloadable

import mods.modularmachinery.MMEvents;
import mods.modularmachinery.MachineStructureFormedEvent;
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

import novaeng.NovaEngUtils;
import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.ComputationCenter;
import novaeng.hypernet.ComputationCenterType;
import novaeng.hypernet.ComputationCenterCache;

import novaeng.hypernet.upgrade.type.ProcessorModuleCPUType;
import novaeng.hypernet.upgrade.type.ProcessorModuleGPUType;
import novaeng.hypernet.upgrade.type.ProcessorModuleRAMType;

var recipeCount = 0;

RecipeBuilder.newBuilder("jxz", "jxz",1)
    .addEnergyPerTickInput(100000000000)
    .addOutput(<minecraft:gold_ingot> * 262144)
    .addOutput(<minecraft:iron_ingot> * 262144)
    .addOutput(<minecraft:dye:4> * 262144)
    .addOutput(<minecraft:diamond> * 262144)
    .addOutput(<minecraft:redstone> * 262144)
    .addOutput(<minecraft:emerald> * 262144)
    .addOutput(<minecraft:quartz> * 262144)
    .addOutput(<minecraft:coal> * 262144)
    .addOutput(<thermalfoundation:material:128> * 262144)
    .addOutput(<thermalfoundation:material:129> * 262144)
    .addOutput(<thermalfoundation:material:130> * 262144)
    .addOutput(<thermalfoundation:material:131> * 262144)
    .addOutput(<thermalfoundation:material:132> * 262144)
    .addOutput(<thermalfoundation:material:133> * 262144)
    .addOutput(<thermalfoundation:material:134> * 262144)
    .addOutput(<thermalfoundation:material:135> * 262144)
    .addOutput(<thermalfoundation:material:136> * 262144)
    .addOutput(<ic2:ingot:8> * 262144)
    .addOutput(<draconicevolution:draconium_ingot> * 262144)
    .addOutput(<biomesoplenty:gem:0> * 262144)
    .addOutput(<biomesoplenty:gem:1> * 262144)
    .addOutput(<biomesoplenty:gem:2> * 262144)
    .addOutput(<biomesoplenty:gem:3> * 262144)
    .addOutput(<biomesoplenty:gem:4> * 262144)
    .addOutput(<biomesoplenty:gem:5> * 262144)
    .addOutput(<biomesoplenty:gem:6> * 262144)
    .addOutput(<biomesoplenty:gem:7> * 262144)
    .addOutput(<ore:ingotThorium> * 262144)
    .addOutput(<ore:ingotBoron> * 262144)
    .addOutput(<ore:ingotMagnesium> * 262144)
    .addOutput(<ore:ingotManganese> * 262144)
    .addOutput(<additions:novaextended-ingot8> * 262144)
    .addOutput(<taiga:dilithium_ingot> * 262144)
    .addOutput(<libvulpes:productingot:7> * 262144)
    .addOutput(<tconstruct:ingots:0> * 262144)
    .addOutput(<tconstruct:ingots:1> * 262144)
    .addOutput(<appliedenergistics2:material:0> * 262144)
    .addOutput(<appliedenergistics2:material:1> * 262144)
    .addOutput(<mekanism:ingot:1> * 262144)
    .addOutput(<mekanism:fluoriteclump> * 262144)
    .addOutput(<futuremc:netherite_scrap> * 262144)
    .addOutput(<rftools:dimensional_shard> * 262144)
    .addOutput(<ore:gemQuartzBlack> * 262144)
    .addOutput(<astralsorcery:itemcraftingcomponent:1> * 262144)
    .addOutput(<astralsorcery:itemcraftingcomponent:0> * 262144)
    .addOutput(<thermalfoundation:material:132> * 262144)
    .addOutput(<taiga:aurorium_ingot> * 262144)
    .addOutput(<taiga:palladium_ingot> * 262144)
    .addOutput(<taiga:prometheum_ingot> * 262144)
    .addOutput(<taiga:valyrium_ingot> * 262144)
    .addOutput(<taiga:vibranium_ingot> * 262144)
    .addOutput(<taiga:osram_ingot> * 262144)
    .addOutput(<taiga:eezo_ingot> * 262144)
    .addOutput(<taiga:uru_ingot> * 262144)
    .addOutput(<taiga:duranite_ingot> * 262144)
    .addOutput(<taiga:karmesine_ingot> * 262144)
    .addOutput(<taiga:abyssum_ingot> * 262144)
    .addOutput(<taiga:tiberium_ingot> * 262144)
    .addOutput(<taiga:jauxum_ingot> * 262144)
    .addOutput(<taiga:ovium_ingot> * 262144)
    .addOutput(<ebwizardry:magic_crystal:1> * 262144)
    .addOutput(<ebwizardry:magic_crystal:2> * 262144)
    .addOutput(<ebwizardry:magic_crystal:3> * 262144)
    .addOutput(<ebwizardry:magic_crystal:4> * 262144)
    .addOutput(<ebwizardry:magic_crystal:5> * 262144)
    .addOutput(<ebwizardry:magic_crystal:6> * 262144)
    .addOutput(<ebwizardry:magic_crystal:7> * 262144)
    .addOutput(<taiga:obsidiorite_ingot> * 262144)
    .addOutput(<taiga:meteorite_ingot> * 262144)
    .addOutput(<appliedenergistics2:sky_stone_block> * 262144)
    .addOutput(<environmentaltech:litherite_crystal> * 262144)
    .addOutput(<environmentaltech:erodium_crystal> * 262144)
    .addOutput(<environmentaltech:lonsdaleite_crystal> * 262144)
    .addOutput(<environmentaltech:kyronite_crystal> * 262144)
    .addOutput(<environmentaltech:pladium_crystal> * 262144)
    .addOutput(<environmentaltech:ionite_crystal> * 262144)
    .addOutput(<environmentaltech:aethium_crystal> * 262144)
        .addFluidOutput(<liquid:jfh> * 10000)
        .addFluidOutput(<liquid:helium_3> * 1000000)
        .addFluidOutput(<liquid:unsteady_plasma> * 100000)
        .addFluidOutput(<liquid:liquidfusionfuel> * 1000000)
        .addOutput(<liquid:crystalloid> * 20000)
        .addOutput(<liquid:plasma> * 100000)
    .addRecipeTooltip([
                "§c从恒星中提取出无穷资源,或引发恒星坍缩",
                "§a天哪,这个配方拥有高贵的32并行,太疯狂了。",
            ])
    .build();

    RecipeBuilder.newBuilder("wzjyq_item", "wzjyq",1)
        .addEnergyPerTickInput(80000000000)
        .addOutput(<contenttweaker:fragments_of_the_space_time_continuum> * 2000)
        .addOutput(<contenttweaker:space_time_condensation_block> * 8)
        .addOutput(<avaritia:resource:5> * 1024)
        .addOutput(<avaritia:block_resource> * 2048)
        .addOutput(<mekanism:antimatterpellet> * 1024)
        .addOutput(<avaritia:block_resource:2> * 1024)
        .addOutput(<contenttweaker:mm_xxjz> * 1)
        .addOutput(<eternalsingularity:eternal_singularity> * 2024)
        .addOutput(<additions:novaextended-crystal4> * 20)
        .addRecipeTooltip([
                "§c从黑洞中提取出无穷资源,或引发黑洞蒸发",
                "§a天哪,这个配方拥有高贵的32并行,太疯狂了。",
            ])
        .build();

 RecipeBuilder.newBuilder("haxsbjsq_item", "haxsbjsq",1)
        .addEnergyPerTickInput(80000000000)
        .addFluidOutput(<liquid:haxwz> * 100)
        .addFluidOutput(<liquid:baxwz> * 250)
        .addFluidOutput(<liquid:hxwz> * 500)
        .addFluidOutput(<liquid:space_time_fluids> * 100)
        .addRecipeTooltip([
                "§c运行至宇宙热寂",
            ])
        .build();

//并行设置
MachineModifier.setInternalParallelism("jxz",32);
MachineModifier.setInternalParallelism("wzjyq",32);

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