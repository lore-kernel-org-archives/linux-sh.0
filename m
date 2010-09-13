From: Matt Fleming <matt@console-pimps.org>
Date: Mon, 13 Sep 2010 21:42:16 +0000
Subject: Re: IRQ flags patch
Message-Id: <20100913214216.GA26815@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
References: <6218.1284051389@redhat.com>
In-Reply-To: <6218.1284051389@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Sep 09, 2010 at 05:56:29PM +0100, David Howells wrote:
> 
> Hi Paul,
> 
> Could you review my SH irqflags changes?  You can see it through here:
> 
> http://git.kernel.org/?p=linux/kernel/git/dhowells/linux-2.6-irqflags.git;a=summary
> 
> I'd like to put it into linux-next soon, hopefully to go to Linus in the next
> merge window, and I'd like for SH to still work...

Hi David,

This patch series fails to link on SH with the following error,

init/built-in.o: In function `do_one_initcall':
/home/matt/src/kernels/mfleming-2.6.git/init/main.c:770: undefined reference to `arch_local_save_flags'
init/built-in.o: In function `check_bugs':
/home/matt/src/kernels/mfleming-2.6.git/arch/sh/include/asm/bugs.h:28: undefined reference to `arch_local_save_flags'
arch/sh/kernel/built-in.o: In function `cpu_idle':
/home/matt/src/kernels/mfleming-2.6.git/arch/sh/kernel/idle.c:114: undefined reference to `arch_local_save_flags'
arch/sh/mm/built-in.o: In function `flush_icache_all':
/home/matt/src/kernels/mfleming-2.6.git/arch/sh/mm/cache-sh4.c:146: undefined reference to `arch_local_save_flags'
arch/sh/mm/built-in.o: In function `sh4_flush_icache_range':
/home/matt/src/kernels/mfleming-2.6.git/arch/sh/mm/cache-sh4.c:86: undefined reference to `arch_local_save_flags'
arch/sh/mm/built-in.o:/home/matt/src/kernels/mfleming-2.6.git/arch/sh/include/asm/bitops-llsc.h:13: more undefined references to `arch_local_save_flags' follow
make: *** [.tmp_vmlinux1] Error 1

I'm guessing the underscores should be dropped from
__arch_local_irq_save() in arch/sh/kernel/irq_32.c seeing as there are
no callers of that function anywhere?

However, this patch series fails to run on my 7785lcr board. You also
need to move RAW_IRQ_DISABLED and RAW_IRQ_ENABLED in
arch/sh/include/asm/irqflags.h to ARCH_IRQ_DISABLED and
ARCH_IRQ_ENABLED. The attached diff gets my board booting.

diff --git a/arch/sh/include/asm/irqflags.h b/arch/sh/include/asm/irqflags.h
index a741153..43b7608 100644
--- a/arch/sh/include/asm/irqflags.h
+++ b/arch/sh/include/asm/irqflags.h
@@ -1,8 +1,8 @@
 #ifndef __ASM_SH_IRQFLAGS_H
 #define __ASM_SH_IRQFLAGS_H
 
-#define RAW_IRQ_DISABLED	0xf0
-#define RAW_IRQ_ENABLED		0x00
+#define ARCH_IRQ_DISABLED	0xf0
+#define ARCH_IRQ_ENABLED	0x00
 
 #include <asm-generic/irqflags.h>
 
diff --git a/arch/sh/kernel/irq_32.c b/arch/sh/kernel/irq_32.c
index 14d2477..e5a755b 100644
--- a/arch/sh/kernel/irq_32.c
+++ b/arch/sh/kernel/irq_32.c
@@ -14,7 +14,7 @@ void notrace arch_local_irq_restore(unsigned long flags)
 {
 	unsigned long __dummy0, __dummy1;
 
-	if (flags = RAW_IRQ_DISABLED) {
+	if (flags = ARCH_IRQ_DISABLED) {
 		__asm__ __volatile__ (
 			"stc	sr, %0\n\t"
 			"or	#0xf0, %0\n\t"
@@ -33,14 +33,14 @@ void notrace arch_local_irq_restore(unsigned long flags)
 #endif
 			"ldc	%0, sr\n\t"
 			: "=&r" (__dummy0), "=r" (__dummy1)
-			: "1" (~RAW_IRQ_DISABLED)
+			: "1" (~ARCH_IRQ_DISABLED)
 			: "memory"
 		);
 	}
 }
 EXPORT_SYMBOL(arch_local_irq_restore);
 
-unsigned long notrace __arch_local_save_flags(void)
+unsigned long notrace arch_local_save_flags(void)
 {
 	unsigned long flags;
 
@@ -54,4 +54,4 @@ unsigned long notrace __arch_local_save_flags(void)
 
 	return flags;
 }
-EXPORT_SYMBOL(__arch_local_save_flags);
+EXPORT_SYMBOL(arch_local_save_flags);

