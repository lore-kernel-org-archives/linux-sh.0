Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AACC433FE
	for <linux-sh@archiver.kernel.org>; Fri, 27 May 2022 12:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355584AbiE0M2K (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 27 May 2022 08:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355144AbiE0M1Y (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 27 May 2022 08:27:24 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB22714E2E5
        for <linux-sh@vger.kernel.org>; Fri, 27 May 2022 05:06:05 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 567673FBEF
        for <linux-sh@vger.kernel.org>; Fri, 27 May 2022 12:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653653144;
        bh=ELHJEY2eK+muvmAqygYYF3QcvcVcGsf6LdaPdx8n1nw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=c2y9ErVISxnurLKUWuvbA4e3MXhyStRC/4XRKhJios0Rm8vFBkmI+qVlRy+62PCp2
         IWeLLpU97k59fXSjNGZFuW44VH9Nh+8YGYGCoo3x749bJYibBa4A3rlGYEO0Uyk9P+
         H0m4Kj6dIcMA6TlTz+aznjpLfGw0YWg97RjHY0rjukUmjUIMzAOG4SUSiZ4im7huOB
         WQhT8ulzVkyq39WNENHHk5QzjSV7JKU3vj/Bmcsv+zgY2NByZmltS4/6Wx/lLwOHK7
         A/nX9QiIHFAMPIE+QRY++dGqkqppv7edq3TkKr+n0k3tkU76rIgCS57B51ChspZ1OK
         t7qYnSYXpkN3Q==
Received: by mail-ed1-f70.google.com with SMTP id ba8-20020a0564021ac800b0042cd460b874so993390edb.15
        for <linux-sh@vger.kernel.org>; Fri, 27 May 2022 05:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ELHJEY2eK+muvmAqygYYF3QcvcVcGsf6LdaPdx8n1nw=;
        b=OpwvcTuZY0nxfQd13M+BtiVNcGqgvdq18GkE/ShK0upHDR0969usb0f34KZjb40jkt
         DFI5wwqxwBL4VFMN/XrJ97bkILZ/9awF6G7+ASgWL9tbw1uKej6Q8CLHyPRf+zRX9+yn
         X+Fz+iUuwLm1VM9HOLrW5NVWdp5romgj+H+ZGqB/cnBFQ+l3E63E6ygkYTY+D+8l82dK
         sRoZfswV3wLOkbvy2nK0SnJ1PU5FeT7I+RbeWiaNtMiFXVdGDvZ/fhvsOVF08bFnovBi
         eoKG3fm5UmwVU9c9VMTQyYKTnGx96lOe6BAK3OnD7RMZZ9Bv7i4xCIVd5gzq6ou4M9z7
         tpMQ==
X-Gm-Message-State: AOAM532SwkmyAW18JKdXb+ACHsIL+qpSqB7rmBMtnu1myQG3U7I8ZhA2
        5yZIqA5cBTRzAt+F/w6dNP2qdtVA0oVUcDMrCYOar2Ht6/MYQ0ynD5zP5F1/WPjixIqqewmjSBO
        kVLgYKYV7vxWwnILM7fTnBDSU+p/67obc4/1p
X-Received: by 2002:a05:6402:1706:b0:42b:d175:1ef4 with SMTP id y6-20020a056402170600b0042bd1751ef4mr11066739edu.10.1653653143860;
        Fri, 27 May 2022 05:05:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKkQu4vwex1CUmBeJ9KoXEu4mtwoV5MbQHQl3N2T9xbM71iOZbr2cqRkGUGMbhsI+DOreR0A==
X-Received: by 2002:a05:6402:1706:b0:42b:d175:1ef4 with SMTP id y6-20020a056402170600b0042bd1751ef4mr11066724edu.10.1653653143714;
        Fri, 27 May 2022 05:05:43 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id j20-20020a1709062a1400b006f3ef214dcdsm1401927eje.51.2022.05.27.05.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 05:05:43 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org, sergei.shtylyov@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 4/4 v2] sh/mm: Kconfig: Fix indentation
Date:   Fri, 27 May 2022 14:05:40 +0200
Message-Id: <20220527120540.459462-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <be49dcae-af31-c825-6ab4-05c59deec9d8@gmail.com>
References: <be49dcae-af31-c825-6ab4-05c59deec9d8@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

The convention for indentation seems to be a single tab. Fix the lines
that violate these rules.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
v2:
  Update commit message per review comments.
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

