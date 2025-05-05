#modloaded zenutils immersiveengineering immersivepetroleum
#priority -1
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
import mods.modularmachinery.RecipeStartEvent;
import mods.modularmachinery.RecipeTickEvent;
import mods.modularmachinery.RecipeFinishEvent;
import mods.modularmachinery.ControllerGUIRenderEvent;
import mods.modularmachinery.FactoryRecipeStartEvent;
import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.MachineTickEvent;
import mods.modularmachinery.SmartInterfaceType;
import mods.modularmachinery.MachineUpgradeHelper;

import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;

import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.research.ResearchCognitionData;
import novaeng.hypernet.ComputationCenterType;
import novaeng.hypernet.DataProcessorType;
import novaeng.hypernet.upgrade.type.ProcessorModuleGPUType;
import novaeng.hypernet.upgrade.type.ProcessorModuleRAMType;

import mods.jei.JEI;

recipes.addShaped(<contenttweaker:surprise>,[
    [<contenttweaker:mola>,<contenttweaker:mola>,<contenttweaker:mola>],
    [<contenttweaker:mola>,<minecraft:writable_book>,<contenttweaker:mola>],
    [<contenttweaker:mola>,<contenttweaker:mola>,<contenttweaker:mola>]
]);

RecipeBuilder.newBuilder("yujingtai","mach_crafter",720)
    .addInputs([
        <touhou_little_maid:power_point>*16,
        <thermalfoundation:coin:1>*66,
        <minecraft:glowstone_dust>*66
    ])
    .addEnergyPerTickInput(20000)
    .addOutput(<modularmachinery:terrace_controller>)
    .requireComputationPoint(20.0F)
    .requireResearch("Keqing")
    .build();

val toolmaid = <draconicevolution:mob_soul>.withTag({EntityName: "touhou_little_maid:entity.passive.maid", display: {Name: "§4神奇的工具人"}});
val esscore = <contenttweaker:essencecore>;
val surprise = <contenttweaker:surprise>;
val mola = <contenttweaker:mola>;
RecipeBuilder.newBuilder("keqing","machine_arm",3600)
    .addInputs([
        <contenttweaker:surprise>*16,
        toolmaid * 16,
        mola * 128,
        <thermalfoundation:coin:1> *99,
        <psi:material:2> * 36
    ])
    .addOutput(<modularmachinery:manufactory_factory_controller>)
    .requireResearch("Keqing")
    .addEnergyPerTickInput(1145141)
    .requireComputationPoint(114.0F)
    .build();
RecipeBuilder.newBuilder("touhoumaid","terrace",720)
    .addInput(<thermalfoundation:coin:1>*9)
    .addCatalystInput(<ore:gemDiamond>,
        ["非常值钱的宝石，能够更快获得回应","配方时间减半"],
        [RecipeModifierBuilder.create("modularmachinery:duration","input",0.5,1,false).build()]
    )
    .addCatalystInput(<ore:singularityGold>,
        ["无穷黄金汇聚而成，是放到眼前就会让人感觉到达了财富本源的东西","配方时间减少80%"],
        [RecipeModifierBuilder.create("modularmachinery:duration","input",0.2,1,false).build()]
    ).setChance(0.001)
    .addCatalystInput(<avaritia:singularity:11>,
        ["真正的财富顶点，完全无法相信现实世界居然会有如此昂贵的东西","产出翻倍"],
        [RecipeModifierBuilder.create("modularmachinery:item","output",2,1,false).build()]
    ).setChance(0.0001)
    .addEnergyPerTickInput(10000)
    .addOutput(toolmaid)
    .build();
JEI.addItem(toolmaid);
toolmaid.addTooltip("通过祭坛交换的工具人");
toolmaid.addTooltip("仅仅只是某位大妖怪随手捏造出来的，玩偶一样的存在");
toolmaid.addTooltip("笨笨的，连自我认知都有些缺乏，所以也不会感到痛苦，就像机器人一样");
toolmaid.addTooltip("正因如此，可以用来做一些不能用人做的事情");
esscore.addTooltip("工具人的灵力消耗完之后遗留下的东西");
esscore.addTooltip("原本是非常一般的材料，但因为浸润了大妖怪的灵力，所以还是很有用");
esscore.addTooltip("似乎是有着点石成金的魔力，能够把圆石变成有用的材料");
esscore.addTooltip("是非常稀有独特的物品");
surprise.addTooltip("无薪驱使没有自我认知的人形生物高强度工作算不算是压榨呢？");
surprise.addTooltip("就算是最了解法律的人也没办法作出回答吧");
surprise.addTooltip("在会议上提出这个想法的时候，实验室的领导层露出了这样的表情");
surprise.addTooltip("总之，最后还是投入到了正式生产之中");
surprise.addTooltip("最后盖章的实验室高层也会在此监工，所以工场也以之为名");
mola.addTooltip("在铜币上镀金之后制造出来的“货币”");
mola.addTooltip("如果是在外面的话会被当作假币，所以只能在工场里使用");
mola.addTooltip("被用来支付工具人的“工资”，是挂在驴面前的胡萝卜一样的东西");
mola.addTooltip("在工具人死亡之后能够部分回收，所以刚开始的时候不需要准备太多");
mola.addTooltip("就算如此，如果缺少的话，工具人也还是会失去工作的动力");
mola.addTooltip("如果想要扩大生产规模的话，会需要注入额外的资金");

val ores as IIngredient[] = [
        <ore:rawOreIron>*16,<ore:rawOreGold>*8,<ore:rawOreGemDiamond>*4,
        <ore:rawOreGemEmerald>*2,<ore:rawOreCopper>*18,<ore:rawOreRedstone>*12,
        <ore:rawOreGemLapis>*24,<ore:rawOreGemQuartz>*14,<ore:rawOreTin>*12,
        <ore:rawOreLead>*15,<ore:rawOreSilver>*8,<ore:rawOreNickel>*8,
        <ore:rawOrePlatinum>*8,<ore:rawOreIridium>*6
    ];
val orechance as float[] = [
        0.8,0.6,0.4,
        0.2,0.7,0.9,
        0.8,0.4,0.5,
        0.6,0.4,0.6,
        0.4,0.4
    ];

MMEvents.onControllerGUIRender("manufactory",function(event as ControllerGUIRenderEvent){
    val ctrl = event.controller;
    val world = ctrl.world;
    val data = ctrl.customData;
    val dData = D(data);
    val maid = dData.getInt("maid",0);
    val deadmaid = dData.getInt("deadmaid",0);
    val mola = dData.getInt("mola",0);
    var para = dData.getInt("para",1);
    var timemagn = dData.getFloat("timemagn",1.0f);
    var info as string[] = [];
    info += "—————工场监测装置—————";
    info += "当前工具人数量:" + maid;
    info += "当前剩余资金：" + mola;
    info += "将会消亡的工具人数量：" + deadmaid;
    info += "当前并行数:" + para;
    info += "当前时间倍率：" + timemagn;
    event.extraInfo = info;
});

HyperNetHelper.proxyMachineForHyperNet("manufactory");
MachineModifier.setMaxThreads("manufactory",0);
MachineModifier.addCoreThread("manufactory",FactoryRecipeThread.createCoreThread("摩拉输入").addRecipe("molain")); 
MachineModifier.addCoreThread("manufactory",FactoryRecipeThread.createCoreThread("工具人输入").addRecipe("maidin")); 
MachineModifier.addCoreThread("manufactory",FactoryRecipeThread.createCoreThread("工资结算").addRecipe("payroll")); 
MachineModifier.addCoreThread("manufactory",FactoryRecipeThread.createCoreThread("伤亡结算").addRecipe("maiddie")); 
MachineModifier.addCoreThread("manufactory",FactoryRecipeThread.createCoreThread("矿物提取").addRecipe("oreout")); 
for i in 1 to 9{
    MachineModifier.addCoreThread("manufactory",FactoryRecipeThread.createCoreThread("制作区域"+i)); 
}

RecipeBuilder.newBuilder("payroll","manufactory",400)
    .addEnergyPerTickInput(20000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val maid = dData.getInt("maid",0);
        var mola = dData.getInt("mola",0);
        val map = data.asMap();
        val reqmola = maid * 100;
        if(mola == 0){
            event.setFailed("还没有注资！");
        }else if(mola < reqmola){
            event.setFailed("工资不够！工具人没有动力了！");
        }else{
            mola = mola - reqmola;
            map["mola"] = mola;
        }
        ctrl.customData = data;
    })
    .addRecipeTooltip("每个工具人每10s会需要100摩拉作为工资","如果不够的话，工具人会失去工作的动力")
    .setThreadName("工资结算")
    .build();
RecipeBuilder.newBuilder("precision_upgrade","manufactory",5)
    .addInput(<modularmachinery:workshop_factory_controller>).setTag("mola")
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val upgrade = dData.getInt("upgrade",0);
        if(upgrade != 0){
            event.setFailed("已经安装了精密装配机升级！");
        }
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val map = data.asMap();
        map["upgrade"] = 1;
        ctrl.customData = data;
    })
    .addRecipeTooltip("解锁精密装配机配方","在控制器旁边的输入仓输入")
    .setParallelized(false)
    .build();
RecipeBuilder.newBuilder("para_upgrade","manufactory",5)
    .addInput(<modularmachinery:blockparallelcontroller:2> * 16).setTag("mola")
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val paramagn = dData.getInt("paramagn",1);
        if(paramagn != 1){
            event.setFailed("已经安装了并行升级！");
        }
    })
    .addFactoryFailureHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val map = data.asMap();
        map["paramagn"] = 4;
        ctrl.customData = data;
    })
    .addRecipeTooltip("让所有配方的并行数变为原来的4倍，升级不可叠加","在控制器旁边的输入仓输入")
    .build();

RecipeBuilder.newBuilder("molain","manufactory",1)
    .addInput(mola*1000).setTag("mola")
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val map = data.asMap();
        var mola = dData.getInt("mola",0);
        mola += 1000;
        map["mola"] = mola;
        ctrl.customData = data;
    })
    .addRecipeTooltip("为工场注资1000摩拉","在控制器旁边的输入仓输入")
    .setThreadName("摩拉输入")
    .setParallelized(false)
    .build();
RecipeBuilder.newBuilder("maidin","manufactory",1)
    .addInput(toolmaid).setTag("mola")
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val map = data.asMap();
        var maid = dData.getInt("maid",0);
        maid += 1;
        map["maid"] = maid;
        ctrl.customData = data;
    })
    .addRecipeTooltip("为工场添加一个工具人","在控制器旁边的输入仓输入")
    .setThreadName("工具人输入")
    .setParallelized(false)
    .build();
RecipeBuilder.newBuilder("maiddie","manufactory",2400)
    .addOutputs([
        esscore,
        mola * 960,
        <liquid:lifeessence>*5000,
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val map = data.asMap();
        var maid = dData.getInt("maid",0);
        var demaid as int = maid / 20;
        if(maid == 0){
            map["deadmaid"] = 0;
            event.setFailed("还没有工具人！");
        }else{
            map["deadmaid"] = demaid;
            event.activeRecipe.maxParallelism = demaid;
        }
        ctrl.customData = data;
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val map = data.asMap();
        var maid = dData.getInt("maid",0);
        val deadmaid = dData.getInt("deadmaid",0);
        maid = maid - deadmaid;
        map["maid"] = maid;
        ctrl.customData  = data;
    })
    .addRecipeTooltip("工具人每120s会消亡5%","会留下960摩拉、5000mb的血液和一个灵核")
    .setThreadName("伤亡结算")
    .build();

var reb = RecipeBuilder.newBuilder("oreout","manufactory",200)
    .addInput(<minecraft:cobblestone>*99).setTag("game")
    .addInput(esscore).setChance(0).setTag("game")
    .setThreadName("矿物提取")
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 2000000000;
    })
    .addRecipeTooltip("和摩拉以及工具人输入不在同一个输入仓","灵核数量决定并行，最大20亿，不会被消耗");

for i in 0 to 14{
    reb.addOutput(ores[i]).setChance(orechance[i]);
}
reb.build();

RecipeBuilder.newBuilder("mola","machine_arm",20)
    .addInputs([
        <ore:blockCopper>,
        <ore:ingotGold>
    ])
    .addOutput(mola*729)
    .build();

RecipeAdapterBuilder.create("manufactory","modularmachinery:machine_arm")
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val map = data.asMap();
        var maid = dData.getInt("maid",0) as float;
        var para = dData.getInt("para",1);
        var timemagn = dData.getFloat("timemagn",1.0f);
        val paramagn = dData.getInt("paramagn",1);
        var a = 100.0f;
        var b = 0.9f;
        if(maid < 90){
            timemagn = 1.0f - (maid / 100.0f);
        }else{
            timemagn = 0.1f;
            para = 1 + (maid - 90) / 16;
        }
        if(ctrl.formedMachineName == "manufactory"){         
            if(isNull(event.controller.recipeThreadList[2].activeRecipe)){
                event.setFailed("没发工资，工具人失去了工作动力！");
                return;
            }
            val relpara = para * paramagn;
            event.activeRecipe.maxParallelism = relpara;
            map["timemagn"] = timemagn;
            map["para"] = para;
            ctrl.customData = data;
        }
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        var timemagn = dData.getFloat("timemagn",1.0f);
        event.factoryRecipeThread.addModifier("maidtest", RecipeModifierBuilder.create("modularmachinery:duration", "input", timemagn, 1, false).build());
    })
    .build();
RecipeAdapterBuilder.create("manufactory","modularmachinery:precision_assembler")
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val map = data.asMap();
        var maid = dData.getInt("maid",0) as float;
        var para = dData.getInt("para",1);
        var timemagn = dData.getFloat("timemagn",1.0f);
        val paramagn = dData.getInt("paramagn",0);
        var a = 100.0f;
        var b = 0.9f;
        if(maid < 90){
            timemagn = 1.0f - (maid / 100.0f);
        }else{
            timemagn = 0.1f;
            para = 1 + (maid - 90) / 16;
        }
        if(ctrl.formedMachineName == "manufactory"){         
            if(isNull(event.controller.recipeThreadList[2].activeRecipe)){
                event.setFailed("没发工资，工具人失去了工作动力！");
                return;
            }
            val relpara = para * paramagn;
            event.activeRecipe.maxParallelism = relpara;
            map["timemagn"] = timemagn;
            map["para"] = para;
            ctrl.customData = data;
        }
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        var timemagn = dData.getFloat("timemagn",1.0f);
        event.factoryRecipeThread.addModifier("maidtest", RecipeModifierBuilder.create("modularmachinery:duration", "input", timemagn, 1, false).build());
    })
    .build();
RecipeAdapterBuilder.create("manufactory","modularmachinery:board_assembly_room")
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val map = data.asMap();
        var maid = dData.getInt("maid",0) as float;
        var para = dData.getInt("para",1);
        var timemagn = dData.getFloat("timemagn",1.0f);
        val paramagn = dData.getInt("paramagn",0);
        var a = 100.0f;
        var b = 0.9f;
        if(maid < 90){
            timemagn = 1.0f - (maid / 100.0f);
        }else{
            timemagn = 0.1f;
            para = 1 + (maid - 90) / 16;
        }
        if(ctrl.formedMachineName == "manufactory"){
            if(isNull(event.controller.recipeThreadList[2].activeRecipe)){
                event.setFailed("没发工资，工具人失去了工作动力！");
                return;
            }
            val relpara = para * paramagn;
            event.activeRecipe.maxParallelism = relpara;
            map["timemagn"] = timemagn;
            map["para"] = para;
            ctrl.customData = data;
        }
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        var timemagn = dData.getFloat("timemagn",1.0f);
        event.factoryRecipeThread.addModifier("maidtest", RecipeModifierBuilder.create("modularmachinery:duration", "input", timemagn, 1, false).build());
    })
    .build();