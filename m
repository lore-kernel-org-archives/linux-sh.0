From: Heiko Carstens <hca@linux.ibm.com>
Date: Mon, 09 Nov 2020 15:03:14 +0000
Subject: Re: [PATCH seccomp 5/8] s390: Enable seccomp architecture tracking
Message-Id: <20201109150314.GA16690@osiris>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1604410035.git.yifeifz2@illinois.edu>
 <0fbe0c14d598e18effad3b648ab4808f9cd95eba.1604410035.git.yifeifz2@illinois.edu>
In-Reply-To: <0fbe0c14d598e18effad3b648ab4808f9cd95eba.1604410035.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: YiFei Zhu <zhuyifei1999@gmail.com>
Cc: linux-sh@vger.kernel.org, Tobin Feldman-Fitzthum <tobin@ibm.com>, Hubertus Franke <frankeh@us.ibm.com>, Jack Chen <jianyan2@illinois.edu>, linux-riscv@lists.infradead.org, Andrea Arcangeli <aarcange@redhat.com>, linux-s390@vger.kernel.org, YiFei Zhu <yifeifz2@illinois.edu>, linux-csky@vger.kernel.org, Tianyin Xu <tyxu@illinois.edu>, linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>, Valentin Rothberg <vrothber@redhat.com>, Josep Torrellas <torrella@illinois.edu>, Will Drewry <wad@chromium.org>, linux-parisc@vger.kernel.org, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, Dimitrios Skarlatos <dskarlat@cs.cmu.edu>, David Laight <David.Laight@aculab.com>, Giuseppe Scrivano <gscrivan@redhat.com>, linuxppc-dev@lists.ozlabs.org

On Tue, Nov 03, 2020 at 07:43:01AM -0600, YiFei Zhu wrote:
> From: YiFei Zhu <yifeifz2@illinois.edu>
> 
> To enable seccomp constant action bitmaps, we need to have a static
> mapping to the audit architecture and system call table size. Add these
> for s390.
> 
> Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
> ---
>  arch/s390/include/asm/seccomp.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/s390/include/asm/seccomp.h b/arch/s390/include/asm/seccomp.h
> index 795bbe0d7ca6..71d46f0ba97b 100644
> --- a/arch/s390/include/asm/seccomp.h
> +++ b/arch/s390/include/asm/seccomp.h
> @@ -16,4 +16,13 @@
>  
>  #include <asm-generic/seccomp.h>
>  
> +#define SECCOMP_ARCH_NATIVE		AUDIT_ARCH_S390X
> +#define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
> +#define SECCOMP_ARCH_NATIVE_NAME	"s390x"
> +#ifdef CONFIG_COMPAT
> +# define SECCOMP_ARCH_COMPAT		AUDIT_ARCH_S390
> +# define SECCOMP_ARCH_COMPAT_NR		NR_syscalls
> +# define SECCOMP_ARCH_COMPAT_NAME	"s390"
> +#endif
> +

Acked-by: Heiko Carstens <hca@linux.ibm.com>
