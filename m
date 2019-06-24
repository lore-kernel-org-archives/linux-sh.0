From: Paul Burton <paul.burton@mips.com>
Date: Mon, 24 Jun 2019 20:33:58 +0000
Subject: Re: [PATCH 5/5] asm-generic: remove ptrace.h
Message-Id: <20190624203357.cgybfqklcflll2ti@pburton-laptop>
List-Id: <linux-sh.vger.kernel.org>
References: <20190624054728.30966-1-hch@lst.de>
 <20190624054728.30966-6-hch@lst.de>
In-Reply-To: <20190624054728.30966-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Jun 24, 2019 at 07:47:28AM +0200, Christoph Hellwig wrote:
> No one is using this header anymore.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  MAINTAINERS                    |  1 -
>  arch/mips/include/asm/ptrace.h |  5 ---
>  include/asm-generic/ptrace.h   | 73 ----------------------------------
>  3 files changed, 79 deletions(-)
>  delete mode 100644 include/asm-generic/ptrace.h

FWIW:

    Acked-by: Paul Burton <paul.burton@mips.com>

Thanks,
    Paul

> diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
> index b6578611dddb..1e76774b36dd 100644
> --- a/arch/mips/include/asm/ptrace.h
> +++ b/arch/mips/include/asm/ptrace.h
> @@ -56,11 +56,6 @@ static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
>  	return regs->regs[31];
>  }
>  
> -/*
> - * Don't use asm-generic/ptrace.h it defines FP accessors that don't make
> - * sense on MIPS.  We rather want an error if they get invoked.
> - */
> -
>  static inline void instruction_pointer_set(struct pt_regs *regs,
>                                             unsigned long val)
>  {
