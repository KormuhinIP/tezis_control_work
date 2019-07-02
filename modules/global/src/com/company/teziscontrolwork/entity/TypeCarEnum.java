/*
 * Copyright (c) 2019 com.company.teziscontrolwork.entity
 */
package com.company.teziscontrolwork.entity;

import com.haulmont.chile.core.datatypes.impl.EnumClass;

import javax.annotation.Nullable;

/**
 * @author kormuhin
 */
public enum TypeCarEnum implements EnumClass<Integer> {

    Crossover(1),
    Vagon(2),
    Sedan(3);

    private Integer id;

    TypeCarEnum(Integer value) {
        this.id = value;
    }

    public Integer getId() {
        return id;
    }

    @Nullable
    public static TypeCarEnum fromId(Integer id) {
        for (TypeCarEnum at : TypeCarEnum.values()) {
            if (at.getId().equals(id)) {
                return at;
            }
        }
        return null;
    }
}