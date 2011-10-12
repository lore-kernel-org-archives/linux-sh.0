From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 12 Oct 2011 07:21:08 +0000
Subject: [PATCH 02/07] sh: intc: Allow triggering on both edges for ARM SoCs
Message-Id: <20111012072108.25511.14676.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Enable IRQ_TYPE_EDGE_BOTH on all R/SH-Mobile ARM SoCs.
This hardware feature is supported by sh7367, sh7377,
sh7372 and sh73a0.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/sh/intc/chip.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/drivers/sh/intc/chip.c
+++ work/drivers/sh/intc/chip.c	2011-10-12 15:02:51.000000000 +0900
@@ -186,7 +186,7 @@ static unsigned char intc_irq_sense_tabl
     !defined(CONFIG_CPU_SUBTYPE_SH7709)
 	[IRQ_TYPE_LEVEL_HIGH] = VALID(3),
 #endif
-#if defined(CONFIG_ARCH_SH7372)
+#if defined(CONFIG_ARM) /* all recent SH-Mobile / R-Mobile ARM support this */
 	[IRQ_TYPE_EDGE_BOTH] = VALID(4),
 #endif
 };
