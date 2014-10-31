From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Fri, 31 Oct 2014 00:00:35 +0000
Subject: Re: [PATCH 05/11] ARM: shmobile: lager: Sound PIO support on DTS
Message-Id: <87y4rx2jne.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87d29ax8rf.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87d29ax8rf.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Geert

> > -- a/arch/arm/mach-shmobile/Kconfig
> > +++ b/arch/arm/mach-shmobile/Kconfig
> > @@ -77,6 +77,7 @@ config MACH_LAGER
> >         bool "Lager board"
> >         depends on ARCH_R8A7790
> >         select MICREL_PHY if SH_ETH
> > +       select SND_SOC_AK4642 if SND_SIMPLE_CARD
> 
> I know there's a long history of putting this into Kconfig.
> 
> However, once Lager becomes multi-platform-only without board file,
> there will be no MACH_LAGER Kconfig option anymore, and you will have
> to add SND_SOC_AK4642=y to the shmobile_defconfig anyway.
> 
> So I think it's better to add it to shmobile_defconfig now, so it won't be
> forgotten.

Inded, good catch !
Will fix in v2 patch-set

Best regards
---
Kuninori Morimoto
