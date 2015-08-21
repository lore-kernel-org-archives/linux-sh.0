From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 21 Aug 2015 00:20:24 +0000
Subject: Re: [PATCH 02/16 v5][RFC] arm64: renesas: Add new Renesas R-Car Gen3 SoC Kconfig
Message-Id: <87fv3dbin1.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87614reqrb.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87614reqrb.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon, Geert

> > > shouldn't we have ARCH_SHMOBILE first, and make ARCH_RCAR_GEN3
> > > depend on it, cfr. what Tegra is doing (and everyone has been doing on 32-bit
> > > arm)?
> > 
> > I'm not sure, but if we used alphabetical order, ARCH_SHMOBILE can be here
> > I will keep this in v6
> 
> Geerts suggestion sounds reasonable to me.

Sorry, I was misunderstood about this.
If we keep alphabetical order for ARCH_SHMOBILE and ARCH_RCAR_GEN3,
and uses "depends on", the menuconfig will be

	[*] Renesas R-Car Gen3 SoC Platform
	[ ] xxx
	[ ] xxx
	[*] Renesas SoC Family
	[ ] xxx

but we want to have this ?

	[ ] xxx
	[*] Renesas SoC Family
	[*]   Renesas R-Car Gen3 SoC Platform
	[ ] xxx
