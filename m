From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 07 Sep 2012 00:38:35 +0000
Subject: Re: [PATCH 1/3] ARM: shmobile: sh73a0: Select ERRATAs in Kconfig
Message-Id: <w3pharaoees.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1346832708-7369-1-git-send-email-koba@kmckk.co.jp>
In-Reply-To: <1346832708-7369-1-git-send-email-koba@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Simon, Kobayashi-san

> > > SH73a0 SoC has Cortex-A9 core which revision is r2p8.
> > > This patch selects ERRATAs for this revision in Kconfig file.
> 
> Magnus, Morimoto-san, do you have an opinion on this?

I guess this is first case in our code
to use "select" for ERRATA_xxx.
We used board defconfig for it.

> > > Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
> > > ---
> > >   arch/arm/mach-shmobile/Kconfig |    7 +++++++
> > >   1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
> > > index 4cacc2d..a80836c 100644
> > > --- a/arch/arm/mach-shmobile/Kconfig
> > > +++ b/arch/arm/mach-shmobile/Kconfig
> > > @@ -28,6 +28,13 @@ config ARCH_SH73A0
> > >   	select ARCH_WANT_OPTIONAL_GPIOLIB
> > >   	select ARM_GIC
> > >   	select I2C
> > > +	select ARM_ERRATA_743622
> > > +	select ARM_ERRATA_751472
> > > +	select ARM_ERRATA_754322
> > > +	select ARM_ERRATA_764369
> > > +	select PL310_ERRATA_588369 if CACHE_PL310
> > > +	select PL310_ERRATA_727915 if CACHE_PL310
> > > +	select PL310_ERRATA_769419 if CACHE_PL310
> > >   
> > >   config ARCH_R8A7740
> > >   	bool "R-Mobile A1 (R8A77400)"
> > > 
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


EC No. 11-TR0139 # Linux BSP
EC No. W         # public

Best regards
--
Kuninori Morimoto
 
