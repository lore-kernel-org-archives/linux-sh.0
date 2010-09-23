From: matt mooney <mfm@muteddisk.com>
Date: Thu, 23 Sep 2010 06:51:21 +0000
Subject: [PATCH 14/20] sh: change to new flag variable
Message-Id: <1285224681-29933-1-git-send-email-mfm@muteddisk.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: Magnus Damm <damm@opensource.se>, Matt Fleming <matt@console-pimps.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Replace EXTRA_CFLAGS with ccflags-y.

Signed-off-by: matt mooney <mfm@muteddisk.com>
---
 arch/sh/cchips/hd6446x/Makefile |    2 +-
 arch/sh/kernel/Makefile         |    2 +-
 arch/sh/lib/Makefile            |    2 +-
 arch/sh/mm/Makefile             |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sh/cchips/hd6446x/Makefile b/arch/sh/cchips/hd6446x/Makefile
index 9682e3a..59c3483 100644
--- a/arch/sh/cchips/hd6446x/Makefile
+++ b/arch/sh/cchips/hd6446x/Makefile
@@ -1,3 +1,3 @@
 obj-$(CONFIG_HD64461)	+= hd64461.o
 
-EXTRA_CFLAGS += -Werror
+ccflags-y := -Werror
diff --git a/arch/sh/kernel/Makefile b/arch/sh/kernel/Makefile
index e25f3c6..b308391 100644
--- a/arch/sh/kernel/Makefile
+++ b/arch/sh/kernel/Makefile
@@ -44,4 +44,4 @@ obj-$(CONFIG_HAS_IOPORT)	+= io_generic.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)		+= hw_breakpoint.o
 obj-$(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST)	+= localtimer.o
 
-EXTRA_CFLAGS += -Werror
+ccflags-y := -Werror
diff --git a/arch/sh/lib/Makefile b/arch/sh/lib/Makefile
index dab4d21..7b95f29 100644
--- a/arch/sh/lib/Makefile
+++ b/arch/sh/lib/Makefile
@@ -30,4 +30,4 @@ lib-$(CONFIG_MMU)		+= copy_page.o __clear_user.o
 lib-$(CONFIG_MCOUNT)		+= mcount.o
 lib-y				+= $(memcpy-y) $(memset-y) $(udivsi3-y)
 
-EXTRA_CFLAGS += -Werror
+ccflags-y := -Werror
diff --git a/arch/sh/mm/Makefile b/arch/sh/mm/Makefile
index 53f7c68..939663c 100644
--- a/arch/sh/mm/Makefile
+++ b/arch/sh/mm/Makefile
@@ -66,4 +66,4 @@ CFLAGS_fault_64.o += -ffixed-r7 \
 	-ffixed-r60 -ffixed-r61 -ffixed-r62 \
 	-fomit-frame-pointer
 
-EXTRA_CFLAGS += -Werror
+ccflags-y := -Werror
-- 
1.7.2.1

