From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 14 Jul 2015 00:40:49 +0000
Subject: Re: [PATCH 0/4 v2][RFC] arm64: Renesas Gen3 initial patch
Message-Id: <87d1zvbml9.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <878uazm9gu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878uazm9gu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Geert

> >> Gaku Inami (3):
> >>       clk: shmobile: add Renesas R-Car Gen3 CPG support
> >>       arm64: Add new Renesas R-Car Gen3 SoC Kconfig
> >>       arm64: renesas: Add initial r8a7795 SoC support
> >>
> >> Kuninori Morimoto (1):
> >>       arm64: defconfig: Enable Renesas R-Car Gen3 SoC in defconfig
> >>
> >>  Documentation/devicetree/bindings/arm/shmobile.txt                       |   2 +
> >>  Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt |  31 ++++++++++++
> >>  drivers/clk/shmobile/clk-rcar-gen3.c                                     | 232 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  include/dt-bindings/clock/r8a7795-clock.h                                |  31 ++++++++++++
> >>  10 files changed, 409 insertions(+)
> 
> If possible, I would like to have support for the "CPG/MSTP Clock Domain"
> from the beginning, to avoid having to break DTS compatibility.

OK, thank you for your help
So, let's keep this patch-set as [RFC] until then :)
Is this OK for you ?
Or can I post these patch-set except CPG/MSTP ?
