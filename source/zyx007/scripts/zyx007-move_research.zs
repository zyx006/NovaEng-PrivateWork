#loader crafttweaker reloadable

import crafttweaker.data.IData;
import crafttweaker.item.IItemStack;
import crafttweaker.event.PlayerInteractBlockEvent;
import mods.modularmachinery.MachineController;
import mods.modularmachinery.IMachineController;
import novaeng.hypernet.Database;
import novaeng.hypernet.NetNodeCache;

<contenttweaker:general_data_card>.addTooltip("§a可用于转移数据库的研究数据");
<contenttweaker:general_data_card>.addTooltip("§b右键§2非空§b数据库控制器读取研究数据至数据卡，再次右键§2空§b数据库控制器写入数据卡中的研究数据至数据库控制器");
<contenttweaker:general_data_card>.addTooltip("§c暂不支持转移研究数据到非空数据库！");
<contenttweaker:general_data_card>.addTooltip("§2可在工作台合成以清除NBT");

recipes.addShapeless("qksjk",<contenttweaker:general_data_card>,[<contenttweaker:general_data_card>]);

events.onPlayerRightClickBlock(function(event as PlayerInteractBlockEvent){
    val item = event.item;
    val block = event.block.data;
    if(!event.world.remote && !isNull(item) && item.definition.id == "contenttweaker:general_data_card" && event.block.definition.id == "modularmachinery:database_t1_factory_controller") {
        var researchs = block.customData.storedResearchCognition;
        if (!isNull(item.tag.stored) && item.tag.stored == true) {
            //数据卡非空，转移研究到数据库
            var cardResearchs = item.tag.customData.storedResearchCognition;
            if (researchs.length == 0) {
                //数据库控制器为空，直接转移数据
                researchs = cardResearchs;
                item.mutable().withEmptyTag();
            } else {
                //数据库控制器非空，从数据卡转移控制器中不存在的研究数据
                /*qnmd sb NPE
                for i in 0 .. cardResearchs.length {
                    if (!(researchs has item) && researchs.length < 20) {
                        researchs += cardResearchs[i];//sb npe
                        cardResearchs -= cardResearchs[i];
                    }
                }
                //更新数据卡中的研究数据
                if (cardResearchs.length == 0)
                    item.mutable().withEmptyTag();
                else
                    item.mutable().updateTag({display: {Lore: ["当前已存储" + researchs.length + "个研究数据"]}, customData: {storedResearchCognition: cardResearchs}});
                */
                event.player.sendMessage("暂不支持转移研究数据到非空数据库！");
                return;
            }
            //更新数据库控制器的研究数据
            event.world.setBlockState(
                event.world.getBlockState(event.position),
                {customData: {storedResearchCognition: researchs}},
                event.position);
            val ctrl = MachineController.getControllerAt(event.world, event.position);
            val database = NetNodeCache.getDatabase(ctrl);
            database.readNBT();
            event.player.sendMessage("成功写入" + researchs.length + "条研究数据到数据库！");
            event.cancel();
        } else {
            //数据卡为空，从数据库读取研究
            item.mutable().updateTag({stored: true, display: {Lore: ["当前已存储" + researchs.length + "个研究数据"]}, customData: {storedResearchCognition: researchs}});
            event.player.sendMessage("成功读取" + researchs.length + "条研究数据到数据卡！");
            event.cancel();
        }
    } 
});