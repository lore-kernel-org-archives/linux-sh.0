From: Vladimir Murzin <vladimir.murzin@arm.com>
Date: Tue, 11 Jun 2019 09:45:31 +0000
Subject: Re: [PATCH 02/15] binfmt_flat: remove flat_set_persistent
Message-Id: <820932ef-bf45-d670-e9d6-979889d62501@arm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20190610212015.9157-1-hch@lst.de>
 <20190610212015.9157-3-hch@lst.de>
In-Reply-To: <20190610212015.9157-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>, Greg Ungerer <gerg@linux-m68k.org>
Cc: uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, linux-c6x-dev@linux-c6x.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On 6/10/19 10:20 PM, Christoph Hellwig wrote:
> This helper is a no-op on all architectures, remove it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm/include/asm/flat.h        | 1 -
>  arch/c6x/include/asm/flat.h        | 1 -
>  arch/h8300/include/asm/flat.h      | 1 -
>  arch/m68k/include/asm/flat.h       | 5 -----
>  arch/microblaze/include/asm/flat.h | 1 -
>  arch/sh/include/asm/flat.h         | 1 -
>  arch/xtensa/include/asm/flat.h     | 1 -
>  fs/binfmt_flat.c                   | 2 --
>  8 files changed, 13 deletions(-)
> 

For ARM bits:

Tested-by: Vladimir Murzin <vladimir.murzin@arm.com>
Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>


> diff --git a/arch/arm/include/asm/flat.h b/arch/arm/include/asm/flat.h
> index 10cce9ecf151..576241d74704 100644
> --- a/arch/arm/include/asm/flat.h
> +++ b/arch/arm/include/asm/flat.h
> @@ -31,6 +31,5 @@ static inline int flat_put_addr_at_rp(u32 __user *rp, u32 addr, u32 rel)
>  }
>  
>  #define	flat_get_relocate_addr(rel)		(rel)
> -#define	flat_set_persistent(relval, p)		0
>  
>  #endif /* __ARM_FLAT_H__ */
> diff --git a/arch/c6x/include/asm/flat.h b/arch/c6x/include/asm/flat.h
> index ecc6aea6606c..ac87368efad1 100644
> --- a/arch/c6x/include/asm/flat.h
> +++ b/arch/c6x/include/asm/flat.h
> @@ -18,6 +18,5 @@ static inline int flat_put_addr_at_rp(u32 __user *rp, u32 addr, u32 rel)
>  	return 0;
>  }
>  #define flat_get_relocate_addr(rel)			(rel)
> -#define flat_set_persistent(relval, p)			0
>  
>  #endif /* __ASM_C6X_FLAT_H */
> diff --git a/arch/h8300/include/asm/flat.h b/arch/h8300/include/asm/flat.h
> index dcc7775115dd..7ef7eefded3d 100644
> --- a/arch/h8300/include/asm/flat.h
> +++ b/arch/h8300/include/asm/flat.h
> @@ -10,7 +10,6 @@
>  
>  #define	flat_argvp_envp_on_stack()		1
>  #define	flat_old_ram_flag(flags)		1
> -#define	flat_set_persistent(relval, p)		0
>  
>  /*
>   * on the H8 a couple of the relocations have an instruction in the
> diff --git a/arch/m68k/include/asm/flat.h b/arch/m68k/include/asm/flat.h
> index a631caf5e18f..955617bb937b 100644
> --- a/arch/m68k/include/asm/flat.h
> +++ b/arch/m68k/include/asm/flat.h
> @@ -30,11 +30,6 @@ static inline int flat_put_addr_at_rp(u32 __user *rp, u32 addr, u32 rel)
>  }
>  #define	flat_get_relocate_addr(rel)		(rel)
>  
> -static inline int flat_set_persistent(u32 relval, u32 *persistent)
> -{
> -	return 0;
> -}
> -
>  #define FLAT_PLAT_INIT(regs) \
>  	do { \
>  		if (current->mm) \
> diff --git a/arch/microblaze/include/asm/flat.h b/arch/microblaze/include/asm/flat.h
> index 34be5ed011be..846084fa7f04 100644
> --- a/arch/microblaze/include/asm/flat.h
> +++ b/arch/microblaze/include/asm/flat.h
> @@ -15,7 +15,6 @@
>  
>  #define	flat_argvp_envp_on_stack()	0
>  #define	flat_old_ram_flag(flags)	(flags)
> -#define	flat_set_persistent(relval, p)		0
>  
>  /*
>   * Microblaze works a little differently from other arches, because
> diff --git a/arch/sh/include/asm/flat.h b/arch/sh/include/asm/flat.h
> index 8f2929b32f2e..6f3b18679a98 100644
> --- a/arch/sh/include/asm/flat.h
> +++ b/arch/sh/include/asm/flat.h
> @@ -25,7 +25,6 @@ static inline int flat_put_addr_at_rp(u32 __user *rp, u32 addr, u32 rel)
>  	return 0;
>  }
>  #define	flat_get_relocate_addr(rel)		(rel)
> -#define	flat_set_persistent(relval, p)		({ (void)p; 0; })
>  
>  #define FLAT_PLAT_INIT(_r) \
>    do { _r->regs[0]=0; _r->regs[1]=0; _r->regs[2]=0; _r->regs[3]=0; \
> diff --git a/arch/xtensa/include/asm/flat.h b/arch/xtensa/include/asm/flat.h
> index 6ee5a35eb0ec..b1bc0d9a8d4e 100644
> --- a/arch/xtensa/include/asm/flat.h
> +++ b/arch/xtensa/include/asm/flat.h
> @@ -18,6 +18,5 @@ static inline int flat_put_addr_at_rp(u32 __user *rp, u32 addr, u32 rel)
>  	return 0;
>  }
>  #define flat_get_relocate_addr(rel)			(rel)
> -#define flat_set_persistent(relval, p)			0
>  
>  #endif /* __ASM_XTENSA_FLAT_H */
> diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
> index afddea583999..a4c0b245ab1f 100644
> --- a/fs/binfmt_flat.c
> +++ b/fs/binfmt_flat.c
> @@ -787,8 +787,6 @@ static int load_flat_file(struct linux_binprm *bprm,
>  			if (get_user(relval, reloc + i))
>  				return -EFAULT;
>  			relval = ntohl(relval);
> -			if (flat_set_persistent(relval, &persistent))
> -				continue;
>  			addr = flat_get_relocate_addr(relval);
>  			rp = (u32 __user *)calc_reloc(addr, libinfo, id, 1);
>  			if (rp = (u32 __user *)RELOC_FAILED) {
> 
