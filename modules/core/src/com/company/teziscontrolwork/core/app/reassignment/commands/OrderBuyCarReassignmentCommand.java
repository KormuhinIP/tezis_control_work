/*
 * Copyright (c) 2019 com.company.teziscontrolwork.core.app.reassignment.commands
 */
package com.company.teziscontrolwork.core.app.reassignment.commands;


import com.company.teziscontrolwork.entity.OrderBuyCar;
import com.haulmont.thesis.core.app.reassignment.commands.AbstractDocReassignmentCommand;

import javax.annotation.ManagedBean;
import javax.annotation.PostConstruct;

/**
 * @author kormuhin
 */
@ManagedBean(OrderBuyCarReassignmentCommand.NAME)
public class OrderBuyCarReassignmentCommand extends AbstractDocReassignmentCommand<OrderBuyCar> {
    protected static final String NAME = "orderbuycar_reassignment_command";

    @PostConstruct
    protected void postInit() {
        type = "OrderBuyCar";
        docQuery = String.format(DOC_QUERY_TEMPLATE, "teziscontrolwork$OrderBuyCar");
    }

    @Override
    public String getName() {
        return NAME;
    }
}