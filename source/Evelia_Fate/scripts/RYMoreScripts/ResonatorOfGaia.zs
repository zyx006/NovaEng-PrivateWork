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

RecipeBuilder.newBuilder("ResonatorOfGaia","workshop",7200)
    .addInputs([
        <extrabotany:coregod>,
        <draconicevolution:chaotic_core>*8,
        <draconicadditions:chaotic_energy_core>*16,
        <botania:storage:4>*32,
        <botania:storage:2>*32,
        <eternalsingularity:eternal_singularity>*16,
        <contenttweaker:charging_crystal_block>*32,
        <liquid:crystalloid>*129600,
    ])
    .addOutput(<modularmachinery:resonatorofgaia_factory_controller>* 1)
    .addRecipeTooltip("如果做不出来，请看一下你的律者核心种类","仅允许显示的这种律者核心，任何其余种类都会导致无法合成")
    .requireResearch("CallOfGaia")
    .requireComputationPoint(3600.0F)
    .build();

MachineModifier.setMaxThreads("ResonatorOfGaia",0);
MachineModifier.addCoreThread("ResonatorOfGaia",FactoryRecipeThread.createCoreThread("盖亚女神专线").addRecipe("CallOfGaia"));
for i in 1 to 5{
        MachineModifier.addCoreThread("ResonatorOfGaia", FactoryRecipeThread.createCoreThread("希望女神做的事#" + i));
}

RecipeBuilder.newBuilder("CallOfGaia","ResonatorOfGaia",8000)
    .addFluidPerTickInput(<liquid:fluidedmana>*10)
    .addOutput(<botania:storage:1>)
    .addRecipeTooltip("维持盖亚的存在需要消耗一定量的魔力")
    .addRecipeTooltip("其余配方依赖于此配方运行")
    .setThreadName("盖亚女神专线")
    .setParallelized(false)
    .build();

RecipeBuilder.newBuilder("GaiaI_1","ResonatorOfGaia",800)
    .addInput(<botania:specialflower>.withTag({type: "asgardandelion"})).setChance(0).setParallelizeUnaffected(true)
    .addInput(<botania:manaresource:4>)
    .addCatalystInput(<avaritiatweaks:infinitato>,
        ["生命力顶点的象征，盖亚女神最喜欢的装饰","减免20%的时间"],
        [RecipeModifierBuilder.create("modularmachinery:duration","input",0.8,1,false).build()]
    ).setChance(0).setParallelizeUnaffected(true)
    .addCatalystInput(<contenttweaker:mana_core>,
        ["万千植物散发的魔力凝聚其中，哪怕对女神来说也是珍贵的礼物","减免40%的时间，产出提升为先前的3倍"],
        [
            RecipeModifierBuilder.create("modularmachinery:duration","input",0.6,1,false).build(),
            RecipeModifierBuilder.create("modularmachinery:item","output",3,1,false).build()
        ]
    ).setChance(0).setParallelizeUnaffected(true)
    .addCatalystInput(<contenttweaker:soul_core>,
        ["凝聚了无数灵魂，是生物圈繁荣的象征，女神也为之高兴","减免20%的时间，产出提升为先前的2倍"],
        [RecipeModifierBuilder.create("modularmachinery:duration","input",0.8,1,false).build(),RecipeModifierBuilder.create("modularmachinery:item","output",2,1,false).build()]
    ).setChance(0).setParallelizeUnaffected(true)
    .addRecipeTooltip("事实证明，科学技术才是第一生产力")
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            event.activeRecipe.maxParallelism = 32;
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚不存在迷你盖亚！");
            return;
        }
    })
    .setThreadName("希望女神做的事#1")
    .addOutput(<botania:manaresource:14>).setChance(0.25)
    .addOutput(<botania:manaresource:5>*8)
    .build();

RecipeBuilder.newBuilder("GaiaII","ResonatorOfGaia",800)
    .addInput(<botania:specialflower>.withTag({type: "asgardandelion"})).setChance(0).setParallelizeUnaffected(true)
    .addInput(<botania:manaresource:14>)
    .addCatalystInput(<avaritiatweaks:infinitato>,
        ["生命力顶点的象征，盖亚女神最喜欢的装饰","减免20%的时间"],
        [RecipeModifierBuilder.create("modularmachinery:duration","input",0.8,1,false).build()]
    ).setChance(0).setParallelizeUnaffected(true)
    .addCatalystInput(<contenttweaker:mana_core>,
        ["万千植物散发的魔力凝聚其中，哪怕对女神来说也是珍贵的礼物","减免40%的时间，产出提升为先前的3倍"],
        [RecipeModifierBuilder.create("modularmachinery:duration","input",0.6,1,false).build(),RecipeModifierBuilder.create("modularmachinery:item","output",3,1,false).build()]
    ).setChance(0).setParallelizeUnaffected(true)
    .addCatalystInput(<contenttweaker:soul_core>,
        ["凝聚了无数灵魂，是生物圈繁荣的象征，女神也为之高兴","减免20%的时间，产出提升为先前的2倍"],
        [RecipeModifierBuilder.create("modularmachinery:duration","input",0.8,1,false).build(),RecipeModifierBuilder.create("modularmachinery:item","output",2,1,false).build()]
    ).setChance(0).setParallelizeUnaffected(true)
    .addRecipeTooltip("女神眼中，这和泰拉钢锭的区别仅在于魔力量不同")
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            event.activeRecipe.maxParallelism = 32;
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚不存在迷你盖亚！");
            return;
        }
    })
    .setThreadName("希望女神做的事#2")
    .addOutput(<botania:manaresource:5>*12)
    .addOutput(<botania:dice>)
    .addOutput(<extrabotany:material:6>).setChance(0.3)
    .build();

RecipeBuilder.newBuilder("GaiaIII","ResonatorOfGaia",800)
    .addInput(<botania:specialflower>.withTag({type: "asgardandelion"})).setChance(0).setParallelizeUnaffected(true)
    .addInput(<extrabotany:natureorb>.withTag({xp: 500000})).setChance(0)
    .addInput(<extrabotany:material:6>)
    .addCatalystInput(<avaritiatweaks:infinitato>,
        ["生命力顶点的象征，盖亚女神最喜欢的装饰","减免20%的时间"],
        [RecipeModifierBuilder.create("modularmachinery:duration","input",0.8,1,false).build()]
    ).setChance(0).setParallelizeUnaffected(true)
    .addCatalystInput(<contenttweaker:mana_core>,
        ["万千植物散发的魔力凝聚其中，哪怕对女神来说也是珍贵的礼物","减免40%的时间，产出提升为先前的3倍"],
        [RecipeModifierBuilder.create("modularmachinery:duration","input",0.6,1,false).build(),RecipeModifierBuilder.create("modularmachinery:item","output",3,1,false).build()]
    ).setChance(0).setParallelizeUnaffected(true)
    .addCatalystInput(<contenttweaker:soul_core>,
        ["凝聚了无数灵魂，是生物圈繁荣的象征，女神也为之高兴","减免20%的时间，产出提升为先前的2倍"],
        [RecipeModifierBuilder.create("modularmachinery:duration","input",0.8,1,false).build(),RecipeModifierBuilder.create("modularmachinery:item","output",2,1,false).build()]
    ).setChance(0).setParallelizeUnaffected(true)
    .addRecipeTooltip("自然之中蕴含着无穷的灵气")
    .addRecipeTooltip("将之提取出来，可以催化合成一些重要物品")
    .addRecipeTooltip("本配方输入的自然蕴息宝珠越多，最大并行数越高")
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            event.activeRecipe.maxParallelism = 32;
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚不存在迷你盖亚！");
            return;
        }
    })
    .setThreadName("希望女神做的事#3")
    .addOutputs(<extrabotany:material:3>*2)
    .build();

RecipeBuilder.newBuilder("Kiana","ResonatorOfGaia",1600)
    .addInput(<botania:specialflower>.withTag({type: "asgardandelion"})).setChance(0).setParallelizeUnaffected(true)
    .addInput(<extrabotany:material:9>)
    .addCatalystInput(<avaritiatweaks:infinitato>,
        ["生命力顶点的象征，盖亚女神最喜欢的装饰","减免20%的时间"],
        [RecipeModifierBuilder.create("modularmachinery:duration","input",0.8,1,false).build()]
    ).setChance(0).setParallelizeUnaffected(true)
    .addCatalystInput(<contenttweaker:mana_core>,
        ["万千植物散发的魔力凝聚其中，哪怕对女神来说也是珍贵的礼物","减免40%的时间，产出提升为先前的3倍"],
        [RecipeModifierBuilder.create("modularmachinery:duration","input",0.6,1,false).build(),RecipeModifierBuilder.create("modularmachinery:item","output",3,1,false).build()]
    ).setChance(0).setParallelizeUnaffected(true)
    .addCatalystInput(<contenttweaker:soul_core>,
        ["凝聚了无数灵魂，是生物圈繁荣的象征，女神也为之高兴","减免20%的时间，产出提升为先前的2倍"],
        [RecipeModifierBuilder.create("modularmachinery:duration","input",0.8,1,false).build(),RecipeModifierBuilder.create("modularmachinery:item","output",2,1,false).build()]
    ).setChance(0).setParallelizeUnaffected(true)
    .addRecipeTooltip("的确很难理解为什么崩坏会锁定一个虚拟星球")
    .addRecipeTooltip("但对女神来说，它们无疑也是敌人")
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            event.activeRecipe.maxParallelism = 32;
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚不存在迷你盖亚！");
            return;
        }
    })
    .setThreadName("希望女神做的事#4")
    .addOutputs(<extrabotany:material:3>*4)
    .addOutput(<extrabotany:lens:6>).setChance(0.12)
    .addOutput(<extrabotany:silenteternity>).setChance(0.03)
    .addOutput(<extrabotany:coregod>).setChance(0.02)
    .build();