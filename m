From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Fri, 13 Apr 2012 03:14:01 +0000
Subject: [PATCH 2/4] sh: sh4: Change the specification method of IRQ to SCIx_IRQ_MUXED
Message-Id: <1334286843-3297-2-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Some SCIF devices specify the same IRQ. We can use SCIx_IRQ_MUXED for this.
And change use to evt2irq(), without specifying the value of IRQ directly.
This is correction to the SH4 series.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/sh/kernel/cpu/sh4/setup-sh7750.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4/setup-sh7750.c b/arch/sh/kernel/cpu/sh4/setup-sh7750.c
index 98cc0c7..56b3bdc 100644
--- a/arch/sh/kernel/cpu/sh4/setup-sh7750.c
+++ b/arch/sh/kernel/cpu/sh4/setup-sh7750.c
@@ -43,7 +43,7 @@ static struct plat_sci_port sci_platform_data = {
 	.scscr		= SCSCR_TE | SCSCR_RE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCI,
-	.irqs		= { 23, 23, 23, 0 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0xE40)),
 	.regshift	= 2,
 };
 
@@ -61,7 +61,7 @@ static struct plat_sci_port scif_platform_data = {
 	.scscr		= SCSCR_TE | SCSCR_RE | SCSCR_REIE,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type		= PORT_SCIF,
-	.irqs		= { 40, 40, 40, 40 },
+	.irqs		= SCIx_IRQ_MUXED(evt2irq(0x700)),
 };
 
 static struct platform_device scif_device = {
-- 
1.7.9.1

