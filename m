From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 Aug 2020 09:09:46 +0000
Subject: Re: [PATCH 1/1] sh: add support for cmpxchg on u8 and u16 pointers
Message-Id: <CAMuHMdVYeAqLHuW2fjQk7HQbnGJhY7YJcksMddn_6Cp61cd-AQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200819030511.1114-1-liambeguin@gmail.com>
In-Reply-To: <20200819030511.1114-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Liam Beguin <liambeguin@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>

Hi Liam,

On Wed, Aug 19, 2020 at 5:07 AM Liam Beguin <liambeguin@gmail.com> wrote:
> The kernel test bot reported[1] that using set_mask_bits on a u8 causes
> the following issue on SuperH:
>
>     >> ERROR: modpost: "__cmpxchg_called_with_bad_pointer" [drivers/phy/ti/phy-tusb1210.ko] undefined!
>
> Add support for cmpxchg on u8 and u16 pointers.
>
> [1] https://lore.kernel.org/patchwork/patch/1288894/#1485536
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Liam Beguin <liambeguin@gmail.com>
> ---
>
> Hi,
>
> This was reported by the kernel test bot on an architecture I can't
> really test on. I was only able to make sure the build succeeds, but
> nothing more.
> This patch is based on the __cmpxchg_u32 impletmentation and seems
> incomplete based on the different cmpxchg headers I can find.

Indeed. This version is suitable for non-SMP machines only.
BTW, it looks like this version can be replaced by the one in asm-generic?

>
> Do these function need to be impletmented in each header
> simulataneously?

Yes, we need them for all variants.

>  arch/sh/include/asm/cmpxchg-irq.h | 27 +++++++++++++++++++++++++++
>  arch/sh/include/asm/cmpxchg.h     |  5 +++--
>  2 files changed, 30 insertions(+), 2 deletions(-)
>
> diff --git a/arch/sh/include/asm/cmpxchg-irq.h b/arch/sh/include/asm/cmpxchg-irq.h
> index 07d3e7f08389..918c4153a930 100644
> --- a/arch/sh/include/asm/cmpxchg-irq.h
> +++ b/arch/sh/include/asm/cmpxchg-irq.h
> @@ -51,4 +51,31 @@ static inline unsigned long __cmpxchg_u32(volatile int *m, unsigned long old,
>         return retval;
>  }
>
> +static inline unsigned long __cmpxchg_u16(volatile u16 *m, unsigned long old,
> +       unsigned long new)
> +{
> +       u16 retval;
> +       unsigned long flags;
> +
> +       local_irq_save(flags);
> +       retval = *m;
> +       if (retval = old)
> +               *m = new;
> +       local_irq_restore(flags);
> +       return (unsigned long)retval;
> +}
> +
> +static inline unsigned long __cmpxchg_u8(volatile u8 *m, unsigned long old,
> +       unsigned long new)
> +{
> +       u8 retval;
> +       unsigned long flags;
> +
> +       local_irq_save(flags);
> +       retval = *m;
> +       if (retval = old)
> +               *m = new;
> +       local_irq_restore(flags);
> +       return (unsigned long)retval;
> +}
>  #endif /* __ASM_SH_CMPXCHG_IRQ_H */
> diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxchg.h
> index e9501d85c278..7d65d0fd1665 100644
> --- a/arch/sh/include/asm/cmpxchg.h
> +++ b/arch/sh/include/asm/cmpxchg.h
> @@ -56,8 +56,9 @@ static inline unsigned long __cmpxchg(volatile void * ptr, unsigned long old,
>                 unsigned long new, int size)
>  {
>         switch (size) {
> -       case 4:
> -               return __cmpxchg_u32(ptr, old, new);
> +       case 4: return __cmpxchg_u32((int *)ptr, old, new);
> +       case 2: return __cmpxchg_u16((u16 *)ptr, old, new);
> +       case 1: return __cmpxchg_u8((u8 *)ptr, old, new);
>         }
>         __cmpxchg_called_with_bad_pointer();
>         return old;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
