From: Matt Fleming <matt@console-pimps.org>
Date: Tue, 06 Oct 2009 21:22:24 +0000
Subject: [PATCH 04/14] sh: Obliterate the P1 area macros
Message-Id: <22db0c702ba4b19699c05c38c26a6061bd0bbf40.1254861984.git.matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the use of PHYSADDR() with __pa(). PHYSADDR() is based on the
idea that all addresses in P1SEG are untranslated, so we can access an
address's physical page as an offset from P1SEG. This doesn't work for
CONFIG_PMB/CONFIG_PMB_FIXED because pages in P1SEG and P2SEG are used
for PMB mappings and so can be translated to any physical address.

Likewise, replace a P1SEGADDR() use with virt_to_phys().

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/boot/compressed/misc.c  |    2 +-
 arch/sh/include/asm/addrspace.h |    3 ---
 arch/sh/kernel/machine_kexec.c  |    2 +-
 arch/sh/mm/cache-sh4.c          |    4 ++--
 arch/sh/mm/cache-sh7705.c       |    2 +-
 5 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/sh/boot/compressed/misc.c b/arch/sh/boot/compressed/misc.c
index fd56a71..b51b1fc 100644
--- a/arch/sh/boot/compressed/misc.c
+++ b/arch/sh/boot/compressed/misc.c
@@ -131,7 +131,7 @@ void decompress_kernel(void)
 #ifdef CONFIG_SUPERH64
 	output_addr = (CONFIG_MEMORY_START + 0x2000);
 #else
-	output_addr = PHYSADDR((unsigned long)&_text+PAGE_SIZE);
+	output_addr = __pa((unsigned long)&_text+PAGE_SIZE);
 #ifdef CONFIG_29BIT
 	output_addr |= P2SEG;
 #endif
diff --git a/arch/sh/include/asm/addrspace.h b/arch/sh/include/asm/addrspace.h
index 80d4081..ebd6e49 100644
--- a/arch/sh/include/asm/addrspace.h
+++ b/arch/sh/include/asm/addrspace.h
@@ -28,9 +28,6 @@
 /* Returns the privileged segment base of a given address  */
 #define PXSEG(a)	(((unsigned long)(a)) & 0xe0000000)
 
-/* Returns the physical address of a PnSEG (n=1,2) address   */
-#define PHYSADDR(a)	(((unsigned long)(a)) & 0x1fffffff)
-
 #if defined(CONFIG_29BIT) || defined(CONFIG_PMB_FIXED)
 /*
  * Map an address to a certain privileged segment
diff --git a/arch/sh/kernel/machine_kexec.c b/arch/sh/kernel/machine_kexec.c
index 7ea2704..de7cf54 100644
--- a/arch/sh/kernel/machine_kexec.c
+++ b/arch/sh/kernel/machine_kexec.c
@@ -49,7 +49,7 @@ int machine_kexec_prepare(struct kimage *image)
 	/* older versions of kexec-tools are passing
 	 * the zImage entry point as a virtual address.
 	 */
-	if (image->start != PHYSADDR(image->start))
+	if (image->start != __pa(image->start))
 		return -EINVAL; /* upgrade your kexec-tools */
 
 	return 0;
diff --git a/arch/sh/mm/cache-sh4.c b/arch/sh/mm/cache-sh4.c
index a98c7d8..2ab8cd4 100644
--- a/arch/sh/mm/cache-sh4.c
+++ b/arch/sh/mm/cache-sh4.c
@@ -104,7 +104,7 @@ static inline void flush_cache_4096(unsigned long start,
 
 	local_irq_save(flags);
 	__flush_cache_4096(start | SH_CACHE_ASSOC,
-			   P1SEGADDR(phys), exec_offset);
+			   virt_to_phys(phys), exec_offset);
 	local_irq_restore(flags);
 }
 
@@ -123,7 +123,7 @@ static void sh4_flush_dcache_page(void *arg)
 	else
 #endif
 	{
-		unsigned long phys = PHYSADDR(page_address(page));
+		unsigned long phys = __pa(page_address(page));
 		unsigned long addr = CACHE_OC_ADDRESS_ARRAY;
 		int i, n;
 
diff --git a/arch/sh/mm/cache-sh7705.c b/arch/sh/mm/cache-sh7705.c
index 2601935..f527fb7 100644
--- a/arch/sh/mm/cache-sh7705.c
+++ b/arch/sh/mm/cache-sh7705.c
@@ -141,7 +141,7 @@ static void sh7705_flush_dcache_page(void *arg)
 	if (mapping && !mapping_mapped(mapping))
 		set_bit(PG_dcache_dirty, &page->flags);
 	else
-		__flush_dcache_page(PHYSADDR(page_address(page)));
+		__flush_dcache_page(__pa(page_address(page)));
 }
 
 static void __uses_jump_to_uncached sh7705_flush_cache_all(void *args)
-- 
1.6.3.3

