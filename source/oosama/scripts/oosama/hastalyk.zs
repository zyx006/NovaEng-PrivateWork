#priority 10
#loader crafttweaker reloadable
import mods.modularmachinery.MMEvents;
import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.MachineBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.FactoryRecipeStartEvent;
import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.MachineTickEvent;
import mods.modularmachinery.SmartInterfaceType;
import mods.modularmachinery.Sync;

import crafttweaker.world.IBlockPos;
import crafttweaker.world.IWorld;
import crafttweaker.item.IItemStack;
import crafttweaker.data.IData;
import crafttweaker.item.IIngredient;
import crafttweaker.oredict.IOreDictEntry;
import crafttweaker.liquid.ILiquidStack;
import crafttweaker.item.WeightedItemStack;
import mod.mekanism.gas.IGasStack;
import mods.astralsorcery.Altar;
import crafttweaker.item.IWeightedIngredient;

import novaeng.NovaEngUtils;
import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.ComputationCenter;
import novaeng.hypernet.ComputationCenterType;
import novaeng.hypernet.ComputationCenterCache;

import novaeng.hypernet.upgrade.type.ProcessorModuleCPUType;
import novaeng.hypernet.upgrade.type.ProcessorModuleGPUType;
import novaeng.hypernet.upgrade.type.ProcessorModuleRAMType;

//工厂线程设置
MachineModifier.setMaxThreads("hastalyk", 0);


// 微生物支配者集成控制器
RecipeBuilder.newBuilder("hastalyk_controller", "workshop", 300)
    .addEnergyPerTickInput(100000)
    .addInputs([
        <contenttweaker:industrial_circuit_v3> * 8,
        <contenttweaker:electric_motor_v3> * 8,
        <contenttweaker:sensor_v3> * 16,
        <modularmachinery:blockcasing:4>,
        //<mets:te:4> * 8,
    ])
    .addOutput(<modularmachinery:hastalyk_controller>)
    .build();

//定义GUI
MachineModifier.addCoreThread("hastalyk", FactoryRecipeThread.createCoreThread("§2液态魔力").addRecipe("hastalyk_mana"));
MachineModifier.addCoreThread("hastalyk", FactoryRecipeThread.createCoreThread("§4生命本源").addRecipe("hastalyk_sm"));
MachineModifier.addCoreThread("hastalyk", FactoryRecipeThread.createCoreThread("§e星光之力").addRecipe("hastalyk_xn"));
MachineModifier.addCoreThread("hastalyk", FactoryRecipeThread.createCoreThread("§1工业基础").addRecipe("hastalyk_gy"));
MachineModifier.addCoreThread("hastalyk", FactoryRecipeThread.createCoreThread("生产序列").addRecipe("hastalyk_pro_0"));
MachineModifier.addCoreThread("hastalyk", FactoryRecipeThread.createCoreThread("生产序列").addRecipe("hastalyk_pro_a"));
MachineModifier.addCoreThread("hastalyk", FactoryRecipeThread.createCoreThread("生产序列").addRecipe("hastalyk_pro_b"));


// 液态魔力
RecipeBuilder.newBuilder("hastalyk_mana", "hastalyk", 10)
    .addFluidInput(<fluid:fluidedmana>*10)
    .addRecipeTooltip([
        "§a使用魔力引发畸变"
    ])
    
    .build();


// 生命本源
RecipeBuilder.newBuilder("hastalyk_sm", "hastalyk", 10)
    .addFluidInput(<liquid:lifeessence>*10)
    .addRecipeTooltip([
        "§a引入血液激发反应"
    ])
    
    .build();


// 星能液
RecipeBuilder.newBuilder("hastalyk_xn", "hastalyk", 10)
    .addFluidInput(<liquid:astralsorcery.liquidstarlight>*10)
    .addRecipeTooltip([
        "§a探求星能趋于稳定"
    ])
    
    .build();

// 硫酸
RecipeBuilder.newBuilder("hastalyk_gy", "hastalyk", 10)
    .addFluidInput(<liquid:sulfuric_acid>*10)
    .addRecipeTooltip([
        "§a落实工业奠定基础"
    ])
    
    .build();

// 编程电路0配方
RecipeBuilder.newBuilder("hastalyk_pro_0", "hastalyk", 1)
.addInput(<minecraft:stone>*64)
.addEnergyPerTickInput(32000)
.addFluidInput(<liquid:sulfuric_acid>*10)
.addFluidInput(<liquid:astralsorcery.liquidstarlight>*10)
.addFluidInput(<liquid:lifeessence>*10)
.addFluidInput(<fluid:fluidedmana>*10)
.addInput(<contenttweaker:programming_circuit_0>).setChance(0)
.addItemOutput(<draconicevolution:draconium_ore> * 64).setChance(0.054) // 龙矿
.addItemOutput(<thermalfoundation:ore_fluid:4> * 64).setChance(0.00104) // 谐振末影矿
.addItemOutput(<taiga:palladium_ore> * 64).setChance(0.000113) // 钯
.addItemOutput(<taiga:aurorium_ore> * 64).setChance(0.000175) // 极光金属
.addItemOutput(<taiga:abyssum_ore> * 64).setChance(0.00523) // 深渊金属
.addItemOutput(<taiga:duranite_ore> * 64).setChance(0.000332) // 杜兰蒂
.addItemOutput(<taiga:uru_ore> * 64).setChance(0.00234) // 乌鲁
.addItemOutput(<taiga:osram_ore> * 64).setChance(0.000332) // 熔晶
.addItemOutput(<minecraft:quartz_ore> * 64).setChance(0.0991) // 下界石英
.addItemOutput(<taiga:tiberium_ore> * 64).setChance(0.2567) // 泰伯利亚
.addItemOutput(<taiga:prometheum_ore> * 64).setChance(0.00261) // 奎摩矿石
.addItemOutput(<taiga:valyrium_ore> * 64).setChance(0.000507) // 瓦雷利亚
.addItemOutput(<tconstruct:ore> * 64).setChance(0.0119) // 钴
.addItemOutput(<tconstruct:ore:1> * 64).setChance(0.0116) // 阿迪特
.addItemOutput(<futuremc:ancient_debris> * 64).setChance(0.00016) // 远古残骸
.addItemOutput(<minecraft:iron_ore> * 64).setChance(0.0872) // 铁
.addItemOutput(<mekanism:oreblock> * 64).setChance(0.0872) // 锝
.addItemOutput(<minecraft:gold_ore> * 64).setChance(0.0154) // 金
.addItemOutput(<minecraft:coal_ore> * 64).setChance(0.1757) // 煤炭
.addItemOutput(<minecraft:lapis_ore> * 64).setChance(0.0404) // 青金石
.addItemOutput(<minecraft:redstone_ore> * 64).setChance(0.1037) // 红石
.addItemOutput(<appliedenergistics2:quartz_ore> * 64).setChance(0.02) // 赛特斯石英
.addItemOutput(<appliedenergistics2:charged_quartz_ore> * 64).setChance(0.01) // 充能赛特斯石英
.addItemOutput(<astralsorcery:blockcustomore> * 64).setChance(0.162) // 水晶石
.addItemOutput(<minecraft:diamond_ore> * 64).setChance(0.0055) // 钻石
.addItemOutput(<minecraft:emerald_ore> * 64).setChance(0.0141) // 绿宝石
.addItemOutput(<thermalfoundation:ore:4> * 64).setChance(0.0269) // 铝
.addItemOutput(<thermalfoundation:ore> * 64).setChance(0.0980) // 铜
.addItemOutput(<thermalfoundation:ore:1> * 64).setChance(0.1192) // 锡
.addItemOutput(<thermalfoundation:ore:3> * 64).setChance(0.0256) // 铅
.addItemOutput(<thermalfoundation:ore:2> * 64).setChance(0.0255) // 银
.addItemOutput(<thermalfoundation:ore:5> * 64).setChance(0.0281) // 镍
.addItemOutput(<thermalfoundation:ore:7> * 64).setChance(0.0121) // 钽
.addItemOutput(<thermalfoundation:ore:6> * 64).setChance(0.0263) // 铂
.addItemOutput(<nuclearcraft:ore:6> * 64).setChance(0.0095) // 锂
.addItemOutput(<thermalfoundation:ore_fluid:2> * 64).setChance(0.0357) // 不稳定红石
.addItemOutput(<immersiveengineering:ore:1> * 64).setChance(0.0507) // 铝土
.addItemOutput(<mets:niobium_ore> * 64).setChance(0.0123) // 铌
.addItemOutput(<mets:titanium_ore> * 64).setChance(0.0124) // 钛
.addItemOutput(<nuclearcraft:ore:3> * 64).setChance(0.0109) // 钸
.addItemOutput(<nuclearcraft:ore:4> * 64).setChance(0.0071) // 铀
.addItemOutput(<nuclearcraft:ore:7> * 64).setChance(0.0025) // 镁
.addItemOutput(<nuclearcraft:ore:5> * 64).setChance(0.0025) // 硼
.addItemOutput(<taiga:eezo_ore> * 64).setChance(0.0033) // 零素
.addItemOutput(<taiga:vibranium_ore> * 64).setChance(0.000089) // 振金
.addItemOutput(<taiga:karmesine_ore> * 64).setChance(0.000234) // 绯红铁
.addItemOutput(<taiga:dilithium_ore> * 64).setChance(0.000664) // 双锂
.addItemOutput(<taiga:ovium_ore> * 64).setChance(0.000187) // 欧维姆
.addItemOutput(<taiga:jauxum_ore> * 64).setChance(0.000222) // 若氏铁
.addRecipeTooltip([
        "§a只能在以下条件满足时工作：",
        "§2-液态魔力线程运行",
        "§2-生命本源线程运行",
        "§2-星光之力线程运行",
        "§2-基础工业线程运行"
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚未稳定魔力");
            return;
        }
        if(isNull(event.controller.recipeThreadList[1].activeRecipe)){
            event.setFailed("尚未平衡本源");
            return;
        }
        if (isNull(event.controller.recipeThreadList[2].activeRecipe)){
            event.setFailed("尚未引导星光");
            return;
        }
            if (isNull(event.controller.recipeThreadList[3].activeRecipe)){
            event.setFailed("尚未筑基工业");
            return;
        }
    })
    .build();


    // 编程电路A配方
RecipeBuilder.newBuilder("hastalyk_pro_a", "hastalyk", 1)
.addInput(<minecraft:stone>*512)
.addEnergyPerTickInput(32000*4)
.addFluidInput(<liquid:sulfuric_acid>*40)
.addFluidInput(<liquid:astralsorcery.liquidstarlight>*40)
.addFluidInput(<liquid:lifeessence>*40)
.addFluidInput(<fluid:fluidedmana>*40)
.addInput(<contenttweaker:programming_circuit_a>).setChance(0)
.addItemOutput(<draconicevolution:draconium_ore> * 64).setChance(0.054) // 龙矿
.addItemOutput(<thermalfoundation:ore_fluid:4> * 64).setChance(0.00104) // 谐振末影矿
.addItemOutput(<taiga:palladium_ore> *512).setChance(0.000113) // 钯
.addItemOutput(<taiga:aurorium_ore> *512).setChance(0.000175) // 极光金属
.addItemOutput(<taiga:abyssum_ore> *512).setChance(0.00523) // 深渊金属
.addItemOutput(<taiga:duranite_ore> *512).setChance(0.000332) // 杜兰蒂
.addItemOutput(<taiga:uru_ore> *512).setChance(0.00234) // 乌鲁
.addItemOutput(<taiga:osram_ore> *512).setChance(0.000332) // 熔晶
.addItemOutput(<minecraft:quartz_ore> *512).setChance(0.0991) // 下界石英
.addItemOutput(<taiga:tiberium_ore> *512).setChance(0.2567) // 泰伯利亚
.addItemOutput(<taiga:prometheum_ore> *512).setChance(0.00261) // 奎摩矿石
.addItemOutput(<taiga:valyrium_ore> *512).setChance(0.000507) // 瓦雷利亚
.addItemOutput(<tconstruct:ore> *512).setChance(0.0119) // 钴
.addItemOutput(<tconstruct:ore:1> *512).setChance(0.0116) // 阿迪特
.addItemOutput(<futuremc:ancient_debris> *512).setChance(0.00016) // 远古残骸
.addItemOutput(<minecraft:iron_ore> *512).setChance(0.0872) // 铁
.addItemOutput(<mekanism:oreblock> *512).setChance(0.0872) // 锝
.addItemOutput(<minecraft:gold_ore> *512).setChance(0.0154) // 金
.addItemOutput(<minecraft:coal_ore> *512).setChance(0.1757) // 煤炭
.addItemOutput(<minecraft:lapis_ore> *512).setChance(0.0404) // 青金石
.addItemOutput(<minecraft:redstone_ore> *512).setChance(0.1037) // 红石
.addItemOutput(<appliedenergistics2:quartz_ore> *512).setChance(0.02) // 赛特斯石英
.addItemOutput(<appliedenergistics2:charged_quartz_ore> *512).setChance(0.01) // 充能赛特斯石英
.addItemOutput(<astralsorcery:blockcustomore> *512).setChance(0.162) // 水晶石
.addItemOutput(<minecraft:diamond_ore> *512).setChance(0.0055) // 钻石
.addItemOutput(<minecraft:emerald_ore> *512).setChance(0.0141) // 绿宝石
.addItemOutput(<thermalfoundation:ore:4> *512).setChance(0.0269) // 铝
.addItemOutput(<thermalfoundation:ore> *512).setChance(0.0980) // 铜
.addItemOutput(<thermalfoundation:ore:1> *512).setChance(0.1192) // 锡
.addItemOutput(<thermalfoundation:ore:3> *512).setChance(0.0256) // 铅
.addItemOutput(<thermalfoundation:ore:2> *512).setChance(0.0255) // 银
.addItemOutput(<thermalfoundation:ore:5> *512).setChance(0.0281) // 镍
.addItemOutput(<thermalfoundation:ore:7> *512).setChance(0.0121) // 钽
.addItemOutput(<thermalfoundation:ore:6> *512).setChance(0.0263) // 铂
.addItemOutput(<nuclearcraft:ore:6> *512).setChance(0.0095) // 锂
.addItemOutput(<thermalfoundation:ore_fluid:2> *512).setChance(0.0357) // 不稳定红石
.addItemOutput(<immersiveengineering:ore:1> *512).setChance(0.0507) // 铝土
.addItemOutput(<mets:niobium_ore> *512).setChance(0.0123) // 铌
.addItemOutput(<mets:titanium_ore> *512).setChance(0.0124) // 钛
.addItemOutput(<nuclearcraft:ore:3> *512).setChance(0.0109) // 钸
.addItemOutput(<nuclearcraft:ore:4> *512).setChance(0.0071) // 铀
.addItemOutput(<nuclearcraft:ore:7> *512).setChance(0.0025) // 镁
.addItemOutput(<nuclearcraft:ore:5> *512).setChance(0.0025) // 硼
.addItemOutput(<taiga:eezo_ore> *512).setChance(0.0033) // 零素
.addItemOutput(<taiga:vibranium_ore> *512).setChance(0.000089) // 振金
.addItemOutput(<taiga:karmesine_ore> *512).setChance(0.000234) // 绯红铁
.addItemOutput(<taiga:dilithium_ore> *512).setChance(0.000664) // 双锂
.addItemOutput(<taiga:ovium_ore> *512).setChance(0.000187) // 欧维姆
.addItemOutput(<taiga:jauxum_ore> *512).setChance(0.000222) // 若氏铁铁
.addRecipeTooltip([
        "§a只能在以下条件满足时工作：",
        "§2-液态魔力线程运行",
        "§2-生命本源线程运行",
        "§2-星光之力线程运行",
        "§2-基础工业线程运行"
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚未稳定魔力");
            return;
        }
        if(isNull(event.controller.recipeThreadList[1].activeRecipe)){
            event.setFailed("尚未平衡本源");
            return;
        }
        if (isNull(event.controller.recipeThreadList[2].activeRecipe)){
            event.setFailed("尚未引导星光");
            return;
        }
            if (isNull(event.controller.recipeThreadList[3].activeRecipe)){
            event.setFailed("尚未筑基工业");
            return;
        }
    })
    .build();


    // 编程电路A配方
RecipeBuilder.newBuilder("hastalyk_pro_b", "hastalyk", 1)
.addInput(<minecraft:stone>*2084)
.addEnergyPerTickInput(32000*128)
.addFluidInput(<liquid:sulfuric_acid>*1280)
.addFluidInput(<liquid:astralsorcery.liquidstarlight>*1280)
.addFluidInput(<liquid:lifeessence>*1280)
.addFluidInput(<fluid:fluidedmana>*1280)
.addInput(<contenttweaker:programming_circuit_b>).setChance(0)
.addItemOutput(<draconicevolution:draconium_ore> * 2048).setChance(0.054) // 龙矿
.addItemOutput(<thermalfoundation:ore_fluid:4> * 2048).setChance(0.00104) // 谐振末影矿
.addItemOutput(<taiga:palladium_ore> * 2048).setChance(0.000113) // 钯
.addItemOutput(<taiga:aurorium_ore> * 2048).setChance(0.000175) // 极光金属
.addItemOutput(<taiga:abyssum_ore> * 2048).setChance(0.00523) // 深渊金属
.addItemOutput(<taiga:duranite_ore> * 2048).setChance(0.000332) // 杜兰蒂
.addItemOutput(<taiga:uru_ore> * 2048).setChance(0.00234) // 乌鲁
.addItemOutput(<taiga:osram_ore> * 2048).setChance(0.000332) // 熔晶
.addItemOutput(<minecraft:quartz_ore> * 2048).setChance(0.0991) // 下界石英
.addItemOutput(<taiga:tiberium_ore> * 2048).setChance(0.2567) // 泰伯利亚
.addItemOutput(<taiga:prometheum_ore> * 2048).setChance(0.00261) // 奎摩矿石
.addItemOutput(<taiga:valyrium_ore> * 2048).setChance(0.000507) // 瓦雷利亚
.addItemOutput(<tconstruct:ore> * 2048).setChance(0.0119) // 钴
.addItemOutput(<tconstruct:ore:1> * 2048).setChance(0.0116) // 阿迪特
.addItemOutput(<futuremc:ancient_debris> * 2048).setChance(0.00016) // 远古残骸
.addItemOutput(<minecraft:iron_ore> * 2048).setChance(0.0872) // 铁
.addItemOutput(<mekanism:oreblock> * 2048).setChance(0.0872) // 锝
.addItemOutput(<minecraft:gold_ore> * 2048).setChance(0.0154) // 金
.addItemOutput(<minecraft:coal_ore> * 2048).setChance(0.1757) // 煤炭
.addItemOutput(<minecraft:lapis_ore> * 2048).setChance(0.0404) // 青金石
.addItemOutput(<minecraft:redstone_ore> * 2048).setChance(0.1037) // 红石
.addItemOutput(<appliedenergistics2:quartz_ore> * 2048).setChance(0.02) // 赛特斯石英
.addItemOutput(<appliedenergistics2:charged_quartz_ore> * 2048).setChance(0.01) // 充能赛特斯石英
.addItemOutput(<astralsorcery:blockcustomore> * 2048).setChance(0.162) // 水晶石
.addItemOutput(<minecraft:diamond_ore> * 2048).setChance(0.0055) // 钻石
.addItemOutput(<minecraft:emerald_ore> * 2048).setChance(0.0141) // 绿宝石
.addItemOutput(<thermalfoundation:ore:4> * 2048).setChance(0.0269) // 铝
.addItemOutput(<thermalfoundation:ore> * 2048).setChance(0.0980) // 铜
.addItemOutput(<thermalfoundation:ore:1> * 2048).setChance(0.1192) // 锡
.addItemOutput(<thermalfoundation:ore:3> * 2048).setChance(0.0256) // 铅
.addItemOutput(<thermalfoundation:ore:2> * 2048).setChance(0.0255) // 银
.addItemOutput(<thermalfoundation:ore:5> * 2048).setChance(0.0281) // 镍
.addItemOutput(<thermalfoundation:ore:7> * 2048).setChance(0.0121) // 钽
.addItemOutput(<thermalfoundation:ore:6> * 2048).setChance(0.0263) // 铂
.addItemOutput(<nuclearcraft:ore:6> * 2048).setChance(0.0095) // 锂
.addItemOutput(<thermalfoundation:ore_fluid:2> * 2048).setChance(0.0357) // 不稳定红石
.addItemOutput(<immersiveengineering:ore:1> * 2048).setChance(0.0507) // 铝土
.addItemOutput(<mets:niobium_ore> * 2048).setChance(0.0123) // 铌
.addItemOutput(<mets:titanium_ore> * 2048).setChance(0.0124) // 钛
.addItemOutput(<nuclearcraft:ore:3> * 2048).setChance(0.0109) // 钸
.addItemOutput(<nuclearcraft:ore:4> * 2048).setChance(0.0071) // 铀
.addItemOutput(<nuclearcraft:ore:7> * 2048).setChance(0.0025) // 镁
.addItemOutput(<nuclearcraft:ore:5> * 2048).setChance(0.0025) // 硼
.addItemOutput(<taiga:eezo_ore> * 2048).setChance(0.0033) // 零素
.addItemOutput(<taiga:vibranium_ore> * 2048).setChance(0.000089) // 振金
.addItemOutput(<taiga:karmesine_ore> * 2048).setChance(0.000234) // 绯红铁
.addItemOutput(<taiga:dilithium_ore> * 2048).setChance(0.000664) // 双锂
.addItemOutput(<taiga:ovium_ore> * 2048).setChance(0.000187) // 欧维姆
.addItemOutput(<taiga:jauxum_ore> * 2048).setChance(0.000222) // 若氏铁
.addRecipeTooltip([
        "§a只能在以下条件满足时工作：",
        "§2-液态魔力线程运行",
        "§2-生命本源线程运行",
        "§2-星光之力线程运行",
        "§2-基础工业线程运行"
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚未稳定魔力");
            return;
        }
        if(isNull(event.controller.recipeThreadList[1].activeRecipe)){
            event.setFailed("尚未平衡本源");
            return;
        }
        if (isNull(event.controller.recipeThreadList[2].activeRecipe)){
            event.setFailed("尚未引导星光");
            return;
        }
            if (isNull(event.controller.recipeThreadList[3].activeRecipe)){
            event.setFailed("尚未筑基工业");
            return;
        }
    })
    .build();