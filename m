From: Simon Horman <horms@verge.net.au>
Date: Mon, 14 Apr 2014 03:56:12 +0000
Subject: Re: [PATCH 0/7] ARM: shmobile: swtich audio settings to new style, and remove compatibility code fro
Message-Id: <20140414035610.GC1948@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87sipg20h1.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87sipg20h1.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: broonie@kernel.org, Magnus <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org

On Sun, Apr 13, 2014 at 05:55:56PM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon, Mark
> 
> Now, Linux v3.15-rc1 was released.
> 1) - 5) remove old style audio settings from platform, and

Thanks, I have queued these up for v3.16.

> 6) - 7) remove compatibility (= old style) code from driver.
>

> These are based on v3.15-rc1
> Simon, can you please create v3.15-rc1 base branch/tag for Mark ?

The safest thing would be for me to wait until after the arm-soc
maintainers have pulled my branches. Otherwise there is a very
real chance that they will ask me to rebase something that Mark
is relying on. And that would be awkward to say the least.

> Kuninori Morimoto (7):
>       1) ARM: shmobile: r8a7778: remove old style audio clock
>       2) ARM: shmobile: r8a7790: remove old style audio clock
>       3) ARM: shmobile: bockw: remove old style audio clock
>       4) ARM: shmobile: bockw: switch to use dai info for R-Car sound
>       5) ARM: shmobile: lager: switch to use dai info for R-Car sound
>       6) ASoC: rsnd: remove old clock style support
>       7) ASoC: rsnd: remove compatibility code
> 
>  arch/arm/mach-shmobile/board-bockw.c   |   63 +++++++++++++++++++----------
>  arch/arm/mach-shmobile/board-lager.c   |   17 +++++---
>  arch/arm/mach-shmobile/clock-r8a7778.c |   22 +++++-----
>  arch/arm/mach-shmobile/clock-r8a7790.c |   24 +++++------
>  include/sound/rcar_snd.h               |   22 ++--------
>  sound/soc/sh/rcar/adg.c                |   39 ++----------------
>  sound/soc/sh/rcar/core.c               |   54 +++++--------------------
>  sound/soc/sh/rcar/rsnd.h               |    3 --
>  sound/soc/sh/rcar/src.c                |   69 ++++++++++----------------------
>  sound/soc/sh/rcar/ssi.c                |   51 +----------------------
>  10 files changed, 111 insertions(+), 253 deletions(-)
> 
> 
> Best regards
> ---
> Kuninori Morimoto
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
