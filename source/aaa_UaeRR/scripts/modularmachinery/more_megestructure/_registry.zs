//ALL RIGHTS RESERVED
//也许你可以对私货进行更改。

#priority 10
#loader crafttweaker reloadable

import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.MachineUpgradeHelper;

import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;

import novaeng.hypernet.DatabaseType;
import novaeng.hypernet.DataProcessorType;
import novaeng.hypernet.ResearchStationType;
import novaeng.hypernet.ComputationCenterType;

import novaeng.hypernet.upgrade.type.ProcessorModuleCPUType;
import novaeng.hypernet.upgrade.type.ProcessorModuleGPUType;
import novaeng.hypernet.upgrade.type.ProcessorModuleRAMType;

//科研枢纽-研究站
MachineModifier.setMaxThreads("kysn_research", 0);
RegistryHyperNet.addResearchStationType(ResearchStationType.create("kysn_research", 25 * 1000 * 100000,  21.1));

//千载星辰
MachineModifier.setMaxThreads("qzxc", 0);
RegistryHyperNet.addDataProcessorType(DataProcessorType.create("qzxc", 1,
        // 热量散发量 过热阈值
        0,        2000000000)
        .addRadiatorIngredient(2000000000, [<liquid:cryotheum> * 7], [])
);
MachineModifier.setInternalParallelism("qzxc", 16);

MachineUpgradeHelper.registerSupportedItem(<contenttweaker:mm_yzjz>);
                             //最低耐久 最高耐久        峰值耗电量           算力上限提供
ProcessorModuleRAMType.create(2147483640,2147483646,  1500, 100000.0 * 1000.0F).register(
        "mm_yzjz", "§5内存§9模块§d「空间」", 12.8F
);
MachineUpgradeHelper.addFixedUpgrade(<contenttweaker:mm_yzjz>, "mm_yzjz");

MachineUpgradeHelper.registerSupportedItem(<contenttweaker:polymer_matter>);
                                    //最低耐久 最高耐久         峰值耗电量         算力产出
ProcessorModuleGPUType.createGPUType(2147483640,2147483646,  1500, 100000.0F * 1000.0F).register(
        "polymer_matter", "§9宇宙图形处理器模块§d「时间」", 12.8F
);
MachineUpgradeHelper.addFixedUpgrade(<contenttweaker:polymer_matter>, "polymer_matter");

//科研枢纽-数据库
MachineModifier.setMaxThreads("kysn_database", 0);
RegistryHyperNet.addDatabaseType(DatabaseType.create("kysn_database", 5000 * 100000,        2000));

//科研枢纽-中心
MachineModifier.setMaxThreads("kysn_core", 0);
RegistryHyperNet.addComputationCenter("kysn_core");
RegistryHyperNet.addComputationCenterType(ComputationCenterType.create("kysn_core", 5 * 1000000 * 1000,
        // 最大连接数 单次最大算力支持 电路板耐久 最低电路板耐久消耗 最高电路板耐久消耗 电路板耐久消耗概率
        4000,        1000000000,        80000000,   1,            1,             0.01F)
        .addFixIngredient(1000, <contenttweaker:industrial_circuit_v1>)
        .addFixIngredient(4000, <contenttweaker:industrial_circuit_v2>)
        .addFixIngredient(150000, <contenttweaker:industrial_circuit_v3>)
        .addFixIngredient(600000, <contenttweaker:industrial_circuit_v4>)
);
