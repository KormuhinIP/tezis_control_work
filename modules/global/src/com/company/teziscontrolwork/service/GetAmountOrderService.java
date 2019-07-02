/*
 * Copyright (c) 2019 com.company.teziscontrolwork.service
 */
package com.company.teziscontrolwork.service;

/**
 * @author kormuhin
 */
public interface GetAmountOrderService {
    String NAME = "teziscontrolwork_GetAmountOrderService";

    long getAmount(Object entity);
}