From: Christoph Hellwig <hch@lst.de>
Date: Mon, 30 Jul 2018 11:24:59 +0000
Subject: Re: [PATCH] SH: statx is missing in the kernel
Message-Id: <20180730112459.GA22813@lst.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Dear linux-sh maintainers,

can we make sure to at least wire statx for 4.19?  That's not going
to immediately solve the glibc problem, but at least it won't be
prolonged.

On Tue, Jul 24, 2018 at 08:51:25PM +0200, Florian Weimer wrote:
> On 07/23/2018 08:05 PM, Romain Naour wrote:
>> __NR_statx is not defined by the kernel headers and __ASSUME_STATX is
>> defined since kernel 4.11.
>>
>> __ASSUME_STATX must be undefined until SH kernel support statx.
>
> Carlos, I would like to check in the attached patch for 2.28.  I 
> compile-tested this with build-many-glibcs.py against a 4.11 kernel tree 
> with --enable-kernel=4.13.
>
> I'm preparing another patch for alpha, which still has to undergo testing 
> on kernel 4.13 sources.
>
> Thanks,
> Florian

> Subject: [PATCH] sh: Do not define __ASSUME_STATX
> To: libc-alpha@sourceware.org
> 
> 2018-07-24  Florian Weimer  <fweimer@redhat.com>
> 
> 	* sysdeps/unix/sysv/linux/sh/kernel-features.h (__ASSUME_STATX):
> 	Undefine.  Suggested by Romain Naour <romain.naour@gmail.com>.
> 
> diff --git a/sysdeps/unix/sysv/linux/sh/kernel-features.h b/sysdeps/unix/sysv/linux/sh/kernel-features.h
> index 05b7dcd037..b8ccb01518 100644
> --- a/sysdeps/unix/sysv/linux/sh/kernel-features.h
> +++ b/sysdeps/unix/sysv/linux/sh/kernel-features.h
> @@ -56,4 +56,7 @@
>  # undef __ASSUME_RENAMEAT2
>  #endif
>  
> +/* sh does not support the statx system call.  */
> +#undef __ASSUME_STATX
> +
>  #endif

---end quoted text---
