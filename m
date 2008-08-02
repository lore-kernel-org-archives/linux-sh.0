From: Adrian Bunk <bunk@kernel.org>
Date: Sat, 02 Aug 2008 16:53:44 +0000
Subject: [2.6 patch] sh/boards/Makefile typo fix
Message-Id: <20080802165344.GP19682@cs181140183.pp.htv.fi>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

The following build error was caused by an obvious typo:

<--  snip  -->

...
  LD      arch/sh/mm/built-in.o
make[2]: *** No rule to make target `arch/sh/boards/board-shmin..o', needed by `arch/sh/boards/built-in.o'.  Stop.

<--  snip  -->

Reported-by: Adrian Bunk <bunk@kernel.org>
Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
399bc393a7499892af33d7a4621516c5f5c359d8 
diff --git a/arch/sh/boards/Makefile b/arch/sh/boards/Makefile
index ff9b93c..463022c 100644
--- a/arch/sh/boards/Makefile
+++ b/arch/sh/boards/Makefile
@@ -5,4 +5,4 @@ obj-$(CONFIG_SH_AP325RXA)	+= board-ap325rxa.o
 obj-$(CONFIG_SH_MAGIC_PANEL_R2)	+= board-magicpanelr2.o
 obj-$(CONFIG_SH_RSK7203)	+= board-rsk7203.o
 obj-$(CONFIG_SH_SH7785LCR)	+= board-sh7785lcr.o
-obj-$(CONFIG_SH_SHMIN)		+= board-shmin..o
+obj-$(CONFIG_SH_SHMIN)		+= board-shmin.o

