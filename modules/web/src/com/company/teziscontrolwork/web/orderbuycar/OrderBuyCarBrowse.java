package com.company.teziscontrolwork.web.orderbuycar;

import com.company.teziscontrolwork.entity.OrderBuyCar;
import com.haulmont.thesis.web.ui.basicdoc.browse.AbstractDocBrowser;

import java.util.Map;

public class OrderBuyCarBrowse extends AbstractDocBrowser<OrderBuyCar> {

    @Override
    public void init(Map<String, Object> params) {
        super.init(params);
        entityName = "teziscontrolwork$OrderBuyCar";
    }
}