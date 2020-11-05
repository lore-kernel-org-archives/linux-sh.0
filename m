From: Helge Deller <deller@gmx.de>
Date: Thu, 05 Nov 2020 13:14:15 +0000
Subject: Re: [PATCH seccomp 2/8] parisc: Enable seccomp architecture tracking
Message-Id: <8d86100a-a3d6-d3bd-856c-38d17f363864@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1604410035.git.yifeifz2@illinois.edu>
 <9bb86c546eda753adf5270425e7353202dbce87c.1604410035.git.yifeifz2@illinois.edu>
In-Reply-To: <9bb86c546eda753adf5270425e7353202dbce87c.1604410035.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: YiFei Zhu <zhuyifei1999@gmail.com>, containers@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org, Tobin Feldman-Fitzthum <tobin@ibm.com>, Hubertus Franke <frankeh@us.ibm.com>, Jack Chen <jianyan2@illinois.edu>, linux-riscv@lists.infradead.org, Andrea Arcangeli <aarcange@redhat.com>, linux-s390@vger.kernel.org, YiFei Zhu <yifeifz2@illinois.edu>, linux-csky@vger.kernel.org, Tianyin Xu <tyxu@illinois.edu>, linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>, Valentin Rothberg <vrothber@redhat.com>, Josep Torrellas <torrella@illinois.edu>, Will Drewry <wad@chromium.org>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, Dimitrios Skarlatos <dskarlat@cs.cmu.edu>, David Laight <David.Laight@aculab.com>, Giuseppe Scrivano <gscrivan@redhat.com>, linuxppc-dev@lists.ozlabs.org

On 11/3/20 2:42 PM, YiFei Zhu wrote:
> From: YiFei Zhu <yifeifz2@illinois.edu>
>
> To enable seccomp constant action bitmaps, we need to have a static
> mapping to the audit architecture and system call table size. Add these
> for parisc.
> > Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>

I did compile- and boot-tested it, works on 32- and 64-bit parisc kernel.
I don't know how to test it actually, but anyway:

Acked-by: Helge Deller <deller@gmx.de>

Thanks!
Helge

> ---
>  arch/parisc/include/asm/Kbuild    |  1 -
>  arch/parisc/include/asm/seccomp.h | 22 ++++++++++++++++++++++
>  2 files changed, 22 insertions(+), 1 deletion(-)
>  create mode 100644 arch/parisc/include/asm/seccomp.h
>
> diff --git a/arch/parisc/include/asm/Kbuild b/arch/parisc/include/asm/Kbuild
> index e3ee5c0bfe80..f16c4db80116 100644
> --- a/arch/parisc/include/asm/Kbuild
> +++ b/arch/parisc/include/asm/Kbuild
> @@ -5,5 +5,4 @@ generated-y += syscall_table_c32.h
>  generic-y += kvm_para.h
>  generic-y += local64.h
>  generic-y += mcs_spinlock.h
> -generic-y += seccomp.h
>  generic-y += user.h
> diff --git a/arch/parisc/include/asm/seccomp.h b/arch/parisc/include/asm/seccomp.h
> new file mode 100644
> index 000000000000..b058b2220322
> --- /dev/null
> +++ b/arch/parisc/include/asm/seccomp.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _ASM_SECCOMP_H
> +#define _ASM_SECCOMP_H
> +
> +#include <asm-generic/seccomp.h>
> +
> +#ifdef CONFIG_64BIT
> +# define SECCOMP_ARCH_NATIVE		AUDIT_ARCH_PARISC64
> +# define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
> +# define SECCOMP_ARCH_NATIVE_NAME	"parisc64"
> +# ifdef CONFIG_COMPAT
> +#  define SECCOMP_ARCH_COMPAT		AUDIT_ARCH_PARISC
> +#  define SECCOMP_ARCH_COMPAT_NR	NR_syscalls
> +#  define SECCOMP_ARCH_COMPAT_NAME	"parisc"
> +# endif
> +#else /* !CONFIG_64BIT */
> +# define SECCOMP_ARCH_NATIVE		AUDIT_ARCH_PARISC
> +# define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
> +# define SECCOMP_ARCH_NATIVE_NAME	"parisc"
> +#endif
> +
> +#endif /* _ASM_SECCOMP_H */
>
