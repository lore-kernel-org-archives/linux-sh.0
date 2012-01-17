From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 17 Jan 2012 11:05:40 +0000
Subject: [PATCH] ARM: mach-shmobile: sh73a0 PINT IRQ base fix
Message-Id: <20120117110540.5414.77262.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Bump up the sh73a0 PINT IRQ base from 768 to 800 to avoid
collision with INTCS vectors for IRQ16->IRQ32 at 0x3xxx.

Without this fix the sh73a0 IRQ pin handling code collides
with the PINT code which results in hangs on Kota2 during boot.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/sh73a0.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- 0001/arch/arm/mach-shmobile/include/mach/sh73a0.h
+++ work/arch/arm/mach-shmobile/include/mach/sh73a0.h	2012-01-17 19:34:48.000000000 +0900
@@ -515,8 +515,8 @@ enum {
 	SHDMA_SLAVE_MMCIF_RX,
 };
 
-/* PINT interrupts are located at Linux IRQ 768 and up */
-#define SH73A0_PINT0_IRQ(irq) ((irq) + 768)
-#define SH73A0_PINT1_IRQ(irq) ((irq) + 800)
+/* PINT interrupts are located at Linux IRQ 800 and up */
+#define SH73A0_PINT0_IRQ(irq) ((irq) + 800)
+#define SH73A0_PINT1_IRQ(irq) ((irq) + 832)
 
 #endif /* __ASM_SH73A0_H__ */
