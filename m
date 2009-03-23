From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Mon, 23 Mar 2009 15:35:07 +0000
Subject: Re: [PATCH][RFC] sh: suspend interpreter V1
Message-Id: <49C7AC2B.9050702@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090323091739.25647.6773.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090323091739.25647.6773.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus
I think I understood how your system works.

Tell me if I'm wrong...

It seems all your instructions accepts zero of at least one argument and 
all the ' 1: bra 1f'  are used to preload.

The main issue, I see, is that there is no conditional statement possible.

I tryed to build something like:

void while_eq(unsigned long *add, unsigned long mask, unsigned long addr)
{
    for (; ((*add) & mask) != value; );
}

but

sh_pm_op(info, SH_PM_OP_MOV_MEM32_R0, _ADDR_);
sh_pm_op(info, SH_PM_OP_AND_IMM_R0,  _MASK_);
sh_pm_op(info, SH_PM_OP_CMP_R0, _VALUE));
sh_pm_op(info, SH_PM_OP_BT, __LABEL__);

On 'SH_PM_OP_CMP_R0' it isn't really a problem... It could be build like 
the other instruction...

While on 'SH_PM_OP_BT' it could be a problem because we don't know the 
'label' address... but I think it
 could be resolved if the sh_pm_op() instead of void returns the address 
of just assembled operation
 therefore I should be able to build something like:

addr = sh_pm_op(info, SH_PM_OP_MOV_MEM32_R0, _ADDR_);
sh_pm_op(info, SH_PM_OP_AND_IMM_R0,  _MASK_);
sh_pm_op(info, SH_PM_OP_CMP_R0, _VALUE));
sh_pm_op(info, SH_PM_OP_BT, addr); /* to jump backward... */

Something similar could be done to jump forward... also in this case the 
'jump' should
  be marked in a first phase as incomplete...  and resolved when all the 
code is built.

At least in a first release the jump forward could be not supported.

Let me know if I'm wrong and if do you agree.

Ciao
 Francesco

> From: Magnus Damm <damm@igel.co.jp>
>
> Hi Francesco, everyone,
>
> Here comes my first suspend interpreter attempt. This patch
> contains a mix of both generic and superh mobile stuff.
> It has only been dry coded so it probably is full of bugs.
> The main point of interest are probably the SH_PM_OP_xxx ops.
>
> The code in sleep.S is generic, so it should be moved out of
> the shmobile directory in the future. The same goes for the
> op defines and the structure, and for sh_pm_op(), sh_pm_run(),
> sh_pm_init() and sh_pm_cleanup().
>
> Start looking at sh_mobile_pm_setup(). The setup() callback is
> used to build the code. The run callback will be used to execute
> the built code, but it is unused so far. The old code in sleep.S
> is still used, but with a little bit more of hacking it should be
> possible to switch over. Not sure what to do about the VBR table
> though.
>
> Comments? Shall I keep on adding code, or start a rewrite? =)
>
> Francesco, I suppose you will need more ops?
>
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
>
>  arch/sh/kernel/cpu/shmobile/pm.c    |  162 +++++++++++++++++++++++++++++++++++
>  arch/sh/kernel/cpu/shmobile/sleep.S |  109 +++++++++++++++++++++++
>  2 files changed, 271 insertions(+)
>
> --- 0001/arch/sh/kernel/cpu/shmobile/pm.c
> +++ work/arch/sh/kernel/cpu/shmobile/pm.c	2009-03-23 18:00:51.000000000 +0900
> @@ -16,6 +16,167 @@
>  #include <asm/suspend.h>
>  #include <asm/uaccess.h>
>  
> +#define SH_PM_OP_IMM_OFFS 8
> +#define SH_PM_OP_JMP_OFFS 12
> +#define SH_PM_OP_SIZE 16
> +
> +#define SH_PM_OP_MOV_IMM_R0	0
> +#define SH_PM_OP_MOV_MEM8_R0	1
> +#define SH_PM_OP_MOV_MEM16_R0	2
> +#define SH_PM_OP_MOV_MEM32_R0	3
> +#define SH_PM_OP_MOV_R0_MEM8	4
> +#define SH_PM_OP_MOV_R0_MEM16	5
> +#define SH_PM_OP_MOV_R0_MEM32	6
> +#define SH_PM_OP_AND_IMM_R0	7
> +#define SH_PM_OP_OR_IMM_R0	8
> +#define SH_PM_OP_ADD_IMM_R0	9
> +#define SH_PM_OP_SLEEP		10
> +#define SH_PM_OP_RTS		11
> +#define SH_PM_OP_NR		12
> +
> +extern unsigned char sh_pm_op_base[SH_PM_OP_SIZE * SH_PM_OP_NR];
> +
> +struct sh_pm_op_info {
> +	unsigned char *buf;
> +	unsigned int nr_ops;
> +	void (*setup)(struct sh_pm_op_info *);
> +	void (*run)(struct sh_pm_op_info *);
> +};
> +
> +static void sh_pm_op(struct sh_pm_op_info *info, int op, unsigned int data)
> +{
> +	unsigned int size = SH_PM_OP_SIZE;
> +	unsigned char *buf = info->buf;
> +
> +	if (buf) {
> +		buf += info->nr_ops * size;
> +		memcpy(buf, &sh_pm_op_base[op * size], size);
> +		*(unsigned int *)(buf + SH_PM_OP_IMM_OFFS) = data;
> +	}
> +	info->nr_ops++;
> +}
> +
> +static void sh_pm_run(struct sh_pm_op_info *info)
> +{
> +	void (*snippet)(void);
> +
> +	/* preload in cache */
> +	snippet = (void *)(info->buf + SH_PM_OP_JMP_OFFS);
> +	snippet();
> +
> +	/* execute in cache */
> +	snippet = (void *)info->buf;
> +	snippet();
> +}
> +
> +int sh_pm_mode_init(struct sh_pm_op_info *info)
> +{
> +	/* run once without buffer to calculate amount of memory needed */
> +	info->buf = NULL;
> +	info->nr_ops = 0;
> +	info->setup(info);
> +
> +	info->buf = kmalloc(info->nr_ops * SH_PM_OP_SIZE, GFP_KERNEL);
> +	if (!info->buf)
> +		return -ENOMEM;
> +
> +	/* run second time with buffer to generate actual code */
> +	info->nr_ops = 0;
> +	info->setup(info);
> +	return 0;
> +}
> +
> +void sh_pm_mode_cleanup(struct sh_pm_op_info *info)
> +{
> +	kfree(info->buf);
> +}
> +
> +/* "sleep" mode */
> +
> +static void sh_mobile_pm_stbcr_setup(struct sh_pm_op_info *info,
> +				     unsigned int mode)
> +{
> +	sh_pm_op(info, SH_PM_OP_MOV_IMM_R0, mode);
> +	sh_pm_op(info, SH_PM_OP_MOV_R0_MEM32, 0xa4150020); /* STBCR */
> +}
> +
> +static void sh_mobile_pm_sleep_setup(struct sh_pm_op_info *info)
> +{
> +	/* make sure STBCR is cleared, execute sleep, return */
> +	sh_mobile_pm_stbcr_setup(info, 0);
> +	sh_pm_op(info, SH_PM_OP_SLEEP, 0);
> +	sh_pm_op(info, SH_PM_OP_RTS, 0);
> +}
> +
> +static struct sh_pm_op_info sh_mobile_pm_sleep = {
> +	.setup = sh_mobile_pm_sleep_setup,
> +	.run = sh_pm_run,
> +};
> +
> +/* "sleep" mode with system memory in self-refresh */
> +
> +static void sh_mobile_pm_sf_suspend(struct sh_pm_op_info *info)
> +{
> +	/* SDRAM: disable power down and put in self-refresh mode */
> +	sh_pm_op(info, SH_PM_OP_MOV_MEM32_R0, 0xfe400008); /* SDCR0 */
> +	sh_pm_op(info, SH_PM_OP_OR_IMM_R0, 0x00000400);
> +	sh_pm_op(info, SH_PM_OP_AND_IMM_R0, 0xffff7fff);
> +	sh_pm_op(info, SH_PM_OP_MOV_R0_MEM32, 0xfe400008); /* SDCR0 */
> +}
> +
> +static void sh_mobile_pm_sf_restore(struct sh_pm_op_info *info)
> +{
> +	/* SDRAM: put back in auto-refresh mode */
> +	sh_pm_op(info, SH_PM_OP_MOV_MEM32_R0, 0xfe400008); /* SDCR0 */
> +	sh_pm_op(info, SH_PM_OP_AND_IMM_R0, 0xfffffbff);
> +	sh_pm_op(info, SH_PM_OP_MOV_R0_MEM32, 0xfe400008); /* SDCR0 */
> +	sh_pm_op(info, SH_PM_OP_MOV_MEM32_R0, 0xfe40001c); /* RTCOR */
> +	sh_pm_op(info, SH_PM_OP_ADD_IMM_R0, (unsigned int)-1);
> +	sh_pm_op(info, SH_PM_OP_OR_IMM_R0, 0xa55a0000);
> +	sh_pm_op(info, SH_PM_OP_MOV_R0_MEM32, 0xfe400018); /* RTCNT */
> +}
> +
> +static void sh_mobile_pm_sleep_sf_setup(struct sh_pm_op_info *info)
> +{
> +	/* setup self-refresh, clear STBCR, execute sleep, restore */
> +	sh_mobile_pm_sf_suspend(info);
> +	sh_mobile_pm_stbcr_setup(info, 0);
> +	sh_pm_op(info, SH_PM_OP_SLEEP, 0);
> +	sh_mobile_pm_sf_restore(info);
> +	sh_pm_op(info, SH_PM_OP_RTS, 0);
> +}
> +
> +static struct sh_pm_op_info sh_mobile_pm_sleep_sf = {
> +	.setup = sh_mobile_pm_sleep_sf_setup,
> +	.run = sh_pm_run,
> +};
> +
> +/* "standby" mode with system memory in self-refresh */
> +
> +static void sh_mobile_pm_standby_sf_setup(struct sh_pm_op_info *info)
> +{
> +	/* setup self-refresh, set STBCR, execute sleep, restore */
> +	sh_mobile_pm_sf_suspend(info);
> +	sh_mobile_pm_stbcr_setup(info, 0x80);
> +	sh_pm_op(info, SH_PM_OP_SLEEP, 0);
> +	sh_mobile_pm_stbcr_setup(info, 0);
> +	sh_mobile_pm_sf_restore(info);
> +	sh_pm_op(info, SH_PM_OP_RTS, 0);
> +}
> +
> +static struct sh_pm_op_info sh_mobile_pm_standby_sf = {
> +	.setup = sh_mobile_pm_standby_sf_setup,
> +	.run = sh_pm_run,
> +};
> +
> +
> +static void sh_mobile_pm_setup(void)
> +{
> +	sh_pm_mode_init(&sh_mobile_pm_sleep);
> +	sh_pm_mode_init(&sh_mobile_pm_sleep_sf);
> +	sh_pm_mode_init(&sh_mobile_pm_standby_sf);
> +}
> +
>  /*
>   * Sleep modes available on SuperH Mobile:
>   *
> @@ -85,6 +246,7 @@ static struct platform_suspend_ops sh_pm
>  
>  static int __init sh_pm_init(void)
>  {
> +	sh_mobile_pm_setup();
>  	suspend_set_ops(&sh_pm_ops);
>  	return 0;
>  }
> --- 0001/arch/sh/kernel/cpu/shmobile/sleep.S
> +++ work/arch/sh/kernel/cpu/shmobile/sleep.S	2009-03-23 17:24:34.000000000 +0900
> @@ -123,3 +123,112 @@ sh_mobile_standby_end:
>  
>  ENTRY(sh_mobile_standby_size)
>  	.long sh_mobile_standby_end - sh_mobile_standby
> +
> +ENTRY(sh_pm_op_base)
> +sh_pm_op_mov_imm_r0:		/* @ SH_PM_OP_MOV_IMM_R0 * SH_PM_OP_SIZE */
> +	mov.l	0f, r0
> +	bra	2f
> +	 nop
> +	nop
> +0:	.long	0
> +1:	bra	1f
> +	 nop
> +
> +sh_pm_op_mov_mem8_r0:		/* @ SH_PM_OP_MOV_MEM8_R0 * SH_PM_OP_SIZE */
> +2:	mov.l	0f, r1
> +	bra	2f
> +	 mov.b	@r1, r0
> +	nop
> +0:	.long	0
> +1:	bra	1f
> +	 nop
> +
> +sh_pm_op_mov_mem16_r0:		/* @ SH_PM_OP_MOV_MEM16_R0 * SH_PM_OP_SIZE */
> +2:	mov.l	0f, r1
> +	bra	2f
> +	 mov.w	@r1, r0
> +	nop
> +0:	.long	0
> +1:	bra	1f
> +	 nop
> +
> +sh_pm_op_mov_mem32_r0:		/* @ SH_PM_OP_MOV_MEM32_R0 * SH_PM_OP_SIZE */
> +2:	mov.l	0f, r1
> +	bra	2f
> +	 mov.l	@r1, r0
> +	nop
> +0:	.long	0
> +1:	bra	1f
> +	 nop
> +
> +sh_pm_op_mov_r0_mem8:		/* @ SH_PM_OP_MOV_R0_MEM8 * SH_PM_OP_SIZE */
> +2:	mov.l	0f, r1
> +	bra	2f
> +	 mov.b	r0, @r1
> +	nop
> +0:	.long	0
> +1:	bra	1f
> +	 nop
> +
> +sh_pm_op_mov_r0_mem16:		/* @ SH_PM_OP_MOV_R0_MEM16 * SH_PM_OP_SIZE */
> +2:	mov.l	0f, r1
> +	bra	2f
> +	 mov.w	r0, @r1
> +	nop
> +0:	.long	0
> +1:	bra	1f
> +	 nop
> +
> +sh_pm_op_mov_r0_mem32:		/* @ SH_PM_OP_MOV_R0_MEM32 * SH_PM_OP_SIZE */
> +2:	mov.l	0f, r1
> +	bra	2f
> +	 mov.l	r0, @r1
> +	nop
> +0:	.long	0
> +1:	bra	1f
> +	 nop
> +
> +sh_pm_op_and_imm_r0:		/* @ SH_PM_OP_AND_IMM_R0 * SH_PM_OP_SIZE */
> +2:	mov.l	0f, r1
> +	bra	2f
> +	 and	r1, r0
> +	nop
> +0:	.long	0
> +1:	bra	1f
> +	 nop
> +
> +sh_pm_op_or_imm_r0:		/* @ SH_PM_OP_OR_IMM_R0 * SH_PM_OP_SIZE */
> +2:	mov.l	0f, r1
> +	bra	2f
> +	 or	r1, r0
> +	nop
> +0:	.long	0
> +1:	bra	1f
> +	 nop
> +
> +sh_pm_op_add_imm_r0:		/* @ SH_PM_OP_ADD_IMM_R0 * SH_PM_OP_SIZE */
> +2:	mov.l	0f, r1
> +	bra	2f
> +	 add	r1, r0
> +	nop
> +0:	.long	0
> +1:	bra	1f
> +	 nop
> +
> +sh_pm_op_sleep:			/* @ SH_PM_OP_SLEEP * SH_PM_OP_SIZE */
> +2:	sleep
> +	bra	2f
> +	 nop
> +	nop
> +0:	.long	0
> +1:	bra	1f
> +	 nop
> +
> +sh_pm_op_rts:			/* @ SH_PM_OP_RTS * SH_PM_OP_SIZE */
> +2:	rts
> +	 nop
> +	nop
> +	nop
> +0:	.long	0
> +1:	rts
> +	 nop
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>   

