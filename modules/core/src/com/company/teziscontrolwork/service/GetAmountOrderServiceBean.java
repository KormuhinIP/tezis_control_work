/*
 * Copyright (c) 2019 com.company.teziscontrolwork.service
 */
package com.company.teziscontrolwork.service;

import com.haulmont.cuba.core.EntityManager;
import com.haulmont.cuba.core.Persistence;
import com.haulmont.cuba.core.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.inject.Inject;

/**
 * @author kormuhin
 */
@Service(GetAmountOrderService.NAME)
public class GetAmountOrderServiceBean implements GetAmountOrderService {

    @Inject
    private Persistence persistence;

    @Transactional
    @Override
    public long getAmount(Object entity) {
        long result;

        EntityManager em = persistence.getEntityManager();

        Query query = em.createQuery("select COUNT (o) from tezistest$ApplicationForCarPurchase o where o.contractor.id =: contractor");
        query.setParameter("contractor", entity);
        result = (long) query.getFirstResult();

        return result;
    }
}