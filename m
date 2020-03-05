From: Arvind Sankar <nivedita@alum.mit.edu>
Date: Thu, 05 Mar 2020 15:10:10 +0000
Subject: [PATCH] sh: Stop printing the virtual memory layout
Message-Id: <20200305151010.835954-1-nivedita@alum.mit.edu>
List-Id: <linux-sh.vger.kernel.org>
References: <202003021038.8F0369D907@keescook>
In-Reply-To: <202003021038.8F0369D907@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kees Cook <keescook@chromium.org>
Cc: "Tobin C . Harding" <me@tobin.cc>, Tycho Andersen <tycho@tycho.ws>, kernel-hardening@lists.openwall.com, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

For security, don't display the kernel's virtual memory layout.

Kees Cook points out:
"These have been entirely removed on other architectures, so let's
just do the same for ia32 and remove it unconditionally."

071929dbdd86 ("arm64: Stop printing the virtual memory layout")
1c31d4e96b8c ("ARM: 8820/1: mm: Stop printing the virtual memory layout")
31833332f798 ("m68k/mm: Stop printing the virtual memory layout")
fd8d0ca25631 ("parisc: Hide virtual kernel memory layout")
adb1fe9ae2ee ("mm/page_alloc: Remove kernel address exposure in free_reserved_area()")

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/sh/mm/init.c | 41 -----------------------------------------
 1 file changed, 41 deletions(-)

diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index d1b1ff2be17a..e68a1106e99b 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -360,47 +360,6 @@ void __init mem_init(void)
 	vsyscall_init();
 
 	mem_init_print_info(NULL);
-	pr_info("virtual kernel memory layout:\n"
-		"    fixmap  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
-#ifdef CONFIG_HIGHMEM
-		"    pkmap   : 0x%08lx - 0x%08lx   (%4ld kB)\n"
-#endif
-		"    vmalloc : 0x%08lx - 0x%08lx   (%4ld MB)\n"
-		"    lowmem  : 0x%08lx - 0x%08lx   (%4ld MB) (cached)\n"
-#ifdef CONFIG_UNCACHED_MAPPING
-		"            : 0x%08lx - 0x%08lx   (%4ld MB) (uncached)\n"
-#endif
-		"      .init : 0x%08lx - 0x%08lx   (%4ld kB)\n"
-		"      .data : 0x%08lx - 0x%08lx   (%4ld kB)\n"
-		"      .text : 0x%08lx - 0x%08lx   (%4ld kB)\n",
-		FIXADDR_START, FIXADDR_TOP,
-		(FIXADDR_TOP - FIXADDR_START) >> 10,
-
-#ifdef CONFIG_HIGHMEM
-		PKMAP_BASE, PKMAP_BASE+LAST_PKMAP*PAGE_SIZE,
-		(LAST_PKMAP*PAGE_SIZE) >> 10,
-#endif
-
-		(unsigned long)VMALLOC_START, VMALLOC_END,
-		(VMALLOC_END - VMALLOC_START) >> 20,
-
-		(unsigned long)memory_start, (unsigned long)high_memory,
-		((unsigned long)high_memory - (unsigned long)memory_start) >> 20,
-
-#ifdef CONFIG_UNCACHED_MAPPING
-		uncached_start, uncached_end, uncached_size >> 20,
-#endif
-
-		(unsigned long)&__init_begin, (unsigned long)&__init_end,
-		((unsigned long)&__init_end -
-		 (unsigned long)&__init_begin) >> 10,
-
-		(unsigned long)&_etext, (unsigned long)&_edata,
-		((unsigned long)&_edata - (unsigned long)&_etext) >> 10,
-
-		(unsigned long)&_text, (unsigned long)&_etext,
-		((unsigned long)&_etext - (unsigned long)&_text) >> 10);
-
 	mem_init_done = 1;
 }
 
-- 
2.24.1
