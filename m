From: David Rientjes <rientjes@google.com>
Date: Sat, 07 Mar 2015 23:53:48 +0000
Subject: [patch 1/2] sh, dwarf: destroy mempools on cleanup
Message-Id: <alpine.DEB.2.10.1503071553110.24048@chino.kir.corp.google.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

dwarf_reg_pool and dwarf_frame_pool are not properly destroyed when
cleaning up the dwarf unwinder.  Destroy them with mempool_destroy().

Also mark dwarf_unwinder_cleanup() as __init.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 arch/sh/kernel/dwarf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/sh/kernel/dwarf.c b/arch/sh/kernel/dwarf.c
--- a/arch/sh/kernel/dwarf.c
+++ b/arch/sh/kernel/dwarf.c
@@ -993,7 +993,7 @@ static struct unwinder dwarf_unwinder = {
 	.rating = 150,
 };
 
-static void dwarf_unwinder_cleanup(void)
+static void __init dwarf_unwinder_cleanup(void)
 {
 	struct dwarf_fde *fde, *next_fde;
 	struct dwarf_cie *cie, *next_cie;
@@ -1009,6 +1009,10 @@ static void dwarf_unwinder_cleanup(void)
 	rbtree_postorder_for_each_entry_safe(cie, next_cie, &cie_root, node)
 		kfree(cie);
 
+	if (dwarf_reg_pool)
+		mempool_destroy(dwarf_reg_pool);
+	if (dwarf_frame_pool)
+		mempool_destroy(dwarf_frame_pool);
 	kmem_cache_destroy(dwarf_reg_cachep);
 	kmem_cache_destroy(dwarf_frame_cachep);
 }
