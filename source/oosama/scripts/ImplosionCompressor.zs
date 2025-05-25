#priority 50
#loader crafttweaker reloadable

import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.FactoryRecipeStartEvent;
import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.MachineTickEvent;


import mods.modularmachinery.SmartInterfaceType;

import mods.modularmachinery.MMEvents;

import novaeng.hypernet.HyperNetHelper;


//内置并行设置
MachineModifier.setInternalParallelism("ImplosionCompressor", 32);

//工厂线程设置
MachineModifier.setMaxThreads("ImplosionCompressor", 8);


var recipeCounter = 1;  // 配方优先级

//聚爆压缩机控制器
RecipeBuilder.newBuilder("ImplosionCompressor1", "machine_arm", 2400)
    .addEnergyPerTickInput(128000)
    .addInputs(<modularmachinery:blockcasing> * 4)  // 机械外壳
    .addInputs(<ic2:te:55> * 4)  // 压缩机
    .addInputs(<minecraft:tnt>*64)  //TNT
    .addInputs(<ic2:te:43> * 4)  // 金属成型机
    .addInputs(<mekanism:controlcircuit:2>* 4)  // 精英电路板
    .addInputs(<ic2:crafting:6>* 8)
    .addOutputs(<modularmachinery:implosioncompressor_controller> * 1) 
    .build();


//聚爆压缩机集成控制器
RecipeBuilder.newBuilder("ImplosionCompressor2", "machine_arm", 2400)
    .addEnergyPerTickInput(128000)
    .addInputs(<modularmachinery:blockcasing> * 16)  // 机械外壳
    .addInputs(<modularmachinery:implosioncompressor_controller> * 4)  // 普通控制器
    .addInputs(<mekanism:controlcircuit:2>* 16)  // 精英电路板
    .addInputs(<ic2:crafting:6>* 8)
    .addOutputs(<modularmachinery:implosioncompressor_factory_controller> * 1) 
    .build();



//高级合金
RecipeBuilder.newBuilder("gaojihejinzhizuo", "ImplosionCompressor", 2)

    .addEnergyPerTickInput(14400) //电
    .addInput(<ic2:ingot>*1)  //合金锭
    .addItemOutput(<ic2:crafting:3>*1)
        .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
        ]

    ).setChance(0.1)
    .build();

//铱矿石制作
RecipeBuilder.newBuilder("yikuangshizhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addInput(<thermalfoundation:material:135>)  //TE的铱锭
    .addItemOutput(<ic2:misc_resource:1>)
    .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
    [
    RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
    ]
    ).setChance(0.1)
    .build();

//制作钛柄
RecipeBuilder.newBuilder("taibingzhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addInput(<libvulpes:metal0:7>)
    .addItemOutput(<mets:titanium_shaft>)
    .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
        ]

    ).setChance(0.1)
    .build();

//钢棒制作
RecipeBuilder.newBuilder("gangbanbgzhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addInput(<thermalfoundation:storage_alloy>) //钢块
    .addItemOutput(<ic2:crafting:30>)
        .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
    [
    RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
    ]
    ).setChance(0.1)
    .build();

//青铜棒制作
RecipeBuilder.newBuilder("qingtongbangzhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addInput(<thermalfoundation:storage_alloy:3>) //青铜块
    .addItemOutput(<ic2:crafting:42>)
        .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
    [
    RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
    ]
    ).setChance(0.1)
    .build();

//铁柄制作
RecipeBuilder.newBuilder("tiebingzhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addInput(<minecraft:iron_block>) //铁块
    .addItemOutput(<ic2:crafting:29>)
        .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
    [
    RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
    ]
    ).setChance(0.1)
    .build();

//制作铁栅栏（小小栅栏居然如此麻烦）
RecipeBuilder.newBuilder("tiezhalanzhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addInput(<thermalfoundation:material:32>) //铁外壳
    .addItemOutput(<ic2:fence>*5)
        .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
    [
    RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
    ]
    ).setChance(0.1)
    .build();

//制作致密铱板
RecipeBuilder.newBuilder("zhimiyibanzhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addInput(<mets:super_iridium_alloy>*3) //致密铱合金
    .addItemOutput(<mets:super_iridium_compress_plate>)
        .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
    [
    RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
    ]
    ).setChance(0.1)
    .build();

//制作NT合金板
RecipeBuilder.newBuilder("nthejinbanzhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addInput(<mets:niobium_titanium_ingot>) //NT合金
    .addItemOutput(<mets:niobium_titanium_plate>)
        .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
    [
    RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
    ]
    ).setChance(0.1)
    .build();


//制作线材
RecipeBuilder.newBuilder("xc1zhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addInput(<ore:ingotCopper>)  //铜锭
    .addItemOutput(<ic2:cable>.withTag({type: 0 as byte, insulation: 0 as byte})*4)
        .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
    [
    RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
    ]
    ).setChance(0.1)
    .build();

//制作线材
RecipeBuilder.newBuilder("xc2zhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addInput(<minecraft:gold_ingot>)  //金锭
    .addItemOutput(<ic2:cable:2>.withTag({type: 2 as byte, insulation: 0 as byte})*4)
        .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
    [
    RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
    ]
    ).setChance(0.1)
    .build();

//制作线材
RecipeBuilder.newBuilder("xc3zhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addInput(<minecraft:iron_ingot>)  //铁锭
    .addItemOutput(<ic2:cable:3>.withTag({type: 3 as byte, insulation: 0 as byte})*4)
        .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
    [
    RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
    ]
    ).setChance(0.1)
    .build();

//制作线材
RecipeBuilder.newBuilder("xc4zhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addInput(<thermalfoundation:material:129>)  //锡锭
    .addItemOutput(<ic2:cable:4>.withTag({type: 4 as byte, insulation: 0 as byte})*4)
        .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
    [
    RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
    ]
    ).setChance(0.1)
    .build();
    
//制作高级铱板
RecipeBuilder.newBuilder("gaojiyibanzhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addInput(<thermalfoundation:material:135>*9)  //铱锭
    .addItemOutput(<super_solar_panels:crafting:41>)
    .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
    [
    RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
    ]
    ).setChance(0.1)
    .build();    

//制作压缩高级铱板
RecipeBuilder.newBuilder("gaojiyibanzhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addInput(<super_solar_panels:crafting:41>*9)  //高级铱板
    .addItemOutput(<super_solar_panels:crafting:43>)
    .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
    [
    RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
    ]
    ).setChance(0.1)
    .build();


//制作能量水晶
RecipeBuilder.newBuilder("nlsjzhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addInput(<ic2:dust:6>*9)  //能量水晶粉
    .addItemOutput(<ic2:energy_crystal>)
        .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
    [
    RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
    ]
    ).setChance(0.1)
    .build();    

//制作外壳
RecipeBuilder.newBuilder("wk1zhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addInput(<thermalfoundation:material:355>)  //qtb
    .addItemOutput(<ic2:casing>*2)
        .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
    [
    RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
    ]
    ).setChance(0.1)
    .build();

//制作外壳
RecipeBuilder.newBuilder("wk2zhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addInput(<thermalfoundation:material:320>)  //tb
    .addItemOutput(<ic2:casing:1>*2)
        .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
    [
    RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
    ]
    ).setChance(0.1)
    .build();

//制作外壳
RecipeBuilder.newBuilder("wk3zhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addInput(<thermalfoundation:material:33>)  //jb
    .addItemOutput(<ic2:casing:2>*2)
        .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
    [
    RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
    ]
    ).setChance(0.1)
    .build();

//制作外壳
RecipeBuilder.newBuilder("wk4zhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addInput(<thermalfoundation:material:32>)  //tb
    .addItemOutput(<ic2:casing:3>*2)
        .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
    [
    RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
    ]
    ).setChance(0.1)
    .build();

//制作外壳
RecipeBuilder.newBuilder("wk5zhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addInput(<thermalfoundation:material:323>)  //qb
    .addItemOutput(<ic2:casing:4>*2)
        .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
    [
    RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
    ]
    ).setChance(0.1)
    .build();

//制作外壳
RecipeBuilder.newBuilder("wk6zhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addInput(<thermalfoundation:material:352>)  //gb
    .addItemOutput(<ic2:casing:5>*2)
        .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
    [
    RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
    ]
    ).setChance(0.1)
    .build();

//制作外壳
RecipeBuilder.newBuilder("wk7zhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addInput(<thermalfoundation:material:321>)  //xb
    .addItemOutput(<ic2:casing:6>*2)
        .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
    [
    RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
    ]
    ).setChance(0.1)
    .build();

//制作钛板（3种钛）
RecipeBuilder.newBuilder("taibanzhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addIngredientArrayInput(
     IngredientArrayBuilder.newBuilder()
        .addIngredients([
           <techguns:itemshared:85>,  // 1
           <libvulpes:productingot:7>,  // 2
           <mets:titanium_ingot>,  // 3
        ])
        )
        .addItemOutput(<mets:titanium_plate>)
        .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
        ]

    ).setChance(0.1)
    .build();

//制作外壳（3种钛）
RecipeBuilder.newBuilder("taiwaikezhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addIngredientArrayInput(
     IngredientArrayBuilder.newBuilder()
        .addIngredients([
            <techguns:itemshared:54>,  // 1
            <libvulpes:productplate:7>,  // 2
            <mets:titanium_plate>,  // 3
        ])
        )
        .addItemOutput(<mets:titanium_casing>*2)
        .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
        ]

    ).setChance(0.1)
    .build();

//制作光合锭
RecipeBuilder.newBuilder("ghdzhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addInput(<super_solar_panels:crafting:52>*9)  //ghwz
    .addItemOutput(<super_solar_panels:crafting:51>)
        .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
    [
    RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
    ]
    ).setChance(0.1)
    .build();

//制作压缩碳板
RecipeBuilder.newBuilder("yasuotanbanzhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addInput(<ic2:crafting:15>*9)  //碳板
    .addItemOutput(<super_solar_panels:crafting:45>)
        .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
    [
    RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
    ]
    ).setChance(0.1)
    .build();

//制作中子
RecipeBuilder.newBuilder("zhongzizhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addInput(<super_solar_panels:crafting:28>*9)  //中子碎片
    .addItemOutput(<super_solar_panels:crafting:29>)
        .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
    [
    RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
    ]
    ).setChance(0.1)
    .build();

//制作质子碎片
RecipeBuilder.newBuilder("zhizisuipianzhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addInput(<ic2:nuclear:3>)  //环
    .addItemOutput(<super_solar_panels:crafting:26>)
        .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
    [
    RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
    ]
    ).setChance(0.1)
    .build();

//制作质子
RecipeBuilder.newBuilder("zhizizhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addInput(<super_solar_panels:crafting:26>*18)  //ghwz
    .addItemOutput(<super_solar_panels:crafting:27>)
        .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
    [
    RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
    ]
    ).setChance(0.1)
    .build();

//制作空气单元
RecipeBuilder.newBuilder("kongqidanyuanzhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addInput(<ic2:fluid_cell>)  //空的流体单元
    .addItemOutput(<ic2:fluid_cell>.withTag({Fluid: {FluidName: "ic2air", Amount: 1000}}))
    .build();

//制作光压缩煤球
RecipeBuilder.newBuilder("yasuomeiqiuzhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addInput(<ic2:crafting:16>)  //煤球
    .addItemOutput(<ic2:crafting:17>)
        .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
    [
    RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
    ]
    ).setChance(0.1)
    .build();

//制作工业钻石
RecipeBuilder.newBuilder("gongyezuanszhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addInput(<ic2:crafting:18>)  //煤球
    .addItemOutput(<ore:gemDiamond>)
        .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
    [
    RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
    ]
    ).setChance(0.1)
    .build();

    //制作充能板
RecipeBuilder.newBuilder("chongnengbanzi1zhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addInput(<actuallyadditions:block_crystal_empowered:1>)  //充能青金石块
    .addItemOutput(<moreplates:empowered_palis_plate>*9)
        .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
    [
    RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
    ]
    ).setChance(0.1)
    .build();

        //制作充能板
RecipeBuilder.newBuilder("chongnengbanzi2zhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addInput(<actuallyadditions:block_crystal_empowered>)  //充能红石块
    .addItemOutput(<moreplates:empowered_restonia_plate>*9)
        .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
    [
    RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
    ]
    ).setChance(0.1)
    .build();

        //制作充能板
RecipeBuilder.newBuilder("chongnengbanzi3zhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addInput(<actuallyadditions:block_crystal_empowered:5>)  //充能铁块
    .addItemOutput(<moreplates:empowered_enori_plate>*9)
        .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
    [
    RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
    ]
    ).setChance(0.1)
    .build();

        //制作充能板
RecipeBuilder.newBuilder("chongnengbanzi4zhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addInput(<actuallyadditions:block_crystal_empowered:3>)  //充能煤块
    .addItemOutput(<moreplates:empowered_void_plate>*9)
        .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
    [
    RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
    ]
    ).setChance(0.1)
    .build();
        //制作充能板
RecipeBuilder.newBuilder("chongnengbanzi5zhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addInput(<actuallyadditions:block_crystal_empowered:4>)  //充能绿宝石块
    .addItemOutput(<moreplates:empowered_emeradic_plate>*9)
        .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
    [
    RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
    ]
    ).setChance(0.1)
    .build();
        //制作充能板
RecipeBuilder.newBuilder("chongnengbanzi6zhizuo", "ImplosionCompressor", 2)
    .addEnergyPerTickInput(14400) //电
    .addInput(<actuallyadditions:block_crystal_empowered:2>)  //充能钻石块
    .addItemOutput(<moreplates:empowered_diamatine_plate>*9)
        .addCatalystInput(<minecraft:tnt> * 1,  // TNT
        ["爆炸就是艺术！","此催化剂可以使产量提高100%"],
    [
    RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
    ]
    ).setChance(0.1)
    .build();
