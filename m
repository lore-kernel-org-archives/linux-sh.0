From: Simon Horman <horms@verge.net.au>
Date: Fri, 01 Mar 2013 06:53:07 +0000
Subject: Re: [PATCH 1/3] ARM: shmobile: armadillo800eva: enable all errata for cache on defconfig
Message-Id: <20130301065305.GB14376@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1346808893-14124-2-git-send-email-horms@verge.net.au>
In-Reply-To: <1346808893-14124-2-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Feb 22, 2013 at 02:58:57PM -0800, Simon Horman wrote:
> On Thu, Feb 21, 2013 at 08:45:57PM -0800, Kuninori Morimoto wrote:
> > Some errata for cache had not enabled on current
> > Armadillo800eva defconfig.
> > This patch enables these.
> > Special thanks to Ishiyama-san
> 
> It seems to me that it would be better to handle these in Kconfig
> to enable them on an SoC or board basis.
> 
> The reason is that I would like to move away from per-board defconfigs
> and towards a more consolidated defconfig. And in that case it will
> be more difficult to know which ERRATA are needed for each board and SoC.
> 
> Obviously this thinking is open to review and it implies that
> several board defconfigs should be updated.

Ping.

> 
> > 
> > Reported-by: Kiyoshi Ishiyama <kiyoshi.ishiyama.wg@renesas.com>
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> >  arch/arm/configs/armadillo800eva_defconfig |    5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
> > index 2e1a825..891318e 100644
> > --- a/arch/arm/configs/armadillo800eva_defconfig
> > +++ b/arch/arm/configs/armadillo800eva_defconfig
> > @@ -25,10 +25,15 @@ CONFIG_CACHE_L2X0=y
> >  CONFIG_ARM_ERRATA_430973=y
> >  CONFIG_ARM_ERRATA_458693=y
> >  CONFIG_ARM_ERRATA_460075=y
> > +CONFIG_PL310_ERRATA_588369=y
> >  CONFIG_ARM_ERRATA_720789=y
> > +CONFIG_PL310_ERRATA_727915=y
> >  CONFIG_ARM_ERRATA_743622=y
> >  CONFIG_ARM_ERRATA_751472=y
> > +CONFIG_PL310_ERRATA_753970=y
> >  CONFIG_ARM_ERRATA_754322=y
> > +CONFIG_PL310_ERRATA_769419=y
> > +CONFIG_ARM_ERRATA_775420=y
> >  CONFIG_AEABI=y
> >  # CONFIG_OABI_COMPAT is not set
> >  CONFIG_FORCE_MAX_ZONEORDER
> > -- 
> > 1.7.9.5
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
