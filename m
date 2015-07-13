From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 13 Jul 2015 05:26:26 +0000
Subject: Re: [PATCH 0/4 v2][RFC] arm64: Renesas Gen3 initial patch
Message-Id: <874ml8fx6g.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <878uazm9gu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878uazm9gu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi SH-ML

No objection about these Gen3 prototype patches ?
If so, I will post these in SH-ML and ARM-ML as formal (= non RFC) patch set

> Gaku Inami (3):
>       clk: shmobile: add Renesas R-Car Gen3 CPG support
>       arm64: Add new Renesas R-Car Gen3 SoC Kconfig
>       arm64: renesas: Add initial r8a7795 SoC support
> 
> Kuninori Morimoto (1):
>       arm64: defconfig: Enable Renesas R-Car Gen3 SoC in defconfig
> 
>  Documentation/devicetree/bindings/arm/shmobile.txt                       |   2 +
>  Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt |  31 ++++++++++++
>  arch/arm64/Kconfig                                                       |   9 ++++
>  arch/arm64/boot/dts/Makefile                                             |   1 +
>  arch/arm64/boot/dts/renesas/Makefile                                     |   5 ++
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi                                 |  93 +++++++++++++++++++++++++++++++++++
>  arch/arm64/configs/defconfig                                             |   4 ++
>  drivers/clk/shmobile/Makefile                                            |   1 +
>  drivers/clk/shmobile/clk-rcar-gen3.c                                     | 232 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/dt-bindings/clock/r8a7795-clock.h                                |  31 ++++++++++++
>  10 files changed, 409 insertions(+)

Best regards
---
Kuninori Morimoto
