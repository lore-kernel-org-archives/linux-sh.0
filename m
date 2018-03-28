From: Shea Levy <shea@shealevy.com>
Date: Wed, 28 Mar 2018 20:36:58 +0000
Subject: [PATCH v4 15/16] sh: Use generic free_initrd_mem.
Message-Id: <20180328203659.18692-16-shea@shealevy.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20180328152714.6103-1-shea@shealevy.com>
 <20180328203659.18692-1-shea@shealevy.com>
In-Reply-To: <20180328203659.18692-1-shea@shealevy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-riscv@lists.infradead.org

Signed-off-by: Shea Levy <shea@shealevy.com>
---
 arch/sh/mm/init.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index ce0bbaa7e404..7451459d0725 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -477,13 +477,6 @@ void free_initmem(void)
 	free_initmem_default(-1);
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-
 #ifdef CONFIG_MEMORY_HOTPLUG
 int arch_add_memory(int nid, u64 start, u64 size, struct vmem_altmap *altmap,
 		bool want_memblock)
-- 
2.16.2

