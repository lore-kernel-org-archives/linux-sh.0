From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Tue, 15 May 2012 01:26:11 +0000
Subject: [PATCH] sh: Fix mistake of the member variable of plat_sci_port for SH7343
Message-Id: <1337045171-20698-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The current code was going to initialize irq of plat_sci_port.
Not irq, irqs is right.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7343.c b/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
index 476f474..5773643 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
@@ -56,7 +56,7 @@ static struct plat_sci_port scif2_platform_data = {
 	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
 	.scbrr_algo_id	= SCBRR_ALGO_2,
 	.type           = PORT_SCIF,
-	.irq            = SCIx_IRQ_MUXED(evt2irq(0xC40)),
+	.irqs           = SCIx_IRQ_MUXED(evt2irq(0xC40)),
 };
 
 static struct platform_device scif2_device = {
-- 
1.7.10

