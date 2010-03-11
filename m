From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 11 Mar 2010 05:33:52 +0000
Subject: [PATCH] ARM: mach-shmobile: bump up NR_IRQS to 640
Message-Id: <20100311053352.26717.21158.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Increase NR_IRQS to 640 on SH-Mobile ARM. With this
applied the INTCS controller on sh7372 can be supported.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Depends on "[PATCH] ARM: Add support for 10 hardirq bits"

 arch/arm/mach-shmobile/include/mach/irqs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0016/arch/arm/mach-shmobile/include/mach/irqs.h
+++ work/arch/arm/mach-shmobile/include/mach/irqs.h	2010-03-09 21:15:41.000000000 +0900
@@ -1,7 +1,7 @@
 #ifndef __ASM_MACH_IRQS_H
 #define __ASM_MACH_IRQS_H
 
-#define NR_IRQS         512
+#define NR_IRQS         640
 #define NR_IRQS_LEGACY  8
 
 /* INTCA */
