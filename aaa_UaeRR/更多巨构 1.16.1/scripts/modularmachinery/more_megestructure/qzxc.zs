//我也不知道我在写什么，反正很魔怔,你可以修改一下内容
#priority 50
#loader crafttweaker reloadable

import crafttweaker.item.IItemStack;

import novaeng.NovaEngUtils;
import novaeng.hypernet.NetNodeCache;
import novaeng.hypernet.DataProcessor;
import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.DataProcessorType;
import novaeng.hypernet.ComputationCenterCache;

import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.RecipeStartEvent;
import mods.modularmachinery.RecipeFinishEvent;

import mods.modularmachinery.IMachineController;

import mods.modularmachinery.MMEvents;
import mods.modularmachinery.MachineTickEvent;
import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.FactoryRecipeStartEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.ControllerGUIRenderEvent;
import mods.modularmachinery.MachineStructureFormedEvent;



MMEvents.onControllerGUIRender("qzxc", function(event as ControllerGUIRenderEvent) {
    onGUIRender(event);
});

function onGUIRender(event as ControllerGUIRenderEvent) {
    val ctrl = event.controller;
    val processor = NetNodeCache.getDataProcessor(ctrl);
    val type = processor.type;

    if (ctrl.ticksExisted % 20 == 0) {
        processor.readNBT();
    }

    var info as string[] = [
        "§9////////// 千载星辰监控 //////////"
    ];

    if (ctrl.isWorking) {
        val maxProvision = processor.maxGeneration;
        val provision = min(processor.computationalLoad, maxProvision);
        info += "§9算力：§b" + formatFLOPS(provision) + " / " + formatFLOPS(maxProvision) + "（负载：§e" + formatPercent(provision / maxProvision, 1.0F) + "§b）";
    }

    val overHeatPercent = processor.storedHU as float / type.overheatThreshold;
    if (overHeatPercent >= 0.85F) {
        info += "§9内部热量：§c" + processor.storedHU + " HU" + "（" + formatPercent(overHeatPercent, 1.0F) + "，触发温控）";
    } else {
        info += "§9内部热量：§c" + processor.storedHU + " HU" + "（" + formatPercent(overHeatPercent, 1.0F) + "）";
    }

    if (processor.connected) {
        info += "§9网络状态：§a已连接";
        info += "§9总算力消耗 / 产出：§b" +
            formatFLOPS(ComputationCenterCache.getComputationPointConsumption()) +
            " / " +
            formatFLOPS(ComputationCenterCache.getComputationPointGeneration());
    } else {
        info += "§9网络状态：§c断开连接";
    }

    info += "§7HyperNet 千载星辰监控 v1.0";
    info += "§9//////////////////////////////";

    event.extraInfo = info;
}

function formatPercent(num1 as int, num2 as int) {
    return NovaEngUtils.formatFloat((num1 * 100) as float / num2 as float, 2) + "%";
}

function formatFLOPS(tflops as float) as string {
    if (tflops < 1000.0F) {
        return NovaEngUtils.formatFloat(tflops, 1) + "T FloPS";
    }
    return NovaEngUtils.formatFloat(tflops / 1000.0F, 1) + "P FloPS";
}

function min(a as float, b as float) as float {
    return a <= b ? a : b;
}
