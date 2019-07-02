/*
 * Copyright (c) 2019 com.company.teziscontrolwork.entity
 */
package com.company.teziscontrolwork.entity;


/**
 * @author kormuhin
 */

import com.haulmont.cuba.core.entity.annotation.EnableRestore;
import com.haulmont.cuba.core.entity.annotation.Listeners;
import com.haulmont.cuba.core.entity.annotation.TrackEditScreenHistory;
import com.haulmont.thesis.core.entity.TsCard;

import javax.persistence.*;
import java.math.BigDecimal;

@Listeners("teziscontrolwork_CarListener")
@PrimaryKeyJoinColumn(name = "CARD_ID", referencedColumnName = "ID")
@Inheritance(strategy = InheritanceType.JOINED)
@DiscriminatorValue("1")
@Table(name = "TEZISCONTROLWORK_CAR")
@Entity(name = "teziscontrolwork$Car")
@EnableRestore
@TrackEditScreenHistory
public class Car extends TsCard {
    private static final long serialVersionUID = -1104802884641001707L;

    @Column(name = "NUMBER_", length = 50)
    protected String number;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "CAR_BRAND_ID")
    protected CarBrand carBrand;

    @Column(name = "NAME", nullable = false, length = 50)
    protected String name;

    @Column(name = "DATE_", nullable = false, length = 50)
    protected Integer date;

    @Column(name = "CAR_COST", nullable = false)
    protected BigDecimal carCost;

    @Column(name = "TYPE_CAR", nullable = false)
    protected Integer typeCar;

    public TypeCarEnum getTypeCar() {
        return typeCar == null ? null : TypeCarEnum.fromId(typeCar);
    }

    public void setTypeCar(TypeCarEnum typeCar) {
        this.typeCar = typeCar == null ? null : typeCar.getId();
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public CarBrand getCarBrand() {
        return carBrand;
    }

    public void setCarBrand(CarBrand carBrand) {
        this.carBrand = carBrand;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getDate() {
        return date;
    }

    public void setDate(Integer date) {
        this.date = date;
    }

    public BigDecimal getCarCost() {
        return carCost;
    }

    public void setCarCost(BigDecimal carCost) {
        this.carCost = carCost;
    }


}