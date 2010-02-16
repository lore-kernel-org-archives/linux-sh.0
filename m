From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 16 Feb 2010 05:19:19 +0000
Subject: [PATCH] sh: fix sh7723 SDHI support using INTC force_disable
Message-Id: <20100216051919.6975.99782.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the sh7723 INTC tables with force_enable support
to mask out pending unsupported SDHI interrupt sources.

Without this patch the kernel locks up due to a pending
SDHI interrupt that the tmio_mmc driver cannot handle.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7723.c	2010-02-16 14:10:22.000000000 +0900
@@ -602,6 +602,7 @@ void l2_cache_init(void)
 enum {
 	UNUSED=0,
 	ENABLED,
+	DISABLED,
 
 	/* interrupt sources */
 	IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7,
@@ -745,7 +746,7 @@ static struct intc_group groups[] __init
 static struct intc_mask_reg mask_registers[] __initdata = {
 	{ 0xa4080080, 0xa40800c0, 8, /* IMR0 / IMCR0 */
 	  { 0, TMU1_TUNI2, TMU1_TUNI1, TMU1_TUNI0,
-	    0, 0, ENABLED, ENABLED } },
+	    0, DISABLED, ENABLED, ENABLED } },
 	{ 0xa4080084, 0xa40800c4, 8, /* IMR1 / IMCR1 */
 	  { VIO_VOUI, VIO_VEU2HI,VIO_BEUI,VIO_CEUI,DMAC0A_DEI3,DMAC0A_DEI2,DMAC0A_DEI1,DMAC0A_DEI0 } },
 	{ 0xa4080088, 0xa40800c8, 8, /* IMR2 / IMCR2 */
@@ -762,7 +763,7 @@ static struct intc_mask_reg mask_registe
 	  { I2C_DTEI, I2C_WAITI, I2C_TACKI, I2C_ALI,
 	    FLCTL_FLTREQ1I, FLCTL_FLTREQ0I, FLCTL_FLTENDI, FLCTL_FLSTEI } },
 	{ 0xa40800a0, 0xa40800e0, 8, /* IMR8 / IMCR8 */
-	  { 0, 0, ENABLED, ENABLED,
+	  { 0, DISABLED, ENABLED, ENABLED,
 	    0, 0, SCIFA_SCIFA2, SIU_SIUI } },
 	{ 0xa40800a4, 0xa40800e4, 8, /* IMR9 / IMCR9 */
 	  { 0, 0, 0, CMT_CMTI, 0, 0, USB_USI0,0 } },
@@ -806,6 +807,7 @@ static struct intc_mask_reg ack_register
 static struct intc_desc intc_desc __initdata = {
 	.name = "sh7723",
 	.force_enable = ENABLED,
+	.force_disable = DISABLED,
 	.hw = INTC_HW_DESC(vectors, groups, mask_registers,
 			   prio_registers, sense_registers, ack_registers),
 };
