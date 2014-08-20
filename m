From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 20 Aug 2014 07:28:36 +0000
Subject: Re: [PATCH 0/3 v2] clk: shmobile: clk: shmobile: add missing 0x0100 for SDCKCR
Message-Id: <8738cripr6.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <874mxql8eh.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <874mxql8eh.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon, Mike

Could you teach me current status of these patches ?

> These patches fixup hidden-bug for R-Car Gen2 clock.
> 
> Kuninori Morimoto (3):
>       clk: shmobile: add missing 0x0100 for SDCKCR
>       ARM: shmobile: r8a7790: add missing 0x0100 for SDCKCR
>       ARM: shmobile: r8a7791: add missing 0x0100 for SDCKCR
> 
>  arch/arm/mach-shmobile/clock-r8a7790.c |    4 ++--
>  arch/arm/mach-shmobile/clock-r8a7791.c |    2 +-
>  drivers/clk/shmobile/clk-rcar-gen2.c   |    1 +
>  3 files changed, 4 insertions(+), 3 deletions(-)
> 
> 
> Best regards
> ---
> Kuninori Morimoto
