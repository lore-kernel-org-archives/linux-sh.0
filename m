Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81FAC433EF
	for <linux-sh@archiver.kernel.org>; Fri, 10 Sep 2021 17:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 875816120F
	for <linux-sh@archiver.kernel.org>; Fri, 10 Sep 2021 17:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbhIJRTH (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 10 Sep 2021 13:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbhIJRTG (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 10 Sep 2021 13:19:06 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E941C061756
        for <linux-sh@vger.kernel.org>; Fri, 10 Sep 2021 10:17:55 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id m21-20020a17090a859500b00197688449c4so1937010pjn.0
        for <linux-sh@vger.kernel.org>; Fri, 10 Sep 2021 10:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=itbhu.ac.in; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xYD2n/bm80yFsEOIoHqmRvRvE9j03/5QQwdCIDeVouU=;
        b=g6xs6P54IkYtF5FK7SspjiY78aJPPYvQRHcCJm6RP9CLyvtXFOfksrkurUDezPMuK1
         5UwrSybwYWU7b9Z2PgFR8SW91AExhnMPaFN5cxwEEuUHKiSmSpboXNy5BLlrFY2Gq7sQ
         Ha+aYR3mkliESuWELCSfFMaXv0g71tBGrVkJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xYD2n/bm80yFsEOIoHqmRvRvE9j03/5QQwdCIDeVouU=;
        b=PmGLt2plqXck6BSjGyDYCais6aiHJCdFdkDRNV9lvg94dWDtcow57wMcsxPcP10FKd
         hDHS4IxJSqdmOn6CNGxuNCdEZl5hbE/0U/QVXGpzNb0SV0mxgGLvKlUadlYfFEsc7vGp
         yGloxnnX7BMrIrYns04MTlLMAHFZGMl9SkIMNNkOMzeT2o/i7z2JKwAZa/nbDgjMQ1pF
         MoR3bkdASAnNfu+nyojW4JpNlbQsREOeq5CNIA1/S/NjIKVZwc5FcqsdU9F8vLoPtCBx
         jVfazfnnhp3W174VekYEKNGnNMwlVUpTOZml5/2XqX2fRE51w+vWFv/LFuyAVjEDGcZQ
         rBaw==
X-Gm-Message-State: AOAM533eGK4BnAyAOtfNH3+PA/eESzgc+zsiTR3ki4XDDjlVqTtYvwca
        R4k+7hYepQRnLhImcn/rmdvcFA==
X-Google-Smtp-Source: ABdhPJzWk0gtuIYMobzAVCVYLNT+B7v6FD3bl44SoFprjDvseTdwAb1XRDNu/8GxxYCQ4eCwwoGAiw==
X-Received: by 2002:a17:90a:c89:: with SMTP id v9mr10519405pja.71.1631294274829;
        Fri, 10 Sep 2021 10:17:54 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:8015:105a:2a52:f3e7:aa6a:4b8a])
        by smtp.gmail.com with ESMTPSA id a194sm5541181pfa.119.2021.09.10.10.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 10:17:54 -0700 (PDT)
From:   Siddhartha Das <siddhartha.das.min19@itbhu.ac.in>
To:     ysato@users.sourceforge.jp
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Siddhartha Das <siddhartha.das.min19@itbhu.ac.in>
Subject: [PATCH] arch: sh: drivers: dma: dma-api.c: Changed preferred function strscpy over strlcpy issue arch: sh: drivers: dma: dma-sysfs.c: Changed preferred function simple_strtoul over kstrtout issue arch: sh: drivers: dma: dmabrg.c: Fixed pointer declaration code issue arch: sh: drivers: heartbeat.c: Fixed preferred unsigned int over unsigned issue
Date:   Fri, 10 Sep 2021 22:47:33 +0530
Message-Id: <20210910171733.105486-1-siddhartha.das.min19@itbhu.ac.in>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Fixed Code style issues and prefer cases

Signed-off-by: Siddhartha Das <siddhartha.das.min19@itbhu.ac.in>
---
 arch/sh/drivers/dma/dma-api.c   | 2 +-
 arch/sh/drivers/dma/dma-sysfs.c | 2 +-
 arch/sh/drivers/dma/dmabrg.c    | 2 +-
 arch/sh/drivers/heartbeat.c     | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/sh/drivers/dma/dma-api.c b/arch/sh/drivers/dma/dma-api.c
index ab9170494dcc..89cd4a3b4cca 100644
--- a/arch/sh/drivers/dma/dma-api.c
+++ b/arch/sh/drivers/dma/dma-api.c
@@ -198,7 +198,7 @@ int request_dma(unsigned int chan, const char *dev_id)
 	if (atomic_xchg(&channel->busy, 1))
 		return -EBUSY;
 
-	strlcpy(channel->dev_id, dev_id, sizeof(channel->dev_id));
+	strscpy(channel->dev_id, dev_id, sizeof(channel->dev_id));
 
 	if (info->ops->request) {
 		result = info->ops->request(channel);
diff --git a/arch/sh/drivers/dma/dma-sysfs.c b/arch/sh/drivers/dma/dma-sysfs.c
index 8ef318150f84..6d20f2ed3b7a 100644
--- a/arch/sh/drivers/dma/dma-sysfs.c
+++ b/arch/sh/drivers/dma/dma-sysfs.c
@@ -80,7 +80,7 @@ static ssize_t dma_store_config(struct device *dev,
 	struct dma_channel *channel = to_dma_channel(dev);
 	unsigned long config;
 
-	config = simple_strtoul(buf, NULL, 0);
+	config = kstrtoul(buf, NULL, 0);
 	dma_configure_channel(channel->vchan, config);
 
 	return count;
diff --git a/arch/sh/drivers/dma/dmabrg.c b/arch/sh/drivers/dma/dmabrg.c
index 5b2c1fd254d7..04c66a8d893f 100644
--- a/arch/sh/drivers/dma/dmabrg.c
+++ b/arch/sh/drivers/dma/dmabrg.c
@@ -122,7 +122,7 @@ static void dmabrg_enable_irq(unsigned int dmairq)
 	__raw_writel(dcr, DMABRGCR);
 }
 
-int dmabrg_request_irq(unsigned int dmairq, void(*handler)(void*),
+int dmabrg_request_irq(unsigned int dmairq, void(*handler)(void *),
 		       void *data)
 {
 	if ((dmairq > 9) || !handler)
diff --git a/arch/sh/drivers/heartbeat.c b/arch/sh/drivers/heartbeat.c
index 24391b444b28..07f04ed0d517 100644
--- a/arch/sh/drivers/heartbeat.c
+++ b/arch/sh/drivers/heartbeat.c
@@ -30,7 +30,7 @@
 static unsigned char default_bit_pos[] = { 0, 1, 2, 3, 4, 5, 6, 7 };
 
 static inline void heartbeat_toggle_bit(struct heartbeat_data *hd,
-					unsigned bit, unsigned int inverted)
+					unsigned int bit, unsigned int inverted)
 {
 	unsigned int new;
 
@@ -59,7 +59,7 @@ static inline void heartbeat_toggle_bit(struct heartbeat_data *hd,
 static void heartbeat_timer(struct timer_list *t)
 {
 	struct heartbeat_data *hd = from_timer(hd, t, timer);
-	static unsigned bit = 0, up = 1;
+	static unsigned int bit = 0, up = 1;
 
 	heartbeat_toggle_bit(hd, bit, hd->flags & HEARTBEAT_INVERTED);
 
-- 
2.25.1

