Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9959C433F5
	for <linux-sh@archiver.kernel.org>; Fri, 27 May 2022 12:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348156AbiE0M1r (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 27 May 2022 08:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349085AbiE0MXN (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 27 May 2022 08:23:13 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EBB170651
        for <linux-sh@vger.kernel.org>; Fri, 27 May 2022 05:03:03 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AB84F3F5EE
        for <linux-sh@vger.kernel.org>; Fri, 27 May 2022 12:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653652981;
        bh=BkCOp4tVpeV9PMtuyS95bXY8E1w+xk5Ztl83CleBuR0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Hm9Epu+umu/XsJgij0G2XD7RSd6uzZP5w2U+Df5g1jCjGQ/ax/9o/arjVe+jX1/m9
         tspQ6wMc5Q79XZlLBqSXDAf6LI2QBEpxMJft6+DLd4kFf6tOhhBMyK6AbhCncU9MvL
         DaYaXnqAbI/mC4O0WjRltoj2nYAlkybIb3sXSdc5K+dZr+obEpkzWkapSedkoAMxB8
         PfNannZvyLdCeTJI0qoQnZku9fXS75/q2N9kWEUVaCQuEDpxiGY1o20tOFWIoMWGDN
         TIZJadhWpXmwxkxzKc6k22huOxxvLTAXzlRkB2GPZveI3z/N8AK+5ntoO8Vrg5BEW4
         hcplPNRlE24nA==
Received: by mail-ed1-f69.google.com with SMTP id v1-20020a056402348100b0042b4442b954so2903659edc.22
        for <linux-sh@vger.kernel.org>; Fri, 27 May 2022 05:03:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BkCOp4tVpeV9PMtuyS95bXY8E1w+xk5Ztl83CleBuR0=;
        b=Mh0Ru48EQCmI2J1b8AD7PMIDroYNH9FAEIl9lVtTGRuy70n+qeZXM2HgVtedEj0xuA
         IJwXLPZ9v8O79N4fGua6d0ytu3yB+nR83q/mmvb/qrPtt/XpOnULU276U7A19Tjb2Vkc
         GfVZxQEa171xXSPpb6BrLZNJsYBcGDIkRNt8u57PwGy6BmA0JSzQxZtNKSnNpR60JMmz
         5hxSemHlgy68tBDVFJg8B+wd/Q6AiYAj4mPj7qhkjAh4or/94g9ZI0DzPbwR4FWM3Uys
         4Puam010YzOw7EsiGHgXMFbUL6GC/8Y6CJm8u43LurDgq4vRyVlsO2qvQaLS9sY5iL8m
         GPig==
X-Gm-Message-State: AOAM531gHwJOEAPM1fV9Qg9m3Tle5LsmtFL+1nJhjWXTPSDoTcX9lKgv
        Mji6pxqQnanXJ++96XR+thSDyaHMlOB5iQUgPlkmLG0w3CrD9DM6376EY+uM3LUUertH6q9/JSD
        CKwnSFnwfmSnt5P3+14ZNK6He6MaBja25zbfb
X-Received: by 2002:aa7:cacd:0:b0:42b:b1b6:e054 with SMTP id l13-20020aa7cacd000000b0042bb1b6e054mr15390302edt.281.1653652981336;
        Fri, 27 May 2022 05:03:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRnXq7jWUrcCmZLYsRNc7Xxu7Z3WvvC7roh4JAteb5lincMrIi20bIz83Lx5oUjeZ1Ox2TCg==
X-Received: by 2002:aa7:cacd:0:b0:42b:b1b6:e054 with SMTP id l13-20020aa7cacd000000b0042bb1b6e054mr15390273edt.281.1653652981060;
        Fri, 27 May 2022 05:03:01 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id q9-20020a50cc89000000b0042ac2705444sm2016808edi.58.2022.05.27.05.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 05:03:00 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org, sergei.shtylyov@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 1/4 v2] sh: Kconfig: Fix indentation and remove trailing whitespaces
Date:   Fri, 27 May 2022 14:02:54 +0200
Message-Id: <20220527120254.458949-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <0f0c5ce5-3845-c4b4-180e-380dec53b525@gmail.com>
References: <0f0c5ce5-3845-c4b4-180e-380dec53b525@gmail.com>
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

