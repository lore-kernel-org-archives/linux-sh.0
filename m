From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 16 Feb 2010 05:17:52 +0000
Subject: [PATCH] sh: fix sh7722 SDHI support using INTC force_disable
Message-Id: <20100216051752.6966.30761.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the sh7722 INTC tables with force_enable support
to mask out pending unsupported SDHI interrupt sources.

Without this patch the kernel locks up due to a pending
SDHI interrupt that the tmio_mmc driver cannot handle.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7722.c	2010-02-16 12:45:52.000000000 +0900
@@ -447,6 +447,7 @@ void __init plat_early_device_setup(void
 enum {
 	UNUSED=0,
 	ENABLED,
+	DISABLED,
 
 	/* interrupt sources */
 	IRQ0, IRQ1, IRQ2, IRQ3, IRQ4, IRQ5, IRQ6, IRQ7,
@@ -534,7 +535,7 @@ static struct intc_mask_reg mask_registe
 	  { I2C_DTEI, I2C_WAITI, I2C_TACKI, I2C_ALI,
 	    FLCTL_FLTREQ1I, FLCTL_FLTREQ0I, FLCTL_FLENDI, FLCTL_FLSTEI } },
 	{ 0xa40800a0, 0xa40800e0, 8, /* IMR8 / IMCR8 */
-	  { 0, 0, ENABLED, ENABLED, 0, 0, TWODG, SIU } },
+	  { DISABLED, DISABLED, ENABLED, ENABLED, 0, 0, TWODG, SIU } },
 	{ 0xa40800a4, 0xa40800e4, 8, /* IMR9 / IMCR9 */
 	  { 0, 0, 0, CMT, 0, USB_USBI1, USB_USBI0, } },
 	{ 0xa40800a8, 0xa40800e8, 8, /* IMR10 / IMCR10 */
@@ -575,6 +576,7 @@ static struct intc_mask_reg ack_register
 static struct intc_desc intc_desc __initdata = {
 	.name = "sh7722",
 	.force_enable = ENABLED,
+	.force_disable = DISABLED,
 	.hw = INTC_HW_DESC(vectors, groups, mask_registers,
 			   prio_registers, sense_registers, ack_registers),
 };
