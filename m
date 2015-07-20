From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 20 Jul 2015 10:06:14 +0000
Subject: [PATCH 01/03] irqchip: renesas-irqc: Get rid of IRQF_VALID
Message-Id: <20150720100614.2552.86867.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150720100602.2552.85507.sendpatchset@little-apple>
In-Reply-To: <20150720100602.2552.85507.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: jason@lakedaemon.net, geert+renesas@glider.be, linux-kernel@vger.kernel.org, horms@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

From: Magnus Damm <damm+renesas@opensource.se>

IRQF_VALID is not needed on ARM anymore, so get rid of it.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/irqchip/irq-renesas-irqc.c |    1 -
 1 file changed, 1 deletion(-)

--- 0001/drivers/irqchip/irq-renesas-irqc.c
+++ work/drivers/irqchip/irq-renesas-irqc.c	2015-07-20 17:40:00.272366518 +0900
@@ -162,7 +162,6 @@ static int irqc_irq_domain_map(struct ir
 	irqc_dbg(&p->irq[hw], "map");
 	irq_set_chip_data(virq, h->host_data);
 	irq_set_chip_and_handler(virq, &p->irq_chip, handle_level_irq);
-	set_irq_flags(virq, IRQF_VALID); /* kill me now */
 	return 0;
 }
 
