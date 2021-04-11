Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94DDC433B4
	for <linux-sh@archiver.kernel.org>; Sun, 11 Apr 2021 14:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CC2F6101B
	for <linux-sh@archiver.kernel.org>; Sun, 11 Apr 2021 14:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbhDKOGA (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 11 Apr 2021 10:06:00 -0400
Received: from condef-07.nifty.com ([202.248.20.72]:41896 "EHLO
        condef-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbhDKOGA (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sun, 11 Apr 2021 10:06:00 -0400
X-Greylist: delayed 338 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Apr 2021 10:05:59 EDT
Received: from conuserg-07.nifty.com ([10.126.8.70])by condef-07.nifty.com with ESMTP id 13BDv60G003330
        for <linux-sh@vger.kernel.org>; Sun, 11 Apr 2021 22:57:06 +0900
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 13BDtZpj024906;
        Sun, 11 Apr 2021 22:55:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 13BDtZpj024906
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1618149336;
        bh=vS8e0SLZkCBy0RmRBkXW9rD3CCXXaiE+fv8+9wtNFcQ=;
        h=From:To:Cc:Subject:Date:From;
        b=T4auvfUkLCtH1xfy+3/BrGcOzcfBKdffBrAXk4ktteZcBCINybIlbpHd9u+FXgcif
         RO7XzBcc9p98FwTRNy8JybHK2F1kD5uOTKziM8txSjy2xhfOkbGIf/yytdOE+0jpI8
         KviylrePITI/U3uMXnTZgwZjolQgFonocj7FYZytyy/PjeAFIk4d+ZnlqNcz82TC5w
         YlRMzOSoLaSCC1uOkHx7R065zcm6947UcUG2em5S3RDI+7PnZJcADDKJj5uN27osZQ
         9HFOIw4qnFiaxSzmdf0tITxyKAxAA/2oJKzo5VUOhdMB6iiBQ1EhXsj3PC5YdEkMlh
         RRIP4+C1tEq2Q==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Rich Felker <dalias@libc.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        uclinux-h8-devel@lists.sourceforge.jp
Subject: [PATCH] kbuild: use ?= to assign CROSS_COMPILE by arch-Makefile
Date:   Sun, 11 Apr 2021 22:55:32 +0900
Message-Id: <20210411135532.219797-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Use ?= operator to let arch/*/Makefile to assign CROSS_COMPILE only
when CROSS_COMPILE is undefined.

This allows arch-Makefiles to drop the ifeq ($(CROSS_COMPILE),)
conditional.

This slightly changes the behavior; the arch-Makefile previously
overrode CROSS_COMPILE when CROSS_COMPILE has already been made empty
via an environment variable as in 'export CROSS_COMPILE='.

With this commit, arch-Makefle will respect the user's environment
set-up, which seems to be a more correct behavior.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arc/Makefile    | 4 +---
 arch/h8300/Makefile  | 4 +---
 arch/m68k/Makefile   | 4 +---
 arch/mips/Makefile   | 4 +---
 arch/parisc/Makefile | 6 ++----
 arch/sh/Makefile     | 4 +---
 6 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index 4392c9c189c4..bd5a9daa3461 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -5,9 +5,7 @@
 
 KBUILD_DEFCONFIG := haps_hs_smp_defconfig
 
-ifeq ($(CROSS_COMPILE),)
-CROSS_COMPILE := $(call cc-cross-prefix, arc-linux- arceb-linux-)
-endif
+CROSS_COMPILE ?= $(call cc-cross-prefix, arc-linux- arceb-linux-)
 
 cflags-y	+= -fno-common -pipe -fno-builtin -mmedium-calls -D__linux__
 
diff --git a/arch/h8300/Makefile b/arch/h8300/Makefile
index ba0f26cfad61..d6e466dbfc00 100644
--- a/arch/h8300/Makefile
+++ b/arch/h8300/Makefile
@@ -26,9 +26,7 @@ KBUILD_LDFLAGS += $(ldflags-y)
 
 CHECKFLAGS += -msize-long
 
-ifeq ($(CROSS_COMPILE),)
-CROSS_COMPILE := $(call cc-cross-prefix, h8300-unknown-linux- h8300-linux-)
-endif
+CROSS_COMPILE ?= $(call cc-cross-prefix, h8300-unknown-linux- h8300-linux-)
 
 core-y	+= arch/$(ARCH)/kernel/ arch/$(ARCH)/mm/
 core-y	+= arch/$(ARCH)/boot/dts/
diff --git a/arch/m68k/Makefile b/arch/m68k/Makefile
index ea14f2046fb4..79208ad7a355 100644
--- a/arch/m68k/Makefile
+++ b/arch/m68k/Makefile
@@ -17,10 +17,8 @@
 KBUILD_DEFCONFIG := multi_defconfig
 
 ifneq ($(SUBARCH),$(ARCH))
-	ifeq ($(CROSS_COMPILE),)
-		CROSS_COMPILE := $(call cc-cross-prefix, \
+	CROSS_COMPILE ?= $(call cc-cross-prefix, \
 			m68k-linux-gnu- m68k-linux- m68k-unknown-linux-gnu-)
-	endif
 endif
 
 #
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index e71d587af49c..75e4e46532a4 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -51,9 +51,7 @@ UTS_MACHINE		:= mips64
 endif
 
 ifneq ($(SUBARCH),$(ARCH))
-  ifeq ($(CROSS_COMPILE),)
-    CROSS_COMPILE := $(call cc-cross-prefix, $(tool-archpref)-linux-  $(tool-archpref)-linux-gnu-  $(tool-archpref)-unknown-linux-gnu-)
-  endif
+  CROSS_COMPILE ?= $(call cc-cross-prefix, $(tool-archpref)-linux-  $(tool-archpref)-linux-gnu-  $(tool-archpref)-unknown-linux-gnu-)
 endif
 
 ifdef CONFIG_FUNCTION_GRAPH_TRACER
diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
index 7d9f71aa829a..62272cb3513c 100644
--- a/arch/parisc/Makefile
+++ b/arch/parisc/Makefile
@@ -42,12 +42,10 @@ endif
 export LD_BFD
 
 ifneq ($(SUBARCH),$(UTS_MACHINE))
-	ifeq ($(CROSS_COMPILE),)
-		CC_SUFFIXES = linux linux-gnu unknown-linux-gnu
-		CROSS_COMPILE := $(call cc-cross-prefix, \
+	CC_SUFFIXES = linux linux-gnu unknown-linux-gnu
+	CROSS_COMPILE ?= $(call cc-cross-prefix, \
 			$(foreach a,$(CC_ARCHES), \
 			$(foreach s,$(CC_SUFFIXES),$(a)-$(s)-)))
-	endif
 endif
 
 ifdef CONFIG_DYNAMIC_FTRACE
diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index 3bcbf52fb30e..0e8277be362e 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -10,9 +10,7 @@
 # for more details.
 #
 ifneq ($(SUBARCH),$(ARCH))
-  ifeq ($(CROSS_COMPILE),)
-    CROSS_COMPILE := $(call cc-cross-prefix, sh-linux- sh-linux-gnu- sh-unknown-linux-gnu-)
-  endif
+  CROSS_COMPILE ?= $(call cc-cross-prefix, sh-linux- sh-linux-gnu- sh-unknown-linux-gnu-)
 endif
 
 KBUILD_DEFCONFIG	:= shx3_defconfig
-- 
2.27.0

