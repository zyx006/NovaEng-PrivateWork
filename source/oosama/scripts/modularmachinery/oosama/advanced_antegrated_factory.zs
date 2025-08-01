

#priority 50
#loader crafttweaker reloadable

import crafttweaker.item.IItemStack;

import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;

import mods.modularmachinery.IMachineController;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.ActiveMachineRecipe;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.MachineModifier;

import mods.modularmachinery.MMEvents;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.MachineTickEvent;
import mods.modularmachinery.RecipeStartEvent;
import mods.modularmachinery.RecipeFinishEvent;
import mods.modularmachinery.IngredientArrayBuilder;

import novaeng.hypernet.HyperNetHelper;

//////////物质工厂//////////
//最大并行数
MachineModifier.setMaxParallelism("advanced_antegrated_factory", 1024);
//内置并行设置
MachineModifier.setInternalParallelism("advanced_antegrated_factory",1024);
//工厂线程设置
MachineModifier.setMaxThreads("advanced_antegrated_factory", 20);

# 控制器
//控制器合成
RecipeBuilder.newBuilder("advanced_antegrated_factory", "workshop", 60)
    .addEnergyPerTickInput(1000000)
        .addInputs([
        <contenttweaker:industrial_circuit_v3> * 32,
        <contenttweaker:field_generator_v2> * 32,
        <contenttweaker:robot_arm_v4> * 32,
        <contenttweaker:engineering_battery_v4> * 32,
        <avaritia:resource:4> * 32,
        <tconstruct:firewood:1> * 64,
        <ebwizardry:magic_crystal:1> * 64,
        <thermalfoundation:upgrade:35>*12,
        <enderio:block_enhanced_alloy_smelter> * 12,
        <nuclearcraft:alloy_furnace>*12,
        <thermalexpansion:machine:3>*12,
        <liquid:pyrotheum>*5000
                ])
        .addOutput(<modularmachinery:advanced_antegrated_factory_factory_controller>)
    .build();

val baseGlass = <ore:dustObsidian>; // 基础玻璃材料
val machineName = "advanced_antegrated_factory";  // 使用的机器名称
val time = 5;                                   // 配方所需时间（单位：ticks）
val energyPerTick = 10000;                          // 每 tick 所需能量


//岩石粉碎配方
    RecipeBuilder.newBuilder("separator_uranium", "item_shredder", 10)
    .addInput(<ore:stoneAndesite>*10)
    .addOutput(<nuclearcraft:dust:9>* 10)
    .addOutput(<nuclearcraft:compound:11> * 6)
    .addOutput(<nuclearcraft:gem_dust:10> * 3)
    .addEnergyPerTickInput(10000) // 5.0 RF/t × 20 ticks = 100 RF
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

  RecipeBuilder.newBuilder("stoneDiorite_is", "item_shredder", 10)
    .addInput(<ore:stoneDiorite>*10)
    .addOutput(<nuclearcraft:dust:10>* 10)
    .addOutput(<mekanism:otherdust:7> * 9)
    .addOutput(<nuclearcraft:gem_dust:9> * 7)
    .addEnergyPerTickInput(10000) // 5.0 RF/t × 20 ticks = 100 RF
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

    RecipeBuilder.newBuilder("stoneGranite_is", "item_shredder", 10)
    .addInput(<ore:stoneGranite>*10)
    .addOutput(<nuclearcraft:gem_dust:1>* 8)
    .addOutput(<thermalfoundation:material:771>* 6)
    .addOutput(<nuclearcraft:gem_dust:8>* 4)
    .addEnergyPerTickInput(10000) // 5.0 RF/t × 20 ticks = 100 RF
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();  
    
    //单质
    RecipeBuilder.newBuilder("separator_uranium", "item_shredder", 10)
    .addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients([
        <ore:dustUranium>*10
            ]))
    .addOutput(<nuclearcraft:uranium:10>* 9)
    .addOutput(<nuclearcraft:uranium:5> * 1)
    .addEnergyPerTickInput(10000) // 5.0 RF/t × 20 ticks = 100 RF
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

RecipeBuilder.newBuilder("separator_boron", "item_shredder", 10)
.addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients([
        <ore:dustBoron>*12
             ]))
    .addOutput(<nuclearcraft:boron:1>* 9)
    .addOutput(<nuclearcraft:boron>* 3)
    .addEnergyPerTickInput(10000)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();
RecipeBuilder.newBuilder("separator_lithium", "item_shredder", 10)
.addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients([
        <ore:dustLithium>*10
          ]))
    .addOutput(<nuclearcraft:lithium:1> * 9)
    .addOutput(<nuclearcraft:lithium> * 1)
    .addEnergyPerTickInput(10000)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

//极寒末影锭（有别的更加优质的私货这个其实并不好用）
RecipeBuilder.newBuilder("redstonerepository_socool_aaf", machineName, time)
    .addInputs(
        <thermalfoundation:material:1025>,
        <thermalfoundation:material:167>
        )  
    .addOutput(<redstonerepository:material:1>) 
    .addEnergyPerTickInput(energyPerTick)  // 设置每 tick 的能量需求
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();  


//科技枪里面的黑曜石钢锭
RecipeBuilder.newBuilder("itemshared_aaf", machineName, time)
    .addInputs(
        <ore:dustObsidian>,
        <ore:ingotSteel>
        )  
    .addOutput(<techguns:itemshared:84>) 
    .addEnergyPerTickInput(energyPerTick)  // 设置每 tick 的能量需求
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();  

//各种玻璃啊
// Titanium 硬化玻璃块配方
RecipeBuilder.newBuilder("block_glasshardenedtitanium", machineName, time)
    .addInput(baseGlass)  // 添加基础玻璃作为输入
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotTitanium>,  // 可以使用钛锭
                <ore:dustTitanium>    // 或者钛粉尘
            ])
    )
    .addOutput(<jaopca:block_glasshardenedtitanium>*2)  // 输出为钛硬化玻璃块
    .addEnergyPerTickInput(energyPerTick)  // 设置每 tick 的能量需求
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();  

// Uranium 硬化玻璃块配方
RecipeBuilder.newBuilder("block_glasshardeneduranium", machineName, time)
    .addInput(baseGlass)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotUranium>,
                <ore:dustUranium>
            ])
    )
    .addOutput(<jaopca:block_glasshardeneduranium>*2)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

// WillowAlloy 硬化玻璃块配方
RecipeBuilder.newBuilder("block_glasshardenedwillowalloy", machineName, time)
    .addInput(baseGlass)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotWillowalloy>,
                <ore:dustWillowalloy>
            ])
    )
    .addOutput(<jaopca:block_glasshardenedwillowalloy>*2)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

// Dilithium 硬化玻璃块配方
RecipeBuilder.newBuilder("block_glasshardeneddilithium", machineName, time)
    .addInput(baseGlass)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotDilithium>,
                <ore:dustDilithium>
            ])
    )
    .addOutput(<jaopca:block_glasshardeneddilithium>*2)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

// Cobalt 硬化玻璃块配方
RecipeBuilder.newBuilder("block_glasshardenedcobalt", machineName, time)
    .addInput(baseGlass)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotCobalt>,
                <ore:dustCobalt>
            ])
    )
    .addOutput(<jaopca:block_glasshardenedcobalt>*2)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

// AstralStarmetal 硬化玻璃块配方
RecipeBuilder.newBuilder("block_glasshardenedastralstarmetal", machineName, time)
    .addInput(baseGlass)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotAstralStarmetal>,
                <ore:dustAstralStarmetal>
            ])
    )
    .addOutput(<jaopca:block_glasshardenedastralstarmetal>*2)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

// Boron 硬化玻璃块配方
RecipeBuilder.newBuilder("block_glasshardenedboron", machineName, time)
    .addInput(baseGlass)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotBoron>,
                <ore:dustBoron>
            ])
    )
    .addOutput(<jaopca:block_glasshardenedboron>*2)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

// Gold 硬化玻璃块配方
RecipeBuilder.newBuilder("block_glasshardenedgold", machineName, time)
    .addInput(baseGlass)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotGold>,
                <ore:dustGold>
            ])
    )
    .addOutput(<jaopca:block_glasshardenedgold>*2)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

// Thorium 硬化玻璃块配方
RecipeBuilder.newBuilder("block_glasshardenedthorium", machineName, time)
    .addInput(baseGlass)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotThorium>,
                <ore:dustThorium>
            ])
    )
    .addOutput(<jaopca:block_glasshardenedthorium>*2)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

// Draconium 硬化玻璃块配方
RecipeBuilder.newBuilder("block_glasshardeneddraconium", machineName, time)
    .addInput(baseGlass)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotDraconium>,
                <ore:dustDraconium>
            ])
    )
    .addOutput(<jaopca:block_glasshardeneddraconium>*2)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

// Iron 硬化玻璃块配方
RecipeBuilder.newBuilder("block_glasshardenediron", machineName, time)
    .addInput(baseGlass)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotIron>,
                <ore:dustIron>
            ])
    )
    .addOutput(<jaopca:block_glasshardenediron>*2)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

// Osmium 硬化玻璃块配方
RecipeBuilder.newBuilder("block_glasshardenedosmium", machineName, time)
    .addInput(baseGlass)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotOsmium>,
                <ore:dustOsmium>
            ])
    )
    .addOutput(<jaopca:block_glasshardenedosmium>*2)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

// Magnesium 硬化玻璃块配方
RecipeBuilder.newBuilder("block_glasshardenedmagnesium", machineName, time)
    .addInput(baseGlass)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotMagnesium>,
                <ore:dustMagnesium>
            ])
    )
    .addOutput(<jaopca:block_glasshardenedmagnesium>    *2)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

// Lithium 硬化玻璃块配方
RecipeBuilder.newBuilder("block_glasshardenedlithium", machineName, time)
    .addInput(baseGlass)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotLithium>,
                <ore:dustLithium>
            ])
    )
    .addOutput(<jaopca:block_glasshardenedlithium>*2)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

RecipeBuilder.newBuilder("block_glasshardenediron", machineName, time)
    .addInput(baseGlass)  // 添加基础玻璃输入
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotIron>,   // 可使用铁锭
                <ore:dustIron>     // 或者铁粉
            ])
    )
    .addOutput(<jaopca:block_glasshardenediron>)  // 输出铁制硬化玻璃块
    .addEnergyPerTickInput(energyPerTick)  // 设置每 tick 所需能量
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();  

RecipeBuilder.newBuilder("block_glasshardeneddraconium", machineName, time)
    .addInput(baseGlass)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotDraconium>,
                <ore:dustDraconium>
            ])
    )
    .addOutput(<jaopca:block_glasshardeneddraconium>*2)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

RecipeBuilder.newBuilder("block_glasshardenedthorium", machineName, time)
    .addInput(baseGlass)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotThorium>,
                <ore:dustThorium>
            ])
    )
    .addOutput(<jaopca:block_glasshardenedthorium>*2)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();


RecipeBuilder.newBuilder("block_glasshardenedmagnesium", machineName, time)
    .addInput(baseGlass)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotMagnesium>,
                <ore:dustMagnesium>
            ])
    )
    .addOutput(<jaopca:block_glasshardenedmagnesium>*2)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

RecipeBuilder.newBuilder("block_glasshardenedlithium", machineName, time)
    .addInput(baseGlass)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotLithium>,
                <ore:dustLithium>
            ])
    )
    .addOutput(<jaopca:block_glasshardenedlithium>*2)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

RecipeBuilder.newBuilder("block_glasshardenedosmium", machineName, time)
    .addInput(baseGlass)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotOsmium>,
                <ore:dustOsmium>
            ])
    )
    .addOutput(<jaopca:block_glasshardenedosmium>*2)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

RecipeBuilder.newBuilder("ingots_lvhuangt", machineName, time)
    .addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients([
                <ore:dustCopper>,
                <ore:ingotCopper>
            ]))
    .addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients([
                <ore:ingotAluminium>*3,
                <ore:dustAluminium>*3
            ]))
    .addOutput(<tconstruct:ingots:5>*4)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

 RecipeBuilder.newBuilder("glitch_infused_ingot", machineName, time)
    .addInputs(
         <minecraft:dye:4>,
         <minecraft:gold_ingot>,
         <deepmoblearning:glitch_fragment>
    )
    .addOutput(<deepmoblearning:glitch_infused_ingot>)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

    // 创建 Glazed Nether Brick 配方
RecipeBuilder.newBuilder("glazed_nether_brick_recipe", machineName, time)
    .addInputs(
        <minecraft:netherbrick>,
        <minecraft:nether_wart> * 4,
        <minecraft:clay_ball> * 6
    )
    .addOutput(<ore:ingotBrickNetherGlazed>)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

    // 创建硅晶片配方（Silicon Wafer）
RecipeBuilder.newBuilder("silicon_wafer_recipe", machineName, time)
    .addInputs(
        <ore:ingotLead> * 3,
        <minecraft:ender_pearl> * 4,
        <thermalfoundation:material:134>
    )
    .addOutput(<enderio:item_material:39>)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

//神经红色燃料配方
RecipeBuilder.newBuilder("hongseranliao", machineName, time)
    .addInputs(
        <minecraft:beetroot>,
        <ore:egg>*6,
        <minecraft:clay_ball>*3
    )
    .addOutput(<minecraft:dye:1>*12)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

//两个吃的
RecipeBuilder.newBuilder("xiaobinggan", machineName, time)
    .addInputs(
        <ore:dustWheat>,
        <minecraft:dye:3>
    )
    .addOutput(<minecraft:cookie>*12)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

RecipeBuilder.newBuilder("mianbaobian", machineName, time)
    .addInputs(
        <ore:dustWheat>*3,
        <ore:egg>
    )
    .addOutput(<enderio:item_material:70>*12)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();
//炉渣
RecipeBuilder.newBuilder("timeisover", machineName, time)
    .addInputs(
        <ore:sand>,
        <ore:dustRedstone>
    )
    .addOutput(<thermalfoundation:material:864>)
    .addOutput(<thermalfoundation:material:865>).setChance(0.5)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();
//富炉渣
RecipeBuilder.newBuilder("timeisoverallright", machineName, time)
    .addInputs(
        <ore:sand>,
        <thermalfoundation:material:865>
    )
    .addOutput(<thermalfoundation:material:865>)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

//三个有机染料
RecipeBuilder.newBuilder("item_material75", machineName, time)
    .addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients([
                <ore:dustCoal>,
                <ore:dustCharcoal>
            ]))
    .addInput(<enderio:item_material:20>)
    .addOutput(<enderio:item_material:75>*4)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

RecipeBuilder.newBuilder("item_material49", machineName, time)
    .addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients([
                <ore:slimeball>,
                <ore:egg>
            ]))
    .addInputs(
        <ore:dustCoal>,
        <ore:dyeBrown>
    )
    .addOutput(<enderio:item_material:49>*4)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

    RecipeBuilder.newBuilder("item_material48", machineName, time)
    .addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients([
                <ore:slimeball>,
                <ore:egg>
            ]))
    .addInputs(
        <ore:dustCoal>,
        <ore:dyeGreen>
    )
    .addOutput(<enderio:item_material:48>*4)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

    RecipeBuilder.newBuilder("item_material50", machineName, time)
    .addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients([
                <ore:slimeball>,
                <ore:egg>
            ]))
    .addInputs(
        <ore:dustCoal>,
        <ore:dustCharcoal>
    )
    .addOutput(<enderio:item_material:50>*4)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

    //神秘的花

    // 创建死亡袋子配方（Death Pouch Recipe）
RecipeBuilder.newBuilder("death_pouch_recipe", machineName, time)
    .addInputs(
        <minecraft:dye:15> * 7,           // 黑色染料 x7
        <enderio:item_material:81>        // Ender IO 特殊材料
    )
    .addOutput(<enderio:block_death_pouch>)  // 输出死亡袋子
    .addEnergyPerTickInput(energyPerTick)              // 每 tick 所需能量
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();                                  // 注册该配方


    // 创建暗钢升级模块配方（Dark Steel Upgrade Recipe）
RecipeBuilder.newBuilder("dark_steel_upgrade_recipe", machineName, time)
    .addInputs(
        <minecraft:string> * 4,           // 线 x4
        <enderio:block_dark_iron_bars>,   // 暗铁栅栏
        <minecraft:clay_ball>             // 粘土球
    )
    .addOutput(<enderio:item_dark_steel_upgrade>)  // 输出暗钢升级模块
    .addEnergyPerTickInput(energyPerTick)                   // 每 tick 所需能量
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();    

// 创建铁粉配方（Iron Dust Recipe）
RecipeBuilder.newBuilder("iron_dust_recipe", machineName, time)
    .addInputs(
        <enderio:item_material:51>,       // 第一个输入材料
        <enderio:item_material>         // 第二个输入材料，需确认具体的子ID
    )
    .addOutput(<enderio:item_material:1>) // 输出铁粉
    .addEnergyPerTickInput(energyPerTick)           // 每 tick 所需能量
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();                               // 注册该配方


    // 创建基础电容配方（Basic Capacitor Recipe）
RecipeBuilder.newBuilder("basic_capacitor_recipe", machineName, time)
    .addInputs(
        <enderio:item_material:52>,       // 输入材料1（例如：基板）
        <enderio:item_material:66>        // 输入材料2（例如：硅芯片）
    )
    .addOutput(<enderio:item_material:54>)  // 输出基础电容
    .addEnergyPerTickInput(energyPerTick)             // 每 tick 所需能量
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();                                 // 注册该配方

    // 创建银粉配方（Silver Dust Recipe）
RecipeBuilder.newBuilder("silver_dust_recipe", machineName, time)
    .addInputs(
        <enderio:item_material:0>,         // 第一个输入材料，需确认具体的子ID
        <enderio:item_material:52>         // 第二个输入材料
    )
    .addOutput(<enderio:item_material:53>) // 输出银粉
    .addEnergyPerTickInput(energyPerTick)           // 每 tick 所需能量
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();                               // 注册该配方
//石英玻璃
    RecipeBuilder.newBuilder("block_dark_fused_quartz", machineName, time)
    .addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients([
                <ore:blockQuartz>,
                <ore:gemQuartz>*4
            ]))
    .addInputs(
        <ore:dyeBlack>
    )
    .addOutput(<enderio:block_dark_fused_quartz>)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

    RecipeBuilder.newBuilder("block_enlightened_fused_quartz", machineName, time)
    .addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients([
                <ore:blockQuartz>,
                <ore:gemQuartz>*4
            ]))
    .addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients([
        <chisel:glowstone:5>,
        <minecraft:glowstone_dust>*4
    ]))
    .addOutput(<enderio:block_enlightened_fused_quartz>)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

    RecipeBuilder.newBuilder("block_fused_quartz", machineName, time)
    .addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients([
                <ore:blockQuartz>,
                <ore:gemQuartz>*4
            ]))
    .addOutput(<enderio:block_fused_quartz>)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

//纯净玻璃
    RecipeBuilder.newBuilder("block_dark_fused_glass", machineName, time)
    .addInputs(
        <ore:dyeBlack>,
        <ore:blockGlass>
    )
    .addOutput(<enderio:block_dark_fused_glass>)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

    RecipeBuilder.newBuilder("block_enlightened_fused_glass", machineName, time)
    .addInputs(
        <ore:blockGlass>
    )
    .addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients([
        <chisel:glowstone:5>,
        <minecraft:glowstone_dust>*4
    ]))
    .addOutput(<enderio:block_enlightened_fused_glass>)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

    RecipeBuilder.newBuilder("block_fused_glass", machineName, time)
    .addInputs(
        <ore:blockGlass>
    )
    .addOutput(<enderio:block_fused_glass>)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();
// 创建工业绝缘块配方（Industrial Insulation Recipe）
RecipeBuilder.newBuilder("industrial_insulation_recipe", machineName, time)
    .addInputs(
        <ore:dustTin>,              // 锡粉
        <ore:dustLapis>,            // 青金石粉
        <minecraft:wool>            // 羊毛
    )
    .addOutput(<enderio:block_industrial_insulation>)  // 输出工业绝缘块
    .addEnergyPerTickInput(energyPerTick)    // 每 tick 所需能量
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();                      // 注册该配方

// 创建 Endergy 合金锭配方
RecipeBuilder.newBuilder("endergy_alloy_ingot_recipe",machineName, time)
    .addInputs(
        <minecraft:clay_ball>,
        <minecraft:gravel>,
        <ore:cobblestone>  //原石
    )
    .addOutput(<enderio:item_alloy_endergy_ingot>)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();
//感知锭
RecipeBuilder.newBuilder("konwyouding",machineName, time)
    .addInputs(
        <tconevo:material>,
        <bloodmagic:monster_soul>  //灵魂
    )
    .addOutput(<tconevo:metal:30>)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

//你太美合金
RecipeBuilder.newBuilder("youaresomeili",machineName, time)
    .addInputs(
         <mets:niobium_titanium_dust>*4
    )
    .addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients([
         <ore:charcoal>,
         <ore:coal>,
         <contenttweaker:material_part:84>

    ]))
    .addOutput(<mets:niobium_titanium_ingot>* 4)
    .addEnergyPerTickInput(energyPerTick)
    .addRecipeTooltip("这个是§c私货§f自己加的配方！")
    .build();

//嗨嗨嗨配方继承

RecipeAdapterBuilder.create("advanced_antegrated_factory", "modularmachinery:large_metallurgical_complex")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.025,  1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 1, 1, false).build())
    .build();

    
RecipeAdapterBuilder.create("advanced_antegrated_factory", "nuclearcraft:alloy_furnace")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.025,  1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 1000, 1, false).build())
    .build();
    
RecipeAdapterBuilder.create("large_metallurgical_complex", "modularmachinery:advanced_antegrated_factory")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 1, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 1, 1, false).build())
    .build();

// 时钟座星图
val horologiumStellationPaper = <contenttweaker:horologium_star_map>;
// 天炉座星图
val celestialFurnaceStellationPaper = <contenttweaker:fornax_star_map>;

// 相位炼化棱镜：配方继承
# 时钟座 + 天炉座
RecipeAdapterBuilder.create("phaselense", "modularmachinery:advanced_antegrated_factory")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 1, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 1, 1, false).build())
    .addInput(celestialFurnaceStellationPaper).setChance(0).setParallelizeUnaffected(true)
    .addInput(horologiumStellationPaper).setChance(0).setParallelizeUnaffected(true)
    .build();

    # 天炉座
RecipeAdapterBuilder.create("phaselense", "modularmachinery:advanced_antegrated_factory")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 1, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 1, 1, false).build())
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Ddata = D(data);
        val sfsz = Ddata.getInt("sfsz",1);
        if (sfsz != 1) {
            if(ctrl.world.dayTime){
                event.setFailed("§9星能不足以运行");
                return;
            }
        }
    })
    .addInput(celestialFurnaceStellationPaper).setChance(0).setParallelizeUnaffected(true)
    .build();