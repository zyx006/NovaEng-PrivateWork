//我也不知道我在写什么，反正很魔怔,你可以修改一下内容
#priority 50
#loader crafttweaker reloadable

import crafttweaker.item.IItemStack;

import novaeng.NovaEngUtils;
import novaeng.hypernet.NetNodeCache;
import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.ResearchStation;
import novaeng.hypernet.RegistryHyperNet;
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
import mods.modularmachinery.ControllerGUIRenderEvent;
import mods.modularmachinery.MachineStructureFormedEvent;



MMEvents.onControllerGUIRender("kysn_research", function(event as ControllerGUIRenderEvent) {
    onGUIRender(event);
});

function onGUIRender(event as ControllerGUIRenderEvent) {
    val ctrl = event.controller;
    val researchStation = NetNodeCache.getResearchStation(ctrl);

    if (ctrl.ticksExisted % 20 == 0) {
        researchStation.readNBT();
    }

    var info as string[] = [
        "§9//////////// 科研枢纽-研究站 ////////////"
    ];

    if (ctrl.isWorking) {
        info += "§9算力消耗：§b" + formatFLOPS(researchStation.computationPointConsumption);
    }

    if (researchStation.connected) {
        info += "§9网络状态：§a已连接";
        info += "§9总算力消耗 / 产出：§b" +
            formatFLOPS(ComputationCenterCache.getComputationPointConsumption()) +
            " / " +
            formatFLOPS(ComputationCenterCache.getComputationPointGeneration());
    } else {
        info += "§9网络状态：§c断开连接";
    }

    info += "§7HyperNet 科研枢纽-研究站监控 v1.0";
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