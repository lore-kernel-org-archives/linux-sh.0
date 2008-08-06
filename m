From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 06 Aug 2008 08:17:31 +0000
Subject: Re: [PATCH] Add PLAT_FLAT_INIT
Message-Id: <20080806081731.GD2610@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <48994E9C.7030102@renesas.com>
In-Reply-To: <48994E9C.7030102@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

[ adding a few CCs.. ]

On Wed, Aug 06, 2008 at 04:11:24PM +0900, Takashi Yoshii wrote:
> This patch adds FLAT_PLAT_INIT macro which initialize registers of
> new process, same as ELF_PLAT_INIT does.
> 
> It is needed because startup routine (crt1) expects r4 has meaningful
> value(even 0), though I can't find any ABI/specs around here.
> Anyway I believe registers has fixed value when a process starts.
> 
> # BTW. Where fs/binfmt_flat.c patch should be sent to ?
> 
> Signed-off-by: Takashi YOSHII <yoshii.takashi@renesas.com>
> ---
> arch/sh/include/asm/flat.h |    7 +++++++
> fs/binfmt_flat.c           |    4 +++-
> 2 files changed, 10 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/sh/include/asm/flat.h b/arch/sh/include/asm/flat.h
> index 0cc8002..d3b2b4f 100644
> --- a/arch/sh/include/asm/flat.h
> +++ b/arch/sh/include/asm/flat.h
> @@ -21,4 +21,11 @@
> #define	flat_get_relocate_addr(rel)		(rel)
> #define	flat_set_persistent(relval, p)		({ (void)p; 0; })
> 
> +#define FLAT_PLAT_INIT(_r) \
> +  do { _r->regs[0]=0; _r->regs[1]=0; _r->regs[2]=0; _r->regs[3]=0; \
> +       _r->regs[4]=0; _r->regs[5]=0; _r->regs[6]=0; _r->regs[7]=0; \
> +       _r->regs[8]=0; _r->regs[9]=0; _r->regs[10]=0; _r->regs[11]=0; \
> +       _r->regs[12]=0; _r->regs[13]=0; _r->regs[14]=0; \
> +       _r->sr = SR_FD; } while (0)
> +
> #endif /* __ASM_SH_FLAT_H */
> diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
> index c65d431..77ceae4 100644
> --- a/fs/binfmt_flat.c
> +++ b/fs/binfmt_flat.c
> @@ -914,7 +914,9 @@ static int load_flat_binary(struct linux_binprm * bprm, 
> struct pt_regs * regs)
> 	/* Stash our initial stack pointer into the mm structure */
> 	current->mm->start_stack = (unsigned long )sp;
> 
> -	
> +#ifdef FLAT_PLAT_INIT
> +	FLAT_PLAT_INIT(regs);
> +#endif
> 	DBG_FLT("start_thread(regs=0x%x, entry=0x%x, start_stack=0x%x)\n",
> 		(int)regs, (int)start_addr, (int)current->mm->start_stack);
> 	
> -- 
> 1.5.4.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
