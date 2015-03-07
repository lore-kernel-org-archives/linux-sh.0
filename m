From: David Rientjes <rientjes@google.com>
Date: Sat, 07 Mar 2015 23:54:16 +0000
Subject: [patch 2/2] sh, dwarf: use mempool_create_slab_pool()
Message-Id: <alpine.DEB.2.10.1503071554010.24048@chino.kir.corp.google.com>
List-Id: <linux-sh.vger.kernel.org>
References: <alpine.DEB.2.10.1503071553110.24048@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.10.1503071553110.24048@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

Mempools created for slab caches should use
mempool_create_slab_pool().

Signed-off-by: David Rientjes <rientjes@google.com>
---
 arch/sh/kernel/dwarf.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/sh/kernel/dwarf.c b/arch/sh/kernel/dwarf.c
--- a/arch/sh/kernel/dwarf.c
+++ b/arch/sh/kernel/dwarf.c
@@ -1180,17 +1180,13 @@ static int __init dwarf_unwinder_init(void)
 			sizeof(struct dwarf_reg), 0,
 			SLAB_PANIC | SLAB_HWCACHE_ALIGN | SLAB_NOTRACK, NULL);
 
-	dwarf_frame_pool = mempool_create(DWARF_FRAME_MIN_REQ,
-					  mempool_alloc_slab,
-					  mempool_free_slab,
-					  dwarf_frame_cachep);
+	dwarf_frame_pool = mempool_create_slab_pool(DWARF_FRAME_MIN_REQ,
+						    dwarf_frame_cachep);
 	if (!dwarf_frame_pool)
 		goto out;
 
-	dwarf_reg_pool = mempool_create(DWARF_REG_MIN_REQ,
-					 mempool_alloc_slab,
-					 mempool_free_slab,
-					 dwarf_reg_cachep);
+	dwarf_reg_pool = mempool_create_slab_pool(DWARF_REG_MIN_REQ,
+						  dwarf_reg_cachep);
 	if (!dwarf_reg_pool)
 		goto out;
 
