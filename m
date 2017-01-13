From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 13 Jan 2017 09:48:08 +0000
Subject: [PATCH 1/3] sh/intc: Use kcalloc() in register_intc_controller()
Message-Id: <6f6f99f6-26f0-d002-ca85-d974d71aa518@users.sourceforge.net>
List-Id: <linux-sh.vger.kernel.org>
References: <4d37c4d8-d28b-bd98-968b-f544d6a213eb@users.sourceforge.net>
In-Reply-To: <4d37c4d8-d28b-bd98-968b-f544d6a213eb@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 13 Jan 2017 10:04:38 +0100

Multiplications for the size determination of memory allocations
indicated that array data structures should be processed.
Thus use the corresponding function "kcalloc".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/sh/intc/core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
index 8e72bcbd3d6d..27817a8466f1 100644
--- a/drivers/sh/intc/core.c
+++ b/drivers/sh/intc/core.c
@@ -203,7 +203,8 @@ int __init register_intc_controller(struct intc_desc *desc)
 
 	if (desc->num_resources) {
 		d->nr_windows = desc->num_resources;
-		d->window = kzalloc(d->nr_windows * sizeof(*d->window),
+		d->window = kcalloc(d->nr_windows,
+				    sizeof(*d->window),
 				    GFP_NOWAIT);
 		if (!d->window)
 			goto err1;
@@ -229,13 +230,12 @@ int __init register_intc_controller(struct intc_desc *desc)
 	d->nr_reg += hw->sense_regs ? hw->nr_sense_regs : 0;
 	d->nr_reg += hw->ack_regs ? hw->nr_ack_regs : 0;
 	d->nr_reg += hw->subgroups ? hw->nr_subgroups : 0;
-
-	d->reg = kzalloc(d->nr_reg * sizeof(*d->reg), GFP_NOWAIT);
+	d->reg = kcalloc(d->nr_reg, sizeof(*d->reg), GFP_NOWAIT);
 	if (!d->reg)
 		goto err2;
 
 #ifdef CONFIG_SMP
-	d->smp = kzalloc(d->nr_reg * sizeof(*d->smp), GFP_NOWAIT);
+	d->smp = kcalloc(d->nr_reg, sizeof(*d->smp), GFP_NOWAIT);
 	if (!d->smp)
 		goto err3;
 #endif
@@ -253,7 +253,8 @@ int __init register_intc_controller(struct intc_desc *desc)
 	}
 
 	if (hw->prio_regs) {
-		d->prio = kzalloc(hw->nr_vectors * sizeof(*d->prio),
+		d->prio = kcalloc(hw->nr_vectors,
+				  sizeof(*d->prio),
 				  GFP_NOWAIT);
 		if (!d->prio)
 			goto err4;
@@ -269,7 +270,8 @@ int __init register_intc_controller(struct intc_desc *desc)
 	}
 
 	if (hw->sense_regs) {
-		d->sense = kzalloc(hw->nr_vectors * sizeof(*d->sense),
+		d->sense = kcalloc(hw->nr_vectors,
+				   sizeof(*d->sense),
 				   GFP_NOWAIT);
 		if (!d->sense)
 			goto err5;
-- 
2.11.0

