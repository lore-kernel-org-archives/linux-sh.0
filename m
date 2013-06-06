From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 06 Jun 2013 07:28:47 +0000
Subject: [PATCH 1/2] irqchip: renesas-irqc: Fix irqc_probe error handling
Message-Id: <1370503728-31373-2-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1370503728-31373-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1370503728-31373-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Axel Lin <axel.lin@ingics.com>

The code in goto err3 path is wrong because it will call fee_irq() with k = 0,
which means it does free_irq(p->irq[-1].requested_irq, &p->irq[-1]);

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/irqchip/irq-renesas-irqc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
index 927bff3..2f404ba 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -248,8 +248,8 @@ static int irqc_probe(struct platform_device *pdev)
 
 	return 0;
 err3:
-	for (; k >= 0; k--)
-		free_irq(p->irq[k - 1].requested_irq, &p->irq[k - 1]);
+	while (--k >= 0)
+		free_irq(p->irq[k].requested_irq, &p->irq[k]);
 
 	irq_domain_remove(p->irq_domain);
 err2:
-- 
1.8.2.1

