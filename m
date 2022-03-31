Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46F2C433F5
	for <linux-sh@archiver.kernel.org>; Thu, 31 Mar 2022 16:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239667AbiCaQIb (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 31 Mar 2022 12:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239651AbiCaQIY (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 31 Mar 2022 12:08:24 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AA35AEF6
        for <linux-sh@vger.kernel.org>; Thu, 31 Mar 2022 09:06:37 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id i4so449954wrb.5
        for <linux-sh@vger.kernel.org>; Thu, 31 Mar 2022 09:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject
         :content-transfer-encoding;
        bh=/vW6GKQwBl/KpyF0gls7oQD7ldrjM8IGIWqfV18ZMuM=;
        b=XlvyW5FBQVp2XxqfjzTdF2ot3bJAivhzF5aYf3Vs8RAAmTSwBzP7A+vC+uALRRDnCd
         ygZegcJwmIiftKXZF4GalV+zlqy0Z1SAGrcnO3SUw2/Tq5hgtfoghK6AHySr4bsK2nK3
         Znz+nSktF8BdnMFAk0I55glIysXVkKSgEuVB0PBSJ0TMAxJPFLbL6oBbm1H7MZx1icaR
         r/e+7DXQ9Qa8qHyDVV7hBRGbLwcu2m4HgesCrt/r5kD61yO6GR3/xa+5jZKDF2aBGuDb
         e7yU4v1nIGG0yks2HqBibEK/hxVyMIZixDofjl46drxhZbayJP9H4cMqQRGhoVKtPA5R
         tJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :content-transfer-encoding;
        bh=/vW6GKQwBl/KpyF0gls7oQD7ldrjM8IGIWqfV18ZMuM=;
        b=b4XufeKMkACWJzvnvnPGBoZES4jVcDr3zNmTKq2mDUu1032Zw64xheUiXDs7g5FrQE
         PoS/2YLJk6fX87HvqwNcCvyzIO4+NNsgJ8DkGdAIpn7iqx+yyt2AlSnVYppLL1sHWxbn
         +Dt2u7WGneuSfeZvMXFmftADxnoSvcsVDGPbkHTewAFsBPrDMzdu7HboxCsGQngcSO14
         d0d2mrfK+cxxCI15dPOjSyD+UucQQLprqRz9OkLb2NkvOM23ityCote1J4LWR0zHvcyK
         totBKalexwJBiPufugnncxn7NvUEjy7LhA4YsW+0uQ2bsgaqrxjIn0z4coKlpBxFIc55
         SY0Q==
X-Gm-Message-State: AOAM530y0i55hbLwe6fovdOGbstqKE3OOMn1pycuAnCmK/ozq/56Kp6J
        uMzdMMBpvXQb2KAPoAlfmGWa3K8W+j8=
X-Google-Smtp-Source: ABdhPJwuOCuk841Mxw/uGlltD4dFuX8IrIPqsJdBZ+u8p+jdPauG2G4v3ALq2E/rIN5t8/oJfevsQA==
X-Received: by 2002:a5d:6da8:0:b0:205:8537:af57 with SMTP id u8-20020a5d6da8000000b002058537af57mr4617023wrs.80.1648742795457;
        Thu, 31 Mar 2022 09:06:35 -0700 (PDT)
Received: from DESKTOP-R5VBAL5 ([39.53.224.185])
        by smtp.gmail.com with ESMTPSA id l13-20020a05600002ad00b00203d64c5289sm23728777wry.112.2022.03.31.09.06.33
        for <linux-sh@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 31 Mar 2022 09:06:34 -0700 (PDT)
Message-ID: <6245d18a.1c69fb81.cfd72.e7a3@mx.google.com>
Date:   Thu, 31 Mar 2022 09:06:34 -0700 (PDT)
X-Google-Original-Date: 31 Mar 2022 12:06:34 -0400
MIME-Version: 1.0
From:   gallegosdreamlandestimation@gmail.com
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
Kind Regards=0D=0AGallegos Christoper=0D=0ADreamland Estimation, =
LLC

