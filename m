From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 08 Jun 2010 06:25:17 +0000
Subject: [PATCH] net/irda/sh_irda: Modify clk_get lookups
Message-Id: <w3p7hmaujlf.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>, "David S. Miller" <davem@davemloft.net>
Cc: Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Net <netdev@vger.kernel.org>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
This patch is v2 of
ARM: mach-shmobile: clock-sh7367: modify IrDA clock

 arch/arm/mach-shmobile/board-g3evm.c |    1 +
 drivers/net/irda/sh_irda.c           |    6 ++----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-g3evm.c b/arch/arm/mach-shmobile/board-g3evm.c
index 95ccb94..a552590 100644
--- a/arch/arm/mach-shmobile/board-g3evm.c
+++ b/arch/arm/mach-shmobile/board-g3evm.c
@@ -232,6 +232,7 @@ static struct resource irda_resources[] = {
 
 static struct platform_device irda_device = {
 	.name		= "sh_irda",
+	.id		= -1,
 	.resource	= irda_resources,
 	.num_resources	= ARRAY_SIZE(irda_resources),
 };
diff --git a/drivers/net/irda/sh_irda.c b/drivers/net/irda/sh_irda.c
index 9a828b0..9db7084 100644
--- a/drivers/net/irda/sh_irda.c
+++ b/drivers/net/irda/sh_irda.c
@@ -748,7 +748,6 @@ static int __devinit sh_irda_probe(struct platform_device *pdev)
 	struct net_device *ndev;
 	struct sh_irda_self *self;
 	struct resource *res;
-	char clk_name[8];
 	unsigned int irq;
 	int err = -ENOMEM;
 
@@ -775,10 +774,9 @@ static int __devinit sh_irda_probe(struct platform_device *pdev)
 	if (err)
 		goto err_mem_2;
 
-	snprintf(clk_name, sizeof(clk_name), "irda%d", pdev->id);
-	self->clk = clk_get(&pdev->dev, clk_name);
+	self->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(self->clk)) {
-		dev_err(&pdev->dev, "cannot get clock \"%s\"\n", clk_name);
+		dev_err(&pdev->dev, "cannot get irda clock\n");
 		goto err_mem_3;
 	}
 
-- 
1.7.0.4

