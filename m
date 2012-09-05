From: Simon Horman <horms@verge.net.au>
Date: Wed, 05 Sep 2012 08:39:50 +0000
Subject: Re: [PATCH 1/3] ARM: shmobile: sh73a0: Select ERRATAs in Kconfig
Message-Id: <20120905083950.GA3645@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1346832708-7369-1-git-send-email-koba@kmckk.co.jp>
In-Reply-To: <1346832708-7369-1-git-send-email-koba@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Sep 05, 2012 at 05:20:49PM +0900, Tetsuyuki Kobayashi wrote:
> I am sorry, I missed subject. This patch is not 1/3, but only one.
> The correct subject is:
> 
> [PATCH] ARM: shmobile: sh73a0: Select ERRATAs in Kconfig

Thanks, noted.

> 
> (2012/09/05 17:11), Tetsuyuki Kobayshi wrote:
> > From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
> > 
> > SH73a0 SoC has Cortex-A9 core which revision is r2p8.
> > This patch selects ERRATAs for this revision in Kconfig file.

Magnus, Morimoto-san, do you have an opinion on this?

> > Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
> > ---
> >   arch/arm/mach-shmobile/Kconfig |    7 +++++++
> >   1 file changed, 7 insertions(+)
> > 
> > diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
> > index 4cacc2d..a80836c 100644
> > --- a/arch/arm/mach-shmobile/Kconfig
> > +++ b/arch/arm/mach-shmobile/Kconfig
> > @@ -28,6 +28,13 @@ config ARCH_SH73A0
> >   	select ARCH_WANT_OPTIONAL_GPIOLIB
> >   	select ARM_GIC
> >   	select I2C
> > +	select ARM_ERRATA_743622
> > +	select ARM_ERRATA_751472
> > +	select ARM_ERRATA_754322
> > +	select ARM_ERRATA_764369
> > +	select PL310_ERRATA_588369 if CACHE_PL310
> > +	select PL310_ERRATA_727915 if CACHE_PL310
> > +	select PL310_ERRATA_769419 if CACHE_PL310
> >   
> >   config ARCH_R8A7740
> >   	bool "R-Mobile A1 (R8A77400)"
> > 
> 
