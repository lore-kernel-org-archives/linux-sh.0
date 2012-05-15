From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Tue, 15 May 2012 17:37:02 +0000
Subject: Re: [PATCH 0/2] ARM: mach-shmobile: KZM9G SMP support
Message-Id: <201205151937.02915.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <87ehqspl59.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ehqspl59.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tuesday, May 15, 2012, Kuninori Morimoto wrote:
> 
> Hi Magnus, Simon
> 
> > > --------------------------------------------------
> > > commit e2c31b3fdd48274e9deb450e21279e54dfa02ccd
> > > Author: Magnus Damm <damm@opensource.se>
> > > Date:   Tue Jan 17 20:10:49 2012 +0900
> > >
> > >    ARM: mach-shmobile: sh73a0 IRQ sparse alloc fix
> > > --------------------------------------------------
> > >
> > > It seems interrupt numbering issue.
> > > intc_pint0_desc and IRQ17 - IRQ31 are using same irq number.
> > > Magnus, how to solve this issue ?
> > 
> > I'm not sure which way is best right now, but can you please try to
> > fix it yourself? Take a piece of paper, write down the IRQ ranges that
> > are being used by Linux. If there are any collision then please try to
> > use some unused area.
> 
> I checked again this issue
> 
> At first, below patch modify INTCS_VECT_BASE from 0x2200 to 0x3400.
> Then, IRQ16-IRQ31 interrupt number will be 800.
> 
> --------------------------------------------------------
> commit 1ee8299a9ec1ce5137a044c7768293007b9a3267
> Author: Magnus Damm <damm@opensource.se>
> Date:   Wed Mar 28 19:22:54 2012 +0900
> 
>     ARM: mach-shmobile: Use 0x3400 as INTCS vector offset
>     
>     Update mach-shmobile to use 0x3400 as INTCS_VECT_BASE.
> --------------------------------------------------------
> 
> And, below patch modify PINT IRQ base nuber from 768 to 800.
> Then, conflict happen around 800.
> 
> --------------------------------------------------------
> commit 0df1a838d678fc6ab49f983a19e905f6a42297a0
> Author: Magnus Damm <damm@opensource.se>
> Date:   Tue Jan 17 20:05:40 2012 +0900
> 
>     ARM: mach-shmobile: sh73a0 PINT IRQ base fix
>     
>     Bump up the sh73a0 PINT IRQ base from 768 to 800 to avoid
>     collision with INTCS vectors for IRQ16->IRQ32 at 0x3xxx.
> --------------------------------------------------------
> 
> If I revert 1ee8299a9ec1ce5137a044c7768293007b9a3267 commit,
> or, if I added this patch, it start works without WARNING.

Can you repost the patch below with a changelog, please?

Rafael


> ---------------------------
> diff --git a/arch/arm/mach-shmobile/include/mach/sh73a0.h b/arch/arm/mach-shmobi
> index ac75857..a418518 100644
> --- a/arch/arm/mach-shmobile/include/mach/sh73a0.h
> +++ b/arch/arm/mach-shmobile/include/mach/sh73a0.h
> @@ -519,7 +519,7 @@ enum {
>  };
>  
>  /* PINT interrupts are located at Linux IRQ 800 and up */
> -#define SH73A0_PINT0_IRQ(irq) ((irq) + 800)
> -#define SH73A0_PINT1_IRQ(irq) ((irq) + 832)
> +#define SH73A0_PINT0_IRQ(irq) ((irq) + 700)
> +#define SH73A0_PINT1_IRQ(irq) ((irq) + 732)
>  
>  #endif /* __ASM_SH73A0_H__ */
> ---------------------------
> 
> 
> Best regards
> ---
> Kuninori Morimoto
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

