From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 16 May 2012 06:50:26 +0000
Subject: [PATCH] ARM: mach-shmobile: sh73a0: fixup PINT/IRQ16-IRQ31 irq number conflict
Message-Id: <87pqa48vrn.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Current IRQ16-IRQ31 irq number are located around 800 from
1ee8299a9ec1ce5137a044c7768293007b9a3267
(ARM: mach-shmobile: Use 0x3400 as INTCS vector offset)

But, the PINT0/1 IRQ number are also located around 800 from
0df1a838d678fc6ab49f983a19e905f6a42297a0
(ARM: mach-shmobile: sh73a0 PINT IRQ base fix)

This patch relocates PINT0/1 IRQ number to around 700 where is not used,
and adds current IRQ location table in comment area.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
>> Magnus

I added IRQ location table on this patch.
Please check it, and please give this patch your acked-by if you can agree this location.

 arch/arm/mach-shmobile/include/mach/sh73a0.h |   34 +++++++++++++++++++++++--
 1 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/sh73a0.h b/arch/arm/mach-shmobile/include/mach/sh73a0.h
index ac75857..398e2c1 100644
--- a/arch/arm/mach-shmobile/include/mach/sh73a0.h
+++ b/arch/arm/mach-shmobile/include/mach/sh73a0.h
@@ -518,8 +518,36 @@ enum {
 	SHDMA_SLAVE_MMCIF_RX,
 };
 
-/* PINT interrupts are located at Linux IRQ 800 and up */
-#define SH73A0_PINT0_IRQ(irq) ((irq) + 800)
-#define SH73A0_PINT1_IRQ(irq) ((irq) + 832)
+/*
+ *		SH73A0 IRQ LOCATION TABLE
+ *
+ * 416	-----------------------------------------
+ *		IRQ0-IRQ15
+ * 431	-----------------------------------------
+ * ...
+ * 448	-----------------------------------------
+ *		sh73a0-intcs
+ *		sh73a0-intca-irq-pins
+ * 680	-----------------------------------------
+ * ...
+ * 700	-----------------------------------------
+ *		sh73a0-pint0
+ * 731	-----------------------------------------
+ * 732	-----------------------------------------
+ *		sh73a0-pint1
+ * 739	-----------------------------------------
+ * ...
+ * 800	-----------------------------------------
+ *		IRQ16-IRQ31
+ * 815	-----------------------------------------
+ * ...
+ * 928	-----------------------------------------
+ *		sh73a0-intca-irq-pins
+ * 943	-----------------------------------------
+ */
+
+/* PINT interrupts are located at Linux IRQ 700 and up */
+#define SH73A0_PINT0_IRQ(irq) ((irq) + 700)
+#define SH73A0_PINT1_IRQ(irq) ((irq) + 732)
 
 #endif /* __ASM_SH73A0_H__ */
-- 
1.7.5.4

