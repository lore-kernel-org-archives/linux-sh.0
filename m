From: Joe Perches <joe@perches.com>
Date: Fri, 17 Feb 2017 07:11:43 +0000
Subject: [PATCH 30/35] drivers/sh: Convert remaining use of pr_warning to pr_warn
Message-Id: <ab61d54ada3fff9e5c300a6d829a0ae9a80b8cae.1487314667.git.joe@perches.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

To enable eventual removal of pr_warning

This makes pr_warn use consistent for drivers/sh

Prior to this patch, there was 1 use of pr_warning and
0 uses of pr_warn in drivers/sh

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/sh/intc/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
index 8e72bcbd3d6d..2258597f354a 100644
--- a/drivers/sh/intc/core.c
+++ b/drivers/sh/intc/core.c
@@ -100,8 +100,8 @@ static void __init intc_register_irq(struct intc_desc *desc,
 		primary = 1;
 
 	if (!data[0] && !data[1])
-		pr_warning("missing unique irq mask for irq %d (vect 0x%04x)\n",
-			   irq, irq2evt(irq));
+		pr_warn("missing unique irq mask for irq %d (vect 0x%04x)\n",
+			irq, irq2evt(irq));
 
 	data[0] = data[0] ? data[0] : intc_get_mask_handle(desc, d, enum_id, 1);
 	data[1] = data[1] ? data[1] : intc_get_prio_handle(desc, d, enum_id, 1);
-- 
2.10.0.rc2.1.g053435c

