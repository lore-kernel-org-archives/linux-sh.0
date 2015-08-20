From: Simon Horman <horms@verge.net.au>
Date: Thu, 20 Aug 2015 18:01:42 +0000
Subject: Re: [PATCH 02/16 v5][RFC] arm64: renesas: Add new Renesas R-Car Gen3 SoC Kconfig
Message-Id: <20150820180140.GB21446@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87614reqrb.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87614reqrb.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 20, 2015 at 06:27:42AM +0000, Kuninori Morimoto wrote:
> 
> Hi Geert
> 
> > > +config ARCH_RCAR_GEN3
> > > +       bool "Renesas R-Car Gen3 SoC Platform"
> > > +       select ARCH_SHMOBILE
> > > +       help
> > > +         This enables support for Renesas SoC.
> > > +
> > 
> > Please insert ARCH_RCAR_GEN3 before ARCH_ROCKCHIP to keep
> > sort order. However...
> 
> OK, thanks
> 
> > >  config ARCH_SEATTLE
> > >         bool "AMD Seattle SoC Family"
> > >         help
> > >           This enables support for AMD Seattle SOC Family
> > >
> > > +config ARCH_SHMOBILE
> > > +       bool
> > > +
> > 
> > shouldn't we have ARCH_SHMOBILE first, and make ARCH_RCAR_GEN3
> > depend on it, cfr. what Tegra is doing (and everyone has been doing on 32-bit
> > arm)?
> 
> I'm not sure, but if we used alphabetical order, ARCH_SHMOBILE can be here
> I will keep this in v6

Geerts suggestion sounds reasonable to me.
