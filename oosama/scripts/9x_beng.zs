#priority 10
#loader crafttweaker reloadable

import mods.modularmachinery.MMEvents;
import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.MachineBuilder;
import mods.modularmachinery.MachineTickEvent;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.MultiblockModifierBuilder;
import mods.modularmachinery.ControllerGUIRenderEvent;
import mods.modularmachinery.BlockArrayBuilder;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.IMachineController;

import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.RecipeTickEvent;
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

import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.research.ResearchCognitionData;
import novaeng.NovaEngUtils;


// 二重压缩重水泵 控制器
recipes.addShaped( 
    <modularmachinery:9x_beng_controller>, // 输出物品
    [[<modularmachinery:beng_controller>, <modularmachinery:beng_controller>, <modularmachinery:beng_controller>],
    [<modularmachinery:beng_controller>, <modularmachinery:beng_controller>, <modularmachinery:beng_controller>],
    [<modularmachinery:beng_controller>, <modularmachinery:beng_controller>, <modularmachinery:beng_controller>]]
);

// 三重压缩重水泵 控制器
recipes.addShaped( 
    <modularmachinery:81x_beng_controller>, // 输出物品
    [[<modularmachinery:9x_beng_controller>, <modularmachinery:9x_beng_controller>, <modularmachinery:9x_beng_controller>],
    [<modularmachinery:9x_beng_controller>, <modularmachinery:9x_beng_controller>, <modularmachinery:9x_beng_controller>],
    [<modularmachinery:9x_beng_controller>, <modularmachinery:9x_beng_controller>, <modularmachinery:9x_beng_controller>]]
);

// 四重压缩重水泵 控制器
recipes.addShaped( 
    <modularmachinery:729x_beng_controller>, // 输出物品
    [[<modularmachinery:81x_beng_controller>, <modularmachinery:81x_beng_controller>, <modularmachinery:81x_beng_controller>],
    [<modularmachinery:81x_beng_controller>, <modularmachinery:81x_beng_controller>, <modularmachinery:81x_beng_controller>],
    [<modularmachinery:81x_beng_controller>, <modularmachinery:81x_beng_controller>, <modularmachinery:81x_beng_controller>]]
);

// 五重压缩重水泵 控制器
recipes.addShaped( 
    <modularmachinery:6561x_beng_controller>, // 输出物品
    [[<modularmachinery:729x_beng_controller>, <modularmachinery:729x_beng_controller>, <modularmachinery:729x_beng_controller>],
    [<modularmachinery:729x_beng_controller>, <modularmachinery:729x_beng_controller>, <modularmachinery:729x_beng_controller>],
    [<modularmachinery:729x_beng_controller>, <modularmachinery:729x_beng_controller>, <modularmachinery:729x_beng_controller>]]
);

// 六重压缩重水泵 控制器
recipes.addShaped( 
    <modularmachinery:59049x_beng_controller>, // 输出物品
    [[<modularmachinery:6561x_beng_controller>, <modularmachinery:6561x_beng_controller>, <modularmachinery:6561x_beng_controller>],
    [<modularmachinery:6561x_beng_controller>, <modularmachinery:6561x_beng_controller>, <modularmachinery:6561x_beng_controller>],
    [<modularmachinery:6561x_beng_controller>, <modularmachinery:6561x_beng_controller>, <modularmachinery:6561x_beng_controller>]]
);

// 七重压缩重水泵 控制器
recipes.addShaped( 
    <modularmachinery:531441x_beng_controller>, // 输出物品
    [[<modularmachinery:59049x_beng_controller>, <modularmachinery:59049x_beng_controller>, <modularmachinery:59049x_beng_controller>],
    [<modularmachinery:59049x_beng_controller>, <modularmachinery:59049x_beng_controller>, <modularmachinery:59049x_beng_controller>],
    [<modularmachinery:59049x_beng_controller>, <modularmachinery:59049x_beng_controller>, <modularmachinery:59049x_beng_controller>]]
);

// 八重压缩重水泵 控制器
recipes.addShaped( 
    <modularmachinery:4782969x_beng_controller>, // 输出物品
    [[<modularmachinery:531441x_beng_controller>, <modularmachinery:531441x_beng_controller>, <modularmachinery:531441x_beng_controller>],
    [<modularmachinery:531441x_beng_controller>, <modularmachinery:531441x_beng_controller>, <modularmachinery:531441x_beng_controller>],
    [<modularmachinery:531441x_beng_controller>, <modularmachinery:531441x_beng_controller>, <modularmachinery:531441x_beng_controller>]]
);

// 九重压缩重水泵 控制器
recipes.addShaped( 
    <modularmachinery:43046721x_beng_controller>, // 输出物品
    [[<modularmachinery:4782969x_beng_controller>, <modularmachinery:4782969x_beng_controller>, <modularmachinery:4782969x_beng_controller>],
    [<modularmachinery:4782969x_beng_controller>, <modularmachinery:4782969x_beng_controller>, <modularmachinery:4782969x_beng_controller>],
    [<modularmachinery:4782969x_beng_controller>, <modularmachinery:4782969x_beng_controller>, <modularmachinery:4782969x_beng_controller>]]
);


    //盐水
    RecipeBuilder.newBuilder("9x_beng_yanshui", "9x_beng", 20,0)
    .addEnergyPerTickInput(225000)
    .addInput(<liquid:water> * 1485000)
    .addOutput(<liquid:brine> * 148500)
    .build();

    RecipeBuilder.newBuilder("9x_beng_tbyxpf", "9x_beng", 20,0)
    .addEnergyPerTickInput(2250000)
    .addInput(<extendedae:infinity_cell>.withTag({r: {FluidName: "water"}})).setPreViewNBT({r: {FluidName: "water", Craft: 0 as byte, Cnt: 1 as long, Count: 0 as byte, Req: 0 as long}, t: "f"}).setChance(0).setParallelizeUnaffected(true)
    .addInput(<appliedenergistics2:io_port>).setChance(0)
    .addOutput(<liquid:brine> * 148500)
    .addRecipeTooltip("这他喵的就是力量，兄弟！")
    .build();
    //液态锂
    RecipeBuilder.newBuilder("9x_beng_lishui", "9x_beng", 20,0)
    .addEnergyPerTickInput(540000)
    .addInput(<liquid:brine> * 1485000)
    .addOutput(<liquid:liquidlithium>  * 148500)
    .build();
    //重水
    RecipeBuilder.newBuilder("9x_beng_heavywater", "9x_beng", 40)
    .addEnergyPerTickInput(337500)
    .addInput(<mekanism:filterupgrade>).setChance(0)
    .addRecipeTooltip("§e过滤升级§9对于压缩系列不影响并行！")
    .addOutput(<liquid:heavywater> * 8100)
    .build();


// 配方继承：二重压缩
RecipeAdapterBuilder.create("81x_beng", "modularmachinery:9x_beng")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy", "input", 9.0F, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:fluid", "output", 9.0F, 1, false).build())
    .build();

// 配方继承：三重压缩
RecipeAdapterBuilder.create("729x_beng", "modularmachinery:9x_beng")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy", "input", 81.0F, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:fluid", "output", 81.0F, 1, false).build())
    .build();

// 配方继承：四重压缩
RecipeAdapterBuilder.create("6561x_beng", "modularmachinery:9x_beng")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy", "input", 729.0F, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:fluid", "output", 729.0F, 1, false).build())
    .build();

// 配方继承：五重压缩
RecipeAdapterBuilder.create("59049x_beng", "modularmachinery:9x_beng")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy", "input", 6561.0F, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:fluid", "output", 6561.0F, 1, false).build())
    .build();

// 配方继承：六重压缩
RecipeAdapterBuilder.create("531441x_beng", "modularmachinery:9x_beng")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy", "input", 59049.0F, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:fluid", "output", 59049.0F, 1, false).build())
    .build();

// 配方继承：七重压缩
RecipeAdapterBuilder.create("4782969x_beng", "modularmachinery:9x_beng")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy", "input", 531441.0F, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:fluid", "output", 531441.0F, 1, false).build())
    .build();

// 配方继承：八重压缩
RecipeAdapterBuilder.create("43046721x_beng", "modularmachinery:9x_beng")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy", "input", 4782969.0F, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:fluid", "output", 4782969.0F, 1, false).build())
    .build();
