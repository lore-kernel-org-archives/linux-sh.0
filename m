From: Felix Born <felix.born@online.de>
Date: Mon, 21 May 2012 17:32:12 +0000
Subject: Re: Compile Failure SH7203
Message-Id: <4FBA7C1C.7060701@online.de>
List-Id: <linux-sh.vger.kernel.org>
References: <4FB7A92F.9030102@online.de>
In-Reply-To: <4FB7A92F.9030102@online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org



Am 20.05.2012 03:15, schrieb Paul Mundt:
> On Sat, May 19, 2012 at 04:07:43PM +0200, Felix Born wrote:
>> Hi,
>> I get an error while compiling the kernel for sh7203.
>> I' am using the Linux/sh 3.3.0 Kernel.
>> Can anyone give me some hints?
> ..
>
>> In file included from include/asm-generic/getorder.h:7:0,
>>                  from /home/testo/SH2A/sh7203_gcc-3.4.6_kernel_mod/linux-3.3.0-sh7203/arch/sh/include/asm/page.h:187,
>>                  from /home/testo/SH2A/sh7203_gcc-3.4.6_kernel_mod/linux-3.3.0-sh7203/arch/sh/include/asm/mmu.h:38,
>>                  from /home/testo/SH2A/sh7203_gcc-3.4.6_kernel_mod/linux-3.3.0-sh7203/arch/sh/include/asm/system_32.h:5,
>>                  from /home/testo/SH2A/sh7203_gcc-3.4.6_kernel_mod/linux-3.3.0-sh7203/arch/sh/include/asm/system.h:179,
>>                  from include/asm-generic/bitops/atomic.h:5,
>>                  from /home/testo/SH2A/sh7203_gcc-3.4.6_kernel_mod/linux-3.3.0-sh7203/arch/sh/include/asm/bitops.h:21,
>>                  from include/linux/bitops.h:22,
>>                  from include/linux/thread_info.h:52,
>>                  from include/linux/preempt.h:9,
>>                  from include/linux/spinlock.h:50,
>>                  from include/linux/mmzone.h:7,
>>                  from include/linux/gfp.h:4,
>>                  from include/linux/mm.h:8,
>>                  from arch/sh/kernel/asm-offsets.c:13:
>> include/linux/log2.h: In function '__ilog2_u32':
>> include/linux/log2.h:34:2: error: implicit declaration of function 'fls'
>> include/linux/log2.h: In function '__ilog2_u64':
>> include/linux/log2.h:42:2: error: implicit declaration of function 'fls64'
>> include/linux/log2.h: In function '__roundup_pow_of_two':
>> include/linux/log2.h:63:2: error: implicit declaration of function 'fls_long'
> This looks familiar..
>
> It's already fixed in mainline, but you can cherry-pick the comit.
> Perhaps we should queue this one up for a -stable backport.
>
> Does this work for you?
>
> ---
>
> commit 344dd2f4c2bf6d80b54f78012532debeb22c66fd
> Author: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> Date:   Tue Mar 6 14:07:09 2012 +0900
>
> ..
>
> diff --git a/arch/sh/include/asm/bitops.h b/arch/sh/include/asm/bitops.h
> index 90fa3e4..ea8706d 100644
> --- a/arch/sh/include/asm/bitops.h
> +++ b/arch/sh/include/asm/bitops.h
> @@ -7,7 +7,6 @@
>  #error only <linux/bitops.h> can be included directly
>  #endif
>  
> -#include <asm/system.h>
>  /* For __swab32 */
>  #include <asm/byteorder.h>
My bitopts.h already was without the line:
#include <asm/system.h>
So the patch didn't work.
However I tried to compile the mainline kernel for sh7203.
That worked without errors.
