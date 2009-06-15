From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Mon, 15 Jun 2009 03:19:02 +0000
Subject: [PATCH] sh: Remove mask variable
Message-Id: <4A35BDA6.1030600@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The mask variable was deleted from irqaction structure from 2.6.31.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
CC: Magnus Damm <magnus.damm@gmail.com>
---
 drivers/clocksource/sh_tmu.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index d6ea439..08e6ec2 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -385,7 +385,6 @@ static int sh_tmu_setup(struct sh_tmu_priv *p, struct platform_device *pdev)
 	p->irqaction.dev_id = p;
 	p->irqaction.irq = irq;
 	p->irqaction.flags = IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL;
-	p->irqaction.mask = CPU_MASK_NONE;

 	/* get hold of clock */
 	p->clk = clk_get(&p->pdev->dev, cfg->clk);
-- 
1.6.3.1

