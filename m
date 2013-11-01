From: Cody P Schafer <cody@linux.vnet.ibm.com>
Date: Fri, 01 Nov 2013 22:38:52 +0000
Subject: [PATCH 8/8] sh/dwarf: use rbtree postorder iteration helper instead of solution using repeated rb_er
Message-Id: <1383345566-25087-8-git-send-email-cody@linux.vnet.ibm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383345566-25087-1-git-send-email-cody@linux.vnet.ibm.com>
In-Reply-To: <1383345566-25087-1-git-send-email-cody@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Cody P Schafer <cody@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>

Use rbtree_postorder_for_each_entry_safe() to destroy the rbtree instead
of using repeated rb_erase() calls

Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
---
 arch/sh/kernel/dwarf.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/sh/kernel/dwarf.c b/arch/sh/kernel/dwarf.c
index 49c09c7..67a049e 100644
--- a/arch/sh/kernel/dwarf.c
+++ b/arch/sh/kernel/dwarf.c
@@ -995,29 +995,19 @@ static struct unwinder dwarf_unwinder = {
 
 static void dwarf_unwinder_cleanup(void)
 {
-	struct rb_node **fde_rb_node = &fde_root.rb_node;
-	struct rb_node **cie_rb_node = &cie_root.rb_node;
+	struct dwarf_fde *fde, *next_fde;
+	struct dwarf_cie *cie, *next_cie;
 
 	/*
 	 * Deallocate all the memory allocated for the DWARF unwinder.
 	 * Traverse all the FDE/CIE lists and remove and free all the
 	 * memory associated with those data structures.
 	 */
-	while (*fde_rb_node) {
-		struct dwarf_fde *fde;
-
-		fde = rb_entry(*fde_rb_node, struct dwarf_fde, node);
-		rb_erase(*fde_rb_node, &fde_root);
+	rbtree_postorder_for_each_entry_safe(fde, next_fde, &fde_root, node)
 		kfree(fde);
-	}
 
-	while (*cie_rb_node) {
-		struct dwarf_cie *cie;
-
-		cie = rb_entry(*cie_rb_node, struct dwarf_cie, node);
-		rb_erase(*cie_rb_node, &cie_root);
+	rbtree_postorder_for_each_entry_safe(cie, next_cie, &cie_root, node)
 		kfree(cie);
-	}
 
 	kmem_cache_destroy(dwarf_reg_cachep);
 	kmem_cache_destroy(dwarf_frame_cachep);
-- 
1.8.4.2

