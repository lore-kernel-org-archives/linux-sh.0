From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 09 Jun 2011 06:20:03 +0000
Subject: [PATCH] ARM: mach-shmobile: sh73a0 gic_arch_extn.irq_set_wake() fix
Message-Id: <20110609062003.383.67447.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Initialize ->irq_set_wake() in gic_arch_extn to unbreak wake
up from the KEYSC device on AG5EVM in case of Suspend-to-RAM.

Without this patch "echo mem > /sys/power/state" and a key
press results in the following message on resume:

WARNING: at kernel/irq/manage.c:507 irq_set_irq_wake+0x7c/0xd8()                
Unbalanced IRQ 103 wake disable                                                 

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/intc-sh73a0.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- 0001/arch/arm/mach-shmobile/intc-sh73a0.c
+++ work/arch/arm/mach-shmobile/intc-sh73a0.c	2011-06-08 18:42:14.000000000 +0900
@@ -250,6 +250,11 @@ static irqreturn_t sh73a0_intcs_demux(in
 	return IRQ_HANDLED;
 }
 
+static int sh73a0_set_wake(struct irq_data *data, unsigned int on)
+{
+	return 0; /* always allow wakeup */
+}
+
 void __init sh73a0_init_irq(void)
 {
 	void __iomem *gic_dist_base = __io(0xf0001000);
@@ -257,6 +262,7 @@ void __init sh73a0_init_irq(void)
 	void __iomem *intevtsa = ioremap_nocache(0xffd20100, PAGE_SIZE);
 
 	gic_init(0, 29, gic_dist_base, gic_cpu_base);
+	gic_arch_extn.irq_set_wake = sh73a0_set_wake;
 
 	register_intc_controller(&intcs_desc);
 
