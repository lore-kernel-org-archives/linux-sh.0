Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731FBC433F5
	for <linux-sh@archiver.kernel.org>; Wed, 25 May 2022 12:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242040AbiEYMkc (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 25 May 2022 08:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243208AbiEYMk2 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 25 May 2022 08:40:28 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A9887221
        for <linux-sh@vger.kernel.org>; Wed, 25 May 2022 05:40:25 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F1B0D3F044
        for <linux-sh@vger.kernel.org>; Wed, 25 May 2022 12:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653482422;
        bh=wxP3HgqlZutRyZ4be1K5ovWzoc7v+dNBukvYrue+SPk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=P+Hem80gbFPa7It+Xslg/l0cKRvVXnj+hPf3i471R5mvkTyh2rkl087hMjBGwExee
         kqu9itjwXQcwP0keO6O57agas6vSPnzIe6r/FPfnqPjeDj9dcQxFYBCcBiktVy9gHL
         Zxl+ZCH0gbsOrF/WzWlWHPjSUtHKifH5beh9S45u6nWau5+cnkUSy2SiSBskwFmqr8
         rfY/+OHuJkhSAd0eire8qKeINHMDw5xcgsvoKkq9sHtEb6B/P84FEulsuNV8k+H2Hq
         Mrr52qxRvHhdNFU8UzibVkhC9MNcfzgL2b2EmDUcQhPJz4Iomm0kmT54Zpr5ztRKnr
         94rh6lLHg7Wxw==
Received: by mail-ed1-f72.google.com with SMTP id b3-20020aa7d483000000b004282ca95814so14663845edr.9
        for <linux-sh@vger.kernel.org>; Wed, 25 May 2022 05:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wxP3HgqlZutRyZ4be1K5ovWzoc7v+dNBukvYrue+SPk=;
        b=2sTW3Hpz15CtBR2uLUyEcTSa+M2lJ57AxBMMGNfIpA0MBGkIyyPq90h+QgpePWPq8x
         mYDHQgzwX7wPW5d//IkLYHsZJ54tpEWe2M+3M8KvD1PT1nZYzaLmr+zQFYfD/WGwQQus
         LYi+X2L+EfwG/oEiSQXXEHNwKWdl/swiyI51ffssk2Vi4D75vL2odmSM0qFGRvd9mhAH
         wRoe+mlnF+4mmd00lcdQie/K3eAss758Kc1SM2mMSmPwZnQLRnu4leXWliKWDRNCb+3O
         wq1mzx8UlFK6XxffUPuVhZasyKaUiya6S72IJ7fJ1omv1Uli3sOnoOKgWClWHx0ohTZI
         ACWQ==
X-Gm-Message-State: AOAM5320Rn1LLxznowmc1Gn+6V336rLkhg3yCnDTobwDMPw0gFt1xwGM
        dqjbrmS8uPZucDRPs0v9bpOsHOC6rwpCXsTL0BAljC1GUmcZES4F7XZKENTkbpgs3LI3bXySV+H
        tOr5t3j2ZV5HL7hzVyynYWIZzwv6i3PbPjPGF
X-Received: by 2002:a05:6402:190a:b0:42b:60b:592b with SMTP id e10-20020a056402190a00b0042b060b592bmr31295065edz.127.1653482418294;
        Wed, 25 May 2022 05:40:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIMAXsEqufeY6FOCVF5hwJzfTKb6LKPU2BWrQTsIhu4mtSwZ/E8Ri0gjrQfdHvSRWC1/8qFw==
X-Received: by 2002:a05:6402:190a:b0:42b:60b:592b with SMTP id e10-20020a056402190a00b0042b060b592bmr31295046edz.127.1653482418107;
        Wed, 25 May 2022 05:40:18 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id y20-20020a50eb94000000b0042617ba63c4sm10632614edr.78.2022.05.25.05.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 05:40:17 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 4/4] sh/mm: Kconfig: Fix indentation
Date:   Wed, 25 May 2022 14:40:07 +0200
Message-Id: <20220525124007.45328-5-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220525124007.45328-1-juerg.haefliger@canonical.com>
References: <20220525124007.45328-1-juerg.haefliger@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 arch/sh/mm/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
index ba569cfb4368..a563211aeb63 100644
--- a/arch/sh/mm/Kconfig
+++ b/arch/sh/mm/Kconfig
@@ -2,7 +2,7 @@
 menu "Memory management options"
 
 config MMU
-        bool "Support for memory management hardware"
+	bool "Support for memory management hardware"
 	depends on !CPU_SH2
 	default y
 	help
@@ -141,8 +141,8 @@ config ARCH_MEMORY_PROBE
 	depends on MEMORY_HOTPLUG
 
 config IOREMAP_FIXED
-       def_bool y
-       depends on X2TLB
+	def_bool y
+	depends on X2TLB
 
 config UNCACHED_MAPPING
 	bool
-- 
2.32.0

