From: Felix Born <felix.born@online.de>
Date: Sat, 19 May 2012 14:07:43 +0000
Subject: Compile Failure SH7203
Message-Id: <4FB7A92F.9030102@online.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,
I get an error while compiling the kernel for sh7203.
I' am using the Linux/sh 3.3.0 Kernel.
Can anyone give me some hints?
The compile log is listed below:
======================   CHK     include/linux/version.h
   CHK     include/generated/utsrelease.h
make[1]: `include/generated/machtypes.h' is up to date.
   CC      arch/sh/kernel/asm-offsets.s
In file included from include/asm-generic/getorder.h:7:0,
                  from /home/testo/SH2A/sh7203_gcc-3.4.6_kernel_mod/linux-3.3.0-sh7203/arch/sh/include/asm/page.h:187,
                  from /home/testo/SH2A/sh7203_gcc-3.4.6_kernel_mod/linux-3.3.0-sh7203/arch/sh/include/asm/mmu.h:38,
                  from /home/testo/SH2A/sh7203_gcc-3.4.6_kernel_mod/linux-3.3.0-sh7203/arch/sh/include/asm/system_32.h:5,
                  from /home/testo/SH2A/sh7203_gcc-3.4.6_kernel_mod/linux-3.3.0-sh7203/arch/sh/include/asm/system.h:179,
                  from include/asm-generic/bitops/atomic.h:5,
                  from /home/testo/SH2A/sh7203_gcc-3.4.6_kernel_mod/linux-3.3.0-sh7203/arch/sh/include/asm/bitops.h:21,
                  from include/linux/bitops.h:22,
                  from include/linux/thread_info.h:52,
                  from include/linux/preempt.h:9,
                  from include/linux/spinlock.h:50,
                  from include/linux/mmzone.h:7,
                  from include/linux/gfp.h:4,
                  from include/linux/mm.h:8,
                  from arch/sh/kernel/asm-offsets.c:13:
include/linux/log2.h: In function '__ilog2_u32':
include/linux/log2.h:34:2: error: implicit declaration of function 'fls'
include/linux/log2.h: In function '__ilog2_u64':
include/linux/log2.h:42:2: error: implicit declaration of function 'fls64'
include/linux/log2.h: In function '__roundup_pow_of_two':
include/linux/log2.h:63:2: error: implicit declaration of function 'fls_long'
In file included from /home/testo/SH2A/sh7203_gcc-3.4.6_kernel_mod/linux-3.3.0-sh7203/arch/sh/include/asm/bitops.h:98:0,
                  from include/linux/bitops.h:22,
                  from include/linux/thread_info.h:52,
                  from include/linux/preempt.h:9,
                  from include/linux/spinlock.h:50,
                  from include/linux/mmzone.h:7,
                  from include/linux/gfp.h:4,
                  from include/linux/mm.h:8,
                  from arch/sh/kernel/asm-offsets.c:13:
include/asm-generic/bitops/fls.h: At top level:
include/asm-generic/bitops/fls.h:12:28: error: static declaration of 'fls' follows non-static declaration
include/linux/log2.h:34:9: note: previous implicit declaration of 'fls' was here
In file included from /home/testo/SH2A/sh7203_gcc-3.4.6_kernel_mod/linux-3.3.0-sh7203/arch/sh/include/asm/bitops.h:100:0,
                  from include/linux/bitops.h:22,
                  from include/linux/thread_info.h:52,
                  from include/linux/preempt.h:9,
                  from include/linux/spinlock.h:50,
                  from include/linux/mmzone.h:7,
                  from include/linux/gfp.h:4,
                  from include/linux/mm.h:8,
                  from arch/sh/kernel/asm-offsets.c:13:
include/asm-generic/bitops/fls64.h:18:28: error: static declaration of 'fls64' follows non-static declaration
include/linux/log2.h:42:9: note: previous implicit declaration of 'fls64' was here
In file included from include/linux/thread_info.h:52:0,
                  from include/linux/preempt.h:9,
                  from include/linux/spinlock.h:50,
                  from include/linux/mmzone.h:7,
                  from include/linux/gfp.h:4,
                  from include/linux/mm.h:8,
                  from arch/sh/kernel/asm-offsets.c:13:
include/linux/bitops.h:160:24: error: conflicting types for 'fls_long'
include/linux/log2.h:63:16: note: previous implicit declaration of 'fls_long' was here
make[1]: *** [arch/sh/kernel/asm-offsets.s] Error 1
make: *** [prepare0] Error 2
======================Thanks.
Kind Regards.
Felix Born

