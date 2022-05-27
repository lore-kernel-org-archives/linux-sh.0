Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80FCC433EF
	for <linux-sh@archiver.kernel.org>; Fri, 27 May 2022 12:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353168AbiE0M3D (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 27 May 2022 08:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355037AbiE0M1O (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 27 May 2022 08:27:14 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8B714CDEE
        for <linux-sh@vger.kernel.org>; Fri, 27 May 2022 05:05:38 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CBE863F5EE
        for <linux-sh@vger.kernel.org>; Fri, 27 May 2022 12:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653653075;
        bh=oOCTsXFRjJ2XlQZekYMt58Ab+xoHPAvZsZMQKS0jhWk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=DRKEWB1+G4YgtMdv5nNECfeFyN7R0n8iqMeJwMRGD6OloLgZ+ONfooHVjzUvcIUrK
         mc6yAzLPpTWkE+UcH2VYbwSJitDWCHIlbOzyeZHokPaBIFPHLw8u2SE3LrxXKl22MV
         vb2qM0/G9nELx2HBDFEQat0swAl8IOv1uunkO2aXRcvD7wwfBK3cDS4oewpwojP226
         CimFlHXvp8ruHpP0Sgb94zx2+TT3eorfBJlNRhpAaOm1RwrSE9qpuBRymS+Jd0hK4m
         aAbIq8bKrJS0dvJvv8yDOD/TiGJwDc0A4Z6ByIyVVOs0KNSaAOBccIuimcn3CJwPwA
         kMDvBByu2UcAg==
Received: by mail-ej1-f71.google.com with SMTP id p7-20020a170906614700b006f87f866117so2290169ejl.21
        for <linux-sh@vger.kernel.org>; Fri, 27 May 2022 05:04:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oOCTsXFRjJ2XlQZekYMt58Ab+xoHPAvZsZMQKS0jhWk=;
        b=ow03mS1A4K13w6g5YgSQR/7kyrL1Qsr5KTUFWsVP/5fgGOtFbhHT/onZaBZwh81ljc
         /9RXSjkc+rY6iBnMm6/wPwvOd1HhbhdzNi4URbSr1+IvZT7uhxoLj36FCDCGvbnvw+hy
         1efV9N/OGGbxmQU7PXa/1HshIAoQFp1OGGLMhI+6eswE1ntxe2qHSKHJo4tAqwzekuKb
         vcM1o62upt9aAXRWWKQ76Mlpebk3hLf3KJeRxb+4EZUzJfPdkjbjjwz6oS2jUNvOn5iY
         0wmRW6DWe1U2lqwPQEPdnTTsTm3I/ehaQCSoGQwIm7es5iMRZ1v4G5Igfa1dN81uiCfg
         KAmw==
X-Gm-Message-State: AOAM5325dV9iFPzdl+Q2NhKnph+CHsginAo406Hj10BsQiVgiHfAz0mv
        tyioIiv3KJZnrXRQRuPJYjIW8qGf+z6Vz3GLXsdf1sI34K7cE6dMPLFN9O8OeyHlfASJ9+VMCzz
        AY9L+vXEVljVyuPftrCRAo0Hle7J0z7WEBxDC
X-Received: by 2002:a05:6402:528f:b0:42a:c778:469e with SMTP id en15-20020a056402528f00b0042ac778469emr44092649edb.404.1653653075192;
        Fri, 27 May 2022 05:04:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzebqk4x0v1u6z1D5wE6Tcbj7WIsf2nELITM9fcePdJZJWGLK19jFqy0txhZTtOE+1rguS0lw==
X-Received: by 2002:a05:6402:528f:b0:42a:c778:469e with SMTP id en15-20020a056402528f00b0042ac778469emr44092623edb.404.1653653075022;
        Fri, 27 May 2022 05:04:35 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id bw12-20020a170906c1cc00b006f3ef214dc3sm1413242ejb.41.2022.05.27.05.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 05:04:33 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org, sergei.shtylyov@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 3/4 v2] sh/boards: Kconfig: Fix indentation and remove trailing whitespaces
Date:   Fri, 27 May 2022 14:04:30 +0200
Message-Id: <20220527120430.459187-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <c371fcc7-08ad-7de7-cb9a-aa316a98047c@gmail.com>
References: <c371fcc7-08ad-7de7-cb9a-aa316a98047c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two spaces. Fix the lines that violate
these rules.

While at it, remove trailing whitespaces.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
v2:
  Update commit message and subject per review comments.
---
 arch/sh/boards/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
index 83bcb6d2daca..fbdb3fbfb976 100644
--- a/arch/sh/boards/Kconfig
+++ b/arch/sh/boards/Kconfig
@@ -36,7 +36,7 @@ config SH_SOLUTION_ENGINE
 	select CPU_HAS_IPR_IRQ
 	depends on CPU_SUBTYPE_SH7705 || CPU_SUBTYPE_SH7709 || CPU_SUBTYPE_SH7710 || \
 	  CPU_SUBTYPE_SH7712 || CPU_SUBTYPE_SH7750 || CPU_SUBTYPE_SH7750S || \
-	  CPU_SUBTYPE_SH7750R 
+	  CPU_SUBTYPE_SH7750R
 	help
 	  Select SolutionEngine if configuring for a Hitachi SH7705, SH7709,
 	  SH7710, SH7712, SH7750, SH7750S or SH7750R evaluation board.
@@ -56,7 +56,7 @@ config SH_7619_SOLUTION_ENGINE
 	help
 	  Select 7619 SolutionEngine if configuring for a Hitachi SH7619
 	  evaluation board.
-	
+
 config SH_7721_SOLUTION_ENGINE
 	bool "SolutionEngine7721"
 	select SOLUTION_ENGINE
@@ -94,7 +94,7 @@ config SH_7751_SOLUTION_ENGINE
 	help
 	  Select 7751 SolutionEngine if configuring for a Hitachi SH7751
 	  evaluation board.
-	  
+
 config SH_7780_SOLUTION_ENGINE
 	bool "SolutionEngine7780"
 	select SOLUTION_ENGINE
@@ -167,8 +167,8 @@ config SH_RSK
 	  CPU_SUBTYPE_SH7264 || CPU_SUBTYPE_SH7269
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
-	 Select this option if configuring for any of the RSK+ MCU
-	 evaluation platforms.
+	  Select this option if configuring for any of the RSK+ MCU
+	  evaluation platforms.
 
 config SH_SDK7780
 	bool "SDK7780R3"
@@ -236,7 +236,7 @@ config SH_MIGOR
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
 	  Select Migo-R if configuring for the SH7722 Migo-R platform
-          by Renesas System Solutions Asia Pte. Ltd.
+	  by Renesas System Solutions Asia Pte. Ltd.
 
 config SH_AP325RXA
 	bool "AP-325RXA"
-- 
2.32.0

