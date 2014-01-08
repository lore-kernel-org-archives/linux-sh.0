From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Wed, 08 Jan 2014 02:50:14 +0000
Subject: Re: [PATCH 0/2] ARM: shmobile: r8a7790: add Audio-DMAC support
Message-Id: <877gabxk4c.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1386935560-16739-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1386935560-16739-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> > These patches add Audio DMAC support on r8a7790.
> > These are used from R-Car sound driver.
> > 
> > Current Simon's branch doesn't have R-Car
> > sound driver support, since it needs ASoC branch merge.
> > (= it has Gen2 support)
> > But, this DMAEngine support can be applied without
> > sound driver support.
> > 
> > These are based on renesas-devel-v3.13-rc5-20131230 tag
> 
> Thanks Morimoto-san.
> 
> Is it appropriate to update the koelsch defconfig to enable DMAEngine?
> 
> If so could you please supply a patch?

Current lager_defconfig (not koelsch :) already have DMAEngine support

PC> grep CONFIG_SH_DMAE arch/arm/configs/lager_defconfig
CONFIG_SH_DMAE=y

Best regards
---
Kuninori Morimoto
