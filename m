From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Wed, 26 Mar 2014 00:02:07 +0000
Subject: Re: [PATCH 0/6] ARM: shmobile: r8a7778/r8a7790: use new style sound data
Message-Id: <87mwgdn7yf.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87ior2dhp9.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87ior2dhp9.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon

I will re-post these patches after merge window

> Next R-Car sound driver supports new style platform data
> which is required for DT support.
> We need switch to new style on platform.
> Current sound driver has new/old style compatibility,
> but, I would like to remove old style compatibility immediately.
> I can do it if these patches are accepted.
> 
> These patches are based on...
> 
>     1) Simon's renesas-devel-v3.14-rc7-20140324
>     2) Mark's  asoc/topic/rcar
>     3) Mark's  asoc/topic/simple
>     4) Mark's  asoc/fix/rcar
> 
> Simon, can you use 2) branch for these patches ?
> 3) is needed to use sound, but not needed for compile.
> 4) will goes to linus/master soon
> 
> I would like to ask Mark to use cross brach between Simon's tree.
> Is it possible ?
> 
> Kuninori Morimoto (6):
>       ARM: lager: fixup SND_SOC_DAIFMT_CBx_CFx flags
>       ARM: shmobile: r8a7778: remove old style audio clock
>       ARM: shmobile: r8a7790: remove old style audio clock
>       ARM: shmobile: bockw: remove old style audio clock
>       ARM: shmobile: bockw: switch to use dai info for R-Car sound
>       ARM: shmobile: lager: switch to use dai info for R-Car sound
> 
>  arch/arm/mach-shmobile/board-bockw.c   |   63 +++++++++++++++++++++-----------
>  arch/arm/mach-shmobile/board-lager.c   |   21 +++++++----
>  arch/arm/mach-shmobile/clock-r8a7778.c |   22 +++++------
>  arch/arm/mach-shmobile/clock-r8a7790.c |   24 +++++-------
>  4 files changed, 73 insertions(+), 57 deletions(-)
