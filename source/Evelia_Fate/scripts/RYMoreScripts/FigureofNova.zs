import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.MachineBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.RecipeModifierBuilder;

import crafttweaker.item.IItemStack;

import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.research.ResearchCognitionData;
RecipeBuilder.newBuilder("FigureofNova","mach_crafter",3600)
    .addInputs([
        <botania:petal:6>*64,
        <cookingforblockheads:cow_jar>*2,
        <astralsorcery:itemcraftingcomponent:1>*9,
        <minecraft:nether_star>*16,
    ])
    .addEnergyPerTickInput(1000000)
    .requireComputationPoint(100.0F)
    .requireResearch("FigureofNova")
    .addOutput(<modularmachinery:figureofnova_factory_controller>)
    .build();
RecipeBuilder.newBuilder("Novahead","FigureofNova",100)
    .addInputs(<liquid:ic2uu_matter>*10)
    .addOutput(<minecraft:skull:3>.withTag({SkullOwner: {Id: "92396ca4-e643-44e8-b3dc-61d35fc0127d", Properties: {textures: [{Signature: "QGS5qfCsxdUMTHPIJ9W9PBJkP0bu26NwlK1OmjiyN17kmPDHDd+j0Ao+SbIpv/pxGaItBfRq52ETsOwbTe3mnnNWv3JooQN8YlEHVaZrZK/32i01Y53MUDZ3JtVJPEiIb3EOkhIciGUMeRpNTa9CVv5skOn+rye0f/eetQRUFAZKRSdgW7Gz1MnqzAPOCct69RHcHCCnwny/DSGnNsnfz+AJKOyubdRHBZbX/+Ug+8AMa2ava/rrMFV5h8oTT57awpBsnKsWac1Mijk/8wmpci6bA8b8xiIBBmLV//tGj/iU1eusfx+zkanYDdPoLOmxf00vkblyf/Rt4oNbp/h9f3d7+SnnwPCzvUvKm2GzngVmS35epIZGshU3/cuvBOmvGNLZux5x2ykxCwECsJhEVy7lvzpYMC5iNH1i3hZVqKGLOcBSOFBSz0vlAyMAkJnmlCW2TBaXbx/O5LdC/czLCqGpRfmlUjBz8RA27WVQ/HvCG/ys0s3JBJGYHD/xVcGwMFuIQPR4GCCAIEUxLO/o23c+4mSowugj5phZ7WUEl7A6O8m3cAcx3kyj8k4SmMsBo1pf7Khmq4KRznMrv9JZnkIOGXOpqjzCccj7C9B0S5v/Viz1/9K1jaPxdkcm4qk6XVFCru5yvKGb5Jc9H+W4KuvHGi1WbbSBNU2ftZ7GojY=", Value: "ewogICJ0aW1lc3RhbXAiIDogMTY4NTYxNzM1ODE1OSwKICAicHJvZmlsZUlkIiA6ICI5MjM5NmNhNGU2NDM0NGU4YjNkYzYxZDM1ZmMwMTI3ZCIsCiAgInByb2ZpbGVOYW1lIiA6ICJLYXN1bWlfTm92YSIsCiAgInNpZ25hdHVyZVJlcXVpcmVkIiA6IHRydWUsCiAgInRleHR1cmVzIiA6IHsKICAgICJTS0lOIiA6IHsKICAgICAgInVybCIgOiAiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS81ODQ1OWU5ZmQ1YzQxZTlhZWYxMzVjYzdjYzUwMWM2MTBjMDA2Y2UzYzQxNzYwYTUwYTA5MmZhYzJmZDYxYzNkIiwKICAgICAgIm1ldGFkYXRhIiA6IHsKICAgICAgICAibW9kZWwiIDogInNsaW0iCiAgICAgIH0KICAgIH0KICB9Cn0="}]}, Name: "Kasumi_Nova"}}))
    .addOutput(<liquid:milk>*1000)
    .build();
