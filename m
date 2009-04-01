From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 01 Apr 2009 14:20:58 +0000
Subject: [PATCH] sh_intc: install enable, disable and shutdown callbacks
Message-Id: <20090401142058.32553.60588.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Modify the intc code to install a disable callback. The current
solution without a disable callback results in use of the
generic default_disable() function. This function is a no-op
so suspend_device_irqs() will not disable any intc interrupts
at suspend time without this patch. Also, install enable and
shutdown callbacks while at it.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/sh/intc.c |    3 +++
 1 file changed, 3 insertions(+)

--- 0001/drivers/sh/intc.c
+++ work/drivers/sh/intc.c	2009-04-01 21:03:04.000000000 +0900
@@ -707,6 +707,9 @@ void __init register_intc_controller(str
 	d->chip.mask = intc_disable;
 	d->chip.unmask = intc_enable;
 	d->chip.mask_ack = intc_disable;
+	d->chip.enable = intc_enable;
+	d->chip.disable = intc_disable;
+	d->chip.shutdown = intc_disable;
 	d->chip.set_type = intc_set_sense;
 
 #if defined(CONFIG_CPU_SH3) || defined(CONFIG_CPU_SH4A)
