#priority 1000

#loader contenttweaker

import mods.contenttweaker.VanillaFactory;
import mods.contenttweaker.Item;

function regItem(name as string) {
    val item as Item = VanillaFactory.createItem(name);
    item.creativeTab = <creativetab:misc>;
    item.register();
}

function regItemWithStackSize(name as string, maxStackSize as int) {
    val item as Item = VanillaFactory.createItem(name);
    item.creativeTab = <creativetab:misc>;
    item.maxStackSize = maxStackSize;
    item.register();
}
function regFluid(regName as string, color as int, temperature as int) {
    var fluid = VanillaFactory.createFluid(regName, color);
    fluid.colorize = true;
    fluid.temperature = temperature;
    fluid.stillLocation = "base:fluids/liquid";
    fluid.flowingLocation = "base:fluids/liquid_flow";
    fluid.register();
}

//真理矩阵
regItem("truthmatrix");

//已满的极限能源存储器
regItem("charged_max_energy_containers");

//极限能源存储器
regItem("max_energy_containers");

//恒稳态超临界光子
regItem("steady_supercritical_photons");

//方舟运载火箭
regItem("ark_launch_vehicle");

//暗物质
regItem("dark_matter");

//星空本源
regItem("starry_orgin");

//恒星符文
regItem("sunrune");

//寰宇核心
regItem("infinitycore");

//集成电路
regItem("integratedcircuit");

//量子芯片
regItem("quantumchip");

//电路基板
regItem("circuit_boards");

//精致电路基板
regItem("refine_circuit_boards");

//超越电路基板
regItem("overcircuit");

//拉多集成电路
regItem("rado_circuit");

//奇异处理器
regItem("processor");

//奇异集成电路
regItem("assembly");

//奇异电路集群
regItem("processorcluster");

//奇异主机
regItem("mainframe");

//灵力核心
regItem("essencecore");

//刻晴惊讶
regItem("surprise");

//摩拉
regItem("mola");

//培养皿系列
regItem("petri_dish");
regItem("petri_dish_a");
regItem("petri_dish_b");
regItem("rado_dish");

//网络卡
regItem("network_card");

//永恒新星
regItem("eternity_nova");

//调律源金
regItem("shirabon");

//异氙
regFluid("strxenon",0xBEBEBE,300);

//拉多
regFluid("rado",0xA020F0,12000);
regFluid("radox",0xA020F0,24000);

//液化方舟
regFluid("ark",0x21B1FF,36000);