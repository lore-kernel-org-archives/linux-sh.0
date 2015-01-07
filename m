From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 07 Jan 2015 02:52:15 +0000
Subject: Re: [PATCH resend 0/3] ARM: shmobile: dts sound updates
Message-Id: <87egr7paij.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1420574513-15135-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1420574513-15135-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Geert, Simon

> This patch series updates/cleans up SoC-specific bindings in dts
> files.
> 
> It was sent before as part of a larger series, of which the
> ASoC-specific parts have been applied by the ASoC maintainer.
> 
> Thanks for applying!
> 
> Geert Uytterhoeven (3):
>   ARM: shmobile: sh73a0 dtsi: Add SoC-specific FSI2 compatible property
>   ARM: shmobile: r8a7790 dtsi: Drop "renesas,rcar_sound" compatible
>     value
>   ARM: shmobile: r8a7791 dtsi: Drop "renesas,rcar_sound" compatible
>     value
> 
>  arch/arm/boot/dts/r8a7790.dtsi | 2 +-
>  arch/arm/boot/dts/r8a7791.dtsi | 2 +-
>  arch/arm/boot/dts/sh73a0.dtsi  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

For all patches

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Best regards
---
Kuninori Morimoto
