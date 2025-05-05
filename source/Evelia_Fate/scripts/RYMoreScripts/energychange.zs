import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;
import crafttweaker.data.IData;
import crafttweaker.world.IWorld;
import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.MMEvents;
import mods.modularmachinery.ControllerGUIRenderEvent;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.MachineModifier;
import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.research.ResearchCognitionData;
import crafttweaker.util.Math;
import mods.modularmachinery.SmartInterfaceType;
import mods.modularmachinery.RecipeModifier;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.RecipeTickEvent;
import mods.modularmachinery.FactoryRecipeStartEvent;
import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.MachineController;
import mods.modularmachinery.MachineTickEvent;
import crafttweaker.oredict.IOreDictEntry;
import crafttweaker.liquid.ILiquidStack;
import novaeng.NovaEngUtils;
import mods.modularmachinery.Sync;

MachineModifier.addSmartInterfaceType("energychange",
    SmartInterfaceType.create("speed", 1)
        .setHeaderInfo("转换速度设置")
        .setValueInfo("速度：§a%.0f ")
        .setFooterInfo("§a每1代表5GRF/t的转换速度,最大14400")
        .setJeiTooltip("速度范围：最低 §a%.0f 倍§f，最高 §a%.0f 倍", 2)
        .setNotEqualMessage("§a输入速度过载或过低！")
);
MMEvents.onMachinePostTick("energychange", function(event as MachineTickEvent) {
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    val nullable = ctrl.getSmartInterfaceData("speed");
    var speed = isNull(nullable) ? 1.0f : nullable.value;
    //检查数据正确性
    if (speed < 1 || speed > 14400) {
        nullable.value = 1;
    }
    map["speed"] = speed;
    ctrl.customData = data;
});
RecipeBuilder.newBuilder("enerchange1","energychange",1)
    .addFluidInput(<liquid:liquid_energy>)
    .addEnergyPerTickOutput(5000000000)
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val speed = dData.getFloat("speed",1) as int;
        event.activeRecipe.maxParallelism = speed;
    })
    .addRecipeTooltip("在智能数据接口处调整并行")
    .build();
RecipeBuilder.newBuilder("enerchange2","workshop",3600)
    .addEnergyPerTickInput(400000000000)
    .addInputs([
        <modularmachinery:energy_conversion_station_controller>*2,
        <avaritiaio:infinitecapacitor>,
        <draconicadditions:chaotic_energy_core>*64,
        <fluxnetworks:gargantuanfluxstorage>*256,
        <liquid:liquid_energy>*3600,
        <liquid:crystalloid>*10800
    ])
    .addOutput(<modularmachinery:energychange_controller>)
    .build();

MachineModifier.addSmartInterfaceType("fluidchange",
    SmartInterfaceType.create("speed", 1)
        .setHeaderInfo("转换速度设置")
        .setValueInfo("速度：§a%.0f ")
        .setFooterInfo("§a每1代表5GRF/t的转换速度,最大14400")
        .setJeiTooltip("速度范围：最低 §a%.0f 倍§f，最高 §a%.0f 倍", 2)
        .setNotEqualMessage("§a输入速度过载或过低！")
);
MMEvents.onMachinePostTick("fluidchange", function(event as MachineTickEvent) {
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    val nullable = ctrl.getSmartInterfaceData("speed");
    var speed = isNull(nullable) ? 1.0f : nullable.value;
    //检查数据正确性
    if (speed < 1 || speed > 14400) {
        nullable.value = 1;
    }
    map["speed"] = speed;
    ctrl.customData = data;
});
RecipeBuilder.newBuilder("fluidchange1","fluidchange",1)
    .addFluidOutput(<liquid:liquid_energy>)
    .addEnergyPerTickInput(5000000000)
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
        val ctrl = event.controller;
        val data = ctrl.customData;
        val dData = D(data);
        val speed = dData.getFloat("speed",1) as int;
        event.activeRecipe.maxParallelism = speed;
    })
    .addRecipeTooltip("在智能数据接口处调整并行")
    .build();
RecipeBuilder.newBuilder("fluidchange2","workshop",3600)
    .addInputs([
        <modularmachinery:energy_liquefier_controller>*4,
        <avaritiaio:infinitecapacitor>,
        <novaeng_core:estorage_energy_cell_l9>*8,
        <super_solar_panels:machines:47>*8,
        <mekanism:basicblock2:3>.withTag({tier: 3})*16,
        <mekanism:basicblock2:4>.withTag({tier: 3})*16,
        <liquid:liquid_energy>*3600,
        <liquid:crystalloid>*10800
    ])
    .addEnergyPerTickInput(200000000000)
    .addOutput(<modularmachinery:fluidchange_controller>)
    .build();