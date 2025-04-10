#priority 50
#loader crafttweaker reloadable

import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.RecipeStartEvent;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.RecipeModifierBuilder;

import novaeng.hypernet.HyperNetHelper;

MachineModifier.setMaxThreads("9x_neutron_platemk1", 16);
MachineModifier.setMaxThreads("9x_neutron_platemk2", 16);

// 9重压缩中子素吸积盘mk1 控制器
recipes.addShaped( 
    <modularmachinery:9x_neutron_platemk1_factory_controller>, // 输出物品
    [[<modularmachinery:neutron_accretion_plate_factory_controller>, <modularmachinery:neutron_accretion_plate_factory_controller>, <modularmachinery:neutron_accretion_plate_factory_controller>],
    [<modularmachinery:neutron_accretion_plate_factory_controller>, <modularmachinery:neutron_accretion_plate_factory_controller>, <modularmachinery:neutron_accretion_plate_factory_controller>],
    [<modularmachinery:neutron_accretion_plate_factory_controller>, <modularmachinery:neutron_accretion_plate_factory_controller>, <modularmachinery:neutron_accretion_plate_factory_controller>]]
);
// 9重压缩中子素吸积盘mk2控制器 控制器
recipes.addShaped(
    <modularmachinery:9x_neutron_platemk2_factory_controller>, // 输出物品
    [[<modularmachinery:9x_neutron_platemk1_factory_controller>, <modularmachinery:9x_neutron_platemk1_factory_controller>, <modularmachinery:9x_neutron_platemk1_factory_controller>],
    [<modularmachinery:9x_neutron_platemk1_factory_controller>, <modularmachinery:9x_neutron_platemk1_factory_controller>, <modularmachinery:9x_neutron_platemk1_factory_controller>],
    [<modularmachinery:9x_neutron_platemk1_factory_controller>, <modularmachinery:9x_neutron_platemk1_factory_controller>, <modularmachinery:9x_neutron_platemk1_factory_controller>]]
);


// 9重压缩中子素吸积盘mk1
//产出
RecipeBuilder.newBuilder("9x_neutron_platemk1_working", "9x_neutron_platemk1", 30)
    .addStartHandler(function(event as RecipeStartEvent) {
        val ctrl = event.controller;
        val yPos = ctrl.pos.y;
        if (yPos > 230) {
            ctrl.addModifier("efficiency", RecipeModifierBuilder.create("modularmachinery:item", "output", 2, 1, false).build());
        } else if (yPos > 200) {
            ctrl.addModifier("efficiency", RecipeModifierBuilder.create("modularmachinery:item", "output", 1.75, 1, false).build());
        } else if (yPos > 150) {
            ctrl.addModifier("efficiency", RecipeModifierBuilder.create("modularmachinery:item", "output", 1.5, 1, false).build());
        } else if (yPos > 100) {
            ctrl.addModifier("efficiency", RecipeModifierBuilder.create("modularmachinery:item", "output", 1.25, 1, false).build());
        }
    })
    .addOutput(<avaritia:resource:3>).setMinMaxAmount(1, 4)
    .addRecipeTooltip([
        "控制器高度大于 §b230§f 时，粒产出 §ax2§f。",
        "控制器高度大于 §b200§f 时，粒产出 §ax1.75§f。",
        "控制器高度大于 §b150§f 时，粒产出 §ax1.5§f。",
        "控制器高度大于 §b100§f 时，粒产出 §ax1.25§f。",
    ])
    .build();

// 9重压缩中子素吸积盘mk2
//产出
RecipeBuilder.newBuilder("9x_neutron_platemk2_working", "9x_neutron_platemk2", 30)
    .addStartHandler(function(event as RecipeStartEvent) {
        val ctrl = event.controller;
        val yPos = ctrl.pos.y;
        if (yPos > 230) {
            ctrl.addModifier("efficiency", RecipeModifierBuilder.create("modularmachinery:item", "output", 2, 1, false).build());
        } else if (yPos > 200) {
            ctrl.addModifier("efficiency", RecipeModifierBuilder.create("modularmachinery:item", "output", 1.75, 1, false).build());
        } else if (yPos > 150) {
            ctrl.addModifier("efficiency", RecipeModifierBuilder.create("modularmachinery:item", "output", 1.5, 1, false).build());
        } else if (yPos > 100) {
            ctrl.addModifier("efficiency", RecipeModifierBuilder.create("modularmachinery:item", "output", 1.25, 1, false).build());
        }
    })
    .addOutput(<avaritia:resource:4>).setMinMaxAmount(1, 4)
    .addRecipeTooltip([
        "控制器高度大于 §b230§f 时，锭产出 §ax2§f。",
        "控制器高度大于 §b200§f 时，锭产出 §ax1.75§f。",
        "控制器高度大于 §b150§f 时，锭产出 §ax1.5§f。",
        "控制器高度大于 §b100§f 时，锭产出 §ax1.25§f。",
    ])
    .build();
