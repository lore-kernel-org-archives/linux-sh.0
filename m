Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1B7C43334
	for <linux-sh@archiver.kernel.org>; Thu, 30 Jun 2022 15:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbiF3PeQ (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 30 Jun 2022 11:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236014AbiF3Pdk (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 30 Jun 2022 11:33:40 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22EA25FA
        for <linux-sh@vger.kernel.org>; Thu, 30 Jun 2022 08:33:39 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v9so12287527wrp.7
        for <linux-sh@vger.kernel.org>; Thu, 30 Jun 2022 08:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject
         :content-transfer-encoding;
        bh=TFGxfKfYNc6FX30F9sKmEL18XnIK/Iwh98w/L1TSaX4=;
        b=blUFbC3b9XXke4KbKSdxYfQvJ8ALHON967lZ20HW9c2BDfQlwP5UNrBlcXptRBxm0e
         +AvtQVHNd4kJwKkGxXYH4MIU+3TiFMA5ey5Q6pNjaFqMb1WKUwtiI7RpqiZPxDCitiL6
         fsWNCRHiho/gk7OJSO9137Op6oHH2CesBLnp7U011Yn6G92obx1GD79ZjMcVAjmiti4k
         5o6aLidz8MykdCsBCMjaqP7MM7anBUbbmuMrTgzA2TTfOynVveq8gtnYuoNr9duISY2B
         UrE/KJ5NwhGXabuJGSZKi6PtOxfM56xo8m+BN4Q3ZqsZUSi3QTjAt97sapu0ASnm5a3Q
         2HRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :content-transfer-encoding;
        bh=TFGxfKfYNc6FX30F9sKmEL18XnIK/Iwh98w/L1TSaX4=;
        b=qIaVnD1jeRDyzYazJHQnL11wv2F9lfEYWxp8va5rmDJg85SMRDiDEyvWLZcmH+Mfdq
         ZDf1iQZl09at6vOy6BzIfNPqCJY4hnx/Az91Bat4U4voRoaKN+f5Q0hdWaOn0KoBbOyA
         3sNQOw5kqwVQTrgqJy1LiRvYGiertcAKGsmIqQtTNFEgyZLrBqrr0bvJBY5MRR2UjKus
         9O5l4KSnDoFXs/Y3UD/zeVLavkS5NWUyw4EVcIGVM79JKZcaeTYtc2Ft5WaGmn+lUNIP
         SXCCsjkUF069x+WLEJhrEE0cPmO7Q+S6jM2+mKIxQwz87D/pDZ1FO4V1VftcD4dQ2gbm
         EXmA==
X-Gm-Message-State: AJIora+mYDPyxA63jtGRtLx0+pax57GWru3Q+SdvzF7cm/jR1fD8QmNS
        CbsoFSmh3b2bTetvuCCJVv29HLyjlIw=
X-Google-Smtp-Source: AGRyM1sRPxRDHN38kD4D5jLSRoup+bqizxPQrD88AW0D0//ZlEVuoPW+hnFh/ZHo8IJ69AlUlgPIYg==
X-Received: by 2002:adf:db89:0:b0:21b:84a6:9cce with SMTP id u9-20020adfdb89000000b0021b84a69ccemr9270686wri.675.1656603218136;
        Thu, 30 Jun 2022 08:33:38 -0700 (PDT)
Received: from DESKTOP-L1U6HLH ([39.53.244.205])
        by smtp.gmail.com with ESMTPSA id e12-20020a5d530c000000b002185d79dc7fsm19643154wrv.75.2022.06.30.08.33.37
        for <linux-sh@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 30 Jun 2022 08:33:37 -0700 (PDT)
Message-ID: <62bdc251.1c69fb81.c2d0e.5b94@mx.google.com>
Date:   Thu, 30 Jun 2022 08:33:37 -0700 (PDT)
X-Google-Original-Date: 30 Jun 2022 11:33:39 -0400
MIME-Version: 1.0
From:   bryce.dreamlamdestimation@gmail.com
To:     linux-sh@vger.kernel.org
Subject: Estimating Services
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hi,=0D=0A=0D=0AWe provide estimation & quantities takeoff service=
s. We are providing 98-100 accuracy in our estimates and take-off=
s. Please tell us if you need any estimating services regarding y=
our projects.=0D=0A=0D=0ASend over the plans and mention the exac=
t scope of work and shortly we will get back with a proposal on w=
hich our charges and turnaround time will be mentioned=0D=0A=0D=0A=
You may ask for sample estimates and take-offs. Thanks.=0D=0A=0D=0A=
Kind Regards=0D=0ABryce Weems=0D=0ADreamland Estimation, LLC

