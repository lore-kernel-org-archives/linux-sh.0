From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 20 Dec 2010 10:56:30 +0000
Subject: [PATCH] ARM: mach-shmobile: Bump up NR_IRQS to 1024
Message-Id: <20101220110019.6581.88408.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
References: <20100311053352.26717.21158.sendpatchset@t400s>
In-Reply-To: <20100311053352.26717.21158.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Increase NR_IRQS from 512 to 1024 on SH-Mobile ARM.

Needed to support vectors in the sh73a0 INTCS block.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/irqs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/include/mach/irqs.h
+++ work/arch/arm/mach-shmobile/include/mach/irqs.h	2010-12-20 19:55:57.000000000 +0900
@@ -1,7 +1,7 @@
 #ifndef __ASM_MACH_IRQS_H
 #define __ASM_MACH_IRQS_H
 
-#define NR_IRQS         512
+#define NR_IRQS         1024
 
 /* GIC */
 #define gic_spi(nr)		((nr) + 32)
