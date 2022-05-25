Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2149EC433FE
	for <linux-sh@archiver.kernel.org>; Wed, 25 May 2022 12:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238201AbiEYMkW (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 25 May 2022 08:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbiEYMkU (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 25 May 2022 08:40:20 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FEB7A821
        for <linux-sh@vger.kernel.org>; Wed, 25 May 2022 05:40:17 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EB3A63F6F9
        for <linux-sh@vger.kernel.org>; Wed, 25 May 2022 12:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653482415;
        bh=qDDIAAvUt7blo3PUroyBqBlIiFZ/YuR5nco8lmMiCCY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=j3gy2uRhV9oujvkF0MxvhoU075lmQ0qqT7Cd8zxWRHpjhH12aQPpi4XOEqNph6+LW
         oIXqcuXxMqCkSaM4qg0ipbkvw9LTeax9ALsv614RxABcdn+xgHdynwTZeE43YCot2w
         7BMZgH8VmEHLRGyKsZ+POdWtPe9pQJb8yVwUEmqm1WQuakuyeFAIS5IyHBJQqahck8
         eETp8v5IwXZGkbB6FEELXBvBSAr6di58B3pbRon86XjpIwEFy7LlCN64LYT3ui43sP
         yQ5HAH9y0pBRu5BXmfgd96MWSiBNlSOeQkm9EXoH1VVHNmgtP4cILnmn/ujIqrvf6a
         HDlWVWbpAdyVw==
Received: by mail-ed1-f70.google.com with SMTP id y10-20020aa7ce8a000000b0042bc52fb825so1740480edv.8
        for <linux-sh@vger.kernel.org>; Wed, 25 May 2022 05:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qDDIAAvUt7blo3PUroyBqBlIiFZ/YuR5nco8lmMiCCY=;
        b=5lxx+bijf6dZr005QLYfUfiE8jTPDepdQIhWEcIy52A325UqbIlZBkXvjt/ezOfZgf
         wL3r+2wZp++O1Z4x5QCnuFWqRciOUT6SPMXcrri7W1Si6oPI7r3jsuMU9G85mRv7e7kP
         UD8egLXfhhayt8+m2pdYx3LGLYsuT/w+5O4R+cXRE2JcGFQVtWLOeBsIeUx8bgST4p/U
         YVA38vv94n7emS0nvfu7xWOdxeYaT2UMlW244nvLA2kXPeYDXEJ5B5BO8ymFYjSwCAMC
         D/zYlzInEFglcH8oAL81Mtq4gsvPs6e1ijWB+TcnqveMr7HyFbC+pJptqxxtPA9/vB43
         8Tkw==
X-Gm-Message-State: AOAM530mJINn9ImxUvFtfskc4u54/psqgYAUOVLrq/5vDWiRnpBOBOhb
        NzZorRZJ6zzLmrrzdJAmnwcHi0R+cAxTyfQXaFuYAg0TLO1LbWMOM1Nj4++6ou9253HWUKeyGEw
        GIDWnRXjuerJ67XjW7tU9mKIdKbgpymiqFFhg
X-Received: by 2002:a05:6402:40cc:b0:42b:3327:d699 with SMTP id z12-20020a05640240cc00b0042b3327d699mr25863282edb.380.1653482415597;
        Wed, 25 May 2022 05:40:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfaCyBUXVQDvxQHJs2/wsF8PEzAocgngbhZDSaAmeNaGiWhQpkkOgFhOVssls3a9B2ozPozA==
X-Received: by 2002:a05:6402:40cc:b0:42b:3327:d699 with SMTP id z12-20020a05640240cc00b0042b3327d699mr25863266edb.380.1653482415378;
        Wed, 25 May 2022 05:40:15 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id y20-20020a50eb94000000b0042617ba63c4sm10632614edr.78.2022.05.25.05.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 05:40:14 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 1/4] sh: Kconfig: Fix indentation
Date:   Wed, 25 May 2022 14:40:04 +0200
Message-Id: <20220525124007.45328-2-juerg.haefliger@canonical.com>
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

While at it, remove stray spaces from seemingly empty lines.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 arch/sh/Kconfig | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 5f220e903e5a..fc15fd6b719e 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -200,9 +200,9 @@ config ARCH_SHMOBILE
 	select PM
 
 config CPU_HAS_PMU
-       depends on CPU_SH4 || CPU_SH4A
-       default y
-       bool
+	depends on CPU_SH4 || CPU_SH4A
+	default y
+	bool
 
 choice
 	prompt "Processor sub-type selection"
@@ -231,7 +231,7 @@ config CPU_SUBTYPE_SH7201
 	select CPU_SH2A
 	select CPU_HAS_FPU
 	select SYS_SUPPORTS_SH_MTU2
- 
+
 config CPU_SUBTYPE_SH7203
 	bool "Support SH7203 processor"
 	select CPU_SH2A
@@ -493,7 +493,7 @@ config CPU_SUBTYPE_SH7366
 endchoice
 
 source "arch/sh/mm/Kconfig"
- 
+
 source "arch/sh/Kconfig.cpu"
 
 source "arch/sh/boards/Kconfig"
@@ -644,7 +644,7 @@ config GUSA
 	  This is the default implementation for both UP and non-ll/sc
 	  CPUs, and is used by the libc, amongst others.
 
-	  For additional information, design information can be found 
+	  For additional information, design information can be found
 	  in <http://lc.linux.or.jp/lc2002/papers/niibe0919p.pdf>.
 
 	  This should only be disabled for special cases where alternate
@@ -775,12 +775,12 @@ config MAPLE
 	bool "Maple Bus support"
 	depends on SH_DREAMCAST
 	help
-	 The Maple Bus is SEGA's serial communication bus for peripherals
-	 on the Dreamcast. Without this bus support you won't be able to
-	 get your Dreamcast keyboard etc to work, so most users
-	 probably want to say 'Y' here, unless you are only using the
-	 Dreamcast with a serial line terminal or a remote network
-	 connection.
+	  The Maple Bus is SEGA's serial communication bus for peripherals
+	  on the Dreamcast. Without this bus support you won't be able to
+	  get your Dreamcast keyboard etc to work, so most users
+	  probably want to say 'Y' here, unless you are only using the
+	  Dreamcast with a serial line terminal or a remote network
+	  connection.
 
 endmenu
 
-- 
2.32.0

