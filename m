From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 13 Jan 2017 09:50:29 +0000
Subject: [PATCH 3/3] sh/intc: Add a space character for better code readability in register_intc_controller()
Message-Id: <c23fefa5-cd69-3ae7-0064-82933707e0a1@users.sourceforge.net>
List-Id: <linux-sh.vger.kernel.org>
References: <4d37c4d8-d28b-bd98-968b-f544d6a213eb@users.sourceforge.net>
In-Reply-To: <4d37c4d8-d28b-bd98-968b-f544d6a213eb@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 13 Jan 2017 10:32:04 +0100

The script "checkpatch.pl" pointed information out like the following.

ERROR: spaces required around that '+=' (ctx:VxW)

Thus fix the affected source code place.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/sh/intc/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
index 95fb29d69ab7..e7f5aeeb1cee 100644
--- a/drivers/sh/intc/core.c
+++ b/drivers/sh/intc/core.c
@@ -286,7 +286,7 @@ int __init register_intc_controller(struct intc_desc *desc)
 	if (hw->subgroups)
 		for (i = 0; i < hw->nr_subgroups; i++)
 			if (hw->subgroups[i].reg)
-				k+= save_reg(d, k, hw->subgroups[i].reg, 0);
+				k += save_reg(d, k, hw->subgroups[i].reg, 0);
 
 	memcpy(&d->chip, &intc_irq_chip, sizeof(struct irq_chip));
 	d->chip.name = desc->name;
-- 
2.11.0

