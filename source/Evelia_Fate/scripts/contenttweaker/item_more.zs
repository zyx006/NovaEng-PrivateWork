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