From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 15 Feb 2010 11:40:25 +0000
Subject: [PATCH] sh: extend INTC with force_disable
Message-Id: <20100215114025.22039.11843.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Extend the shared INTC code with force_disable support to
allow keeping mask bits statically disabled. Needed for
SDHI support to mask out unsupported interrupt sources.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/sh/intc.c       |    3 +++
 include/linux/sh_intc.h |    1 +
 2 files changed, 4 insertions(+)

--- 0001/drivers/sh/intc.c
+++ work/drivers/sh/intc.c	2010-02-15 20:03:32.000000000 +0900
@@ -851,6 +851,9 @@ void __init register_intc_controller(str
 		d->chip.mask_ack = intc_mask_ack;
 	}
 
+	/* disable bits matching force_disable before registering irqs */
+	if (desc->force_disable)
+		intc_enable_disable_enum(desc, d, desc->force_disable, 0);
 
 	/* disable bits matching force_enable before registering irqs */
 	if (desc->force_enable)
--- 0001/include/linux/sh_intc.h
+++ work/include/linux/sh_intc.h	2010-02-15 20:03:32.000000000 +0900
@@ -72,6 +72,7 @@ struct intc_hw_desc {
 struct intc_desc {
 	char *name;
 	intc_enum force_enable;
+	intc_enum force_disable;
 	struct intc_hw_desc hw;
 };
 
