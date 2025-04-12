//我也不知道我在写什么，反正很魔怔,你可以修改一下内容
#priority 50
#loader crafttweaker reloadable

import crafttweaker.item.IItemStack;

import novaeng.NovaEngUtils;
import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.ComputationCenter;
import novaeng.hypernet.ComputationCenterType;
import novaeng.hypernet.ComputationCenterCache;

import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.RecipeStartEvent;
import mods.modularmachinery.RecipeFinishEvent;

import mods.modularmachinery.IMachineController;

import mods.modularmachinery.MMEvents;
import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.ControllerGUIRenderEvent;
import mods.modularmachinery.MachineStructureFormedEvent;


MMEvents.onControllerGUIRender("networkcenter_mk4", function(event as ControllerGUIRenderEvent) {
    onGUIRender(event);
});

function onGUIRender(event as ControllerGUIRenderEvent) {
    val ctrl = event.controller;
    val processor = ComputationCenter.from(ctrl);
    val type = processor.type;

    if (ctrl.ticksExisted % 20 == 0) {
        processor.readNBT();
    }

    var info as string[] = [
        "§9///////////// 中心监控 /////////////"
    ];

    if (ctrl.isWorking) {
        info += "§9状态：§a在线";
        info += "§9已连接 §a" + ComputationCenterCache.getTotalConnected() + " §9/ §e" + type.maxConnections + " §9台机械";
        info += "§9总算力消耗 / 产出：§b" +
            formatFLOPS(ComputationCenterCache.getComputationPointConsumption()) +
            " / " +
            formatFLOPS(ComputationCenterCache.getComputationPointGeneration());
    } else {
        info += "§9状态：§c离线";
    }

    info += "§9电路板耐久剩余：§a" + processor.circuitDurability + "（" + formatPercent(processor.circuitDurability, type.circuitDurability) + "）";

    info += "§7HyperNet Monitor v2.0";
    info += "§9//////////////////////////////////";

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
    if (tflops < 1000000.0F) {
        return NovaEngUtils.formatFloat(tflops, 1) + "T FloPS";
    }
    return NovaEngUtils.formatFloat(tflops / 1000000.0F, 1) + "E FloPS";
}