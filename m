From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 15 Feb 2010 11:53:43 +0000
Subject: [PATCH] sh: fix sh7724 SDHI support using INTC force_disable
Message-Id: <20100215115343.22072.41994.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the sh7724 INTC tables with force_enable support
to mask out pending unsupported SDHI interrupt sources.

Without this patch the kernel locks up due to a pending
SDHI interrupt that the tmio_mmc driver cannot handle.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7724.c	2010-02-15 20:06:48.000000000 +0900
@@ -724,6 +724,7 @@ void l2_cache_init(void)
 enum {
 	UNUSED = 0,
 	ENABLED,
+	DISABLED,
 
 	/* interrupt sources */
 	IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7,
@@ -890,7 +891,7 @@ static struct intc_group groups[] __init
 static struct intc_mask_reg mask_registers[] __initdata = {
 	{ 0xa4080080, 0xa40800c0, 8, /* IMR0 / IMCR0 */
 	  { 0, TMU1_TUNI2, TMU1_TUNI1, TMU1_TUNI0,
-	    0, 0, ENABLED, ENABLED } },
+	    0, DISABLED, ENABLED, ENABLED } },
 	{ 0xa4080084, 0xa40800c4, 8, /* IMR1 / IMCR1 */
 	  { VIO_VOU, VIO_VEU1, VIO_BEU0, VIO_CEU0,
 	    DMAC0A_DEI3, DMAC0A_DEI2, DMAC0A_DEI1, DMAC0A_DEI0 } },
@@ -912,7 +913,7 @@ static struct intc_mask_reg mask_registe
 	  { I2C0_DTEI, I2C0_WAITI, I2C0_TACKI, I2C0_ALI,
 	    I2C1_DTEI, I2C1_WAITI, I2C1_TACKI, I2C1_ALI } },
 	{ 0xa40800a0, 0xa40800e0, 8, /* IMR8 / IMCR8 */
-	  { 0, 0, ENABLED, ENABLED,
+	  { DISABLED, DISABLED, ENABLED, ENABLED,
 	    0, 0, SCIFA5, FSI } },
 	{ 0xa40800a4, 0xa40800e4, 8, /* IMR9 / IMCR9 */
 	  { 0, 0, 0, CMT, 0, USB1, USB0, 0 } },
@@ -962,6 +963,7 @@ static struct intc_mask_reg ack_register
 static struct intc_desc intc_desc __initdata = {
 	.name = "sh7724",
 	.force_enable = ENABLED,
+	.force_disable = DISABLED,
 	.hw = INTC_HW_DESC(vectors, groups, mask_registers,
 			   prio_registers, sense_registers, ack_registers),
 };
