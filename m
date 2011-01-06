From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 06 Jan 2011 10:38:47 +0000
Subject: [PATCH] ARM: mach-shmobile: sh7367 Enable SDIO IRQs
Message-Id: <20110106103847.7691.38739.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch enables interrupt generation for SDIO IRQs
of the SDHI block on the sh7367 aka G3 processor. Use
together with a recent SDHI driver using TMIO_MMC_SDIO_IRQ
and with the MMC_CAP_SDIO_IRQ flag in the board code.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/intc-sh7367.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- 0001/arch/arm/mach-shmobile/intc-sh7367.c
+++ work/arch/arm/mach-shmobile/intc-sh7367.c	2011-01-06 19:23:28.000000000 +0900
@@ -189,10 +189,10 @@ static struct intc_mask_reg intca_mask_r
 	  { SCIFB, SCIFA5, SCIFA4, MSIOF1,
 	    0, 0, MSIOF2, 0 } },
 	{ 0xe694009c, 0xe69400dc, 8, /* IMR7A / IMCR7A */
-	  { DISABLED, DISABLED, ENABLED, ENABLED,
+	  { DISABLED, ENABLED, ENABLED, ENABLED,
 	    FLCTL_FLTREQ1I, FLCTL_FLTREQ0I, FLCTL_FLTENDI, FLCTL_FLSTEI } },
 	{ 0xe69400a0, 0xe69400e0, 8, /* IMR8A / IMCR8A */
-	  { DISABLED, DISABLED, ENABLED, ENABLED,
+	  { DISABLED, ENABLED, ENABLED, ENABLED,
 	    TTI20, USBDMAC_USHDMI, SPU, SIU } },
 	{ 0xe69400a4, 0xe69400e4, 8, /* IMR9A / IMCR9A */
 	  { CMT1_CMT13, CMT1_CMT12, CMT1_CMT11, CMT1_CMT10,
@@ -207,7 +207,7 @@ static struct intc_mask_reg intca_mask_r
 	  { 0, 0, TPU0, TPU1,
 	    TPU2, TPU3, TPU4, 0 } },
 	{ 0xe69400b4, 0xe69400f4, 8, /* IMR13A / IMCR13A */
-	  { DISABLED, DISABLED, ENABLED, ENABLED,
+	  { DISABLED, ENABLED, ENABLED, ENABLED,
 	    MISTY, CMT3, RWDT1, RWDT0 } },
 };
 
