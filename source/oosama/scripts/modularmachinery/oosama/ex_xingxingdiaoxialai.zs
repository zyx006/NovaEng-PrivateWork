import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.RecipeModifierBuilder;
import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.research.ResearchCognitionData;
import mods.modularmachinery.MachineModifier;

var recipeCounter = 114514;

HyperNetHelper.proxyMachineForHyperNet("falling_star");

//催化剂配方
mods.avaritia.Compressor.add("yunshi",<contenttweaker:yunshi>, -450, <appliedenergistics2:sky_stone_block>);
mods.bloodmagic.BloodAltar.addRecipe(<contenttweaker:cxyunshi>,<contenttweaker:yunshi>,3,1000000,2000,0);
//附加的配方

RecipeBuilder.newBuilder("oo_TAIGAN", "falling_star", 40, recipeCounter, false)
    .addLifeEssenceInput(100000,true)
    .addInput(<taiga:eezo_block> * 32)                       .setTag("cailiao")
        .setPreViewNBT({display:{Lore:["§6放入控制器左方的材料输入仓方可识别"]}})
    .addInput(<contenttweaker:cxyunshi> * 1)                      .setTag("cuihua") .setChance(0.08) 
        .setPreViewNBT({display:{Lore:["§6放入控制器右方的催化剂输入仓方可识别"]}})
    .addOutputs(<contenttweaker:huanxing24> * 1)
    .requireComputationPoint(400.0F)
    .requireResearch("zhuixing")
    .addRecipeTooltip("§4注意你的LP存储，这个配方需要§6400万LP§4来完成！")
    .addRecipeTooltip("§4放置§5晶簇块§4来减少配方时间与LP的消耗")
    .addRecipeTooltip("这个是私货自己加的配方！")
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("oo_chonglaiyishi", "falling_star", 100, recipeCounter, false)
    .addLifeEssenceInput(100000,true)
    .addInput(<botania:storage:4> * 32)                       .setTag("cailiao")
        .setPreViewNBT({display:{Lore:["§6放入控制器左方的材料输入仓方可识别"]}})
    .addInput(<contenttweaker:cxyunshi> * 1)                      .setTag("cuihua") .setChance(0.08) 
        .setPreViewNBT({display:{Lore:["§6放入控制器右方的催化剂输入仓方可识别"]}})
    .addOutputs(<contenttweaker:huanxing23> * 1)
    .requireComputationPoint(400.0F)
    .requireResearch("zhuixing")
    .addRecipeTooltip("§4注意你的LP存储，这个配方需要§61000万LP§4来完成！")
    .addRecipeTooltip("§4放置§5晶簇块§4来减少配方时间与LP的消耗")
    .addRecipeTooltip("这个是私货自己加的配方！")
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("oo_TAIGEN", "falling_star", 40, recipeCounter, false)
    .addLifeEssenceInput(100000,true)
    .addInput(<taiga:abyssum_block> * 32)                       .setTag("cailiao")
        .setPreViewNBT({display:{Lore:["§6放入控制器左方的材料输入仓方可识别"]}})
    .addInput(<contenttweaker:cxyunshi> * 1)                      .setTag("cuihua") .setChance(0.08) 
        .setPreViewNBT({display:{Lore:["§6放入控制器右方的催化剂输入仓方可识别"]}})
    .addOutputs(<contenttweaker:huanxing25> * 1)
    .requireComputationPoint(400.0F)
    .requireResearch("zhuixing")
    .addRecipeTooltip("§4注意你的LP存储，这个配方需要§6400万LP§4来完成！")
    .addRecipeTooltip("§4放置§5晶簇块§4来减少配方时间与LP的消耗")
    .addRecipeTooltip("这个是私货自己加的配方！")
    .build();
recipeCounter += 1;
