From: Yinghai Lu <yinghai@kernel.org>
Date: Sun, 06 Apr 2014 05:39:23 +0000
Subject: [RFC PATCH 2/5] sh: Remove irq_reserve_irq calling
Message-Id: <1396762766-4942-3-git-send-email-yinghai@kernel.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1396762766-4942-1-git-send-email-yinghai@kernel.org>
In-Reply-To: <1396762766-4942-1-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

in sh calling path:
	register_intc_controller
		=> irq_create_identity_mapping/irq_create_strict_mappins
			=>irq_alloc_desc: it will set bits on allocate_irq
		=> intc_register_irq
			=> irq_reserve_irq: set bits again

so we can kill this irq_reserve_irq calling.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org
---
 drivers/sh/intc/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
index 8f32a13..05118f92 100644
--- a/drivers/sh/intc/core.c
+++ b/drivers/sh/intc/core.c
@@ -81,11 +81,8 @@ static void __init intc_register_irq(struct intc_desc *desc,
 	unsigned long flags;
 
 	/*
-	 * Register the IRQ position with the global IRQ map, then insert
-	 * it in to the radix tree.
+	 * insert it in to the radix tree.
 	 */
-	irq_reserve_irq(irq);
-
 	raw_spin_lock_irqsave(&intc_big_lock, flags);
 	radix_tree_insert(&d->tree, enum_id, intc_irq_xlate_get(irq));
 	raw_spin_unlock_irqrestore(&intc_big_lock, flags);
-- 
1.8.4.5

