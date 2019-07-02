/*
 * Copyright (c) 2019 com.company.teziscontrolwork.core.listener
 */
package com.company.teziscontrolwork.core.listener;

import com.company.teziscontrolwork.entity.Car;
import com.haulmont.cuba.core.Persistence;
import com.haulmont.cuba.core.listener.BeforeInsertEntityListener;
import com.haulmont.cuba.core.listener.BeforeUpdateEntityListener;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;

import javax.annotation.ManagedBean;
import javax.inject.Inject;
import java.util.Arrays;
import java.util.Set;

/**
 * @author kormuhin
 */
@ManagedBean("teziscontrolwork_CarListener")
public class CarListener implements BeforeUpdateEntityListener<Car>, BeforeInsertEntityListener<Car> {

    @Inject
    protected Persistence persistence;

    @Override
    public void onBeforeUpdate(Car entity) {

        Set<String> fields = persistence.getTools().getDirtyFields(entity);

        if (CollectionUtils.containsAny(fields, Arrays.asList("number"))) {
            StringBuilder description = new StringBuilder();
            description.append(StringUtils.trimToEmpty(entity.<String>getValue("number")));
            entity.setDescription(description.toString());
        }
    }

    @Override
    public void onBeforeInsert(Car entity) {
        onBeforeUpdate(entity);
    }
}