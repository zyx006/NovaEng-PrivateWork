//额外添加
#priority 1000

#loader contenttweaker

import mods.contenttweaker.Block;
import mods.contenttweaker.CreativeTab;
import mods.contenttweaker.VanillaFactory;
import mods.contenttweaker.Item;

function regItem(name as string) {
    val item as Item = VanillaFactory.createItem(name);
    item.creativeTab = <creativetab:misc>;
    item.register();
}

function regItemWithStackSize(name as string, maxStackSize as int) {
    val item as Item = VanillaFactory.createItem(name);
    item.creativeTab = <creativetab:misc>;
    item.maxStackSize = maxStackSize;
    item.register();
}


//宇宙探测器MKI-III
regItem("space_probe_mk1");
regItem("space_probe_mk2");
regItem("space_probe_mk3");


//压缩时空立场发生器
var OOA as Block = VanillaFactory.createBlock("spacetime_compression_field_generator", <blockmaterial:iron>);
OOA.fullBlock = true;
OOA.setLightOpacity(255);
OOA.translucent = true;
OOA.setLightValue(0);
OOA.setBlockHardness(7.5);
OOA.setBlockResistance(100.0);
OOA.setToolClass("pickaxe");
OOA.setToolLevel(3);
OOA.setBlockSoundType(<soundtype:metal>);
OOA.register();

//维度创造方块
var OOB as Block = VanillaFactory.createBlock("dimension_creation_casing", <blockmaterial:iron>);
OOB.fullBlock = true;
OOB.setLightOpacity(255);
OOB.translucent = true;
OOB.setLightValue(0);
OOB.setBlockHardness(7.5);
OOB.setBlockResistance(100.0);
OOB.setToolClass("pickaxe");
OOB.setToolLevel(3);
OOB.setBlockSoundType(<soundtype:metal>);
OOB.register();

//维度稳定方块
var OOC as Block = VanillaFactory.createBlock("dimensional_stability_casing", <blockmaterial:iron>);
OOC.fullBlock = true;
OOC.setLightOpacity(255);
OOC.translucent = true;
OOC.setLightValue(0);
OOC.setBlockHardness(7.5);
OOC.setBlockResistance(100.0);
OOC.setToolClass("pickaxe");
OOC.setToolLevel(3);
OOC.setBlockSoundType(<soundtype:metal>);
OOC.register();

//遏制场发生器
var OOD as Block = VanillaFactory.createBlock("containment_field_generator", <blockmaterial:iron>);
OOD.fullBlock = true;
OOD.setLightOpacity(255);
OOD.translucent = true;
OOD.setLightValue(0);
OOD.setBlockHardness(7.5);
OOD.setBlockResistance(100.0);
OOD.setToolClass("pickaxe");
OOD.setToolLevel(3);
OOD.setBlockSoundType(<soundtype:metal>);
OOD.register();