package com.company.teziscontrolwork.web.orderbuycar;

import com.company.teziscontrolwork.entity.OrderBuyCar;
import com.haulmont.cuba.core.entity.Entity;
import com.haulmont.cuba.gui.components.CheckBox;
import com.haulmont.cuba.gui.components.Component;
import com.haulmont.cuba.gui.components.Label;
import com.haulmont.cuba.gui.data.ValueListener;
import com.haulmont.cuba.security.global.UserSession;
import com.haulmont.thesis.gui.processaction.DefaultCardAccessData;
import com.haulmont.thesis.gui.processaction.doc.DefaultDocAccessData;
import com.haulmont.thesis.web.actions.PrintReportAction;
import com.haulmont.thesis.web.ui.basicdoc.editor.AbstractDocEditor;
import com.haulmont.workflow.core.app.WfUtils;
import org.apache.commons.lang.StringUtils;

import javax.annotation.Nullable;
import javax.inject.Inject;
import java.util.Map;

public class OrderBuyCarEdit extends AbstractDocEditor<OrderBuyCar> {


    @Inject
    private CheckBox payment;
    @Inject
    private UserSession userSession;


    // DefaultDocAccessManager defaultDocAccessManager;





    @Override
    public void init(Map<String, Object> params) {

        //   OrderBuyCar item = WindowParams.ITEM.getEntity(params);

        //   defaultDocAccessManager = new DefaultDocAccessManager(item, params);


        super.init(params);


        payment.addListener(new ValueListener() {
            @Override
            public void valueChanged(Object source, String property, @Nullable Object prevValue, @Nullable Object value) {
                if (!(boolean) value) {
                    userSession.getRoles();


                }
            }
        });

    }

    @Override
    protected DefaultCardAccessData createAccessData() {
        return super.createAccessData();
    }


    @Override
    protected DefaultDocAccessData getAccessData() {
        return super.getAccessData();
    }

    @Override
    protected String getHiddenTabsConfig() {
        return "correspondenceHistoryTab,docLogTab,cardLinksTab,processTab,securityTab,docTransferLogTab,cardProjectsTab,versionsTab,openHistoryTab";
    }

    @Override
    public void setItem(Entity item) {
        super.setItem(item);
        printButton.addAction(new PrintReportAction("printExecutionList", this, "printDocExecutionListReportName"));
    }

    @Override
    protected Component createState() {
        if (WfUtils.isCardInState(getItem(), "New") || StringUtils.isEmpty(getItem().getState())) {
            Label label = componentsFactory.createComponent(Label.NAME);
            label.setValue(StringUtils.isEmpty(getItem().getState()) ? "" : getItem().getLocState());
            return label;
        } else {
            return super.createState();
        }
    }

    @Override
    protected void fillHiddenTabs() {
        hiddenTabs.put("office", getMessage("office"));
        hiddenTabs.put("attachmentsTab", getMessage("attachmentsTab"));
        hiddenTabs.put("docTreeTab", getMessage("docTreeTab"));
        hiddenTabs.put("cardCommentTab", getMessage("cardCommentTab"));
        super.fillHiddenTabs();
    }
}