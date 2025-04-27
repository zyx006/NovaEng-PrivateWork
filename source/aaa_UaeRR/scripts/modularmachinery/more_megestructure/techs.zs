#priority 1000
#loader crafttweaker reloadable

import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.research.ResearchCognitionData;

RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("starting_mega_tech", "黎明的曙光",<modularmachinery:gshag_controller>,    // 预览物品
        10.8,                                 // 科技等级（难度）
        250000000,                          // 需要科研点
        5000.0F,                               // 最低每 Tick 算力要求
        [
            "建造集成式处理车间后,Nova至高无上帝国的技术进入了爆炸式增长",
            "工程部看着隔壁科研部无止境的§c§m内卷§f工作,他们开始思考自己的落后",
            "渐渐地,总部对如今的产能产生极大不满",
            "工程部逐渐失去了信心,就连eco-y7+满超频复制机配合终极并行仓也无法满足需求",
            "工程部将无尽这一材料与其分支当做黎明的曙光",
            "不能再等待了",
            "By GigaV4.3.3 BugFix & Add Tech * 1 & Pull Request",
        ],
        [
            "§2什么都没解锁",
        ],
        [
            "eco_y7",
            "assembly_line",
            "tokmak_reactor",                               // 前置科技
        ]
));
RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("gshag", "§k巨构计划§k§k§k§k:平流层风力发电初步运用",<modularmachinery:gshag_controller>,    // 预览物品
        10.8,                                 // 科技等级（难度）
        250000000,                          // 需要科研点
        5000.0F,                               // 最低每 Tick 算力要求
        [
            "我们的发展速度已经超乎想象",
            "但对材料的需求也呈倍增加",
            "于是巨构计划§k诞生了",
            "§2§k凡§k夫§k俗§k子§k永§k远§k无§k法§k理§k解§k我§k们§k的§k进§k步§k",
        ],
        [
            "§2解锁集成式处理车间配方:巨型平流层风力发电机控制器",
            "§2最大线程数:没有",
            "§2最大并行数:没有",
            "非常好被动发电,使我梦核旋转",
        ],
        [
            "eco_y7",
            "assembly_line",
            "tokmak_reactor",
            "starting_mega_tech",                               // 前置科技
        ]
));

RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("gshag_factory", "§k巨构计划§k§k§k§k:更好的风力发电",<modularmachinery:gshag_controller>,    // 预览物品
        12.5,                                 // 科技等级（难度）
        500000000,                          // 需要科研点
        10000.0F,                               // 最低每 Tick 算力要求
        [
            "我们的发展速度已经超乎想象",
            "但对材料的需求也呈倍增加",
            "于是巨构计划§k诞生了",
            "§2§k凡§k夫§k俗§k子§k永§k远§k无§k法§k理§k解§k我§k们§k的§k进§k步§k",
        ],
        [
            "§2解锁集成式处理车间配方:巨型平流层风力发电机集成控制器",
            "§2最大线程数:20",
            "§2最大并行数:没有",
            "非常好被动发电,使我梦核旋转",
            "天哪这是什么,16g的被动发电,方舟辅助仓是什么垃圾,除了很丑全是优点！",
        ],
        [
            "assembly_line",
            "gshag",                              // 前置科技
        ]
));

RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("ACAA", "§k巨构计划§k§k§k§k:高级机械串联运用",<modularmachinery:gshag_controller>,    // 预览物品
        12,                                 // 科技等级（难度）
        400000000,                          // 需要科研点
        100000.0F,                               // 最低每 Tick 算力要求
        [
            "我们的发展速度已经超乎想象",
            "但对材料的需求也呈倍增加",
            "于是巨构计划§k诞生了",
            "§2§k凡§k夫§k俗§k子§k永§k远§k无§k法§k理§k解§k我§k们§k的§k进§k步§k",
        ],
        [
            "§2解锁集成式处理车间配方:高级元件装配阵列集成控制器",
            "§2最大线程数:20",
            "§2初始并行数:2048",
        ],
        [
            "APAC",
            "assembly_line",
            "gshag_factory"                       // 前置科技
        ]
));

RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("APAC", "§k巨构计划§k§k§k§k:基础机械串联运用",<modularmachinery:gshag_controller>,    // 预览物品
        10.5,                                 // 科技等级（难度）
        200000000,                          // 需要科研点
        40000.0F,                               // 最低每 Tick 算力要求
        [
            "我们的发展速度已经超乎想象",
            "但对材料的需求也呈倍增加",
            "于是巨构计划§k诞生了",
            "§2§k凡§k夫§k俗§k子§k永§k远§k无§k法§k理§k解§k我§k们§k的§k进§k步§k",
        ],
        [
            "§2解锁集成式处理车间配方:精密装配机阵列集成控制器",
            "§2最大线程数:20",
            "§2初始并行数:8192",
        ],
        [
            "assembly_line",
            "gshag_factory"                           // 前置科技
        ]
));

//研究
RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("G_MT", "§k巨构计划§k§k§k§k:压缩机",<modularmachinery:gshag_controller>,    // 预览物品
        13,                                 // 科技等级（难度）
        500000000,                          // 需要科研点
        100000.0F,                               // 最低每 Tick 算力要求
        [
            "我们的发展速度已经超乎想象",
            "但对材料的需求也呈倍增加",
            "于是巨构计划§k诞生了",
            "§2§k凡§k夫§k俗§k子§k永§k远§k无§k法§k理§k解§k我§k们§k的§k进§k步§k",
        ],
        [
            "§2解锁集成式处理车间配方:§B'家用'小锤子集成控制器",
            "§2最大线程数:20",
            "§2初始并行数:32767",
            "§2配方可能无法正常显示,以不需要流体的数控锻造机床为准",
        ],
        [
            "starburst_reactor",
            "assembly_line",
            "gshag_factory"                      // 前置科技
        ] 
));

//研究
RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("G_IC", "§k巨构计划§k§k§k§k:粉碎机",<modularmachinery:gshag_controller>,    // 预览物品
        13,                                 // 科技等级（难度）
        500000000,                          // 需要科研点
        100000.0F,                               // 最低每 Tick 算力要求
        [
            "我们的发展速度已经超乎想象",
            "但对材料的需求也呈倍增加",
            "于是巨构计划§k诞生了",
            "§2§k凡§k夫§k俗§k子§k永§k远§k无§k法§k理§k解§k我§k们§k的§k进§k步§k",
        ],
        [
            "§2解锁集成式处理车间配方:§B'家用'破壁机集成控制器",
            "§2最大线程数:20",
            "§2初始并行数:32767",
        ],
        [
            "starburst_reactor",
            "assembly_line",
            "gshag_factory"                      // 前置科技
        ] 
));

//研究
RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("G_CO", "§k巨构计划§k§k§k§k:共价超载器",<modularmachinery:gshag_controller>,    // 预览物品
        13,                                 // 科技等级（难度）
        500000000,                          // 需要科研点
        100000.0F,                               // 最低每 Tick 算力要求
        [
            "我们的发展速度已经超乎想象",
            "但对材料的需求也呈倍增加",
            "于是巨构计划§k诞生了",
            "§2§k凡§k夫§k俗§k子§k永§k远§k无§k法§k理§k解§k我§k们§k的§k进§k步§k",
        ],
        [
            "§2解锁集成式处理车间配方:§B巨型共价超载器集成控制器",
            "§2最大线程数:20",
            "§2初始并行数:32767",
        ],
        [
            "starburst_reactor",
            "assembly_line", 
            "gshag_factory"                     // 前置科技
        ] 
));

RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("G_HTMP", "§k巨构计划§k§k§k§k:高温熔化机",<modularmachinery:gshag_controller>,    // 预览物品
        13,                                 // 科技等级（难度）
        500000000,                          // 需要科研点
        100000.0F,                               // 最低每 Tick 算力要求
        [
            "我们的发展速度已经超乎想象",
            "但对材料的需求也呈倍增加",
            "于是巨构计划§k诞生了",
            "§2§k凡§k夫§k俗§k子§k永§k远§k无§k法§k理§k解§k我§k们§k的§k进§k步§k",
        ],
        [
            "§2解锁集成式处理车间配方:§B巨型高温熔化熔化工厂集成控制器",
            "§2最大线程数:20",
            "§2初始并行数:32767",
        ],
        [
            "starburst_reactor",
            "assembly_line",   
            "gshag_factory"                   // 前置科技
        ] 
));

//==============================太空电梯==============================
//研究
RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("SE_tech1", "§k巨构计划§k§k§k§k:太空电梯-材料",<modularmachinery:space_elevator_controller>,    // 预览物品
        14.1,                                 // 科技等级（难度）
        500000000,                          // 需要科研点
        200000.0F,                               // 最低每 Tick 算力要求
        [
            "地球上的资源已经无法满足我们的需求,而现阶段的太空航行我们只能依靠跃迁核心,但是跃迁核心只能够手动操作",
            "于是——太空电梯计划诞生了",
            "太空电梯计划立志于满足星际航行需求与为建造巨型空间站做足准备",
            "我们迎来的第一个问题便是材料问题,现有的材料要么过于昂贵,要么十分脆弱,也许我们可以对材料进行改造以满足需求",
        ],
        [
            "§2啥也没解锁",
        ],
        [
            "starburst_reactor",
            "assembly_line", 
            "gshag_factory"                     // 前置科技
        ] 
));

RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("SE_tech2", "§k巨构计划§k§k§k§k:太空电梯-图纸",<modularmachinery:space_elevator_controller>,    // 预览物品
        14.1,                                 // 科技等级（难度）
        500000000,                          // 需要科研点
        200000.0F,                               // 最低每 Tick 算力要求
        [
            "在解决材料问题后,我们成立了'太空电梯专项项目组'",
            "项目组筹备了大量的方舟锭来解决材料问题",
            "但是没有一个好的图纸那么这些方舟锭也是一堆废铁",
        ],
        [
            "§2啥也没解锁",
        ],
        [
            "SE_tech1",
            "starburst_reactor",
            "assembly_line",                      // 前置科技
        ] 
));

RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("SE_tech3", "§k巨构计划§k§k§k§k:太空电梯-初版",<modularmachinery:space_elevator_controller>,    // 预览物品
        14.1,                                 // 科技等级（难度）
        500000000,                          // 需要科研点
        200000.0F,                               // 最低每 Tick 算力要求
        [
            "在图纸设计完成后,我们通过强大的算力模拟了初版太空电梯的运行,发现初版太空电梯拥有致命性缺陷——缺少力场控制器",
        ],
        [
            "§2啥也没解锁",
        ],
        [
            "SE_tech2",
            "starburst_reactor",
            "assembly_line",                      // 前置科技
        ] 
));

RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("SE_tech4", "§k巨构计划§k§k§k§k:太空电梯-无限潜力",<modularmachinery:space_elevator_controller>,    // 预览物品
        14.1,                                 // 科技等级（难度）
        500000000,                          // 需要科研点
        200000.0F,                               // 最低每 Tick 算力要求
        [
            "在改进完成第一代太空电梯后,我们的太空电梯已经拥有了最基础的功能,但我们的野心远远不止于此",
        ],
        [
            "§2啥也没解锁",
        ],
        [
            "SE_tech3",
            "starburst_reactor",
            "assembly_line",                      // 前置科技
        ] 
));

RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("SE_tech5", "§k巨构计划§k§k§k§k:太空电梯-圆满",<modularmachinery:space_elevator_controller>,    // 预览物品
        14.1,                                 // 科技等级（难度）
        500000000,                          // 需要科研点
        500000.0F,                               // 最低每 Tick 算力要求
        [
            "经过无数日夜的努力,我们终于完成了太空电梯的理论部分,现在我们可以直接建造太空电梯了",
        ],
        [
            "§2解锁集成式处理车间配方:§B太空电梯集成控制器",
        ],
        [
            "SE_tech4",
            "starburst_reactor",
            "assembly_line",                      // 前置科技
        ] 
));

RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("SE_tech6", "§k巨构计划§k§k§k§k:太空电梯-进阶",<modularmachinery:space_elevator_controller>,    // 预览物品
        14.1,                                 // 科技等级（难度）
        500000000,                          // 需要科研点
        500000.0F,                               // 最低每 Tick 算力要求
        [
            "进一步改造太空电梯,使太空电梯的产能加强",
        ],
        [
            "§2解锁集成式处理车间配方:§B太空电梯mk2集成控制器",
        ],
        [
            "SE_tech5",
            "starburst_reactor",
            "assembly_line",                      // 前置科技
        ] 
));

RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("SE_tech7", "§k巨构计划§k§k§k§k:太空电梯-无限",<modularmachinery:space_elevator_controller>,    // 预览物品
        14.1,                                 // 科技等级（难度）
        500000000,                          // 需要科研点
        500000.0F,                               // 最低每 Tick 算力要求
        [
            "进一步改造太空电梯,使太空电梯的产能加强",
        ],
        [
            "§2解锁集成式处理车间配方:§B太空电梯mk3集成控制器",
        ],
        [
            "SE_tech6",
            "starburst_reactor",
            "assembly_line",                      // 前置科技
        ] 
));

RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("SE_tech8", "§k巨构计划§k§k§k§k:太空电梯-疯狂",<modularmachinery:space_elevator_controller>,    // 预览物品
        14.1,                                 // 科技等级（难度）
        500000000,                          // 需要科研点
        500000.0F,                               // 最低每 Tick 算力要求
        [
            "进一步改造太空电梯,使太空电梯的产能加强",
        ],
        [
            "§2解锁集成式处理车间配方:§B太空电梯mk4集成控制器",
        ],
        [
            "SE_tech7",
            "starburst_reactor",
            "assembly_line",                      // 前置科技
        ] 
));

RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("G_MA", "§k巨构计划§k§k§k§k:魔力聚合机",<modularmachinery:space_elevator_controller>,    // 预览物品
        12,                                 // 科技等级（难度）
        50000000,                          // 需要科研点
        50000.0F,                               // 最低每 Tick 算力要求
        [
            "没写完捏。",
        ],
        [
            "§2解锁集成式处理车间配方:§B魔力聚合机ProMax+集成控制器",
        ],
        [
            "starburst_reactor",
            "assembly_line",                      // 前置科技
        ] 
));

//==============================巨型合金炉==============================
RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("G_AF", "§k巨构计划§k§k§k§k:合金炉",<modularmachinery:space_elevator_controller>,    // 预览物品
        14,                                 // 科技等级（难度）
        50000000,                          // 需要科研点
        50000.0F,                               // 最低每 Tick 算力要求
        [
            "你说得对,但是这是绝望的温度!",
            "通过无尽线圈加热物质至彻底融合",
        ],
        [
            "§2解锁集成式处理车间配方:§B这是绝望的温度!集成控制器",
        ],
        [
            "starburst_reactor",
            "assembly_line",                      // 前置科技
        ] 
));

RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("ODAL_1", "§k星陨计划§k§k§k§k:超维度装配线:理论研究",<modularmachinery:gshag_controller>,    // 预览物品
        14.1,                                 // 科技等级（难度）
        250000000,                          // 需要科研点
        500000.0F,                               // 最低每 Tick 算力要求
        [
            "没写完",
        ],
        [
            "§2解锁科技§k星陨计划§k§k§k§k:超维度装配线",
        ],
        [
            "eco_y7",
            "assembly_line",
            "tokmak_reactor",
            "DPTF_2",                               // 前置科技
        ]
));


RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("ODAL_2", "§k星陨计划§k§k§k§k:超维度装配线",<modularmachinery:gshag_controller>,    // 预览物品
        14.1,                                 // 科技等级（难度）
        250000000,                          // 需要科研点
        500000.0F,                               // 最低每 Tick 算力要求
        [
            "没写完",
        ],
        [
            "§2解锁集成式处理车间配方:超维度装配线",
        ],
        [
            "eco_y7",
            "assembly_line",
            "tokmak_reactor",
            "ODAL_1",                               // 前置科技
        ]
));


RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("DPTF_0", "§k巨构计划§k§k§k§k:完成",<modularmachinery:gshag_controller>,    // 预览物品
        14.1,                                 // 科技等级（难度）
        250000000,                          // 需要科研点
        500000.0F,                               // 最低每 Tick 算力要求
        [
            "在太空电梯建设完成后",
            "巨构计划理事会宣布了巨构计划的圆满完成",
            "但我们不能止步于此",
            "星陨计划被提出的那一刻", 
            "就代表我们已经无法在前进的路上停止了",
        ],
        [
            "§2解锁科技§k星陨计划§k§k§k§k:过渡",
        ],
        [
            "eco_y7",
            "assembly_line",
            "tokmak_reactor",                               // 前置科技
        ]
));

RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("DPTF_1", "§k星陨计划§k§k§k§k:过渡",<modularmachinery:gshag_controller>,    // 预览物品
        14.1,                                 // 科技等级（难度）
        250000000,                          // 需要科研点
        500000.0F,                               // 最低每 Tick 算力要求
        [
            "巨构计划已经无法满足我们的需求",
            "我们必须前进",
            "自诞生起,探索欲就无法控制",
            "现在,我们完成了巨构计划",
            "我们必须前进!",
        ],
        [
            "§2解锁科技:§k星陨计划§k§k§k§k:第一步",
        ],
        [
            "eco_y7",
            "assembly_line",
            "tokmak_reactor",
            "DPTF_0",                               // 前置科技
        ]
));

RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("DPTF_2", "§k星陨计划§k§k§k§k:第一步",<modularmachinery:gshag_controller>,    // 预览物品
        14.1,                                 // 科技等级（难度）
        250000000,                          // 需要科研点
        500000.0F,                               // 最低每 Tick 算力要求
        [
            "巨构计划已经无法满足我们的需求",
            "我们必须前进",
            "自诞生起,探索欲就无法控制",
            "现在,我们完成了巨构计划",
            "我们必须前进!",
        ],
        [
            "§2解锁科技:§k星陨计划§k§k§k§k:超维度装配线:理论研究",
            "§2解锁科技:§k星陨计划§k§k§k§k:超维度等离子锻炉:理论研究",
        ],
        [
            "eco_y7",
            "assembly_line",
            "tokmak_reactor",
            "DPTF_1",                               // 前置科技
        ]
));

RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("DPTF_2", "§k星陨计划§k§k§k§k:超维度等离子锻炉:理论研究",<modularmachinery:gshag_controller>,    // 预览物品
        14.1,                                 // 科技等级（难度）
        250000000,                          // 需要科研点
        500000.0F,                               // 最低每 Tick 算力要求
        [
            "没写完",
        ],
        [
            "§2解锁科技:§k星陨计划§k§k§k§k:超维度等离子锻炉:材料",
        ],
        [
            "eco_y7",
            "assembly_line",
            "tokmak_reactor",
            "DPTF_1",                               // 前置科技
        ]
));

RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("DPTF_3", "§k星陨计划§k§k§k§k:超维度等离子锻炉:材料",<modularmachinery:gshag_controller>,    // 预览物品
        14.1,                                 // 科技等级（难度）
        250000000,                          // 需要科研点
        500000.0F,                               // 最低每 Tick 算力要求
        [
            "没写完",
        ],
        [
            "§2解锁科技:§k星陨计划§k§k§k§k:超维度等离子锻炉:图纸",
        ],
        [
            "eco_y7",
            "assembly_line",
            "tokmak_reactor",
            "DPTF_2",                               // 前置科技
        ]
));

RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("DPTF_4", "§k星陨计划§k§k§k§k:超维度等离子锻炉:图纸",<modularmachinery:gshag_controller>,    // 预览物品
        14.1,                                 // 科技等级（难度）
        250000000,                          // 需要科研点
        500000.0F,                               // 最低每 Tick 算力要求
        [
            "没写完",
        ],
        [
            "§2解锁科技:§k星陨计划§k§k§k§k:超维度等离子锻炉:测试",
        ],
        [
            "eco_y7",
            "assembly_line",
            "tokmak_reactor",
            "DPTF_3",                               // 前置科技
        ]
));

RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("DPTF_5", "§k星陨计划§k§k§k§k:超维度等离子锻炉:测试",<modularmachinery:gshag_controller>,    // 预览物品
        14.1,                                 // 科技等级（难度）
        250000000,                          // 需要科研点
        500000.0F,                               // 最低每 Tick 算力要求
        [
            "没写完",
        ],
        [
            "§2解锁科技:§k星陨计划§k§k§k§k:超维度等离子锻炉:无限潜力",
        ],
        [
            "eco_y7",
            "assembly_line",
            "tokmak_reactor",
            "DPTF_4",                               // 前置科技
        ]
));

RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("DPTF_6", "§k星陨计划§k§k§k§k:超维度等离子锻炉:无限潜力",<modularmachinery:gshag_controller>,    // 预览物品
        14.1,                                 // 科技等级（难度）
        250000000,                          // 需要科研点
        500000.0F,                               // 最低每 Tick 算力要求
        [
            "没写完",
        ],
        [
            "§2解锁科技:§k星陨计划§k§k§k§k:超维度等离子锻炉:初版",
        ],
        [
            "eco_y7",
            "assembly_line",
            "tokmak_reactor",
            "DPTF_5",                               // 前置科技
        ]
));

RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("DPTF_7", "§k星陨计划§k§k§k§k:超维度等离子锻炉:初版",<modularmachinery:gshag_controller>,    // 预览物品
        14.1,                                 // 科技等级（难度）
        250000000,                          // 需要科研点
        500000.0F,                               // 最低每 Tick 算力要求
        [
            "没写完",
        ],
        [
            "§2解锁科技:§k星陨计划§k§k§k§k:超维度等离子锻炉",
        ],
        [
            "eco_y7",
            "assembly_line",
            "tokmak_reactor",
            "DPTF_6",                               // 前置科技
        ]
));

RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("DPTF_8", "§k星陨计划§k§k§k§k:超维度等离子锻炉",<modularmachinery:gshag_controller>,    // 预览物品
        14.1,                                 // 科技等级（难度）
        250000000,                          // 需要科研点
        500000.0F,                               // 最低每 Tick 算力要求
        [
            "没写完",
        ],
        [
            "§2解锁集成式处理车间配方超维度等离子锻炉",
        ],
        [
            "eco_y7",
            "assembly_line",
            "tokmak_reactor",
            "DPTF_7",                               // 前置科技
        ]
));
RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("networkcenter_mk4", "§k星陨计划§k§k§k§k:时空计算阵列",<modularmachinery:gshag_controller>,    // 预览物品
        14.1,                                 // 科技等级（难度）
        250000000,                          // 需要科研点
        500000.0F,                               // 最低每 Tick 算力要求
        [
            "没写完",
        ],
        [
            "§2解锁集成式处理车间配方:§bHyperNet §5计算网络中心（等级 4）",
        ],
        [
            "eco_y7",
            "assembly_line",
            "tokmak_reactor",
            "DPTF_1",                               // 前置科技
        ]
));
RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("qft_1", "§k星陨计划§k§k§k§k:量子异常",<modularmachinery:gshag_controller>,    // 预览物品
        14.1,                                 // 科技等级（难度）
        250000000,                          // 需要科研点
        500000.0F,                               // 最低每 Tick 算力要求
        [
            "没写完",
        ],
        [
            "§2啥也没解锁",
        ],
        [
            "eco_y7",
            "assembly_line",
            "tokmak_reactor",
            "DPTF_1",                               // 前置科技
        ]
));
RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("qft_2", "§k星陨计划§k§k§k§k:量子物质实现可能",<modularmachinery:gshag_controller>,    // 预览物品
        14.1,                                 // 科技等级（难度）
        250000000,                          // 需要科研点
        500000.0F,                               // 最低每 Tick 算力要求
        [
            "没写完",
        ],
        [
            "§2啥也没解锁",
        ],
        [
            "eco_y7",
            "assembly_line",
            "tokmak_reactor",
            "qft_1",                               // 前置科技
        ]
));
RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("qft_3", "§k星陨计划§k§k§k§k:量子异常稳定态",<modularmachinery:gshag_controller>,    // 预览物品
        14.1,                                 // 科技等级（难度）
        250000000,                          // 需要科研点
        500000.0F,                               // 最低每 Tick 算力要求
        [
            "没写完",
        ],
        [
            "§2啥也没解锁",
        ],
        [
            "eco_y7",
            "assembly_line",
            "tokmak_reactor",
            "qft_2",                               // 前置科技
        ]
));
RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("qft_4", "§k星陨计划§k§k§k§k:量子操控者",<modularmachinery:gshag_controller>,    // 预览物品
        14.1,                                 // 科技等级（难度）
        250000000,                          // 需要科研点
        500000.0F,                               // 最低每 Tick 算力要求
        [
            "没写完",
        ],
        [
            "§2解锁集成式处理车间配方:§1量子操控者",
        ],
        [
            "eco_y7",
            "assembly_line",
            "tokmak_reactor",
            "qft_3",                               // 前置科技
        ]
));
RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("dsp_1", "§k星陨计划§k§k§k§k:悖论",<modularmachinery:gshag_controller>,    // 预览物品
        14.1,                                 // 科技等级（难度）
        250000000,                          // 需要科研点
        500000.0F,                               // 最低每 Tick 算力要求
        [
            "没写完喵",
        ],
        [
            "§2啥也没解锁",
        ],
        [
            "ODAL_2",
            "DPTF_8",
            "qft_4",                               // 前置科技
        ]
));
RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("dsp_2", "§k星陨计划§k§k§k§k:虚空裂隙",<modularmachinery:gshag_controller>,    // 预览物品
        14.1,                                 // 科技等级（难度）
        250000000,                          // 需要科研点
        500000.0F,                               // 最低每 Tick 算力要求
        [
            "没写完喵",
        ],
        [
            "§2啥也没解锁",
        ],
        [
            "dsp_1",                               // 前置科技
        ]
));
RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("dsp_3", "§k星陨计划§k§k§k§k:四维空间初步探索",<modularmachinery:gshag_controller>,    // 预览物品
        14.1,                                 // 科技等级（难度）
        250000000,                          // 需要科研点
        500000.0F,                               // 最低每 Tick 算力要求
        [
            "没写完喵",
        ],
        [
            "§2啥也没解锁",
        ],
        [
             "dsp_2",                                // 前置科技
        ]
));
RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("dsp_4", "§k星陨计划§k§k§k§k",<modularmachinery:gshag_controller>,    // 预览物品
        14.1,                                 // 科技等级（难度）
        250000000,                          // 需要科研点
        500000.0F,                               // 最低每 Tick 算力要求
        [
            "没写完喵",
        ],
        [
            "§2现在可以量产矩阵了",
        ],
        [
             "dsp_3",                                // 前置科技
        ]
));
RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("ae_gtlite_cell", "奇点级存储实现可能",<modularmachinery:gshag_controller>,    // 预览物品
        14.1,                                 // 科技等级（难度）
        250000000,                          // 需要科研点
        500000.0F,                               // 最低每 Tick 算力要求
        [
            "§f随着产能的逐渐爆炸§c§m扣0§f,eco实验室与巨构计划理事会联合设计了一种新型元件,它的主要结构被封装在无限小的奇点当中,但是由于奇点的特质,每个奇点原件仅仅能存储一种物品",
        ],
        [
            "§2解锁超时空装配线配方:ME数字奇点存储元件",
        ],
        [
             "SE_tech5",                                // 前置科技
        ]
));
RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("xhqj_start", "§k星河奇迹§k§k§k§k:过渡",<modularmachinery:gshag_controller>,    // 预览物品
        14.1,                                 // 科技等级（难度）
        250000000,                          // 需要科研点
        500000.0F,                               // 最低每 Tick 算力要求
        [
            "自从星陨计划结束之后,我们已然达到二级文明的巅峰——彻底掌控整个恒星系的资源",
            "§c四方上下曰宇，古往今来曰宙。时空为针，质能为缕，逍遥御风，今朝而始",
        ],
        [
            "时空为针,质能为缕,我们将完成对「世界」的编织",
        ],
        [
             "dsp_4",                                // 前置科技
        ]
));
RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("xhqj_start1", "§k星河奇迹§k§k§k§k:时空科技",<modularmachinery:gshag_controller>,    // 预览物品
        14.1,                                 // 科技等级（难度）
        250000000,                          // 需要科研点
        500000.0F,                               // 最低每 Tick 算力要求
        [
            "前进是时代的必然,但在当前的状况下,我们应该首先思考如何发展科技,'星陨计划理事会'在对太空电梯从异世界带来的神秘材料——§8时空连续体碎片§f进行研究后发现了时空科技的存在,也许我们应该向这方面发展",
        ],
        [
            "时空为针,质能为缕,我们将完成对「世界」的编织",
        ],
        [
             "xhqj_start",                                // 前置科技
        ]
));
RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("xhqj_start2", "§k星河奇迹§k§k§k§k:时空碎片初级研究",<modularmachinery:gshag_controller>,    // 预览物品
        14.1,                                 // 科技等级（难度）
        250000000,                          // 需要科研点
        500000.0F,                               // 最低每 Tick 算力要求
        [
            "eco实验室对§8时空连续体碎片§f做了各种测试,奇怪的是,这种碎片不会与任何已知元素进行反应,甚至面对毁灭性打击也毫发无损,也许我们应该将它作为主要材料",
        ],
        [
            "时空为针,质能为缕,我们将完成对「世界」的编织",
        ],
        [
             "xhqj_start1",                                // 前置科技
        ]
));
RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("xhqj_kysn", "§k星河奇迹§k§k§k§k:科学枢纽",<modularmachinery:gshag_controller>,    // 预览物品
        14.1,                                 // 科技等级（难度）
        250000000,                          // 需要科研点
        500000.0F,                               // 最低每 Tick 算力要求
        [
            "在第315次实验后,eco实验室发现时空物质聚合体与宇宙矩阵相结合可以产生100E的算力,也许我们可以制造科学枢纽来发挥它们的作用",
        ],
        [
            "时空为针,质能为缕,我们将完成对「世界」的编织",
            "珍惜一下吧,这是最后一个难度为14.1的科技",
        ],
        [
             "xhqj_start1",                                // 前置科技
        ]
));
RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("xhqj_end", "§k星河奇迹§k§k§k§k:时空科技彻底研究",<modularmachinery:gshag_controller>,    // 预览物品
        16,                                 // 科技等级（难度）
        250000000,                          // 需要科研点
        10000 * 1000.0F,                               // 最低每 Tick 算力要求
        [
            "在第782次实验后,eco实验室对时空碎片释放了高达100E的算力,使时空碎片开始高速旋转,eco实验室想将其捕获,但时空碎片瞬移到了太空并迅速展开,展开后eco实验室派出第一编队进行围剿,在内部竟然发现了nova的头像!众人大惊,迅速将研究成果待会实验室",
        ],
        [
            "时空为针,质能为缕,我们将完成对「世界」的编织",
        ],
        [
             "xhqj_kysn",                                // 前置科技
        ]
));
RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("xhqj", "§k星河奇迹§k§k§k§k",<modularmachinery:gshag_controller>,    // 预览物品
        18,                                 // 科技等级（难度）
        250000000,                          // 需要科研点
        10000 * 1000.0F,                               // 最低每 Tick 算力要求
        [
            "这是一张大饼,一张神秘的大饼,这个科技用来解锁举星者 物质解压器和红矮星衰变加速器,什么,你问最后一个有什么用,当然是我没写好,等3.5~4.0会写的",
        ],
        [
            "时空为针,质能为缕,我们将完成对「世界」的编织",
        ],
        [
             "xhqj_end",                                // 前置科技
        ]
));
RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("final_tech_test", "多元宇宙航行理论",<modularmachinery:gshag_controller>,    // 预览物品
        21,                                 // 科技等级（难度）
        250000000,                          // 需要科研点
        10000 * 1000.0F,                               // 最低每 Tick 算力要求
        [
            "'快要完成了吧'",
            "'是的,距离那东西只差一点了'",
            "'好,把他们全都上市!'",
            "'这是帝国最后的荣耀'",
        ],
        [
            "时空为针,质能为缕,我们将完成对「世界」的编织",
            "玩到这里也是神人了,感谢你玩这么神经的私货",
        ],
        [
             "xhqj",                                // 前置科技
        ]
));
RegistryHyperNet.addResearchCognitionData(ResearchCognitionData.create("final_tech", "讴歌之终结万物",<modularmachinery:gshag_controller>,    // 预览物品
        21,                                 // 科技等级（难度）
        250000000,                          // 需要科研点
        10000 * 1000.0F,                               // 最低每 Tick 算力要求
        [
            "§c帝国最后的荣耀,终于在星海帝国成立后的10^9次方宇宙年后被研究出来,我们真正掌握了整个宇宙并研究了多元宇宙航行理论的要点——奇迹顶点",
            "§c奇迹顶点是一种建造在2^31-1维——即宇宙终点的超级巨构,他可以制造一种性质即为奇怪的AE2磁盘——这种磁盘可以在瞬间产生近乎无限的资源",
            "§c而多元宇宙的航行需要近乎无限的补给,这种磁盘适于便携,及其适合多元宇宙航行",
            "§c现在——让我们——来——§1重§2铸§3帝§4国§5荣§6光!",
        ],
        [
            "§d我们以嫣然站在星海之巅,真正的达到了前无古人后无来者,现在我们可以建造时代的终焉——奇迹顶点了",
            "§d我们的征途是星辰大海!",
            "我是不是忘了有千兆零素锻造厂这个东西了",
            "算了不管了,完结!!!!!",
            "Ciallo～(∠・ω< )⌒★",
        ],
        [
             "final_tech_test",                                // 前置科技
        ]
));