From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 10 Feb 2010 11:17:39 +0000
Subject: [PATCH] sh: extend INTC with optional ioremap() support
Message-Id: <20100210111739.11145.92334.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add the member "io_window" to intc_desc to allow
passing a physical memory window to the INTC code.
The INTC code will ioremap the window if present.

Required to support INTCS on SH-Mobile G-series.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/sh/intc.c       |   14 ++++++++++++++
 include/linux/sh_intc.h |    3 +++
 2 files changed, 17 insertions(+)

--- 0006/drivers/sh/intc.c
+++ work/drivers/sh/intc.c	2010-02-10 19:31:14.000000000 +0900
@@ -45,6 +45,8 @@ struct intc_handle_int {
 
 struct intc_desc_int {
 	struct list_head list;
+	unsigned long virt_base;
+	unsigned long phys_base;
 	struct sys_device sysdev;
 	pm_message_t state;
 	unsigned long *reg;
@@ -425,6 +427,9 @@ static unsigned int __init intc_get_reg(
 {
 	unsigned int k;
 
+	address -= d->phys_base;
+	address += d->virt_base;
+
 	for (k = 0; k < d->nr_reg; k++) {
 		if (d->reg[k] = address)
 			return k;
@@ -774,6 +779,9 @@ static unsigned int __init save_reg(stru
 				    unsigned int smp)
 {
 	if (value) {
+		value -= d->phys_base;
+		value += d->virt_base;
+
 		d->reg[cnt] = value;
 #ifdef CONFIG_SMP
 		d->smp[cnt] = smp;
@@ -800,6 +808,12 @@ void __init register_intc_controller(str
 	INIT_LIST_HEAD(&d->list);
 	list_add(&d->list, &intc_list);
 
+	if (desc->io_window) {
+		d->phys_base = desc->io_window->start;
+		d->virt_base = (unsigned long)ioremap_nocache(d->phys_base,
+					       resource_size(desc->io_window));
+	}
+
 	d->nr_reg = hw->mask_regs ? hw->nr_mask_regs * 2 : 0;
 	d->nr_reg += hw->prio_regs ? hw->nr_prio_regs * 2 : 0;
 	d->nr_reg += hw->sense_regs ? hw->nr_sense_regs : 0;
--- 0006/include/linux/sh_intc.h
+++ work/include/linux/sh_intc.h	2010-02-10 19:31:14.000000000 +0900
@@ -1,6 +1,8 @@
 #ifndef __SH_INTC_H
 #define __SH_INTC_H
 
+#include <linux/ioport.h>
+
 typedef unsigned char intc_enum;
 
 struct intc_vect {
@@ -71,6 +73,7 @@ struct intc_hw_desc {
 
 struct intc_desc {
 	char *name;
+	struct resource *io_window;
 	intc_enum force_enable;
 	struct intc_hw_desc hw;
 };
