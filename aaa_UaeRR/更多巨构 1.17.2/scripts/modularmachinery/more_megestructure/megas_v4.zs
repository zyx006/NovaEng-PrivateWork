//ALL RIGHTS RESERVED
//也许你可以对私货进行更改。

#priority 400
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

import crafttweaker.block.IBlock;
import crafttweaker.item.IItemStack;
import crafttweaker.util.Math;
import crafttweaker.world.IBlockPos;
import crafttweaker.item.IIngredient;
import crafttweaker.world.IFacing;


import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.research.ResearchCognitionData;
import novaeng.NovaEngUtils;

MachineModifier.setInternalParallelism("TC_STAR_WEAVER", 2147483647);

RecipeBuilder.newBuilder("tc_tyf1","tc_star_weaver",1)
    .addInput(<contenttweaker:tyf1> * 1).setChance(0)
    .addEnergyPerTickOutput(3500000)
    .addRecipeTooltip([
                "§2拥有(2^31-1)并行§f",
                "由§c亿万烈阳之怒§f线程运行",
            ])
    .build();

RecipeBuilder.newBuilder("tc_tyf2","tc_star_weaver",1)
    .addInput(<contenttweaker:tyf2> * 1).setChance(0)
    .addEnergyPerTickOutput(28000000)
    .addRecipeTooltip([
                "§2拥有(2^31-1)并行§f",
                "由§c亿万烈阳之怒§f线程运行",
            ])
    .build();

RecipeBuilder.newBuilder("tc_tyf3","tc_star_weaver",1)
    .addInput(<contenttweaker:tyf3> * 1).setChance(0)
    .addEnergyPerTickOutput(350000000)
    .addRecipeTooltip([
                "§2拥有(2^31-1)并行§f",
                "由§c亿万烈阳之怒§f线程运行",
            ])
    .build();

RecipeBuilder.newBuilder("tc_quasar_eyes","Stellar_Firmament_Anchor",1)
    .addOutput(<contenttweaker:quasar_energy> * 1)
    .addRecipeTooltip([
                "由§e类星体之眼§f线程运行",
            ])
    .build();

RecipeBuilder.newBuilder("tc_alloy","tc_star_weaver",1)
    .addInput(<minecraft:gold_ingot> * 1048576)
    .addInput(<minecraft:iron_ingot> * 1048576)
    .addInput(<minecraft:dye:4> * 1048576)
    .addInput(<minecraft:diamond> * 1048576)
    .addInput(<minecraft:redstone> * 1048576)
    .addInput(<minecraft:emerald> * 1048576)
    .addInput(<minecraft:quartz> * 1048576)
    .addInput(<minecraft:coal> * 1048576)
    .addInput(<thermalfoundation:material:128> * 1048576)
    .addInput(<thermalfoundation:material:129> * 1048576)
    .addInput(<thermalfoundation:material:130> * 1048576)
    .addInput(<thermalfoundation:material:131> * 1048576)
    .addInput(<thermalfoundation:material:132> * 1048576)
    .addInput(<thermalfoundation:material:133> * 1048576)
    .addInput(<thermalfoundation:material:134> * 1048576)
    .addInput(<thermalfoundation:material:135> * 1048576)
    .addInput(<thermalfoundation:material:136> * 1048576)
    .addInput(<ic2:ingot:8> * 1048576)
    .addInput(<draconicevolution:draconium_ingot> * 1048576)
    .addInput(<biomesoplenty:gem:0> * 1048576)
    .addInput(<biomesoplenty:gem:1> * 1048576)
    .addInput(<biomesoplenty:gem:2> * 1048576)
    .addInput(<biomesoplenty:gem:3> * 1048576)
    .addInput(<biomesoplenty:gem:4> * 1048576)
    .addInput(<biomesoplenty:gem:5> * 1048576)
    .addInput(<biomesoplenty:gem:6> * 1048576)
    .addInput(<biomesoplenty:gem:7> * 1048576)
    .addInput(<ore:ingotThorium> * 1048576)
    .addInput(<ore:ingotBoron> * 1048576)
    .addInput(<ore:ingotMagnesium> * 1048576)
    .addInput(<ore:ingotManganese> * 1048576)
    .addInput(<additions:novaextended-ingot8> * 1048576)
    .addInput(<taiga:dilithium_ingot> * 1048576)
    .addInput(<libvulpes:productingot:7> * 1048576)
    .addInput(<tconstruct:ingots:0> * 1048576)
    .addInput(<tconstruct:ingots:1> * 1048576)
    .addInput(<appliedenergistics2:material:0> * 1048576)
    .addInput(<appliedenergistics2:material:1> * 1048576)
    .addInput(<mekanism:ingot:1> * 1048576)
    .addInput(<mekanism:fluoriteclump> * 1048576)
    .addInput(<futuremc:netherite_scrap> * 1048576)
    .addInput(<rftools:dimensional_shard> * 1048576)
    .addInput(<ore:gemQuartzBlack> * 1048576)
    .addInput(<astralsorcery:itemcraftingcomponent:1> * 1048576)
    .addInput(<astralsorcery:itemcraftingcomponent:0> * 1048576)
    .addInput(<thermalfoundation:material:132> * 1048576)
    .addInput(<taiga:aurorium_ingot> * 1048576)
    .addInput(<taiga:palladium_ingot> * 1048576)
    .addInput(<taiga:prometheum_ingot> * 1048576)
    .addInput(<taiga:valyrium_ingot> * 1048576)
    .addInput(<taiga:vibranium_ingot> * 1048576)
    .addInput(<taiga:osram_ingot> * 1048576)
    .addInput(<taiga:eezo_ingot> * 1048576)
    .addInput(<taiga:uru_ingot> * 1048576)
    .addInput(<taiga:duranite_ingot> * 1048576)
    .addInput(<taiga:karmesine_ingot> * 1048576)
    .addInput(<taiga:abyssum_ingot> * 1048576)
    .addInput(<taiga:tiberium_ingot> * 1048576)
    .addInput(<taiga:jauxum_ingot> * 1048576)
    .addInput(<taiga:ovium_ingot> * 1048576)
    .addInput(<taiga:obsidiorite_ingot> * 1048576)
    .addInput(<taiga:meteorite_ingot> * 1048576)
    .addInput(<appliedenergistics2:sky_stone_block> * 1048576)
    .addInput(<contenttweaker:fragments_of_the_space_time_continuum> * 16384)
    .addInput(<avaritia:resource:5> * 128)
    .addOutput(<contenttweaker:stellaris_alloy> * 1)
    .addRecipeTooltip([
                "§2拥有(2^31-1)并行§f",
                "由§b恒星引力压缩§f线程运行",
            ])
    .build();

RecipeBuilder.newBuilder("tc_crystal","tc_star_weaver",1)
    .addInput(<environmentaltech:litherite_crystal> * 1048576)
    .addInput(<environmentaltech:erodium_crystal> * 1048576)
    .addInput(<environmentaltech:lonsdaleite_crystal> * 1048576)
    .addInput(<environmentaltech:kyronite_crystal> * 1048576)
    .addInput(<environmentaltech:pladium_crystal> * 1048576)
    .addInput(<environmentaltech:ionite_crystal> * 1048576)
    .addInput(<environmentaltech:aethium_crystal> * 1048576)
    .addInput(<ebwizardry:magic_crystal:1> * 1048576)
    .addInput(<ebwizardry:magic_crystal:2> * 1048576)
    .addInput(<ebwizardry:magic_crystal:3> * 1048576)
    .addInput(<ebwizardry:magic_crystal:4> * 1048576)
    .addInput(<ebwizardry:magic_crystal:5> * 1048576)
    .addInput(<ebwizardry:magic_crystal:6> * 1048576)
    .addInput(<ebwizardry:magic_crystal:7> * 1048576)
    .addInput(<contenttweaker:fragments_of_the_space_time_continuum> * 16384)
    .addInput(<avaritia:resource:5> * 128)
    .addOutput(<contenttweaker:stellaris_crystal> * 1)
    .addRecipeTooltip([
                "§2拥有(2^31-1)并行§f",
                "由§b恒星引力压缩§f线程运行",
            ])
    .build();

RecipeBuilder.newBuilder("tc_gas","tc_star_weaver",1)
    .addFluidInput(<liquid:jfh> * 10000)
    .addFluidInput(<liquid:helium_3> * 1000000)
    .addFluidInput(<liquid:unsteady_plasma> * 100000)
    .addFluidInput(<liquid:liquidfusionfuel> * 1000000)
    .addInput(<liquid:crystalloid> * 20000)
    .addInput(<liquid:plasma> * 100000)
    .addInput(<contenttweaker:fragments_of_the_space_time_continuum> * 16384)
    .addInput(<avaritia:resource:5> * 128)
    .addOutput(<contenttweaker:stellaris_gas> * 1)
    .addRecipeTooltip([
                "§2拥有(2^31-1)并行§f",
                "由§b恒星引力压缩§f线程运行",
            ])
    .build();

RecipeBuilder.newBuilder("tc_quasar_energy","tc_star_weaver",1)
    .addInput(<contenttweaker:quasar_energy> * 4000)
    .addOutput(<contenttweaker:anti_viod> * 1)
    .addRecipeTooltip([
                "§2拥有(2^31-1)并行§f",
                "由§d超维框架§f线程运行",
                "§8将无穷能量压缩至10^-ERROR立方纳米的空间内,通过超维架构阻止规则将这团能量抹除,以坍缩为负虚空",
            ])
    .build();

RecipeBuilder.newBuilder("tc_yzs","tc_star_weaver",100)
    .addInput(<contenttweaker:quasar_energy> * 10)
    .addInput(<contenttweaker:stellaris_shipboard_ship> * 16).setChance(0)
    .addOutput(<liquid:yzs> * 100)
    .addRecipeTooltip([
                "§2拥有(2^31-1)并行§f",
                "由§a虚境超空间航道跃迁§f线程运行",
            ])
    .build();

RecipeBuilder.newBuilder("space_liquid", "odm_megav4",72000)
        .addInput(<contenttweaker:anti_viod> * 200)
        .addInput(<avaritia:resource:6> * 1048576)
        .addInput(<contenttweaker:arkforcefieldcontrolblock> * 1024)
        .addInput(<liquid:yzs> * 4000)
        .addInput(<liquid:baxwz> * 25000)
        .addInput(<liquid:haxwz> * 15000)
        .addOutput(<liquid:space> * 1000)
        .build();

RecipeBuilder.newBuilder("bylt_liquid", "odm_megav4",72000)
        .addInput(<contenttweaker:anti_viod> * 400)
        .addInput(<contenttweaker:arkforcefieldcontrolblock> * 1024)
        .addInput(<liquid:hxwz> * 50000)
        .addInput(<liquid:space_time_fluids> * 25000)
        .addOutput(<liquid:bylt> * 1000)
        .build();

RecipeBuilder.newBuilder("yh_liquid", "odm_megav4",72000)
        .addInput(<contenttweaker:anti_viod> * 400)
        .addInput(<contenttweaker:arkforcefieldcontrolblock> * 1024)
        .addInput(<liquid:space> * 5000)
        .addInput(<liquid:bylt> * 5000)
        .addInput(<liquid:hxwz> * 40000)
        .addOutput(<liquid:yh> * 100)
        .build();


MachineModifier.setMaxThreads("tc_star_weaver", 0);
MachineModifier.addCoreThread("tc_star_weaver", FactoryRecipeThread.createCoreThread("§c亿万烈阳之怒§f").addRecipe("tc_tyf1").addRecipe("tc_tyf2").addRecipe("tc_tyf3"));
MachineModifier.addCoreThread("tc_star_weaver", FactoryRecipeThread.createCoreThread("§b恒星引力压缩§f").addRecipe("tc_crystal").addRecipe("tc_gas").addRecipe("tc_alloy"));
MachineModifier.addCoreThread("tc_star_weaver", FactoryRecipeThread.createCoreThread("§d超维框架§f").addRecipe("tc_quasar_energy"));
MachineModifier.addCoreThread("tc_star_weaver", FactoryRecipeThread.createCoreThread("§a虚境超空间航道跃迁§f").addRecipe("tc_yzs"));
