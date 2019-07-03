/*
 * Copyright (c) 2019 com.company.teziscontrolwork.web.contractorlookup
 */
package com.company.teziscontrolwork.web.contractorlookup;

import com.company.teziscontrolwork.service.GetAmountOrderService;
import com.haulmont.cuba.core.entity.Entity;
import com.haulmont.cuba.gui.ComponentsHelper;
import com.haulmont.cuba.gui.components.Component;
import com.haulmont.cuba.gui.components.Label;
import com.haulmont.cuba.gui.components.TabSheet;
import com.haulmont.cuba.gui.components.Table;
import com.haulmont.cuba.gui.xml.layout.ComponentsFactory;
import com.haulmont.cuba.web.gui.components.WebButtonsPanel;
import com.haulmont.thesis.web.ui.contractor.ConrtactorLookup;

import javax.inject.Inject;
import java.util.Map;

/**
 * @author kormuhin
 */
public class ExtConrtactorLookup extends ConrtactorLookup {

    @Inject
    protected Component companyTablePanel;
    @Inject
    protected Table companyTable;
    @Inject
    protected TabSheet tabsheet;
    private boolean individualTableInited = false;
    @Inject
    private ComponentsFactory componentsFactory;


    @Inject
    private GetAmountOrderService getAmountOrderService;


    @Override
    public void init(Map<String, Object> params) {

        super.init(params);
        changeTable(companyTable);
        
        tabsheet.addListener(new TabSheet.TabChangeListener() {
            public void tabChanged(TabSheet.Tab newTab) {
                setLookupComponent(getComponent("companyTab".equals(newTab.getName()) ? "companyTable" : "individualTable"));

                if (!individualTableInited && "individualTab".equals(newTab.getName())) {
                    Component individualTablePanel = getComponent("individualTablePanel");
                    Table individualTable = getComponent("individualTable");
                    ComponentsHelper.createActions(individualTable);

                    individualTableInited = true;

                    if (individualTable != null && individualTablePanel != null) {
                        WebButtonsPanel buttonsPanel = new WebButtonsPanel();
                        individualTablePanel.setParent(null);
                        buttonsPanel.add(individualTablePanel);
                        individualTable.setButtonsPanel(buttonsPanel);
                        individualTable.setRowsCount(individualTable.getRowsCount());
                    }

                    changeTable(individualTable);
                }


            }
        });

        ComponentsHelper.createActions(companyTable);
        if (companyTablePanel != null) {
            WebButtonsPanel buttonsPanel = new WebButtonsPanel();
            companyTablePanel.setParent(null);
            buttonsPanel.add(companyTablePanel);
            companyTable.setButtonsPanel(buttonsPanel);
            companyTable.setRowsCount(companyTable.getRowsCount());
        }


    }

    private void changeTable(Table table) {


        table.addGeneratedColumn("amount", new Table.ColumnGenerator() {
            @Override
            public Component generateCell(Entity entity) {
                return generateAmountOrder(entity);
            }
        });


    }


    private Component generateAmountOrder(Object entity) {
        Label label = componentsFactory.createComponent(Label.class);
        label.setVisible(true);
        label.setWidth("100%");
        label.setValue(getAmountOrderService.getAmount(entity));
        return label;
    }

}
