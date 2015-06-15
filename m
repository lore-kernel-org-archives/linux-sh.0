From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 15 Jun 2015 23:58:47 +0000
Subject: Re: [PATCH 6/6][RFC] arm64: defconfig: Enable Renesas R-Car Gen3 SoC in defconfig
Message-Id: <87h9q8jzgo.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87wpz5vaia.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wpz5vaia.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Magnus, Khiem-san

> >> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> >> index 866640b..b175c2a 100644
> >> --- a/arch/arm64/configs/defconfig
> >> +++ b/arch/arm64/configs/defconfig
> >> @@ -34,6 +34,7 @@ CONFIG_MODULE_UNLOAD=y
> >>   CONFIG_ARCH_EXYNOS7=y
> >>   CONFIG_ARCH_FSL_LS2085A=y
> >>   CONFIG_ARCH_MEDIATEK=y
> >> +CONFIG_ARCH_RCAR_GEN3=y
> >>   CONFIG_ARCH_SEATTLE=y
> >>   CONFIG_ARCH_TEGRA=y
> >>   CONFIG_ARCH_TEGRA_132_SOC=y
> >> @@ -102,6 +103,8 @@ CONFIG_SERIAL_8250_CONSOLE=y
> >>   CONFIG_SERIAL_8250_MT6577=y
> >>   CONFIG_SERIAL_AMBA_PL011=y
> >>   CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
> >> +CONFIG_SERIAL_SH_SCI=m
> >
> >
> > I wonder whether we can use built-in module, instead of dynamic module.
> > Is there any strong reason for using dynamic module ?
> 
> Thanks, I agree with your question. =)
> 
> Also, what I can tell it seems that the DTS does not include any SCIF
> nodes, so enabling the SCIF here in the defconfig seems a bit of a
> mismatch.

Ohh my..
=m was my mistake.

And the reason why this series doesn't have SCIF is
that emulator != real board.

Best regards
---
Kuninori Morimoto
