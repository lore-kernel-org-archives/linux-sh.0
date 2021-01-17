Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F7DC433DB
	for <linux-sh@archiver.kernel.org>; Sun, 17 Jan 2021 11:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBFF42074F
	for <linux-sh@archiver.kernel.org>; Sun, 17 Jan 2021 11:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbhAQLZD (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 17 Jan 2021 06:25:03 -0500
Received: from condef-02.nifty.com ([202.248.20.67]:47108 "EHLO
        condef-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbhAQLZD (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sun, 17 Jan 2021 06:25:03 -0500
Received: from conuserg-10.nifty.com ([10.126.8.73])by condef-02.nifty.com with ESMTP id 10HBJqwA003500
        for <linux-sh@vger.kernel.org>; Sun, 17 Jan 2021 20:19:52 +0900
Received: from oscar.flets-west.jp (softbank126026094251.bbtec.net [126.26.94.251]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 10HBGXEM004053;
        Sun, 17 Jan 2021 20:16:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 10HBGXEM004053
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1610882195;
        bh=VpBb3xCZqouxrm6ZwD7UxWOfSq9f4ezkEiHwVSXkGjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vKRhzM0+vIykwl6JU7VjFj+2fHqqglDgqBCeYUdFNvQ42nYIb7T4AjrqplFxk7m8r
         HfGQ5uZRmAahzZ+QM/gCIjz7U4tB07nL6dMBeRnGH+wb5hnAJv4A8ViFeKZLrNMdqj
         5o6TYIgEeXlEkbGwnkM4mSx5KWMcSbmV9r3EmIdYgtyolHVrXy1HX59lO9FVDOISXX
         gG8JziIS8RalzRROdV8MOMk4nDOHmJxNju5S8wyCSHvmc2Y3rYVag3hFycfXblR3Ad
         8lB8fKidN3GaYbHinOfaGJUK6NWzwb3EykJiqZBucXkDezlSAiyTzezH1TKaDhq3jv
         3bsIx2I9XqPNw==
X-Nifty-SrcIP: [126.26.94.251]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] sh: boot: avoid unneeded rebuilds under arch/sh/boot/compressed/
Date:   Sun, 17 Jan 2021 20:16:32 +0900
Message-Id: <20210117111632.2392635-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210117111632.2392635-1-masahiroy@kernel.org>
References: <20210117111632.2392635-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Even if none of source code is updated, the following are every time
rebuilt:

  CC      arch/sh/boot/compressed/cache.o
  SHIPPED arch/sh/boot/compressed/ashiftrt.S
  AS      arch/sh/boot/compressed/ashiftrt.o
  SHIPPED arch/sh/boot/compressed/ashldi3.c
  CC      arch/sh/boot/compressed/ashldi3.o
  SHIPPED arch/sh/boot/compressed/ashrsi3.S
  AS      arch/sh/boot/compressed/ashrsi3.o
  SHIPPED arch/sh/boot/compressed/ashlsi3.S
  AS      arch/sh/boot/compressed/ashlsi3.o
  SHIPPED arch/sh/boot/compressed/lshrsi3.S
  AS      arch/sh/boot/compressed/lshrsi3.o
  LD      arch/sh/boot/compressed/vmlinux
  OBJCOPY arch/sh/boot/zImage

Add build artifacts to 'targets' as needed.

I turned the library files to check-in files. It is simpler than
copying from arch/sh/lib/ at build-time.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/sh/boot/compressed/.gitignore |  5 -----
 arch/sh/boot/compressed/Makefile   | 32 ++++++++++++------------------
 arch/sh/boot/compressed/ashiftrt.S |  2 ++
 arch/sh/boot/compressed/ashldi3.c  |  2 ++
 arch/sh/boot/compressed/ashlsi3.S  |  2 ++
 arch/sh/boot/compressed/ashrsi3.S  |  2 ++
 arch/sh/boot/compressed/lshrsi3.S  |  2 ++
 7 files changed, 23 insertions(+), 24 deletions(-)
 create mode 100644 arch/sh/boot/compressed/ashiftrt.S
 create mode 100644 arch/sh/boot/compressed/ashldi3.c
 create mode 100644 arch/sh/boot/compressed/ashlsi3.S
 create mode 100644 arch/sh/boot/compressed/ashrsi3.S
 create mode 100644 arch/sh/boot/compressed/lshrsi3.S

diff --git a/arch/sh/boot/compressed/.gitignore b/arch/sh/boot/compressed/.gitignore
index 37aa53057369..cd16663bc7c8 100644
--- a/arch/sh/boot/compressed/.gitignore
+++ b/arch/sh/boot/compressed/.gitignore
@@ -1,7 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ashiftrt.S
-ashldi3.c
-ashlsi3.S
-ashrsi3.S
-lshrsi3.S
 vmlinux.bin.*
diff --git a/arch/sh/boot/compressed/Makefile b/arch/sh/boot/compressed/Makefile
index 589d2d8a573d..cf3174df7859 100644
--- a/arch/sh/boot/compressed/Makefile
+++ b/arch/sh/boot/compressed/Makefile
@@ -5,12 +5,18 @@
 # create a compressed vmlinux image from the original vmlinux
 #
 
-targets		:= vmlinux vmlinux.bin vmlinux.bin.gz \
-		   vmlinux.bin.bz2 vmlinux.bin.lzma \
-		   vmlinux.bin.xz vmlinux.bin.lzo \
-		   head_32.o misc.o piggy.o
+OBJECTS := head_32.o misc.o cache.o piggy.o \
+           ashiftrt.o ashldi3.o ashrsi3.o ashlsi3.o lshrsi3.o
+
+# These were previously generated files. When you are building the kernel
+# with O=, make sure to remove the stale files in the output tree. Otherwise,
+# the build system wrongly compiles the stale ones.
+ifdef building_out_of_srctree
+$(shell rm -f $(addprefix $(obj)/, ashiftrt.S ashldi3.c ashrsi3.S ashlsi3.S lshrsi3.S))
+endif
 
-OBJECTS = $(obj)/head_32.o $(obj)/misc.o $(obj)/cache.o
+targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 \
+           vmlinux.bin.lzma vmlinux.bin.xz vmlinux.bin.lzo $(OBJECTS)
 
 GCOV_PROFILE := n
 
@@ -33,21 +39,9 @@ ccflags-remove-$(CONFIG_MCOUNT) += -pg
 LDFLAGS_vmlinux := --oformat $(ld-bfd) -Ttext $(IMAGE_OFFSET) -e startup \
 		   -T $(obj)/../../kernel/vmlinux.lds
 
-#
-# Pull in the necessary libgcc bits from the in-kernel implementation.
-#
-lib1funcs-y	:= ashiftrt.S ashldi3.c ashrsi3.S ashlsi3.S lshrsi3.S
-lib1funcs-obj   := \
-	$(addsuffix .o, $(basename $(addprefix $(obj)/, $(lib1funcs-y))))
-
-lib1funcs-dir		:= $(srctree)/arch/$(SRCARCH)/lib
-
-KBUILD_CFLAGS += -I$(lib1funcs-dir) -DDISABLE_BRANCH_PROFILING
-
-$(addprefix $(obj)/,$(lib1funcs-y)): $(obj)/%: $(lib1funcs-dir)/% FORCE
-	$(call cmd,shipped)
+KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
 
-$(obj)/vmlinux: $(OBJECTS) $(obj)/piggy.o $(lib1funcs-obj) FORCE
+$(obj)/vmlinux: $(addprefix $(obj)/, $(OBJECTS)) FORCE
 	$(call if_changed,ld)
 
 $(obj)/vmlinux.bin: vmlinux FORCE
diff --git a/arch/sh/boot/compressed/ashiftrt.S b/arch/sh/boot/compressed/ashiftrt.S
new file mode 100644
index 000000000000..0f3b291a3f4b
--- /dev/null
+++ b/arch/sh/boot/compressed/ashiftrt.S
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#include "../../lib/ashiftrt.S"
diff --git a/arch/sh/boot/compressed/ashldi3.c b/arch/sh/boot/compressed/ashldi3.c
new file mode 100644
index 000000000000..7cebd646df83
--- /dev/null
+++ b/arch/sh/boot/compressed/ashldi3.c
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include "../../lib/ashldi3.c"
diff --git a/arch/sh/boot/compressed/ashlsi3.S b/arch/sh/boot/compressed/ashlsi3.S
new file mode 100644
index 000000000000..e354262b275f
--- /dev/null
+++ b/arch/sh/boot/compressed/ashlsi3.S
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#include "../../lib/ashlsi3.S"
diff --git a/arch/sh/boot/compressed/ashrsi3.S b/arch/sh/boot/compressed/ashrsi3.S
new file mode 100644
index 000000000000..e564be9a4dcd
--- /dev/null
+++ b/arch/sh/boot/compressed/ashrsi3.S
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#include "../../lib/ashrsi3.S"
diff --git a/arch/sh/boot/compressed/lshrsi3.S b/arch/sh/boot/compressed/lshrsi3.S
new file mode 100644
index 000000000000..5a8281b7e516
--- /dev/null
+++ b/arch/sh/boot/compressed/lshrsi3.S
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#include "../../lib/lshrsi3.S"
-- 
2.27.0

