From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 06 Mar 2013 05:02:13 +0000
Subject: [PATCH 1/2 v2] ARM: shmobile: r8a7778: use IOMEM() address for ARM
Message-Id: <87ehftktny.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM needs IOMEM()'ed address access

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - I forgot to send this patch in v1

 arch/arm/mach-shmobile/clock-r8a7778.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7778.c b/arch/arm/mach-shmobile/clock-r8a7778.c
index 4e779444b..bffa206 100644
--- a/arch/arm/mach-shmobile/clock-r8a7778.c
+++ b/arch/arm/mach-shmobile/clock-r8a7778.c
@@ -29,16 +29,16 @@
 #include <linux/clkdev.h>
 #include <mach/common.h>
 
-#define FRQMR   0xffc80014
-#define MSTPCR0 0xffc80030
-#define MSTPCR1 0xffc80034
-#define MSTPCR3 0xffc8003c
-#define MSTPSR1 0xffc80044
-#define MSTPSR4 0xffc80048
-#define MSTPSR6 0xffc8004c
-#define MSTPCR4 0xffc80050
-#define MSTPCR5 0xffc80054
-#define MSTPCR6 0xffc80058
+#define FRQMR		IOMEM(0xffc80014)
+#define MSTPCR0		IOMEM(0xffc80030)
+#define MSTPCR1		IOMEM(0xffc80034)
+#define MSTPCR3		IOMEM(0xffc8003c)
+#define MSTPSR1		IOMEM(0xffc80044)
+#define MSTPSR4		IOMEM(0xffc80048)
+#define MSTPSR6		IOMEM(0xffc8004c)
+#define MSTPCR4		IOMEM(0xffc80050)
+#define MSTPCR5		IOMEM(0xffc80054)
+#define MSTPCR6		IOMEM(0xffc80058)
 
 /* ioremap() through clock mapping mandatory to avoid
  * collision with ARM coherent DMA virtual memory range.
-- 
1.7.9.5

