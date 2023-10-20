/*
 *  Copyright (c) 2022 Microsoft Corporation
 *
 *  This program and the accompanying materials are made available under the
 *  terms of the Apache License, Version 2.0 which is available at
 *  https://www.apache.org/licenses/LICENSE-2.0
 *
 *  SPDX-License-Identifier: Apache-2.0
 *
 *  Contributors:
 *       Microsoft Corporation - Initial implementation
 *
 */

package org.eclipse.edc.sample.extension.transfer;

import org.eclipse.edc.connector.transfer.spi.store.TransferProcessStore;
import org.eclipse.edc.connector.transfer.spi.types.DataRequest;
import org.eclipse.edc.connector.transfer.spi.types.ProvisionedDataDestinationResource;
import org.eclipse.edc.connector.transfer.spi.types.TransferProcess;
import org.eclipse.edc.connector.transfer.spi.types.TransferProcessStates;
import org.eclipse.edc.runtime.metamodel.annotation.Inject;
import org.eclipse.edc.spi.system.ServiceExtension;
import org.eclipse.edc.spi.system.ServiceExtensionContext;
import org.jetbrains.annotations.NotNull;

import java.time.Clock;
import java.time.Duration;
import java.util.Timer;
import java.util.TimerTask;

public class TransferSimulationExtension implements ServiceExtension {

    public static final String TEST_TYPE = "test-type";
    private static final long ALMOST_TEN_MINUTES = Duration.ofMinutes(9).plusSeconds(55).toMillis();
    @Inject
    private TransferProcessStore store;

    @Inject
    private Clock clock;

    @Override
    public void initialize(ServiceExtensionContext context) {
        //Insert a test TP after a delay to simulate a zombie transfer
        new Timer().schedule(
                new TimerTask() {
                    @Override
                    public void run() {
                        var tp = TransferProcess.Builder.newInstance()
                                .id("tp-sample-transfer-03")
                                .dataRequest(getRequest())
                                .state(TransferProcessStates.STARTED.code())
                                .stateTimestamp(clock.millis() - ALMOST_TEN_MINUTES)
                                .build();
                        tp.addProvisionedResource(createDummyResource());

                        context.getMonitor().info("Insert Dummy TransferProcess");
                        store.save(tp);
                    }
                },
                5000
        );
    }

    @NotNull
    private ProvisionedDataDestinationResource createDummyResource() {
        return new ProvisionedDataDestinationResource() {
        };
    }

    private DataRequest getRequest() {
        return DataRequest.Builder.newInstance()
                .id("sample-transfer-03-datarequest")
                .assetId("assetId")
                .contractId("contractId")
                .destinationType(TEST_TYPE)
                .connectorAddress("http//localhost:9999")
                .protocol("dataspace-protocol-http")
                .build();
    }

}
