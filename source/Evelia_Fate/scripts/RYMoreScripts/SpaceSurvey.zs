import mods.modularmachinery.RecipeBuilder;
import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;
import mods.modularmachinery.RecipeCheckEvent;

RecipeBuilder.newBuilder("SpaceSurvey_Con","machine_arm",7200)
    .addInputs([
        <modularmachinery:iridescentobservatory_controller>,
        <contenttweaker:horologium_star_map>,
        <botania:bifrostperm>*640,
        <contenttweaker:field_generator_v1>*4,
        <extrabotany:material:1>*2,
        <extrabotany:material:8>*2,
        <extrabotany:material:5>*2
    ])
    .addInput(<packagedastral:constellation_focus>).setChance(0)
    .requireResearch("SpaceSurvey")
    .requireComputationPoint(100.0F)
    .addEnergyPerTickInput(1000000)
    .addOutput(<modularmachinery:spacesurvey_controller>)
    .build();

function starmap(input as IIngredient[],output as IItemStack,name as int){
    RecipeBuilder.newBuilder("star_map"+name,"spacesurvey",600)
        .addInputs(input)
        .addOutput(output)
        .build();
}
starmap([<ore:gemCrystalFlux> * 64,<ore:blockPsiGem> * 4,<botania:storage:4> * 4,<botania:storage:2> * 4,<ore:paper> * 1,],<contenttweaker:monoceros_star_map>,1);
starmap([<ore:treeSapling> * 64,<ore:dirt> * 64,<ore:paper>,<ore:wool> * 64,<botania:grassseeds>],<contenttweaker:bootes_star_map>,2);
starmap([<ore:blockDraconium> * 64,<ore:blockEmerald> * 64,<ore:paper>,<ore:blockOsmium> * 64,<ore:ingotTerrasteel>],<contenttweaker:corvus_star_map>,3);
starmap([<ore:blockPrismarineBrick> * 64,<ore:listAllfishraw> * 64,<ore:paper>,<minecraft:snow> * 64,<ore:manaPearl>],<contenttweaker:lyra_star_map>,4);
starmap([<ore:obsidian> * 64,<minecraft:nether_brick> * 64,<ore:paper>,<ore:blockCoal> * 64],<contenttweaker:fornax_star_map>,5);
starmap([<contenttweaker:field_generator_v1> * 64,<ore:paper>,<ore:elvenDragonstone>],<contenttweaker:thunderbolt_star_map>,6);
RecipeBuilder.newBuilder("horologium_star_1", "spacesurvey", 600,0)
    .addInput(<contenttweaker:corvus_star_map>).setChance(0)
    .addInput(<contenttweaker:bootes_star_map>).setChance(0)
    .addInput(<contenttweaker:monoceros_star_map>).setChance(0)
    .addInput(<contenttweaker:lyra_star_map>).setChance(0)
    .addInput(<contenttweaker:fornax_star_map>).setChance(0)
    .addInput(<contenttweaker:thunderbolt_star_map>).setChance(0)
    .addInputs([<ore:ingotOrichalcos>,<ore:paper>])
    .addOutput(<contenttweaker:horologium_star_map>)
    .build();
RecipeBuilder.newBuilder("constellation_1","spacesurvey",600)
    .addInputs([
        <contenttweaker:corvus_star_map>,
        <contenttweaker:lyra_star_map>,
        <contenttweaker:fornax_star_map>,
        <contenttweaker:bootes_star_map>,
        <contenttweaker:monoceros_star_map>,
        <contenttweaker:thunderbolt_star_map>,
        <contenttweaker:horologium_star_map>,
        <botania:bifrostperm>*16,
        <astralsorcery:itemcelestialcrystal>.withTag({astralsorcery: {crystalProperties: {collectiveCapability: 100, size: 900, fract: 0, purity: 100, sizeOverride: -1}}})
    ])
    .addOutput(<packagedastral:constellation_focus>)
    .addRecipeTooltip("群星之力，汇聚于此")
    .build();
RecipeBuilder.newBuilder("celestial_1","spacesurvey",60)
    .addInput(<packagedastral:constellation_focus>).setChance(0)
    .addInput(<astralsorcery:blockcustomore>*4).setChance(0)
    .addInputs([
        <astralsorcery:itemcraftingcomponent:2>*4,
        <tconstruct:clear_glass>*16,
        <liquid:astralsorcery.liquidstarlight>*500
    ])
    .addOutput(<astralsorcery:itemcelestialcrystal>.withTag({astralsorcery: {crystalProperties: {collectiveCapability: 100, size: 900, fract: 0, purity: 100, sizeOverride: -1}}}))
    .addRecipeTooltip("快速大量制造完美的水晶石")
    .addRecipeTooltip("会有用的")
    .build();
RecipeBuilder.newBuilder("crystalred_survey","spacesurvey",1500)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16;
    })
    .addInput(<contenttweaker:corvus_star_map>).setChance(0)
    .addInput(<contenttweaker:bootes_star_map>).setChance(0)
    .addInput(<contenttweaker:monoceros_star_map>).setChance(0)
    .addInput(<contenttweaker:lyra_star_map>).setChance(0)
    .addInput(<contenttweaker:fornax_star_map>).setChance(0)
    .addInput(<contenttweaker:thunderbolt_star_map>).setChance(0)
    .addInput(<contenttweaker:horologium_star_map>).setChance(0)
    .addInputs([
        <ore:Antimatter> * 12,
        <liquid:liquid_energy> * 2
    ])
    .addOutput(<contenttweaker:crystalred>)
    .addOutput(<contenttweaker:crystalred>).setChance(0.5)
    .addRecipeTooltip("最大并行为16")
    .build();