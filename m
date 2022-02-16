Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7027C433F5
	for <linux-sh@archiver.kernel.org>; Wed, 16 Feb 2022 01:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245505AbiBPBex (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 15 Feb 2022 20:34:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245502AbiBPBeu (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 15 Feb 2022 20:34:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3FCA6F70DA
        for <linux-sh@vger.kernel.org>; Tue, 15 Feb 2022 17:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644975278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TxaBIMaSmpGvEpUN6pnfgExDYJwGH+sDt4Nge7L+SbE=;
        b=TbJphcHfG4w4kmT5FIjNovFMUbt6+7wpfOtueb8e55n3W7ahslubEcK9/uEeka/VYDyp6c
        xeQXIYKA4DK53y/eB9AEWtJAmHSVFEivCpNH61I5spGa2yaB/bJUusneDbn0FLDIQmNADM
        QLR1nDjujJ58m4IexFM+TIyvDWNSnE4=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-66-fF7EfT21MZaO7N9k-02aaA-1; Tue, 15 Feb 2022 20:34:37 -0500
X-MC-Unique: fF7EfT21MZaO7N9k-02aaA-1
Received: by mail-ot1-f69.google.com with SMTP id q8-20020a056830232800b005ab75f5e906so419067otg.18
        for <linux-sh@vger.kernel.org>; Tue, 15 Feb 2022 17:34:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TxaBIMaSmpGvEpUN6pnfgExDYJwGH+sDt4Nge7L+SbE=;
        b=W3WctQ7iMcNEpLxH47EIQgR6jw5rlAwsm5hvuA28myEuZ95jwLV2gp22wxBhl5WCcr
         ygbIFPp6ya+v9zTO/aTHUiNMfytb9yFE2IEFhiC2xOW8r1iZ0hLhpIyr9qlGx9tw7XsA
         P9G/NC6qKy6tVG4Ea9H52Zc/yBzAy5sRpVWX/dyu4W+DmizCD2LWzlYQBZ+ej8fNKpJv
         VDSE7Shf5HCh24N1tmQWIIZq9DAXQWx3To0V7ZlaiDa58UJqe/XqNXijvjjF3duQPpQT
         nc22yD9NsPvB+Eyc7Wr+pPPv6gFHvOyMPQkqsRkVqfsS3sY3NEg7vM7yFbjHMLQOAGNi
         vuEg==
X-Gm-Message-State: AOAM533iPpwsai7oC7mPJU498mcA2G74bsI8T4Zl0aIkGu+rIONGaNY0
        DoB6OkgpEReFUAyJQsz8wZOdCn2ETXDdcA7Ir9qatQuSUekplaaHwtFRqXbFCD2fSIAd33txhI+
        SHTQIcHwsz679DywB5+Q=
X-Received: by 2002:a05:6870:e749:b0:d3:4ada:380e with SMTP id t9-20020a056870e74900b000d34ada380emr244592oak.206.1644975276261;
        Tue, 15 Feb 2022 17:34:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxIWFPq8WR/J0ftst2Qc1PQDGPtfYiYgOJVkBhQLwJvoEFneclhBD3/SN4zuCWYCBqLlE5zJw==
X-Received: by 2002:a05:6870:e749:b0:d3:4ada:380e with SMTP id t9-20020a056870e74900b000d34ada380emr244588oak.206.1644975276058;
        Tue, 15 Feb 2022 17:34:36 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id 100sm14574391oth.75.2022.02.15.17.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 17:34:35 -0800 (PST)
From:   trix@redhat.com
To:     ysato@users.sourceforge.jp, dalias@libc.org
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] sh: cleanup comments
Date:   Tue, 15 Feb 2022 17:34:24 -0800
Message-Id: <20220216013424.3062140-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Replacements:
SPDX--License-Identifier to SPDX-License-Identifier
incase to in case
Adaptor to Adapter
overruning to overrunning

Signed-off-by: Tom Rix <trix@redhat.com>
---
 arch/sh/drivers/dma/dma-sh.c           | 2 +-
 arch/sh/drivers/pci/fixups-dreamcast.c | 2 +-
 arch/sh/drivers/pci/pci-dreamcast.c    | 2 +-
 arch/sh/drivers/pci/pci-sh7751.c       | 2 +-
 arch/sh/drivers/platform_early.c       | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/sh/drivers/dma/dma-sh.c b/arch/sh/drivers/dma/dma-sh.c
index 96c626c2cd0a..38e2d62c330c 100644
--- a/arch/sh/drivers/dma/dma-sh.c
+++ b/arch/sh/drivers/dma/dma-sh.c
@@ -261,7 +261,7 @@ static inline int dmaor_reset(int no)
 {
 	unsigned long dmaor = dmaor_read_reg(no);
 
-	/* Try to clear the error flags first, incase they are set */
+	/* Try to clear the error flags first, in case they are set */
 	dmaor &= ~(DMAOR_NMIF | DMAOR_AE);
 	dmaor_write_reg(no, dmaor);
 
diff --git a/arch/sh/drivers/pci/fixups-dreamcast.c b/arch/sh/drivers/pci/fixups-dreamcast.c
index 41e4daee8f04..2e8a1e2233a3 100644
--- a/arch/sh/drivers/pci/fixups-dreamcast.c
+++ b/arch/sh/drivers/pci/fixups-dreamcast.c
@@ -9,7 +9,7 @@
  *
  * This file originally bore the message (with enclosed-$):
  *	Id: pci.c,v 1.3 2003/05/04 19:29:46 lethal Exp
- *	Dreamcast PCI: Supports SEGA Broadband Adaptor only.
+ *	Dreamcast PCI: Supports SEGA Broadband Adapter only.
  */
 
 #include <linux/sched.h>
diff --git a/arch/sh/drivers/pci/pci-dreamcast.c b/arch/sh/drivers/pci/pci-dreamcast.c
index 4cff2a8107bf..c48ae4576d24 100644
--- a/arch/sh/drivers/pci/pci-dreamcast.c
+++ b/arch/sh/drivers/pci/pci-dreamcast.c
@@ -7,7 +7,7 @@
  *
  * This file originally bore the message (with enclosed-$):
  *	Id: pci.c,v 1.3 2003/05/04 19:29:46 lethal Exp
- *	Dreamcast PCI: Supports SEGA Broadband Adaptor only.
+ *	Dreamcast PCI: Supports SEGA Broadband Adapter only.
  */
 
 #include <linux/sched.h>
diff --git a/arch/sh/drivers/pci/pci-sh7751.c b/arch/sh/drivers/pci/pci-sh7751.c
index 11ed21c2e9bb..0324ab2564d8 100644
--- a/arch/sh/drivers/pci/pci-sh7751.c
+++ b/arch/sh/drivers/pci/pci-sh7751.c
@@ -170,7 +170,7 @@ static int __init sh7751_pci_init(void)
 	pci_fixup_pcic(chan);
 
 	/* SH7751 init done, set central function init complete */
-	/* use round robin mode to stop a device starving/overruning */
+	/* use round robin mode to stop a device starving/overrunning */
 	word = SH4_PCICR_PREFIX | SH4_PCICR_CFIN | SH4_PCICR_ARBM;
 	pci_write_reg(chan, word, SH4_PCICR);
 
diff --git a/arch/sh/drivers/platform_early.c b/arch/sh/drivers/platform_early.c
index 143747c45206..1c2a571a8ab8 100644
--- a/arch/sh/drivers/platform_early.c
+++ b/arch/sh/drivers/platform_early.c
@@ -1,4 +1,4 @@
-// SPDX--License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0
 
 #include <asm/platform_early.h>
 #include <linux/mod_devicetable.h>
-- 
2.26.3

