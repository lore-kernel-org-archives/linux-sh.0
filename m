From: Paul Mundt <lethal@linux-sh.org>
Date: Sun, 20 May 2012 01:15:11 +0000
Subject: Re: Compile Failure SH7203
Message-Id: <20120520011510.GA16230@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4FB7A92F.9030102@online.de>
In-Reply-To: <4FB7A92F.9030102@online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, May 19, 2012 at 04:07:43PM +0200, Felix Born wrote:
> Hi,
> I get an error while compiling the kernel for sh7203.
> I' am using the Linux/sh 3.3.0 Kernel.
> Can anyone give me some hints?

..

> In file included from include/asm-generic/getorder.h:7:0,
>                  from /home/testo/SH2A/sh7203_gcc-3.4.6_kernel_mod/linux-3.3.0-sh7203/arch/sh/include/asm/page.h:187,
>                  from /home/testo/SH2A/sh7203_gcc-3.4.6_kernel_mod/linux-3.3.0-sh7203/arch/sh/include/asm/mmu.h:38,
>                  from /home/testo/SH2A/sh7203_gcc-3.4.6_kernel_mod/linux-3.3.0-sh7203/arch/sh/include/asm/system_32.h:5,
>                  from /home/testo/SH2A/sh7203_gcc-3.4.6_kernel_mod/linux-3.3.0-sh7203/arch/sh/include/asm/system.h:179,
>                  from include/asm-generic/bitops/atomic.h:5,
>                  from /home/testo/SH2A/sh7203_gcc-3.4.6_kernel_mod/linux-3.3.0-sh7203/arch/sh/include/asm/bitops.h:21,
>                  from include/linux/bitops.h:22,
>                  from include/linux/thread_info.h:52,
>                  from include/linux/preempt.h:9,
>                  from include/linux/spinlock.h:50,
>                  from include/linux/mmzone.h:7,
>                  from include/linux/gfp.h:4,
>                  from include/linux/mm.h:8,
>                  from arch/sh/kernel/asm-offsets.c:13:
> include/linux/log2.h: In function '__ilog2_u32':
> include/linux/log2.h:34:2: error: implicit declaration of function 'fls'
> include/linux/log2.h: In function '__ilog2_u64':
> include/linux/log2.h:42:2: error: implicit declaration of function 'fls64'
> include/linux/log2.h: In function '__roundup_pow_of_two':
> include/linux/log2.h:63:2: error: implicit declaration of function 'fls_long'

This looks familiar..

It's already fixed in mainline, but you can cherry-pick the comit.
Perhaps we should queue this one up for a -stable backport.

Does this work for you?

---

commit 344dd2f4c2bf6d80b54f78012532debeb22c66fd
Author: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date:   Tue Mar 6 14:07:09 2012 +0900

    sh/next: Fix build fail by asm/system.h in asm/bitops.h
    
    Other files are not done include definitely by asm/system.h made
    include in asm/bitops.h.
    This patch remove asm/system.h from asm/bitops.h.
    
    -----
    LANG=C make ARCH=sh CROSS_COMPILE=sh4-linux-gnu-
      CHK     include/linux/version.h
      CHK     include/generated/utsrelease.h
    make[1]: `include/generated/machtypes.h' is up to date.
      CC      arch/sh/kernel/asm-offsets.s
    In file included from include/asm-generic/getorder.h:7,
                   from /home/iwamatsu/work/kernel/sh-2.6-devel/arch/sh/include/asm/page.h:187,
                   from /home/iwamatsu/work/kernel/sh-2.6-devel/arch/sh/include/asm/mmu.h:38,
                   from /home/iwamatsu/work/kernel/sh-2.6-devel/arch/sh/include/asm/system_32.h:5,
                   from /home/iwamatsu/work/kernel/sh-2.6-devel/arch/sh/include/asm/system.h:179,
                   from /home/iwamatsu/work/kernel/sh-2.6-devel/arch/sh/include/asm/bitops.h:10,
                   from include/linux/bitops.h:22,
                   from include/linux/thread_info.h:52,
                   from include/linux/preempt.h:9,
                   from include/linux/spinlock.h:50,
                   from include/linux/mmzone.h:7,
                   from include/linux/gfp.h:4,
                   from include/linux/mm.h:8,
                   from arch/sh/kernel/asm-offsets.c:13:
    include/linux/log2.h: In function '__ilog2_u32':
    include/linux/log2.h:34: error: implicit declaration of function 'fls'
    include/linux/log2.h: In function '__ilog2_u64':
    include/linux/log2.h:42: error: implicit declaration of function 'fls64'
    include/linux/log2.h: In function '__roundup_pow_of_two':
    include/linux/log2.h:63: error: implicit declaration of function 'fls_long'
    -----
    
    Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
    Signed-off-by: Paul Mundt <lethal@linux-sh.org>

diff --git a/arch/sh/include/asm/bitops.h b/arch/sh/include/asm/bitops.h
index 90fa3e4..ea8706d 100644
--- a/arch/sh/include/asm/bitops.h
+++ b/arch/sh/include/asm/bitops.h
@@ -7,7 +7,6 @@
 #error only <linux/bitops.h> can be included directly
 #endif
 
-#include <asm/system.h>
 /* For __swab32 */
 #include <asm/byteorder.h>
 
