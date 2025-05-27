#priority 10
#loader crafttweaker reloadable

import mods.botania.RuneAltar;
import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.MachineBuilder;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.MultiblockModifierBuilder;
import mods.modularmachinery.BlockArrayBuilder;

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
//导

//控制器
// 添加无序合成配方
recipes.addShapeless(
    "modularmachinery:garden_of_salvation_controller", // 输出物品的注册名
    <modularmachinery:garden_of_salvation_controller>, // 输出物品
    [  
        <botania:livingrock> * 64, // 5 个 Botania 的活石
        <botania:livingwood> * 64, // 5 个 Botania 的活木
        <botania:manaresource>* 64, // 1 个 Botania 的 Mana 资源（元数据为 4）
        <botania:specialflower>.withTag({type: "puredaisy"}) * 4  // 4 个带有 NBT 标签的特殊花
    ]
);
//产五颜六色的花瓣0
RecipeBuilder.newBuilder("wuyanliusedehuaban","garden_of_salvation", 20)
.addFluidInput(<liquid:fluidedmana>*10)
.addItemInput(<contenttweaker:programming_circuit_0>*1).setChance(0)
.addItemOutput(<botania:petal>*5).setChance(0.15)
.addItemOutput(<botania:petal:1>*5).setChance(0.15)
.addItemOutput(<botania:petal:2>*5).setChance(0.15)
.addItemOutput(<botania:petal:3>*5).setChance(0.15)
.addItemOutput(<botania:petal:4>*5).setChance(0.15)
.addItemOutput(<botania:petal:5>*5).setChance(0.15)
.addItemOutput(<botania:petal:6>*5).setChance(0.15)
.addItemOutput(<botania:petal:7>*5).setChance(0.15)
.addItemOutput(<botania:petal:8>*5).setChance(0.15)
.addItemOutput(<botania:petal:9>*5).setChance(0.15)
.addItemOutput(<botania:petal:10>*5).setChance(0.15)
.addItemOutput(<botania:petal:11>*5).setChance(0.15)
.addItemOutput(<botania:petal:12>*5).setChance(0.15)
.addItemOutput(<botania:petal:13>*5).setChance(0.15)
.addItemOutput(<botania:petal:14>*5).setChance(0.15)
.addItemOutput(<botania:petal:15>*5).setChance(0.15)
.addItemOutput(<contenttweaker:iridescence>).setChance(0.01)

.build();

//产五颜六色的燃料A

RecipeBuilder.newBuilder("wuyanliusederanliao","garden_of_salvation", 20)
.addFluidInput(<liquid:fluidedmana>*10)
.addItemInput(<contenttweaker:programming_circuit_a>*1).setChance(0)
.addItemOutput(<minecraft:dye:1>*5).setChance(0.15)
.addItemOutput(<minecraft:dye:2>*5).setChance(0.15)
.addItemOutput(<futuremc:dye>*5).setChance(0.15)
.addItemOutput(<futuremc:dye:1>*5).setChance(0.15)
.addItemOutput(<futuremc:dye:2>*5).setChance(0.15)
.addItemOutput(<futuremc:dye:3>*5).setChance(0.15)
.addItemOutput(<minecraft:dye:5>*5).setChance(0.15)
.addItemOutput(<minecraft:dye:6>*5).setChance(0.15)
.addItemOutput(<minecraft:dye:7>*5).setChance(0.15)
.addItemOutput(<minecraft:dye:8>*5).setChance(0.15)
.addItemOutput(<minecraft:dye:9>*5).setChance(0.15)
.addItemOutput(<minecraft:dye:10>*5).setChance(0.15)
.addItemOutput(<minecraft:dye:11>*5).setChance(0.15)
.addItemOutput(<minecraft:dye:12>*5).setChance(0.15)
.addItemOutput(<minecraft:dye:13>*5).setChance(0.15)
.addItemOutput(<minecraft:dye:14>*5).setChance(0.15)
.build();

//产有机燃料
RecipeBuilder.newBuilder("gongyeyoujiranliao","garden_of_salvation", 20)
.addFluidInput(<liquid:fluidedmana>*10)
.addItemInput(<contenttweaker:programming_circuit_b>*1).setChance(0)
.addItemOutput(<enderio:item_material:48>*10).setChance(0.333)
.addItemOutput(<enderio:item_material:49>*10).setChance(0.333)
.addItemOutput(<enderio:item_material:50>*10).setChance(0.333)
.build();

//产活石活木
RecipeBuilder.newBuilder("huoshihuomu","garden_of_salvation", 600)
.addItemInput(<contenttweaker:programming_circuit_c>*1).setChance(0)
.addCatalystInput(<botania:overgrowthseed>,
        ["使用增生之种右击一个草方块，该草方块将变为蕴魔土。", "↑只是玩笑这是一个催化剂罢了", "使工作时间§a减半§f。"],
        [
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.50F, 1, false).build(),
        ]).setChance(0)
        
.addItemOutput(<botania:livingrock>*32)
.addItemOutput(<botania:livingwood>*32)
.build();

