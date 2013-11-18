From: Simon Horman <horms@verge.net.au>
Date: Mon, 18 Nov 2013 07:09:23 +0000
Subject: Re: [PATCH 0/3] ARM: shmobile: bockw: DMAEngine support for sound
Message-Id: <20131118070921.GF27935@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87iovq77a0.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87iovq77a0.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Nov 17, 2013 at 06:50:19PM -0800, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> These patches add DMAEngine support for sound
> These need...
> 
>  - linus/master branch merge (sound driver update)
>  - HPB-DMAC fixup patches (remove noise issue)
>  - my previous patch (DMAEngile stall issue)

Thanks. At some stage I will need a branch to use as a base.
Either something that Mark has deemed as not to be rebased.
Or an -rc from Linus.

> 
> I guess #1 patch needs Mark's Acked-by

Yes. Or perhaps the patch could be split somehow.
A rcar_snd.h portion for Mark to take.
And then a follow-up mach-shmobile portion for me to take
(possibly much later).

> 
> Kuninori Morimoto (3):
>       ARM: shmobile: bockw: remove unused RSND_SSI_CLK_FROM_ADG
>       ARM: shmobile: r8a7778: add HPBIFx DMAEngine support
>       ARM: shmobile: bockw: DMAEngine support for sound
> 
>  arch/arm/mach-shmobile/board-bockw.c          |   22 +++++++----
>  arch/arm/mach-shmobile/include/mach/r8a7778.h |   18 +++++++++
>  arch/arm/mach-shmobile/setup-r8a7778.c        |   51 +++++++++++++++++++++++++
>  include/sound/rcar_snd.h                      |    1 -
>  4 files changed, 84 insertions(+), 8 deletions(-)
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
