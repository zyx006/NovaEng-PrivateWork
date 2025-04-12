//FUCK YOU DIRT DRILL
//acot=堕落帝国科技=古代科技=老登科技=原始人科技!

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

RecipeBuilder.newBuilder("dirt_melon_fusion", "super_dirt_melon_fusion",100)
        .addEnergyPerTickOutput(10000000)
        .addRecipeTooltip([
                "§l有瓜!有瓜!",
            ])
        .build();
RecipeBuilder.newBuilder("dirt_melon_fusion_hdpe", "super_dirt_melon_fusion",100)
        .addInput(<minecraft:melon> * 64)
        .addOutput(<mekanism:polyethene> * 16384)
        .addRecipeTooltip([
                "§l有瓜!有瓜!",
            ])
        .build();
RecipeBuilder.newBuilder("super_dirt_msm", "super_dirt_msm", 120)
    .addOutput(<draconicevolution:chaos_shard> * 4)
    .addOutput(<deepmoblearning:living_matter_overworldian> * 16)
    .addOutput(<deepmoblearning:living_matter_hellish> * 16)
    .addOutput(<deepmoblearning:living_matter_extraterrestrial> * 16)
    .addOutput(<deepmoblearning:living_matter_legend> * 16)
    .addOutput(<contenttweaker:hxs> * 8)
    .addOutput(<deepmoblearning:pristine_matter_thermal_elemental> * 8)
    .addOutput(<minecraft:slime_ball> * 32)
    .addOutput(<minecraft:ghast_tear> * 8)
    .addOutput(<minecraft:coal> * 64)
    .addOutput(<minecraft:dragon_breath> * 32)
    .addOutput(<minecraft:dragon_egg> * 1)
    .addOutput(<draconicevolution:draconium_dust> * 64)
    .addOutput(<draconicevolution:dragon_heart> * 1)
    .addOutput(<minecraft:bone> * 64)
    .addOutput(<minecraft:nether_star> * 5)
    .addOutput(<deepmoblearning:pristine_matter_tinker_slime> * 8)
    .addOutput(<deepmoblearning:glitch_heart> * 2)
    .addOutput(<minecraft:redstone> * 32)
    .addOutput(<minecraft:glowstone_dust> * 32)
    .addOutput(<minecraft:sugar> * 64)
    .addOutput(<minecraft:rotten_flesh> * 64)
    .addOutput(<minecraft:iron_ingot> * 16)
    .addOutput(<minecraft:carrot> * 32)
    .addOutput(<minecraft:potato> * 32)
    .addOutput(<minecraft:spider_eye> * 16)
    .addOutput(<minecraft:string> * 64)
    .addOutput(<minecraft:ender_pearl> * 64)
    .addOutput(<enderio:block_enderman_skull> * 2)
    .addOutput(<minecraft:end_crystal> * 1)
    .addOutput(<minecraft:blaze_rod> * 32)
    .addOutput(<deepmoblearning:pristine_matter_blaze> * 8)
    .addOutput(<minecraft:shulker_shell> * 16)
    .addOutput(<minecraft:diamond> * 2)
    .addOutput(<minecraft:prismarine_shard> * 32)
    .addOutput(<minecraft:prismarine_crystals> * 32)
    .addOutput(<minecraft:fish> * 64)
    .addOutput(<botania:manaresource:5> * 64)
    .addOutput(<extrabotany:material:3>)
    .addOutput(<botania:manaresource> * 16)
    .addOutput(<botania:managlass> * 16)
    .addOutput(<botania:quartz:1> * 16)
    .addOutput(<botania:manaresource:2> * 16)
    .addOutput(<botania:manaresource:23> * 16)
    .addOutput(<botania:manaresource:1> * 16)
    .addOutput(<extrabotany:buddhistrelics>).setChance(0.1)
    .build();

MachineModifier.setMaxThreads("super_dirt_msm", 32);
MachineModifier.setMaxThreads("super_dirt_melon_fusion", 0);
MachineModifier.addCoreThread("super_dirt_melon_fusion", FactoryRecipeThread.createCoreThread("§2瓜聚变单元").addRecipe("dirt_melon_fusion"));
MachineModifier.addCoreThread("super_dirt_melon_fusion", FactoryRecipeThread.createCoreThread("§2hdpe单元").addRecipe("dirt_melon_fusion_hdpe"));
recipes.addShaped(<modularmachinery:super_dirt_melon_fusion_factory_controller>, [[<modularmachinery:blockcasing>, <minecraft:melon_block>, <thermalfoundation:storage_alloy>]]);
recipes.addShaped(<modularmachinery:super_dirt_msm_factory_controller>, [[<modularmachinery:blockcasing>, <minecraft:diamond_sword>, <thermalfoundation:storage_alloy>]]);
MachineModifier.setInternalParallelism("super_dirt_furnace", 1048576);
RecipeBuilder.newBuilder("acot_furnace1", "super_dirt_furnace", 1)
    .addInput(<minecraft:iron_ingot> * 64)
    .addOutput(<thermalfoundation:material:160> * 64)
    .addRecipeTooltip([
                "§l有瓜!有瓜!",
            ])
    .build();
RecipeBuilder.newBuilder("acot_furnace2", "super_dirt_furnace", 1)
    .addInput(<thermalfoundation:material:160> * 64)
    .addOutput(<mets:niobium_titanium_ingot> * 64)
    .addRecipeTooltip([
                "§l有瓜!有瓜!",
            ])
    .build();
RecipeBuilder.newBuilder("acot_furnace3", "super_dirt_furnace", 1)
    .addInput(<mets:niobium_titanium_ingot> * 64)
    .addOutput(<mets:nano_living_metal> * 64)
    .addRecipeTooltip([
                "§l有瓜!有瓜!",
            ])
    .build();
RecipeBuilder.newBuilder("acot_furnace4", "super_dirt_furnace", 1)
    .addInput(<mets:nano_living_metal> * 64)
    .addOutput(<mets:neutron_plate> * 64)
    .addRecipeTooltip([
                "§l有瓜!有瓜!",
            ])
    .build();
RecipeBuilder.newBuilder("acot_furnace5", "super_dirt_furnace", 1)
    .addInput(<mets:neutron_plate> * 64)
    .addOutput(<botania:manaresource> * 64)
    .addRecipeTooltip([
                "§l有瓜!有瓜!",
            ])
    .build();
RecipeBuilder.newBuilder("acot_furnace6", "super_dirt_furnace", 1)
    .addInput(<botania:manaresource> * 64)
    .addOutput(<botania:manaresource:7> * 64)
    .addRecipeTooltip([
                "§l有瓜!有瓜!",
            ])
    .build();
RecipeAdapterBuilder.create("super_dirt_furnace", "minecraft:furnace")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.005, 1, false).build())
    .addRecipeTooltip([
                "§l有瓜!有瓜!",
            ])
    .build();
RecipeBuilder.newBuilder("acot_flower_producer", "super_dirt_flower_producer", 1)
    .addOutput(<botania:petal> * 64)
    .addOutput(<botania:petal:1> * 64)
    .addOutput(<botania:petal:2> * 64)
    .addOutput(<botania:petal:3> * 64)
    .addOutput(<botania:petal:4> * 64)
    .addOutput(<botania:petal:5> * 64)
    .addOutput(<botania:petal:6> * 64)
    .addOutput(<botania:petal:7> * 64)
    .addOutput(<botania:petal:8> * 64)
    .addOutput(<botania:petal:9> * 64)
    .addOutput(<botania:petal:10> * 64)
    .addOutput(<botania:petal:11> * 64)
    .addOutput(<botania:petal:12> * 64)
    .addOutput(<botania:petal:13> * 64)
    .addOutput(<botania:petal:14> * 64)
    .addOutput(<botania:petal:15> * 64)
    .addRecipeTooltip([
                "§l有瓜!有瓜!",
            ])
    .build();
RecipeBuilder.newBuilder("super_dirt_garden", "super_dirt_garden", 1)
    .addOutput(<avaritia:ultimate_stew> * 12)
    .addRecipeTooltip([
                "§l有瓜!有瓜!",
            ])
    .build();
recipes.addShaped(<modularmachinery:super_dirt_garden_factory_controller>, [[<contenttweaker:extrememachineblock>, <avaritia:block_resource>, <thermalfoundation:storage_alloy>]]);
recipes.addShaped(<modularmachinery:super_dirt_flower_producer_factory_controller>, [[<modularmachinery:blockcasing>, <contenttweaker:iridescence>, <thermalfoundation:storage_alloy>]]);
recipes.addShaped(<modularmachinery:super_dirt_furnace_factory_controller>, [[<modularmachinery:blockcasing>, <forge:bucketfilled>.withTag({FluidName: "nitronite_fluid", Amount: 1000}), <thermalfoundation:storage_alloy>]]);
RecipeBuilder.newBuilder("acot_furnace7", "super_dirt_furnace", 1)
    .addInput(<minecraft:dirt> * 64)
    .addOutput(<botania:specialflower>.withTag({type: "orechid"}) * 4)
    .addRecipeTooltip([
                "§l有瓜!有瓜!",
                "§3§l通过原始人魔法孕育出上古花朵(?)",
            ])
    .build();
RecipeBuilder.newBuilder("acot_furnace8", "super_dirt_furnace", 1)
    .addInput(<modularmachinery:super_dirt_drill_factory_controller>)
    .addOutput(<modularmachinery:blockmeitemoutputbus> * 3)
    .addRecipeTooltip([
                "§l有瓜!有瓜!",
                "§3§l通过原始人魔法极限1换3(?)",
            ])
    .build();
RecipeBuilder.newBuilder("acot_furnace9", "super_dirt_furnace", 1)
    .addInput(<appliedenergistics2:sky_stone_chest>)
    .addOutput(<yabba:item_barrel> * 116)
    .addOutput(<yabba:upgrade_star_tier> * 116)
    .addOutput(<yabba:item_barrel_connector> * 4)
    .addRecipeTooltip([
                "§l有瓜!有瓜!",
                "§3§l通过陨石箱子了解外星科技并产出116个储物桶",
            ])
    .build();

MachineModifier.setMaxThreads("super_dirt_drill", 0);

RecipeBuilder.newBuilder("dirt_drill_mana_keeper","super_dirt_drill",1200)
    .addInputs(<fluid:fluidedmana>*5)
    .addRecipeTooltip([
        "使用液态魔力稳定通道"
    ])
    .build();

RecipeBuilder.newBuilder("super_dirt_drill", "super_dirt_drill",1)
    .addInput(<botania:specialflower>.withTag({type: "orechid"}) * 4).setChance(0)
    .addOutput(<minecraft:gold_ingot> * 16)
    .addOutput(<minecraft:iron_ingot> * 16)
    .addOutput(<minecraft:dye:4> * 4)
    .addOutput(<minecraft:diamond> * 4)
    .addOutput(<minecraft:redstone> * 16)
    .addOutput(<minecraft:emerald> * 4)
    .addOutput(<minecraft:quartz> * 16)
    .addOutput(<minecraft:coal> * 16)
    .addOutput(<thermalfoundation:material:128> * 4)
    .addOutput(<thermalfoundation:material:129> * 4)
    .addOutput(<thermalfoundation:material:130> * 4)
    .addOutput(<thermalfoundation:material:131> * 4)
    .addOutput(<thermalfoundation:material:132> * 4)
    .addOutput(<thermalfoundation:material:133> * 4)
    .addOutput(<thermalfoundation:material:134> * 4)
    .addOutput(<thermalfoundation:material:135> * 4)
    .addOutput(<thermalfoundation:material:136> * 4)
    .addOutput(<ic2:ingot:8> * 4)
    .addOutput(<draconicevolution:draconium_ingot> * 4)
    .addOutput(<biomesoplenty:gem:0> * 4)
    .addOutput(<biomesoplenty:gem:1> * 4)
    .addOutput(<biomesoplenty:gem:2> * 4)
    .addOutput(<biomesoplenty:gem:3> * 4)
    .addOutput(<biomesoplenty:gem:4> * 4)
    .addOutput(<biomesoplenty:gem:5> * 4)
    .addOutput(<biomesoplenty:gem:6> * 4)
    .addOutput(<biomesoplenty:gem:7> * 4)
    .addOutput(<ore:ingotThorium> * 4)
    .addOutput(<ore:ingotBoron> * 4)
    .addOutput(<ore:ingotMagnesium> * 4)
    .addOutput(<ore:ingotManganese> * 4)
    .addOutput(<additions:novaextended-ingot8> * 4)
    .addOutput(<taiga:dilithium_ingot> * 4)
    .addOutput(<libvulpes:productingot:7> * 4)
    .addOutput(<tconstruct:ingots:0> * 4)
    .addOutput(<tconstruct:ingots:1> * 4)
    .addOutput(<appliedenergistics2:material:0> * 4)
    .addOutput(<appliedenergistics2:material:1> * 4)
    .addOutput(<mekanism:ingot:1> * 4)
    .addOutput(<mekanism:fluoriteclump> * 4)
    .addOutput(<futuremc:netherite_scrap> * 4)
    .addOutput(<rftools:dimensional_shard> * 4)
    .addOutput(<astralsorcery:itemcraftingcomponent:1> * 4)
    .addOutput(<astralsorcery:itemcraftingcomponent:0> * 4)
    .addOutput(<thermalfoundation:material:132> * 4)
    .addOutput(<taiga:aurorium_ingot> * 4)
    .addOutput(<taiga:palladium_ingot> * 4)
    .addOutput(<taiga:prometheum_ingot> * 4)
    .addOutput(<taiga:valyrium_ingot> * 4)
    .addOutput(<taiga:vibranium_ingot> * 4)
    .addOutput(<taiga:osram_ingot> * 4)
    .addOutput(<taiga:eezo_ingot> * 4)
    .addOutput(<taiga:uru_ingot> * 4)
    .addOutput(<taiga:duranite_ingot> * 4)
    .addOutput(<taiga:karmesine_ingot> * 4)
    .addOutput(<taiga:abyssum_ingot> * 4)
    .addOutput(<taiga:tiberium_ingot> * 4)
    .addOutput(<taiga:jauxum_ingot> * 4)
    .addOutput(<taiga:ovium_ingot> * 4)
    .addOutput(<ebwizardry:magic_crystal:1> * 4)
    .addOutput(<ebwizardry:magic_crystal:2> * 4)
    .addOutput(<ebwizardry:magic_crystal:3> * 4)
    .addOutput(<ebwizardry:magic_crystal:4> * 4)
    .addOutput(<ebwizardry:magic_crystal:5> * 4)
    .addOutput(<ebwizardry:magic_crystal:6> * 4)
    .addOutput(<ebwizardry:magic_crystal:7> * 4)
    .addOutput(<taiga:obsidiorite_ingot> * 4)
    .addOutput(<minecraft:glowstone_dust> * 16)
    .addOutput(<taiga:meteorite_ingot> * 4)
    .addOutput(<appliedenergistics2:sky_stone_block> * 4)
    .addOutput(<environmentaltech:litherite_crystal> * 4)
    .addOutput(<environmentaltech:erodium_crystal> * 4)
    .addOutput(<environmentaltech:lonsdaleite_crystal> * 4)
    .addOutput(<environmentaltech:kyronite_crystal> * 4)
    .addOutput(<environmentaltech:pladium_crystal> * 4)
    .addOutput(<environmentaltech:ionite_crystal> * 4)
    .addOutput(<environmentaltech:aethium_crystal> * 4)
    .addRecipeTooltip([
                "§a只能在魔力维持线程运行时工作",
            ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚未稳定魔力钻井");
            return;
        }
    })
    .build();

RecipeBuilder.newBuilder("dirt_drill_mana_producer","super_dirt_drill",1)
    .addInputs(<fluid:xpjuice>*5)
    .addOutputs(<fluid:fluidedmana>*10)
    .addRecipeTooltip([
        "输入液态经验获取魔力,很简单()"
    ])
    .build();
    
recipes.addShaped(<modularmachinery:super_dirt_drill_factory_controller>, [[<modularmachinery:blockcasing>, <minecraft:diamond_block>, <thermalfoundation:storage_alloy>]]);
MachineModifier.addCoreThread("super_dirt_drill", FactoryRecipeThread.createCoreThread("§2魔力稳定线程").addRecipe("dirt_drill_mana_keeper"));
MachineModifier.addCoreThread("super_dirt_drill", FactoryRecipeThread.createCoreThread("§a原始人魔力钻机").addRecipe("super_dirt_drill"));
MachineModifier.addCoreThread("super_dirt_drill", FactoryRecipeThread.createCoreThread("§2魔力生产线程").addRecipe("dirt_drill_mana_producer"));