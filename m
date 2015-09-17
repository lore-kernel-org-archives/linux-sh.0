From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 17 Sep 2015 07:12:57 +0000
Subject: [PATCH 03/03] irqchip: renesas-irqc: Enable nested lock
Message-Id: <20150917071257.29299.28172.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150917071230.29299.32326.sendpatchset@little-apple>
In-Reply-To: <20150917071230.29299.32326.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: jason@lakedaemon.net, geert+renesas@glider.be, linux-kernel@vger.kernel.org, horms@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

From: Magnus Damm <damm+renesas@opensource.se>

Update the IRQC driver to pass the IRQ_GC_INIT_NESTED_LOCK flag
to enable nested locking using the generic irq chip implementation.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/irqchip/irq-renesas-irqc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0005/drivers/irqchip/irq-renesas-irqc.c
+++ work/drivers/irqchip/irq-renesas-irqc.c	2015-07-20 18:08:35.792366518 +0900
@@ -212,7 +212,7 @@ static int irqc_probe(struct platform_de
 
 	ret = irq_alloc_domain_generic_chips(p->irq_domain, p->number_of_irqs,
 					     1, name, handle_level_irq,
-					     0, 0, 0);
+					     0, 0, IRQ_GC_INIT_NESTED_LOCK);
 	if (ret) {
 		dev_err(&pdev->dev, "cannot allocate generic chip\n");
 		goto err3;
