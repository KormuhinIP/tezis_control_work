/*
 * Copyright (c) 2019 com.company.teziscontrolwork.entity
 */
package com.company.teziscontrolwork.entity;


/**
 * @author kormuhin
 */
import com.haulmont.cuba.core.entity.annotation.EnableRestore;
import com.haulmont.cuba.core.entity.annotation.TrackEditScreenHistory;
import javax.persistence.Entity;
import javax.persistence.Table;
import com.haulmont.chile.core.annotations.NamePattern;
import javax.persistence.Column;
import com.haulmont.cuba.core.entity.StandardEntity;

@NamePattern("%s|name")
@Table(name = "TEZISCONTROLWORK_CAR_BRAND")
@Entity(name = "teziscontrolwork$CarBrand")
@EnableRestore
@TrackEditScreenHistory
public class CarBrand extends StandardEntity {
    private static final long serialVersionUID = -8792226803442246924L;

    @Column(name = "NAME", nullable = false, length = 50)
    protected String name;

    @Column(name = "CODE", nullable = false, length = 3)
    protected String code;

    @Column(name = "NOTE", length = 4000)
    protected String note;

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getCode() {
        return code;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getNote() {
        return note;
    }


}