From: Simon Horman <horms@verge.net.au>
Date: Wed, 21 Aug 2013 08:50:35 +0000
Subject: Re: [PATCH 0/5] ARM: shmobile: bockw: add Sound support
Message-Id: <20130821085034.GG20014@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <874nb2jgc4.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874nb2jgc4.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Subject: Re: [PATCH 1/5] sh-pfc: r8a7778: add SRU/SSI pin support
Organisation: Horms Solutions Ltd.

[ CC Laurent and Linus ]

On Tue, Aug 06, 2013 at 09:05:34PM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> These patches add R-Car sound support on Bock-W board.
> It enables PIO transfer only at this point, because
>  1) PIO settings is the most easy basic settings
>  2) HPB-DMAC is still not enabled on r8a7778
> 
> R-Car sound driver is already supporting DMA transfer on ASoC (= Mark's) branch.
> So, it is easy to support DMA transfer if r8a7778 has HPB-DMAC support.
> 
> To enable R-Car sound on Bock-W board, ASoC branch mergeing is required
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
> :: asoc/topic/ak4554
> :: asoc/topic/rcar
> 
> These patches are based on renesas-devel-20130806v4
> 
> Kuninori Morimoto (5):
>       sh-pfc: r8a7778: add SRU/SSI pin support
>       ARM: shmobile: r8a7778: add SSI/SRU clock support
>       ARM: shmobile: bockw: enable global use of FPGA
>       ARM: shmobile: bockw: add R-Car sound support (PIO)
>       ARM: shmobile: bockw defconfig: add Sound support
> 
>  arch/arm/configs/bockw_defconfig       |    4 +
>  arch/arm/mach-shmobile/Kconfig         |    2 +
>  arch/arm/mach-shmobile/board-bockw.c   |  277 +++++++++++++++++++++++++++++++-
>  arch/arm/mach-shmobile/clock-r8a7778.c |   43 ++++-
>  drivers/pinctrl/sh-pfc/pfc-r8a7778.c   |  163 +++++++++++++++++++
>  5 files changed, 479 insertions(+), 10 deletions(-)

As per my separate email in response to "sh-pfc: r8a7778: add SRU/SSI pin
support", it seems that patch should be reviewed by Laurent and ideally
taken through Linus's tree.

With regards to the remaining patches, Magnus, could you cast an eye over them?


> 
> 
> ---- asoc/topic/ak4554 ---------------------
> commit b25f77815021ec6e7400a82c4984b9c80699ce80
> Author: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Date:   Thu Jul 4 19:42:49 2013 -0700
> 
>     ASoC: ak4554: add DT support
>     
>     Support for loading the ak4554 codec module via devicetree.
>     
>     Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>     Signed-off-by: Mark Brown <broonie@linaro.org>
> 
> ---- asoc/topic/rcar ------------------------
> commit 2460719c79854a3bebe569cbfbfa0b1caa1dc434
> Author: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Date:   Sun Jul 28 18:59:25 2013 -0700
> 
>     ASoC: rsnd: scu: cleanup empty functions
>     
>     This patch cleanups empty functions on scu
>     
>     Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>     Signed-off-by: Mark Brown <broonie@linaro.org>
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
