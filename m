From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 09 Feb 2010 07:17:20 +0000
Subject: [PATCH] sh: fix INTC to use set_irq_chained_handler() for redirects
Message-Id: <20100209071720.3947.94798.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch updates the shared INTC code to use
set_irq_chained_handler() for intc_redirect_irq().

With this in place request_irq() on a merged irq
which has been redirected will now return -EINVAL
instead of 0 together with a crash. This thanks to
the protection of the IRQ_NOREQUEST flag set for
chained interrupt handlers.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/sh/intc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- 0003/drivers/sh/intc.c
+++ work/drivers/sh/intc.c	2010-02-09 16:06:13.000000000 +0900
@@ -896,8 +896,8 @@ void __init register_intc_controller(str
 			vect2->enum_id = 0;
 
 			/* redirect this interrupts to the first one */
-			set_irq_chip_and_handler_name(irq2, &d->chip,
-					intc_redirect_irq, "redirect");
+			set_irq_chained_handler(irq2, intc_redirect_irq);
+			set_irq_chip(irq2, &d->chip);
 			set_irq_data(irq2, (void *)irq);
 		}
 	}
