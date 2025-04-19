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

RecipeBuilder.newBuilder("spacetime_continuum","light-speed_material_accelerator",3600)
    .addEnergyPerTickInput(2000000000000)
    .addInputs([
        <contenttweaker:sensor_v5>*8,
        <minecraft:melon_block>*64
    ])
    .requireComputationPoint(600000.0F)
    .requireResearch("spacetime")
    .addOutput(<contenttweaker:fragments_of_the_space_time_continuum>*1)
    .build();

RecipeBuilder.newBuilder("spacetime_block","light-speed_material_accelerator",360)
    .addEnergyPerTickInput(2000000000000)
    .requireComputationPoint(200000)
    .requireResearch("spacetime")
    .addInputs(<contenttweaker:arkforcefieldcontrolblock>*8).setChance(0)
    .addInputs([
        <avaritia:resource:6>*8,
        <eternalsingularity:eternal_singularity>,
        <contenttweaker:fragments_of_the_space_time_continuum>
    ])
    .addOutput(<contenttweaker:space_time_condensation_block>*1)
    .addOutput(<contenttweaker:fragments_of_the_space_time_continuum>*8)
    .build();


RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("HorizonProbes","突破事件视界",
    <draconicevolution:reactor_core>,
    14.1,
    300000*60*60*20.0F,
    300000.0F,
    [
        "光速，是宇宙给文明设下的最终极的壁障",
        "它将过去与未来约束在光锥之中，将逻辑制约于因果律的范围之内，将文明的活跃范围限制在数光年的狭小范围之中",
        "也正因物质在时空之中运行的速度始终为唯一的光速，黑洞之中发生的事情，我们原本注定无法知晓",
        "好在我们获得了超越光速的图纸，宇宙这最终极奥秘上的帷幕，已然在我们的面前揭开了一角",
        "我们必将知道，我们终将知道"
    ],
    [
        "解锁§c超§6光§e速§a物§b质§9加§5速§9器控制器§2配方§：视界探针",
        "在一次日常检查之中，Nova发现当初自外太空而来，给予了蒙昧时期的实验室以物质-数据转换方式的陨石之中，蕴藏着一些过往从未发现的数据",
        "仔细分析之后，ECO实验室震惊地发现已经使用许久的ME控制器竟极为适合用来处理时空相关的数据",
        "经过深入研究，实验室一致认为，在时空科技方面，一台ME控制器所能够发挥的效果至少需要9.22EFloPS的算力才能够媲美",
        "或许，那已然无法找到踪迹的未知文明，正是一个和我们一样站在终极真理面前上下求索的孤独者吧",
        "———《ECO实验室周刊》时空科技特刊"
    ],
    [
        "spacetime"
    ]
));

RecipeBuilder.newBuilder("gointo_singularity","light-speed_material_accelerator",20000)
    .addInputs([
        <contenttweaker:space_time_condensation_block>*8,
        <contenttweaker:fragments_of_the_space_time_continuum>*64,
        <contenttweaker:arkforcefieldcontrolblock>*32,
        <additions:novaextended-star_ingot>*48,
        <draconicevolution:reactor_component>*16,
        <draconicevolution:reactor_component:1>*4,
        <modularmachinery:data_processor_t4_factory_controller>,
        <modularmachinery:computation_center_t3_factory_controller>,
    ])
    .addEnergyPerTickInput(200000000000)
    .addOutput(<modularmachinery:horizonprobes_factory_controller>)
    .requireComputationPoint(30000.0F)
    .requireResearch("HorizonProbes")
    .build();

<modularmachinery:horizonprobes_factory_controller>.addTooltip("创造一个稳定的黑洞，并借助它完成快速而大量的质能转换");
<modularmachinery:horizonprobes_factory_controller>.addTooltip("存在发电与探测两种模式");
<modularmachinery:horizonprobes_factory_controller>.addTooltip("发电模式下功率为10TRF/tick,产出大量中子素块和时空连续体碎片");
<modularmachinery:horizonprobes_factory_controller>.addTooltip("探测模式下产出巨量时空连续体碎片和一些α物质，发电功率为6TRF/tick");
<contenttweaker:alpha_matter>.addTooltip("从奇点之中获得的奇异物质，对未来的发展有着至关重要的作用");

MachineModifier.setMaxThreads("HorizonProbes",0);
MachineModifier.addCoreThread("HorizonProbes",FactoryRecipeThread.createCoreThread("视界探针控制器").addRecipe("HorizonProbes_state"));
MachineModifier.addCoreThread("HorizonProbes",FactoryRecipeThread.createCoreThread("奇点状态监测器").addRecipe("singularity_state"));
MachineModifier.addCoreThread("HorizonProbes",FactoryRecipeThread.createCoreThread("物质操纵器").addRecipe("eternal_singularity_control"));
MachineModifier.addCoreThread("HorizonProbes",FactoryRecipeThread.createCoreThread("真理计算机").addRecipe("eternal_singularity_detection"));

HyperNetHelper.proxyMachineForHyperNet("HorizonProbes");

//主线程，探针控制器
RecipeBuilder.newBuilder("HorizonProbes_state","HorizonProbes",2147483647)
    .requireComputationPoint(10000.0F)
    .setThreadName("视界探针控制器")
    .addInputs(<avaritia:block_resource>*99)
    .addInputs(<avaritia:block_resource:1>)
    .addRecipeTooltip([
        "通过将极巨量的极限密度物质聚合，以无尽之力作为核心稳定",
        "在精密的控制之下，我们获得了可以用于研究的稳定黑洞",
        "相较于时空科技的部分，这些算力足以忽略不计"
    ])
    .build();
//副线程，可以产出时空碎片和块
RecipeBuilder.newBuilder("singularity_state","HorizonProbes",200)
    .addInputs(<liquid:crystalloid>*256000)
    .addCatalystInput(<ore:ingotInfinity>*16,
    ["在物质活化之前加入无尽之锭可以使奇点更加活跃,更容易粉碎空间,产出翻倍"],
    [RecipeModifierBuilder.create("modularmachinery:item","output",2,1,false).build()]).setChance(1)
    .addOutputs([
        <contenttweaker:space_time_condensation_block>*8,
        <contenttweaker:fragments_of_the_space_time_continuum>*64
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚不存在稳定黑洞");
            return;
        }
    })
    .addRecipeTooltip([
        "借助于紫晶素的神秘力量，奇点得以被进一步稳定",
        "现在可以更加高效地获得时空碎片"
    ])
    .setThreadName("奇点状态监测器")
    .build();
//发电线程，产出一些时空碎片和中子素块
RecipeBuilder.newBuilder("eternal_singularity_control","HorizonProbes",4000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚不存在稳定黑洞");
            return;
        }
    })
    .addInput(<eternalsingularity:eternal_singularity>)
    .addEnergyPerTickOutput(10000000000000)
    .addRecipeTooltip("质能转换")
    .setThreadName("物质操纵器")
    .addOutputs([
        <avaritia:block_resource>*64*10,
        <contenttweaker:fragments_of_the_space_time_continuum>*64*20
    ])
    .build();


//生产线程，能够产出一些真理矩阵
RecipeBuilder.newBuilder("eternal_singularity_detection","HorizonProbes",400)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚不存在稳定黑洞");
            return;
        }
    })
    .addInputs([
        <contenttweaker:world_energy_core>,
        <avaritiatweaks:infinitato>*4
    ])
    .addEnergyPerTickOutput(6000000000000)
    .addRecipeTooltip("奇点探测")
    .setThreadName("真理计算机")
    .addOutputs(<contenttweaker:alpha_matter>*2).setChance(0.2)
    .addOutputs(<contenttweaker:alpha_matter>*4).setChance(0.1)
    .addOutputs(<contenttweaker:alpha_matter>*8).setChance(0.05)
    .addOutputs(<contenttweaker:alpha_matter>*16).setChance(0.01)
    .addOutputs(<contenttweaker:fragments_of_the_space_time_continuum>*64)
    .build();