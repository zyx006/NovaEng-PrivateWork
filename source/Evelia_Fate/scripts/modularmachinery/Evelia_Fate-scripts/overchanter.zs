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
import crafttweaker.item.IIngredient;

import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.research.ResearchCognitionData;

RecipeBuilder.newBuilder("overchanter","machine_arm",360)
    .addInputs([
        <minecraft:enchanting_table>,
        <draconicevolution:diss_enchanter>,
        <minecraft:lapis_block>*16,
        <minecraft:diamond_block>*16,
        <liquid:xpjuice>*160
    ])
    .requireComputationPoint(20.0F)
    .addOutput(<modularmachinery:overchanter_controller>)
    .build();
<modularmachinery:overchanter_controller>.addTooltip("制作优秀的附魔书，铁砧无法发挥它的作用，或许可以试试植物魔法的魔力附魔台？");
function enchant(name as string,input as IIngredient[],output as IIngredient,energycost as int,bloodcost as int,manacost as int){
    RecipeBuilder.newBuilder(name,"overchanter",200)
        .addInputs(input)
        .addInputs([
            <ore:gemLapis>*96,
            <liquid:fluidedmana>*manacost
        ])
        .addEnergyPerTickInput(energycost)
        .addLifeEssenceInput(bloodcost,true)
        .addRecipeTooltip("这个配方需要"+bloodcost*200+"LP完成")
        .addOutput(output)
        .build();
}
enchant("looting",[<minecraft:enchanted_book>.withTag({StoredEnchantments: [{lvl: 3 as short, id: 21}]}),<ore:itemSkull>*128,],<minecraft:enchanted_book>.withTag({StoredEnchantments: [{lvl: 10 as short, id: 21}]}),1000000,1000,1000);//抢夺X
enchant("vorpal",[<minecraft:enchanted_book>.withTag({StoredEnchantments: [{lvl: 3 as short, id: 55}]}),<enderio:item_material:41>*32],<minecraft:enchanted_book>.withTag({StoredEnchantments: [{lvl: 10 as short, id: 55}]}),1000000,2000,1000);//斩首X
enchant("reaper",[<minecraft:enchanted_book>.withTag({StoredEnchantments: [{lvl: 5 as short, id: 11}]}),<draconicevolution:draconium_block>*120],<minecraft:enchanted_book>.withTag({StoredEnchantments: [{lvl: 30 as short, id: 11}]}),5000000,5000,2000);//收割者30
enchant("fortune",[<minecraft:enchanted_book>.withTag({StoredEnchantments: [{lvl: 3 as short, id: 35}]}),<minecraft:emerald>*90],<minecraft:enchanted_book>.withTag({StoredEnchantments: [{lvl: 10 as short, id: 35}]}),5000000,4000,2500);//时运X
enchant("sharpness",[<minecraft:enchanted_book>.withTag({StoredEnchantments: [{lvl: 5 as short, id: 16}]}),<chisel:quartz1:3>*256],<minecraft:enchanted_book>.withTag({StoredEnchantments: [{lvl: 128 as short, id: 16}]}),5000000,10000,5000);//锋利128