Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44518C433F5
	for <linux-sh@archiver.kernel.org>; Wed, 25 May 2022 12:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239019AbiEYMkV (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 25 May 2022 08:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238201AbiEYMkU (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 25 May 2022 08:40:20 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBA97B9C6
        for <linux-sh@vger.kernel.org>; Wed, 25 May 2022 05:40:19 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B53653FBC8
        for <linux-sh@vger.kernel.org>; Wed, 25 May 2022 12:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653482417;
        bh=c10iLeMiN3rtcJh7R+kBjwZ/ioZSoIrALQhmp87Zhi4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=WiDErVRIX37JDRGAyattTvBMlWCeNYjJXMTauu/2ritBqqvKRq001Ghclyu9BpPiX
         u+I8vlSRVvhSyFdEGF/9ofIgC9Aa05uq4kkKc0zgmJ3Nj3q2huF+iEQApy3K/FeXnP
         T6sw2vOA6jMjaSqcfTo+SRfeXbW2DrPVpN/SZhJCPpS6fwiSIR72b8Trx2u6laQCaI
         7NQLrEJ5mmhkJOM6EUPId2GUb23UeraTGw+/5nvQex5EGz2gPpkfz6EHWPqRYx40Y1
         JRT4nVBY/rr3HGsl3+bJFVn/z7YSdXvN5Lh7F1dG0I2smC4y1aEjTSi6Uu67qr9qHA
         tuI9t4n1eeM5g==
Received: by mail-ed1-f70.google.com with SMTP id bc17-20020a056402205100b0042aa0e072d3so14818628edb.17
        for <linux-sh@vger.kernel.org>; Wed, 25 May 2022 05:40:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c10iLeMiN3rtcJh7R+kBjwZ/ioZSoIrALQhmp87Zhi4=;
        b=losE+1fQKUTqwM/yiRxQ3vQmgCkLLjOvrKoUWB3eosEt/zkS3VrekC/1KrEuyj+Q/i
         nYk5I+mVka8YuOMqZMDz+ZgkLJClBZYJWo3jxYyQN2ZGXyU4kVMiDryEg3W+QhzAe8SF
         RZyz5zUicLxRz8+Od6nIbz9PKZ5VTN+idCaryrIu9+Y/zvDinp6/Kqa/4NQL4FxuyZ7L
         tFhP9bB9xK+a097pFzgXVAk/cR++tuipYjR6N4MdS6NROIop0Hc7Qk4XiHFjEtIzVD6i
         NciMlM3X6DbHNdDg/M2/t8hZrEuOn5QB+/sglRMzMpog2mfrwZ1ce+L2xL/NQAJI2byU
         Qfhw==
X-Gm-Message-State: AOAM532PcDsHHUwEpjlaoLDz8kmBye6/+NXDWpfB9gaAAwDhjMdBAlp7
        nmfbkEm/a3mFyKHFdIJEMq/fTIl98M0xUlZrmC9XmMEFtqUvf0FW9aXYmH37b7JfcRQumXecrVC
        kXaolcW4LJiE/2RflrLiPNe4A1JCinmK4z1fY
X-Received: by 2002:a05:6402:34c2:b0:42b:66d3:7b07 with SMTP id w2-20020a05640234c200b0042b66d37b07mr16289205edc.275.1653482417422;
        Wed, 25 May 2022 05:40:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6Zbt6jA3u1X6KTZoLtdjzWjbqAcTxHk4GUPkqPs5gc24VOD834mWi0LGsNzIzB5A6SMXDww==
X-Received: by 2002:a05:6402:34c2:b0:42b:66d3:7b07 with SMTP id w2-20020a05640234c200b0042b66d37b07mr16289182edc.275.1653482417204;
        Wed, 25 May 2022 05:40:17 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id y20-20020a50eb94000000b0042617ba63c4sm10632614edr.78.2022.05.25.05.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 05:40:16 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 3/4] sh/boards: Kconfig: Fix indentation
Date:   Wed, 25 May 2022 14:40:06 +0200
Message-Id: <20220525124007.45328-4-juerg.haefliger@canonical.com>
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

While at it, remove stray tabs/spaces from a seemingly empty line.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
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

