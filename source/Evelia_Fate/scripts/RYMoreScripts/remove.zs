#reloadable
#sideonly client
#priority 1

import mods.jei.JEI;
import mods.zenutils.I18n;
import mods.modularmachinery.MachineModifier;

import crafttweaker.player.IPlayer;
import crafttweaker.entity.IEntity;
import crafttweaker.item.IItemStack;
import crafttweaker.mods.ILoadedMods;
import crafttweaker.event.WorldTickEvent;
import crafttweaker.event.PlayerLoggedInEvent;
import mods.ymadditions.NetHubPowerUsage;


NetHubPowerUsage.calcNetHubPowerUsage(function(context as double, isOtherDim as bool){
    return 0.0D;
});

static diffs as string[int] = {
    1:"§9难度: §a§l§n1§a.",
    2:"§9难度: §a§l§n2§a.",
    3:"§9难度: §a§l§n3§a.",
    4:"§9难度: §b§l§n4§b.",
    5:"§9难度: §b§l§n5§b.",
    6:"§9难度: §5§l§n6§5.",
    7:"§9难度: §5§l§n7§5.",
    8:"§9难度: §5§l§n8§5.",
    9:"§9难度: §6§l§n9§6.",
    10:"§9难度: §6§l§n10§6.",
    11:"§9难度: §c§l§n11§c.",
    12:"§9难度: §c§l§n12§c.",
    13:"§9难度: §4§l§n13§c.",
    14:"§9难度: §4§l§n14§c.",
};

val RemoveController as IItemStack[] = [
    <modularmachinery:fluidchange_factory_controller>,
    <modularmachinery:overchanter_factory_controller>,
    <modularmachinery:energychange_factory_controller>,
    <modularmachinery:deepmelon_factory_controller>,
    <modularmachinery:ethenecontroller_factory_controller>,
    <modularmachinery:particlecontrol_factory_controller>,
    <modularmachinery:terrace_factory_controller>,
    <modularmachinery:spacesurvey_factory_controller>,
    <modularmachinery:paradox_factory_controller>,
    <modularmachinery:stellarator_factory_controller>,

    <modularmachinery:compressed_stellarator_controller>,
    <modularmachinery:advanced_stellarator_controller>,
    <modularmachinery:prototype_controller>,
    <modularmachinery:shadow_controller>,
    <modularmachinery:extreme_stellarator_controller>,
    <modularmachinery:starpith_controller>,
    <modularmachinery:harmony_controller>,
    <modularmachinery:inversion_controller>,
    <modularmachinery:truthseek_controller>,
    <modularmachinery:transcendentmattergenerator_controller>,
    <modularmachinery:creativecomputer_controller>,
    <modularmachinery:stellarregulatorarray_controller>,
    <modularmachinery:electromagnetic_dissociation_controller>,
    <modularmachinery:structural_failure_controller>,
    <modularmachinery:manufactory_controller>,
    <modularmachinery:resonatorofgaia_controller>,
    <modularmachinery:superentropycalculus_controller>,
    <modularmachinery:biospherex_controller>,
    <modularmachinery:circuitassembly_controller>,
    <modularmachinery:songofsuperstring_controller>,
    <modularmachinery:universalassembly_controller>,
    <modularmachinery:horizonprobes_controller>,
    <modularmachinery:thegateofplanck_controller>,
    <modularmachinery:chaosreactor_controller>,
    <modularmachinery:figureofnova_controller>,
    <modularmachinery:artificial_star_controller>,
];

for item in RemoveController{
    JEI.removeAndHide(item);
}

function tooltipRecipe(machine as string,level as int,difficulty as int,factory as bool = true){
    var name as string = machine;
    if (factory){name = machine + "_factory";}
    val item as IItemStack = <item:modularmachinery:${name}_controller>;
    item.clearTooltip(true);
    item.addTooltip("§e//////// 机械信息 / 等级 / 功能 ////////");
    item.addTooltip(diffs[level] + difficulty);
}

tooltipRecipe("manufactory",7,9);
tooltipRecipe("biospherex",9,1);
tooltipRecipe("circuitassembly",13,5);
tooltipRecipe("figureofnova",7,9);
tooltipRecipe("harmony",14,1);
tooltipRecipe("horizonprobes",14,1);
tooltipRecipe("inversion",14,1);
tooltipRecipe("shadow",3,9);
tooltipRecipe("stellarator",9,0,false);
tooltipRecipe("overchanter",3,5,false);
tooltipRecipe("universalassembly",10,9);
tooltipRecipe("artificial_star",12,9);

<modularmachinery:manufactory_factory_controller>.addTooltip("通过输入§4神奇的工具人§r和摩拉以工作，每个工具人每10s消耗100摩拉，每120s死亡5%");
<modularmachinery:manufactory_factory_controller>.addTooltip("在90个工具人之前，每个工具人会降低1%的配方时间，90个之后，每16个工具人会增加1并行");
<modularmachinery:manufactory_factory_controller>.addTooltip("通过输入一个集成式处理车间集成控制器以解锁精密装配机配方，此种配方会有额外4倍的并行加成，元件装配室配方的并行则是16倍");
<modularmachinery:manufactory_factory_controller>.addTooltip("输入16个精英并行控制器会使所有配方的并行数额外变为原来的4倍");
<modularmachinery:manufactory_factory_controller>.addTooltip("§4§o§l有人会说这过于残忍，但我们将之称为高效");

<modularmachinery:biospherex_factory_controller>.addTooltip("终极的生物实验室，有着强大的生产能力，配方运行需要一定洁净度，运行完成后会降低一些洁净度");
<modularmachinery:biospherex_factory_controller>.addTooltip("不同的隔离材料能带来不同的洁净度上限和污染倍率，而高级的净化装置则会带来更高的净化速度");
<modularmachinery:biospherex_factory_controller>.addTooltip("隔离材料依次为镍、恒星合金、无尽、方舟、时空");
<modularmachinery:biospherex_factory_controller>.addTooltip("相应的洁净度上限则是4k、10k、200k、1M、10M，洁净度降低倍率为8、5、3、2、1");
<modularmachinery:biospherex_factory_controller>.addTooltip("净化装置则有6个部分，净化速度依次为20、50、200、1000、5000、20000/t");
<modularmachinery:biospherex_factory_controller>.addTooltip("相应的，耗电量也会有所变化，基础为200kRF/tick，倍率则依次为1，5，10，60，150，600");

<modularmachinery:circuitassembly_factory_controller>.addTooltip("高效制作算力元件，需要安装线圈以运行");
<modularmachinery:circuitassembly_factory_controller>.addTooltip("线圈等级依次为恒星合金、无尽、时空");
<modularmachinery:circuitassembly_factory_controller>.addTooltip("恒星合金线圈仅能安装1次");
<modularmachinery:circuitassembly_factory_controller>.addTooltip("无尽线圈每额外安装1次会提供1点额外点数，时空线圈则是3点");
<modularmachinery:circuitassembly_factory_controller>.addTooltip("运行配方时，额外的线圈等级和点数会提供时间减免");
<modularmachinery:circuitassembly_factory_controller>.addTooltip("实际倍率为0.8^(线圈等级-配方需求等级+额外点数)");

<modularmachinery:figureofnova_factory_controller>.addTooltip("THE BIG NOVA IS WATCHING YOU");

<modularmachinery:harmony_factory_controller>.addTooltip("拆解无尽锭为256并行，原子重构以及其余配方则是2048并行");

<modularmachinery:horizonprobes_factory_controller>.addTooltip("创造一个稳定的黑洞，并借助它完成快速而大量的质能转换");
<modularmachinery:horizonprobes_factory_controller>.addTooltip("存在发电与探测两种模式");
<modularmachinery:horizonprobes_factory_controller>.addTooltip("发电模式下功率为10TRF/tick,产出大量中子素块和时空连续体碎片");
<modularmachinery:horizonprobes_factory_controller>.addTooltip("探测模式下产出巨量时空连续体碎片和一些α物质，发电功率为6TRF/tick");

<modularmachinery:inversion_factory_controller>.addTooltip("§5借助视界反演的力量对宇宙之中的天体进行详细的探测和规约，是成为III级甚至IV级文明最方便的技术");
<modularmachinery:inversion_factory_controller>.addTooltip("§5不同天体的规约所需要的材料不尽相同，其产出也截然不同");
<modularmachinery:inversion_factory_controller>.addTooltip("§5蓝巨星会产出大量的能源以及反物质");
<modularmachinery:inversion_factory_controller>.addTooltip("§5红超巨星仅产出能源，但性价比相对极高");
<modularmachinery:inversion_factory_controller>.addTooltip("§5蓝超巨星产出大量能源与恒稳态超临界光子");
<modularmachinery:inversion_factory_controller>.addTooltip("§5近超新星会在一段时间之后爆发，大部分的太阳帆都会被摧毁，但会产出大量资源");
<modularmachinery:inversion_factory_controller>.addTooltip("§5大质量黑洞会对空间产生极大的破坏，产出巨量时空碎片和时空凝聚块");
<modularmachinery:inversion_factory_controller>.addTooltip("§5类星体的体积过于巨大，需要极为特殊的物质才能规约，会产出大量的真理矩阵以及无尽锭");
<modularmachinery:inversion_factory_controller>.addTooltip("§l§f由于产出能源量过于巨大，无法通过常规手段传递，仅能以极限能源存储器为中介传出");

<modularmachinery:shadow_factory_controller>.addTooltip("在结构的活石桶之中灌入流体以获得并行和速度加成,每5s会检测一次");
<modularmachinery:shadow_factory_controller>.addTooltip("加成从高到低依次为无尽涌流、非稳态等离子体、紫晶素、熔融泰拉钢、液态魔力、其它");
<modularmachinery:shadow_factory_controller>.addTooltip("每桶能够获得的并行加成分别为：32、16、12、6、4、2");
<modularmachinery:shadow_factory_controller>.addTooltip("耗时减少依次为：6%、5%、4%、3%、2%、1%");
<modularmachinery:shadow_factory_controller>.addTooltip("桶数向下取整");

<modularmachinery:stellarator_controller>.addTooltip("文明对能源的需求永无止境");

<modularmachinery:overchanter_controller>.addTooltip("制作优秀的附魔书，铁砧无法发挥它的作用，或许可以试试植物魔法的魔力附魔台？");

<modularmachinery:universalassembly_factory_controller>.addTooltip("工程技术的本质，便是以我们的意志塑造这个世界");
<modularmachinery:universalassembly_factory_controller>.addTooltip("可以执行高级元件装配室、集成式处理车间配方，耗时为1/10");

<modularmachinery:artificial_star_factory_controller>.addTooltip("§e星空之神");
<modularmachinery:artificial_star_factory_controller>.addTooltip("§e通过灌入极巨量的氢氦来模拟一颗恒星从诞生到消亡的全过程");
<modularmachinery:artificial_star_factory_controller>.addTooltip("§3在智能数据接口处调整数值以更改存储上限,以下a为智能数据接口处的反应倍率，是一个1~10的整数");
<modularmachinery:artificial_star_factory_controller>.addTooltip("§3氢的存储上限为1Mmb*3^a,氦的存储上限为2Mmb*2^a");
<modularmachinery:artificial_star_factory_controller>.addTooltip("§3基础运行时间为18000s，实际运行时间会除以2^(a-1)，消耗和产出的能量和物品会乘4^(a-1)");
<modularmachinery:artificial_star_factory_controller>.addTooltip("§3输入氘、氚可额外增加产出，每100kmb氘或氚都会增加20%的能量产出，每种内部叠加计算，两种燃料之间叠乘计算");
<modularmachinery:artificial_star_factory_controller>.addTooltip("§3例如，倘若仅输入2Mmb氘，那能量产出会增加400%，如果再输入2Mmb氚，这个数值则会变为1600%");
<modularmachinery:artificial_star_factory_controller>.addTooltip("§3输入额外的128*a个中子素块能让发电时间变为原来的4倍，产出也会额外增加400%，此加成仅计算一次");
<modularmachinery:artificial_star_factory_controller>.addTooltip("§3每1024个恒稳态超临界光子或1048576个星能聚集光子能使发电量提升1%");
<modularmachinery:artificial_star_factory_controller>.addTooltip("§3需要氢氦存满之后方可启动，其余加成则无具体量要求，会在启动时结算，并在运行完成之后清空");
<modularmachinery:artificial_star_factory_controller>.addTooltip("§3手持超光速核心右键控制器可使发电时间变为原来的1/4，液态能量产出速度变为原来的5倍，加成不会因配方运行清空");
<modularmachinery:artificial_star_factory_controller>.addTooltip("§3基础数值下，会在启动时消耗2P无线电网之中的电量，运行时每tick产出1mb液态能量，结束运行时向电网之中加入4PRF");
<modularmachinery:artificial_star_factory_controller>.addTooltip("§4§o§l能量获取的终极解决方案！");
<modularmachinery:artificial_star_factory_controller>.addTooltip("运行过程中拆下控制器可能会导致恒星无法正常消失，将控制器放回原位并成型即可清除");

val info as string[] = [
    "§b§l霞光瑞云之书中记载着本私货的大部分重要内容，无聊的时候可以多看看",
    "§4§l小知识：除了人造恒星之外，规天也可以使用超光速核心升级，能让探测和发射的速度变为原来的5倍，但是会消耗"
    ];

events.onWorldTick(function(event as WorldTickEvent){
    val world = event.world;
    if(world.remote)return;
    val number = world.random.nextInt(0 ,1);
    val time = world.time;
    val players as [IPlayer] = world.getAllPlayers();
    if(time % 24000 == 0 && !isNull(players) && event.phase == "START"){
        for i in players{
            i.sendMessage(info[number]);
        }
    }
});

events.onPlayerLoggedIn(function(event as PlayerLoggedInEvent){
    val player = event.player;
    if(isNull(player.data.PlayerPersisted) || (!isNull(player.data.PlayerPersisted) && isNull(player.data.PlayerPersisted.gotguidebook))){
        player.give(<patchouli:guide_book>.withTag({"patchouli:book": "patchouli:ruiyun_guide_book"}));
        player.update({PlayerPersisted : {gotguidebook : true}});
    }
});

recipes.addShapeless(<patchouli:guide_book>.withTag({"patchouli:book": "patchouli:ruiyun_guide_book"}),[<minecraft:book>,<minecraft:planks>]);