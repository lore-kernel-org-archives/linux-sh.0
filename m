From: Simon Horman <horms@verge.net.au>
Date: Tue, 09 Dec 2014 00:20:32 +0000
Subject: Re: [PATCH 11/12 v2] ARM: shmobile: multiplatform: add Audo DMAC peri peri support on defconfig
Message-Id: <20141209002029.GA8897@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87h9yl2ie3.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87h9yl2ie3.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Dec 08, 2014 at 04:37:03AM +0000, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> > v1 -> v2
> > 
> > - no change
> > 
> >  arch/arm/configs/shmobile_defconfig |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
> > index b32afae..a2de58e 100644
> > --- a/arch/arm/configs/shmobile_defconfig
> > +++ b/arch/arm/configs/shmobile_defconfig
> > @@ -145,6 +145,7 @@ CONFIG_RTC_CLASS=y
> >  CONFIG_RTC_DRV_S35390A=y
> >  CONFIG_DMADEVICES=y
> >  CONFIG_SH_DMAE=y
> > +CONFIG_RCAR_AUDMAC_PP=y
> >  CONFIG_RCAR_DMAC=y
> >  # CONFIG_IOMMU_SUPPORT is not set
> >  CONFIG_PWM=y
> 
> Is it possible to revert this patch from defconfig ?
> Current upstreamed Audio DMAC peri peri driver is based on SH_DMAE_BASE,
> but, it breaks DMAEngine handling.
> 
> I fix-uped this issue on below patch, but it is not yet accepted.
> 
> 	Subject: [PATCH][resend] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE
> 	Date: Fri, 28 Nov 2014 00:17:59 +0000
> 
> Above patches need this order
> [1/2] : dmaengine: rcar-audmapp: independent from SH_DMAE_BASE
> [2/2] : ARM: shmobile: multiplatform: add Audo DMAC peri peri support on defconfig
> 
> It seems that I2C driver is broken by this patch.
> I will re-send it if missing DMAEngine patch was accepted.

Hi Morimoto-san,

I believe this patch is not present in v3.18 (good) but has been accepted
by the ARM SoC maintainers for v3.19 (not so good).  In other words its
present in arm-soc/for-next and linux-next but not Linus's tree
(but may be soon).

Would you like me to submit a reversion of a fix-for-v3.19 to the ARM SoC
maintainers?
