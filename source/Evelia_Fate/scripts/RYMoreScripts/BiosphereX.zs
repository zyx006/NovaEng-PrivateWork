import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.MachineBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.MMEvents;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.RecipeStartEvent;
import mods.modularmachinery.RecipeTickEvent;
import mods.modularmachinery.RecipeFinishEvent;
import mods.modularmachinery.ControllerGUIRenderEvent;
import mods.modularmachinery.FactoryRecipeStartEvent;
import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.MachineTickEvent;
import mods.modularmachinery.SmartInterfaceType;
import mods.modularmachinery.MachineUpgradeHelper;

import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;

import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.research.ResearchCognitionData;
import mods.botaniatweaks.Agglomeration;
import novaeng.hypernet.ComputationCenterType;
import novaeng.hypernet.DataProcessorType;
import novaeng.hypernet.upgrade.type.ProcessorModuleGPUType;
import novaeng.hypernet.upgrade.type.ProcessorModuleRAMType;

RecipeBuilder.newBuilder("BiosphereX_Con","workshop",7200)
    .addInputs([
        <draconicevolution:mob_soul>*16,
        <minecraft:soul_sand>*128,
        <contenttweaker:hypernet_cpu_t3>*4,
        <additions:novaextended-novaextended_medal5>,
        <avaritia:ultimate_stew>*8,
        <avaritia:cosmic_meatballs>*8,
        <botania:blacklotus:1>*64
    ])
    .addOutput(<modularmachinery:biospherex_factory_controller>)
    .requireComputationPoint(100.0F)
    .build();
Agglomeration.addRecipe(<modularmachinery:colturetank_controller>,
[<botania:manaresource:4>*2,<botania:storage>,<botania:manatablet>.withTag({mana: 500000})],
700000,0x00FF00,0x1E90FF,
<modularmachinery:illum_pool_factory_controller>,<botania:storage:4>,<draconicevolution:draconic_block>,
<modularmachinery:illum_pool_factory_controller>,<minecraft:diamond_block>,<draconicevolution:draconium_block>
);
Agglomeration.addRecipe(<modularmachinery:colturetank_factory_controller>,
[<contenttweaker:exponential_level_processor>*4,<extrabotany:material:8>*8,<extrabotany:material:5>*8,<modularmachinery:colturetank_controller>],
1200000,0x00FF00,0x1E90FF,
<modularmachinery:alfheim_portal_factory_controller>,<extrabotany:blockorichalcos>,<botania:storage:1>,
<modularmachinery:alfheim_portal_factory_controller>,<botania:storage:1>,<botania:storage>
);
RecipeBuilder.newBuilder("petri_dish","material_entropy_converter",720)
    .addInputs([
        <enderio:block_fused_glass>,
        <contenttweaker:charging_crystal>
    ])
    .addOutput(<contenttweaker:petri_dish>*8)
    .addEnergyPerTickInput(200000)
    .build();

MachineModifier.setMaxParallelism("colturetank", 16);
HyperNetHelper.proxyMachineForHyperNet("colturetank");
MachineModifier.setMaxThreads("colturetank",0);
MachineModifier.addCoreThread("colturetank",FactoryRecipeThread.createCoreThread("环境控制计算机")); 
MachineModifier.addCoreThread("colturetank",FactoryRecipeThread.createCoreThread("普通细菌生长控制"));
MachineModifier.addCoreThread("colturetank",FactoryRecipeThread.createCoreThread("异氙菌控制")); 
MachineModifier.addCoreThread("colturetank",FactoryRecipeThread.createCoreThread("拉多生产")); 
MachineModifier.addCoreThread("colturetank",FactoryRecipeThread.createCoreThread("培养皿制作")); 
for i in 1 to 9{
    MachineModifier.addCoreThread("colturetank",FactoryRecipeThread.createCoreThread("普通合成区域#"+i)); 
}

RecipeBuilder.newBuilder("BioConCom","colturetank",20)
    .addInput(<contenttweaker:programming_circuit_0>).setChance(0)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        ctrl.addModifier("bioconcom", RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.3, 1, false).build());
    })
    .setThreadName("环境控制计算机")
    .addRecipeTooltip("会让相同机器里同时运行的所有配方消耗时间降低70%","不要在普通控制器里使用，不然你会后悔的")
    .setParallelized(false)
    .build();
RecipeBuilder.newBuilder("petri_dish_a","colturetank",420)
    .addInputs([
        <contenttweaker:petri_dish>,
        <gas:nutrientsolution> * 2160,
        <minecraft:golden_apple:1>,
        <contenttweaker:lifesense_processor>,
    ])
    .addOutput(<contenttweaker:petri_dish_a>).setChance(0.2)
    .addEnergyPerTickInput(20000)
    .requireComputationPoint(30.0F)
    .setThreadName("培养皿制作")
    .build();
RecipeBuilder.newBuilder("petri_dish_b","colturetank",840)
    .addInputs([
        <contenttweaker:petri_dish_a> * 2,
        <contenttweaker:hxs> * 4,
        <draconicevolution:chaos_shard:2>* 3,
    ])
    .addOutput(<contenttweaker:petri_dish_b>).setChance(0.3)
    .addOutput(<contenttweaker:petri_dish_a>).setChance(0.6)
    .addEnergyPerTickInput(50000)
    .requireComputationPoint(50.0F)
    .setThreadName("培养皿制作")
    .build();
RecipeBuilder.newBuilder("rado_dish","colturetank",2400)
    .addInputs([
        <contenttweaker:petri_dish_b> * 8,
        <draconicevolution:chaotic_core> * 16,
        <draconicadditions:chaotic_energy_core> * 14,
        <liquid:crystalloid> * 2560,
    ])
    .addInput(<avaritia:resource:5>).setChance(0).setParallelizeUnaffected(true)
    .addOutput(<contenttweaker:rado_dish>).setChance(0.2)
    .addOutput(<contenttweaker:rado_dish>).setChance(0.15)
    .addOutput(<contenttweaker:rado_dish>).setChance(0.1)
    .addRecipeTooltip("只需要一个无尽催化剂即可")
    .setThreadName("培养皿制作")
    .build();
RecipeBuilder.newBuilder("nutri","colturetank",120)
    .addInputs([
        <minecraft:rotten_flesh> * 50,
        <liquid:water> * 5000
    ])
    .addOutput(<gas:nutrientsolution>*1000)
    .addInput(<contenttweaker:petri_dish_a>).setChance(0)
    .addRecipeTooltip("培养皿数量决定并行")
    .addEnergyPerTickInput(20000)
    .requireComputationPoint(20.0F)
    .setThreadName("普通细菌生长控制")
    .build();
RecipeBuilder.newBuilder("strxen","colturetank",2400)
    .addInputs([
        <liquid:oil> * 20000,
        <extendedcrafting:material:40>
    ])
    .addInput(<contenttweaker:petri_dish_b>).setChance(0)
    .addOutput(<liquid:strxenon>*1000).setChance(0.5)
    .requireComputationPoint(30.0F)
    .addEnergyPerTickInput(100000)
    .setThreadName("异氙菌控制")
    .addRecipeTooltip("培养皿数量决定并行")
    .build();
RecipeBuilder.newBuilder("rado_produce","colturetank",1200)
    .addInputs([
        <liquid:crystalloidneutron> * 120,
        <liquid:cryotheum> * 16384,
        <liquid:pyrotheum> * 16348,
        <liquid:crystalloid> * 512
    ])
    .addInput(<contenttweaker:rado_dish>).setChance(0)
    .addOutput(<liquid:rado> * 2048).setChance(0.03)
    .addOutput(<liquid:rado> * 3072).setChance(0.015)
    .addOutput(<liquid:rado> * 5120).setChance(0.005)
    .setThreadName("拉多生产")
    .addRecipeTooltip("培养皿数量决定并行")
    .build();
RecipeBuilder.newBuilder("distill_col","colturetank",60)
    .addInputs([
        <ore:itemSkull>,
        <liquid:water> * 1500
    ])
    .addOutput(<liquid:nutrient_distillation> * 750)
    .setMaxThreads(1)
    .setParallelized(false)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <minecraft:nether_wart> * 2,
                <minecraft:fermented_spider_eye>,
                <minecraft:sugar> * 4,
                <minecraft:red_mushroom> * 4,
                <minecraft:brown_mushroom> * 4,
                <minecraft:beef> * 3,
                <minecraft:mutton> * 3,
                <minecraft:chicken> * 3
            ])
    )
    .build();
RecipeBuilder.newBuilder("cloud_col","colturetank",60)
    .addInputs([
        <liquid:water> * 800,
        <ore:blockIce>
    ])
    .addOutput(<liquid:cloud_seed> * 800)
    .setMaxThreads(1)
    .setParallelized(false)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:itemSalt> * 4,
                <minecraft:clay_ball> * 4,
                <ore:dustSilver> ,
                <minecraft:snow>,
            ])
    )
    .build();
RecipeBuilder.newBuilder("ender_distill_col","colturetank",60)
    .addInputs([
        <enderio:item_material:36>,
        <enderio:item_material:37>,
        <liquid:nutrient_distillation> * 4000,
    ])
    .addOutput(<liquid:ender_distillation> * 1000)
    .setMaxThreads(1)
    .setParallelized(false)
    .build();

HyperNetHelper.proxyMachineForHyperNet("biospherex");
MachineModifier.setMaxThreads("biospherex",0);
MachineModifier.addCoreThread("biospherex",FactoryRecipeThread.createCoreThread("装置更新"));
MachineModifier.addCoreThread("biospherex",FactoryRecipeThread.createCoreThread("净化器"));

var maxcleanliness = [0,4000,10000,200000,1000000,10000000] as int[];
var cleanlinessadd = [0,20,50,200,1000,5000,20000] as int[];
var energymagn = [1,1,5,10,60,150,600] as int[];

var nova = <minecraft:skull:3>.withTag({SkullOwner: {Id: "92396ca4-e643-44e8-b3dc-61d35fc0127d", Properties: {textures: [{Signature: "QGS5qfCsxdUMTHPIJ9W9PBJkP0bu26NwlK1OmjiyN17kmPDHDd+j0Ao+SbIpv/pxGaItBfRq52ETsOwbTe3mnnNWv3JooQN8YlEHVaZrZK/32i01Y53MUDZ3JtVJPEiIb3EOkhIciGUMeRpNTa9CVv5skOn+rye0f/eetQRUFAZKRSdgW7Gz1MnqzAPOCct69RHcHCCnwny/DSGnNsnfz+AJKOyubdRHBZbX/+Ug+8AMa2ava/rrMFV5h8oTT57awpBsnKsWac1Mijk/8wmpci6bA8b8xiIBBmLV//tGj/iU1eusfx+zkanYDdPoLOmxf00vkblyf/Rt4oNbp/h9f3d7+SnnwPCzvUvKm2GzngVmS35epIZGshU3/cuvBOmvGNLZux5x2ykxCwECsJhEVy7lvzpYMC5iNH1i3hZVqKGLOcBSOFBSz0vlAyMAkJnmlCW2TBaXbx/O5LdC/czLCqGpRfmlUjBz8RA27WVQ/HvCG/ys0s3JBJGYHD/xVcGwMFuIQPR4GCCAIEUxLO/o23c+4mSowugj5phZ7WUEl7A6O8m3cAcx3kyj8k4SmMsBo1pf7Khmq4KRznMrv9JZnkIOGXOpqjzCccj7C9B0S5v/Viz1/9K1jaPxdkcm4qk6XVFCru5yvKGb5Jc9H+W4KuvHGi1WbbSBNU2ftZ7GojY=", Value: "ewogICJ0aW1lc3RhbXAiIDogMTY4NTYxNzM1ODE1OSwKICAicHJvZmlsZUlkIiA6ICI5MjM5NmNhNGU2NDM0NGU4YjNkYzYxZDM1ZmMwMTI3ZCIsCiAgInByb2ZpbGVOYW1lIiA6ICJLYXN1bWlfTm92YSIsCiAgInNpZ25hdHVyZVJlcXVpcmVkIiA6IHRydWUsCiAgInRleHR1cmVzIiA6IHsKICAgICJTS0lOIiA6IHsKICAgICAgInVybCIgOiAiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS81ODQ1OWU5ZmQ1YzQxZTlhZWYxMzVjYzdjYzUwMWM2MTBjMDA2Y2UzYzQxNzYwYTUwYTA5MmZhYzJmZDYxYzNkIiwKICAgICAgIm1ldGFkYXRhIiA6IHsKICAgICAgICAibW9kZWwiIDogInNsaW0iCiAgICAgIH0KICAgIH0KICB9Cn0="}]}, Name: "Kasumi_Nova"}});
var raa = <minecraft:skull:3>.withTag({SkullOwner: {Id: "249f5c67-eab5-4357-990d-501abb5069e6", Properties: {textures: [{Signature: "Fqmsk5tonG7eHpcVN7tzslDdVKKkB8yaFyN4yJSHYSTpfFhiP32g6iqoy994rQU1/zCwVM4m+eRyJafYmxgq2RoUoUZTGS8inCGdeTazW8lj0q6XGSSXFpOWWYMgdBBXn8lQVMHM0wGczSZaeRcq3P/CcgXJSXJwN6PcsUY5RO4d0BNdEydbnXXTz9ME+PqqjtAIU4NZfr+gac/J7Vfh65vCQcHAvZ/lZiv2sp2cvJPR8qb5qrH+A9ajx6Es6RI9NzxVgkhzk+ZyaDKDy267Bx2+BMnEJRt61DbPpw/BNI+Fd/Fm49inBxuu8cLmCgHkyd6eSkm+r5NrruI+3l3FNo0ArVpZsXn8llPa0QPqm8Fd3BTxnpSzSWbq58b2Zw9jKNho4VtmyOsCPa7CZ6vqowboHDeXE785ccxT4SGn2fe9VHLGY9OBRAn8vURwJ3enDYYrLexiLcg0Elv2VbT2vmMw2Vfke/HvQ2d4jnpm7Q44hAslH6jTdWk+Ozg4kTercICF755n/ui5xLCvHFTbKoDnsSQkzsPDwP0auWVAawhJ5yJYqiEyngNvX+73pv7jsrjgDRq/o/xN3paYQgb5B/Xo/9q024cI7dLUJKgDmSLucn3ja8BLLsHwIo0MiafPesyvLv3s+mENBBxXarYlbGm7gd5W1AXtFyZJvjxDmnI=", Value: "ewogICJ0aW1lc3RhbXAiIDogMTc0MzY3NzE5MzE3NiwKICAicHJvZmlsZUlkIiA6ICIyNDlmNWM2N2VhYjU0MzU3OTkwZDUwMWFiYjUwNjllNiIsCiAgInByb2ZpbGVOYW1lIiA6ICJDaXJjdWxhdGlvbl8iLAogICJzaWduYXR1cmVSZXF1aXJlZCIgOiB0cnVlLAogICJ0ZXh0dXJlcyIgOiB7CiAgICAiU0tJTiIgOiB7CiAgICAgICJ1cmwiIDogImh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZDk2ZjdlNGFhYmNhNzFhMTA3YjdlMGUyYzUxY2RlY2M3YzQyMDY3MTEzMjEyYzljM2FkMjczOTkwMGM4MDIzZSIsCiAgICAgICJtZXRhZGF0YSIgOiB7CiAgICAgICAgIm1vZGVsIiA6ICJzbGltIgogICAgICB9CiAgICB9CiAgfQp9"}]}, Name: "Circulation_"}});
var fate = <minecraft:skull:3>.withTag({SkullOwner: {Id: "b92337e1-f8b8-4270-bb28-1e60eb3c2a45", Properties: {textures: [{Signature: "WG3/C/LBCGUOv50ZlI74R8R7w4lRTAxEstvInLRLJYtwgCEF2y9uGKdz3h9ZZP/xPUiCSKwgfc1cugf46TTdiMlOJbYwMkI7El7iG2v8cgUvV4WD1GRUi2EzUbnP33zMAq499F+F5K7aKqtmERToThVW8gss0P031nzZvlOzj0NB39m1uMArPCP9iNqbv4TlTv7Uupqrwx3WzcgT0y2SSUefLaQkHYd0F6asCaFmoZ9wDdGPq8zQ5PA8aqjz00OsnPetdcfBeiOtBwbjAm6RORV8IEJB3WjJu3Gitr8sB3eWdvstMdRLw4U3UZdxSZdsFdLXQbn7ZNrzKTqUF+/VrrOABiuU+fMcRAXXIMntTvCL/Yx8x/BuepdWAIQhIJv8SbLDPAE+QSFAiKMAwzqorbm5+wjNUaETWChe01auvsdeY9iyxIR/AVJ4wC2yNrGLeHlaxn4BzS8aAyvEwCg5z85qeDHeJID/R8EKvWG5x7gvYCmX65h1cwABZsBnWwZTKY0/J3fC7ojWsuo9FoCtbicflM4v4dt6JDL4/647ZTUu//e5z5drpc/0mWUQA0x+H7VJkPo8OaAr9nIlSsxI/Ng6iMX7fqN5YcWP8SQ9tDq47yA2woYRiHPNaZbpopVRD3VrXbP1M9p6eJoSTnmzFDuvsDNRx2CITePe46GQi4Q=", Value: "ewogICJ0aW1lc3RhbXAiIDogMTc0MzY3NjE4MDA5OCwKICAicHJvZmlsZUlkIiA6ICJiOTIzMzdlMWY4Yjg0MjcwYmIyODFlNjBlYjNjMmE0NSIsCiAgInByb2ZpbGVOYW1lIiA6ICJFdmVsaWFfRmF0ZSIsCiAgInNpZ25hdHVyZVJlcXVpcmVkIiA6IHRydWUsCiAgInRleHR1cmVzIiA6IHsKICAgICJTS0lOIiA6IHsKICAgICAgInVybCIgOiAiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS9mOWNhNDI1NjNmNjZmMTdmYmYyZTFmODk5ZTVmOWFmNjM3NTU4NDdhZmQ4YWQzZTNlOWNkYTJhYWZlYzVmNzI5IiwKICAgICAgIm1ldGFkYXRhIiA6IHsKICAgICAgICAibW9kZWwiIDogInNsaW0iCiAgICAgIH0KICAgIH0KICB9Cn0="}]}, Name: "Evelia_Fate"}});
var ohxihh = <minecraft:skull:3>.withTag({SkullOwner: {Id: "eb563584-b359-456f-bcb0-1bd6962b896e", Properties: {textures: [{Signature: "dT85kApD5NSVUPpS8OZGO+YBgj9hKAorBfA2KjuF1zcqpSYgbryaZ96disEToPOISOON8RaO6vH9229H+wlpRPHba8NR7wrDTTehrLDHOHkj8I21kbTKTYqFHzHmyYPrPBHphcs93zYO8eF4JzCwg0mUEJTtRTykxUmEyInmS0PvFX72De2EW8jY6gvuyEc4Q8+Nqvxnh2oD2kSwlHX6QkJwrjOTRA6f3UeDJKAmFC3ahxlRCzqVbtJ60D2hbK72g1WzSNhttckNcgs+PZ1JFix+2Y8H1/jn4f1Fs29KenUxxaSQdoB7p8PSrrnztzHensziBlbXiO3yjOX7icmT2iqiIzw5Uy+DEWEDz0YaKez4DwjiVc7TOFfnoknV1+Dihm85xRMWx64JE5l0h/9aj/QgRwy/o1CYfcAdTkK2Mooez8NLgY3HajkvxUUoykr0iyRodAzpcRXQ8u0Y8g5hIpmySL6kv2h9ddqbKKJanr5r1AjhYw0Oa76o8GQzrD6c/LjnSuAIp6Tjfzm0tA3rclklAzqRQHKT3K19jN16nycN0gVfIKK7vACwp/+7x86pMlUYeOANzxxqXovODb/OiYZVX32WZJRsv2ZXuSD73h3Sx6IuWaASouZuyZIHUiWosDJqhGjFBfT6uf7eVQC8w2mdMZ2OmOnMQ90m5yh+qwA=", Value: "ewogICJ0aW1lc3RhbXAiIDogMTc0MzY3NzYwNTQ3OSwKICAicHJvZmlsZUlkIiA6ICJlYjU2MzU4NGIzNTk0NTZmYmNiMDFiZDY5NjJiODk2ZSIsCiAgInByb2ZpbGVOYW1lIiA6ICJvaHhpaGgiLAogICJzaWduYXR1cmVSZXF1aXJlZCIgOiB0cnVlLAogICJ0ZXh0dXJlcyIgOiB7CiAgICAiU0tJTiIgOiB7CiAgICAgICJ1cmwiIDogImh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMTJiNTliMTRjN2JlNjYxMzc2MjkzNWYxYjcwYjgwYWMzZDY3Y2YwNzMyNTExMzk1ZTFmZmY4YTgwZDIxNmNlNCIKICAgIH0sCiAgICAiQ0FQRSIgOiB7CiAgICAgICJ1cmwiIDogImh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNTY5YjdmMmExZDAwZDI2ZjMwZWZlM2Y5YWI5YWM4MTdiMWU2ZDM1ZjRmM2NmYjAzMjRlZjJkMzI4MjIzZDM1MCIKICAgIH0KICB9Cn0="}]}, Name: "ohxihh"}});
var remilia = <minecraft:skull:3>.withTag({SkullOwner: {Id: "5e66a961-fb48-4cc3-9504-163718dd73fc", Properties: {textures: [{Signature: "p5w7asw1ntEqib5CxLXyIMIwLiznbnshbYKciGB3VWgvxxOPCaebR41x0lxyWRaelK///zFhGJQKWw6UJd3gPzXmhtKZta1oHgxbim61oMgC1uS7giOd9rlVLQm50rj8K4muxG96aYudT8nlu86nGV+eh8F95mk+nEl7A59DJ3QIg7VCfrbpmetrd+0UrCH1Ytw7mkH2DM1/KzAe/zWu2NxJno2y7dElfq2j0M9ta5B18OScLL1EwTVaXuJPNZGMoSeGQ6LOnGDxd29rgrfbdmx2fIEV24VIXWrJWFd66y1L1yraRGEEYO58t7w4V1iAFJcUa8SOVDqVxCE095tBq+ZEOrqKffVVmTSapIzIAUVRPXJLwqltMrUN3JzGVzXSBC+HsxVighZgjM2/TCn4zX8q8SFizsBx4ptU0BuLkjJBXMIo4RPA+s91T2ozTprAwZCdkefIgFQL9nw3xYKZuvdC79lR4huq3Ay0hbgS4M+O5QQMUZq6sAoM3n0rTA6R8bjHOhjmesTBUpefbRnKR6A5sb6CKHSx0COhOH/OWnnHNZ53wYetqQYV7z+wYsb5RcghVmrdCXKQqhL1QGRtYy3/cx6r7zey+msiKRJdZ/AbcH2Qd21PULlfF46+z8zouKfkWnbcK9poh2IFc+XgGdw4vPPHwwWC4ZlHTSSQGSU=", Value: "ewogICJ0aW1lc3RhbXAiIDogMTc0MzY3NzYyNzg3NSwKICAicHJvZmlsZUlkIiA6ICI1ZTY2YTk2MWZiNDg0Y2MzOTUwNDE2MzcxOGRkNzNmYyIsCiAgInByb2ZpbGVOYW1lIiA6ICJSZW1pbGlhIiwKICAic2lnbmF0dXJlUmVxdWlyZWQiIDogdHJ1ZSwKICAidGV4dHVyZXMiIDogewogICAgIlNLSU4iIDogewogICAgICAidXJsIiA6ICJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzg2NWMyZGE4ZjI3NGM5NDFjYTMzZGU1NzExNTYwOGMwM2JhNmUwMGZjNDlmODg2ZDI0YzcxY2M5NDkzYWI4Y2IiLAogICAgICAibWV0YWRhdGEiIDogewogICAgICAgICJtb2RlbCIgOiAic2xpbSIKICAgICAgfQogICAgfQogIH0KfQ=="}]}, Name: "Remilia"}});
var inf7y = <minecraft:skull:3>.withTag({SkullOwner: {Id: "83fad84a-aeaa-40a9-a331-1ee769cf4faa", Properties: {textures: [{Signature: "lEsebxdv6jcQTD6ephl1mzQvxeRETLBAElDlolf5qP0BXhZJPsHyF6E9DrRUBLUJ/fKum5haVT+9Vte8UjDBGg9ogkBVn3ywFB2BQThUHfL/3sQHRMOviQBohe9C+kZIYIDBGcJIFzJX93AczY1Q+q5t8i1UPF6hYJhKndYh4QYYrj77Ed7fVBoKXKQyM1zCRK+KpOzsb3N5ProKAghz1hxopUe6O+SRTHpOsxlJKvb/mOfY+JouzJVvPDTGOJlZ2hYedZrXq4/rrpD+LPN8Vxu7zYiYCU4jBwejeFltT20MnkBi857oWeMEcODuMHgS48VkZc2BEJRRFjeVD81WnuqgLrD/j0SzbBB+oGisUjglf81UIklC1pSiIrluMe/sg6/IApXu5kqNbxrPMp5vtxUtQV/BCI3JVud2GWJZMZ4Zuk5KsPoaJxgI8fjxcfuAuu79spLkldtZ3rM7C2ht9rQtuTq0/AmoCmq611ZAe2GYb/EUFvVtfewjHuUCjD8mCjXBmxcxdGHVedIL/jkOAo4/T1aFLbm48F+80WW8lAHAR7//xG6zY1ulDmYhYulOe57ZZlKZLVt7aA228qiSWJy/Tbq4MbikhzLUkuC5HckmxEtWxyaObelMRf4yxALhPRg/7nEofOzzXN7d92H9Eh9zDXlPPgVpqZeQa4Fkn7Y=", Value: "ewogICJ0aW1lc3RhbXAiIDogMTc0Mzc2NzEzODg1OCwKICAicHJvZmlsZUlkIiA6ICI4M2ZhZDg0YWFlYWE0MGE5YTMzMTFlZTc2OWNmNGZhYSIsCiAgInByb2ZpbGVOYW1lIiA6ICJpTmY3eV9FbnRyNjBweSIsCiAgInNpZ25hdHVyZVJlcXVpcmVkIiA6IHRydWUsCiAgInRleHR1cmVzIiA6IHsKICAgICJTS0lOIiA6IHsKICAgICAgInVybCIgOiAiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS80OGMzZDNhOGMwM2NmY2RmMjIxZDAxYTc1NWJjY2NlMGZjYjQ5ODQ1ZDVlNGRiMWM0YTIzYzVhZWQyN2YxZDFiIgogICAgfSwKICAgICJDQVBFIiA6IHsKICAgICAgInVybCIgOiAiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS9jZDlkODJhYjE3ZmQ5MjAyMmRiZDRhODZjZGU0YzM4MmE3NTQwZTExN2ZhZTdiOWEyODUzNjU4NTA1YTgwNjI1IgogICAgfQogIH0KfQ=="}]}, Name: "iNf7y_Entr60py"}});
var RTG = <minecraft:skull:3>.withTag({SkullOwner: {Id: "f942e189-4251-414f-a114-3c9abe6d6827", Properties: {textures: [{Signature: "k2hnoc1Yacr0HC7ZZGrrbyGnB4vfhh/848fiNVgMroNWvsTLfnRjdUZEb8wSg5fGoDF2G43VUpGOiBDxlpjGLllockhd7g5mY+gsoSAPcP2W2QbFmmZlGvdK6GQ9gXbxjvFUPEKc8GFO4DBO7m/WIsMmJcuT7pK+Es9Mp1JkdeTZ8kYh+hAnUPZuxZLvtTDnRNYh0G86thckuhS7iFd9+pKr17R2j/03i1IUk1v86Umou5vKXQChqjeWy4lGfg6DZ7YkvTV2EdF/YveYUptjHVyiDEYigNSqRX7f77i4j4Qip6PuMSnStUzTANIGt0PqmSHXTbfa4l1lyfKCkDPryXBO6Fp4nb4/1hPVOG+1izJunKgbfCfljq6owArO0j5dhYsNio0Ee600ZOoTBNuuQtmi1vahITGWu89PhDJ0+7FiPE7KrDjOAtSmurdX4zYAOo+v41pr8Crn+lww+CH3wexOBST7SeNyXgGc+9+zkwBm+8c2KksHhqEUB8jn4sFfCrG/x0bRMJ7T42luDOgPtMgLbY/mNZBarWqQyL0pFOvm4N6TzA0VqAVOnISB5qq9u8n4MCtBxTnQS1L1mccagAXpQ/PlU0TWfUsBtmqVXWf2W8qtJIVja9f4eINnfqDFGZmPvuCLT/O1tcuZFtZ/TY22mkBUVSvc0zTIWWSl4/I=", Value: "ewogICJ0aW1lc3RhbXAiIDogMTc0NDQ3MDgzOTQ1MSwKICAicHJvZmlsZUlkIiA6ICJmOTQyZTE4OTQyNTE0MTRmYTExNDNjOWFiZTZkNjgyNyIsCiAgInByb2ZpbGVOYW1lIiA6ICJSVEczNTIxIiwKICAic2lnbmF0dXJlUmVxdWlyZWQiIDogdHJ1ZSwKICAidGV4dHVyZXMiIDogewogICAgIlNLSU4iIDogewogICAgICAidXJsIiA6ICJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzVhY2FlZWFjNzhhNTZjOTkwNjNjMmY1OWRmYzU0YzU3ZjI5NDdkNzlhN2Y0ZmVkM2JmZTBiNzZlMWZmMjcxN2UiCiAgICB9CiAgfQp9"}]}, Name: "RTG3521"}});

MMEvents.onControllerGUIRender("biospherex",function(event as ControllerGUIRenderEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val dData = D(data);
    val IsoLev = dData.getInt("IsoLev",0);
    val PerDeLev = dData.getInt("PerDeLev",0);
    val Cleanliness = dData.getInt("Cleanliness",0);
    var info as string[] = [];
    info += "————生物环境监测装置————";
    info += "当前隔离装置等级：" + IsoLev;
    info += "当前净化装置完整度："+PerDeLev + "/6";
    info += "当前洁净度：" + Cleanliness + "/" + maxcleanliness[IsoLev];
    event.extraInfo = info;
});

function Isolation(lev as int,ene as int,time as int,input as IIngredient[]){
    var baseen = 1000000 as long;
    val relene = baseen * ene;
    RecipeBuilder.newBuilder("tisolation"+lev,"biospherex",time)
        .addInputs(input)
        .addEnergyPerTickInput(relene)
        .addPreCheckHandler(function(event as RecipeCheckEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val IsoLev = dData.getInt("IsoLev",0);
            if(lev <= IsoLev){
                event.setFailed("已经有同等级或更高等级的隔离装置！");
            }
        })
        .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            map["IsoLev"] = lev;
            ctrl.customData = data;
        })
        .addRecipeTooltip("为机器安装"+lev+"级隔离装置","会覆盖低级的隔离装置")
        .setThreadName("装置更新")
        .build();
}
Isolation(1,1,360,
    [
        <contenttweaker:nickel_wire> * 66,
        <ore:plateNickel> *25,
        <ore:gearNickel> * 16,
        <ore:stickNickel> * 49,
    ]
);
Isolation(2,5,720,
    [
        <contenttweaker:stellar_alloy_wire> * 55,
        <ore:gearStellarAlloy> * 36,
        <ore:plateStellarAlloy> * 30,
        <enderio:item_capacitor_stellar> *4,
    ]
);
Isolation(3,200,1200,
    [
        <contenttweaker:infinity_wire> * 12,
        <moreplates:infinity_plate> * 4,
        <avaritiatweaks:enhancement_crystal> *2,
        <ore:itemInfinityRod> * 99,
    ]
);
Isolation(4,500,2400,
    [
        <ore:ingotArk> * 22,
        <contenttweaker:arkforcefieldcontrolblock> * 3,
        <contenttweaker:coil_v5> * 6,
        <ore:ingotAlloyT3> * 9,
    ]
);
Isolation(5,50000,3600,
    [
        <contenttweaker:fragments_of_the_space_time_continuum> * 66,
        <contenttweaker:space_time_condensation_block> * 14,
        <novaeng_core:estorage_cell_item_256m> *16,
        <novaeng_core:estorage_cell_fluid_256m> * 16,
        <avaritiaddons:avaritiaddons_chest:1> * 8,
        <liquid:liquid_energy> * 12000,
    ]
);

function Purification(lev as int,ene as int,time as int,input as IIngredient[],intro as string){
    var baseen = 100000000 as long;
    val relene = baseen * ene;
    val reqlev = lev - 1;
    RecipeBuilder.newBuilder("purification"+lev,"biospherex",time)
        .addInputs(input)
        .addEnergyPerTickInput(relene)
        .addPreCheckHandler(function(event as RecipeCheckEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val PerDeLev = dData.getInt("PerDeLev",0);
            if(PerDeLev != reqlev){
                event.setFailed("待安装部分错误，无法耦合！");
            }
        })
        .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val map = data.asMap();
            map["PerDeLev"] = lev;
            ctrl.customData = data;
        })
        .addRecipeTooltip(""+intro,"需要前一部分的净化装置")
        .setThreadName("装置更新")
        .build();
}
Purification(1,1,720,
    [
        <ic2:rotor_carbon> * 16,
        <mets:titanium_iron_alloy_rotor> * 8,
        <thermaldynamics:duct_16:6> * 64,
        <mekanism:transmitter:2>.withTag({tier: 3}) * 81,
        <modularmachinery:gas_generator_controller>,
    ],
    "净化装置的第一部分是设置空气以及液体的自循环体系"
);
Purification(2,5,1440,
    [
        <contenttweaker:engineering_battery_v4> * 12,
        <contenttweaker:sensor_v3> * 32,
        <contenttweaker:exponential_level_processor> * 48,
        <enderio:item_capacitor_stellar> * 64,
        <enderio:item_capacitor_totemic> * 26,
    ],
    "净化装置的第二部分是设置详细的监测装置"
);
Purification(3,15,1800,
    [
        <contenttweaker:hypernet_gpu_t3> * 4,
        <contenttweaker:hypernet_ram_t5> * 8,
        <appliedenergistics2:spatial_storage_cell_128_cubed> * 27,
        <draconicadditions:chaotic_energy_core> * 8,
    ],
    "净化装置的第三部分是详细分析并高效使用获得的数据"
);
Purification(4,35,2600,
    [
        <mets:living_circuit> * 128,
        <mets:nano_living_metal> * 512,
        <contenttweaker:crystalpurple> * 21,
        <botania:manaresource:14> * 192,
    ],
    "净化装置的第四部分是用纳米机器人从原子层面清除杂质"
);
Purification(5,106,3900,
    [
        <avaritiaio:infinitecapacitor> * 18,
        <avaritiaddons:infinity_glass> * 5,
        <avaritiatweaks:enhancement_crystal> * 24,
        <botania:specialflower>.withTag({type: "asgardandelion"}) * 4,
    ],
    "净化装置的第五部分是借助寰宇之力进行彻底且完全的清洁"
);
Purification(6,248,8100,
    [
        <contenttweaker:fragments_of_the_space_time_continuum> * 64,
        <contenttweaker:arkforcefieldcontrolblock> * 29,
        <contenttweaker:energized_fuel_v4> * 41,
        <contenttweaker:field_generator_v4> * 19,
        <contenttweaker:sensor_v5> * 25
    ],
    "净化装置的最后一部分是控制时空本身的运行"
);

RecipeBuilder.newBuilder("purificate","biospherex",1)
    .addEnergyPerTickInput(200000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val Cleanliness = dData.getInt("Cleanliness",0);
        val IsoLev = dData.getInt("IsoLev",0);
        val PerDeLev = dData.getInt("PerDeLev",0);
        if(IsoLev == 0){
            event.setFailed("还不存在隔离装置！");
        }else if(PerDeLev == 0){
            event.setFailed("还不存在净化装置！");
        }else if(Cleanliness == maxcleanliness[IsoLev]){
            event.setFailed("已经完全净化！");
        }
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val PerDeLev = dData.getInt("PerDeLev",0);
        val magn = energymagn[PerDeLev];
        event.factoryRecipeThread.addModifier("PuriEnerIn",RecipeModifierBuilder.create("modularmachinery:energy", "input",magn, 1, false).build());
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val Cleanliness = dData.getInt("Cleanliness",0);
        val IsoLev = dData.getInt("IsoLev",0);
        val PerDeLev = dData.getInt("PerDeLev",0);
        val map = data.asMap();
        val FuCleanliness = Cleanliness + cleanlinessadd[PerDeLev];
        if(FuCleanliness < maxcleanliness[IsoLev]){
            map["Cleanliness"] = FuCleanliness;
        }else{
            map["Cleanliness"] = maxcleanliness[IsoLev];
        }
        ctrl.customData = data;
    })
    .setThreadName("净化器")
    .addRecipeTooltip("依照目前的净化器完整度进行净化","耗电量取决于净化器完整度")
    .build();

function BioCraft(name as int,time as int,reqPuri as int,PuriCost as int,magn as int,cys as IIngredient,input as IIngredient[],output as IIngredient[]){
    val CleanCostMagn as int[] = [100,8,5,3,2,1];
    val oilout =  magn * time * 10;
    RecipeBuilder.newBuilder("BioCraft"+name,"biospherex",time)
        .addInput(cys).setChance(0)
        .addInputs(input)
        .addOutputs(output)
        .addOutput(<liquid:oil> * oilout)
        .addPreCheckHandler(function(event as RecipeCheckEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val Cleanliness = dData.getInt("Cleanliness",0);
            val IsoLev = dData.getInt("IsoLev",0);
            if(Cleanliness < reqPuri){
                event.setFailed("洁净度不够！");
            }else{
                event.activeRecipe.maxParallelism = Cleanliness / (PuriCost * CleanCostMagn[IsoLev]);
            }
        })
        .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val dData = D(data);
            val Cleanliness = dData.getInt("Cleanliness",0);
            val IsoLev = dData.getInt("IsoLev",0);
            val map = data.asMap();
            map["cleanliness"] = Cleanliness - (PuriCost * CleanCostMagn[IsoLev] * event.activeRecipe.parallelism);
            ctrl.customData = data;
        })
        .addRecipeTooltip("需求"+reqPuri+"点洁净度，会消耗"+PuriCost+"点洁净度","并行数极限为一次性耗空所有洁净度")
        .build();
}
BioCraft(1,60,2000,500,1,<contenttweaker:petri_dish_a>*16,
    [
        <minecraft:rotten_flesh> * 640,
        <liquid:water> * 80000
    ],
    [
        <gas:nutrientsolution> * 20000
    ]
);
BioCraft(2,1200,50000,10000,5,<contenttweaker:petri_dish_b> * 16,
    [
        <liquid:oil> * 400000,
        <extendedcrafting:material:40> * 16
    ],
    [
        <liquid:strxenon> * 20000
    ]
);
BioCraft(3,600,200000,50000,10,<contenttweaker:rado_dish> * 8,
    [
        <liquid:crystalloidneutron> * 120,
        <liquid:cryotheum> * 16384,
        <liquid:pyrotheum> * 16348,
        <liquid:crystalloid> * 512
    ],
    [
        <liquid:rado> * 8192
    ]
);
BioCraft(4,300,3500,500,1,<mekanismmultiblockmachine:laserlenses>,
    [
        <ore:materialRubber> * 32,
        <ic2:crafting:4> * 2,
        <mets:neutron_plate>,
    ],
    [
        <contenttweaker:circuit_boards> * 4,
    ]
);
BioCraft(5,400,14000,2000,4,<contenttweaker:yltj> * 4,
    [
        <contenttweaker:circuit_boards> * 4,
        <mets:superconducting_cable> * 16,
        <mets:super_lapotron_crystal>,
        <mekanism:controlcircuit:3> * 4,
        <liquid:strxenon> * 128
    ],
    [
        <contenttweaker:refine_circuit_boards> * 4
    ]
);
BioCraft(6,400,150000,15000,9,<contenttweaker:additional_component_3> * 4,
    [
        <contenttweaker:refine_circuit_boards> * 2,
        <contenttweaker:eternity_nova> * 2,
        <moreplates:infinity_plate> * 4,
        <contenttweaker:charging_crystal_block> * 6,
        <liquid:strxenon> * 2560
    ],
    [
        <contenttweaker:overcircuit> * 2
    ]
);
BioCraft(7,600,900000,160000,15,<contenttweaker:ymysq> * 4,
    [
        <contenttweaker:overcircuit>,
        <contenttweaker:coil_v5> * 6,
        <contenttweaker:antimatter_core> * 3,
        <contenttweaker:field_generator_v3> * 2,
        <liquid:rado> * 1280
    ],
    [
        <contenttweaker:rado_circuit>
    ]
);