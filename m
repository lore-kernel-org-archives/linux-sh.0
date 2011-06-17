From: Petr Tesarik <ptesarik@suse.cz>
Date: Fri, 17 Jun 2011 08:46:24 +0000
Subject: [PATCH 06/10] sh: change valid_phys_addr_range's @addr param to phys_addr_t
Message-Id: <201106171046.24949.ptesarik@suse.cz>
List-Id: <linux-sh.vger.kernel.org>
References: <201106171038.25988.ptesarik@suse.cz>
In-Reply-To: <201106171038.25988.ptesarik@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

No other changes are needed, the function will work just fine with
a potentially larger data type.


Signed-off-by: Petr Tesarik <ptesarik@suse.cz>
---
 arch/sh/include/asm/io.h |    2 +-
 arch/sh/mm/mmap.c        |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 28c5aa5..e6d5add 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -383,7 +383,7 @@ static inline int iounmap_fixed(void __iomem *addr) { return -EINVAL; }
 #define xlate_dev_kmem_ptr(p)	p
 
 #define ARCH_HAS_VALID_PHYS_ADDR_RANGE
-int valid_phys_addr_range(unsigned long addr, size_t size);
+int valid_phys_addr_range(phys_addr_t addr, size_t size);
 int valid_mmap_phys_addr_range(unsigned long pfn, size_t size);
 
 #endif /* __KERNEL__ */
diff --git a/arch/sh/mm/mmap.c b/arch/sh/mm/mmap.c
index afeb710..80bf494 100644
--- a/arch/sh/mm/mmap.c
+++ b/arch/sh/mm/mmap.c
@@ -238,7 +238,7 @@ bottomup:
  * You really shouldn't be using read() or write() on /dev/mem.  This
  * might go away in the future.
  */
-int valid_phys_addr_range(unsigned long addr, size_t count)
+int valid_phys_addr_range(phys_addr_t addr, size_t count)
 {
 	if (addr < __MEMORY_START)
 		return 0;
-- 
1.7.3.4
