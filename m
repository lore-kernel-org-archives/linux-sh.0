Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEF8C77B75
	for <linux-sh@archiver.kernel.org>; Tue, 18 Apr 2023 04:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjDREIR (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 18 Apr 2023 00:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjDREIR (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 18 Apr 2023 00:08:17 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538163C3B
        for <linux-sh@vger.kernel.org>; Mon, 17 Apr 2023 21:08:13 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d2e1a72fcca58-63b62d2f729so1091423b3a.1
        for <linux-sh@vger.kernel.org>; Mon, 17 Apr 2023 21:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20221208.gappssmtp.com; s=20221208; t=1681790892; x=1684382892;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=meno7njxl6eUAqTyuR1oL0Xd/upDGwD5Z023aoxqfg8=;
        b=oJExoZdvkrp+5RCwyR10oeKAqhF4xM59+qryek4MRN7IOTu9JzC/gC8KiCm07JLzgh
         T/1zpdRcJrd8BOEgNOJcL3fBJBElhWw3pYd+42Y69N/arD9rNMmE15xuktgz11J1O7YS
         DD1NNQesZWmEgSNhTidkvlv0lU+2HkuVlKC8lmiZngGXeI0dXNR8VrehDacOmGo/+rcy
         iVRz01hR7b9wJydqVI49Ie7cGmI3CAvXUxETNgL47qe8L8HJexbf5sXSJtbcdM6/091g
         +wXMOR8FZRPA+4gRQy8Y1mahojpayWl+yIbeTNLaFz1aCdtsLL0PKUwAOvMhveiAX3zQ
         TlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681790892; x=1684382892;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=meno7njxl6eUAqTyuR1oL0Xd/upDGwD5Z023aoxqfg8=;
        b=ggWqGM7IbFuJzcXDlJ6N5htgoel61n9BJGJofPRFiJMLYOnOWqFjbyNiAOqNvXAD96
         DfMTT9EpTD4xWcL/oGO9GlCWZixPiu5fbXj/X4NV/91O0FleFWfadntLYsmc6v+ips/X
         s6nmL5zYn5n9sYTLKZbTxu7TfTlDpdIqOiuRkGsGxY/15LzTT2DWTPTo67B4J56qptZY
         S/gJjbu29Bni1FQ+2jhnGTRwrG0GIWnIqeN0aFcm4Mh2dG+XL4Iriu+1yao9l8cTf9Qe
         hfx+V+PhSgWLlNPHKR/4OZN+XFIfF2imNKCt8phucmxNn/u83pss++4tSfMfgK60QimL
         ER1A==
X-Gm-Message-State: AAQBX9dZMygeQj1wz8MfDC/uZ+ZH3kcOTTNXKK6/CLM0KOcBoPugfgwb
        kIa6xcsg6h6sa00e/gCUaCVKUCjz7IpJ+cCiEqtVc7xF
X-Google-Smtp-Source: AKy350YA7j1KDvIvpv8dnk82wVulyNWoeUDJ10Fifk1A0ZABoILnEoVp6OJD0qNTq181O8lsaH2Dkw==
X-Received: by 2002:a05:6a00:850:b0:626:1523:b10d with SMTP id q16-20020a056a00085000b006261523b10dmr28697289pfk.4.1681790892647;
        Mon, 17 Apr 2023 21:08:12 -0700 (PDT)
Received: from [192.168.33.147] (124-110-25-102.east.xps.vectant.ne.jp. [124.110.25.102])
        by smtp.gmail.com with ESMTPSA id e16-20020aa78250000000b005e4c3e2022fsm8231847pfn.72.2023.04.17.21.08.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 21:08:12 -0700 (PDT)
Message-ID: <ec905cf9-09de-a5d1-b8ee-0d874db4c301@landley.net>
Date:   Mon, 17 Apr 2023 23:23:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Linux-sh list <linux-sh@vger.kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
From:   Rob Landley <rob@landley.net>
Subject: [PATCH] Fix J-core aic warning spam
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

From: Rich Felker <dalias@libc.org>
Signed-off-by: Rob Landley <rob@landley.net>

Silence noisy boot messages (warning and stack dump for each IRQ) when booting
on J2 SOC.

---
 drivers/irqchip/irq-jcore-aic.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/irqchip/irq-jcore-aic.c b/drivers/irqchip/irq-jcore-aic.c
index 5f47d8ee4ae3..730252cb7b08 100644
--- a/drivers/irqchip/irq-jcore-aic.c
+++ b/drivers/irqchip/irq-jcore-aic.c
@@ -68,6 +68,7 @@ static int __init aic_irq_of_init(struct device_node *node,
 	unsigned min_irq = JCORE_AIC2_MIN_HWIRQ;
 	unsigned dom_sz = JCORE_AIC_MAX_HWIRQ+1;
 	struct irq_domain *domain;
+	int rc;

 	pr_info("Initializing J-Core AIC\n");

@@ -100,6 +101,11 @@ static int __init aic_irq_of_init(struct device_node *node,
 	jcore_aic.irq_unmask = noop;
 	jcore_aic.name = "AIC";

+	rc = irq_alloc_descs(min_irq, min_irq, dom_sz - min_irq,
+			     of_node_to_nid(node));
+	if (rc < 0)
+		pr_info("Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
+			min_irq);
 	domain = irq_domain_add_legacy(node, dom_sz - min_irq, min_irq, min_irq,
 				       &jcore_aic_irqdomain_ops,
 				       &jcore_aic);
-- 
2.20.1
