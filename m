From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 20 Jan 2015 09:58:15 +0000
Subject: Re: [PATCH 0/8 v2] dmaengine: shdma: use normal interface for passing slave id
Message-Id: <CAPDyKFpr_QqPf78kE5HbHn5JGx+-sqs=eL+9nL=erGqu5OfwAA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87lhkyaxzs.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87lhkyaxzs.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 20 January 2015 at 05:14, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> Hi Vinod
> Cc Arnd, Ulf, Brian, Mark
>
> These are v2 of shdma-base fixup patches.
> Original patch came from Arnd, and, I tidyuped/tested on real board.
>
> Arnd
>         can you please check these patches ?
>
> Brian
>         can you please check 2) these patches ?
>
> Ulf
>         can you please check 5) 6) patches ?

I will.

>
> Mark
>         can you please check 3) 4) 7) 8) patches ?
>
> I don't know who/how to merge these patches, but,

I am not sure what dependency there are  between all the patches. I
would be easiest to handle them separately if possible.

> 5) 6) patches needs Vinod's next branch and Ulf's next branch.

I have shared the following immutable branch for tmio. Don't pull my
next branch, since I rebase it.

git.linaro.org/people/ulf.hansson/mmc.git tmio

>
> Arnd Bergmann (4):
>       1) dmaengine: shdma: use normal interface for passing slave id
>       2) mtd: sh_flctl: remove slave_id settings for DMAEngine
>       3) spi: rspi: remove slave_id settings for DMAEngine
>       4) spi: sh-msiof: remove slave_id settings for DMAEngine
>
> Kuninori Morimoto (4):
>       5) mmc: sh_mmcif: remove slave_id settings for DMAEngine
>       6) mmc: tmio_mmc: remove slave_id settings for DMAEngine
>       7) ASoC: fsi: remove slave_id settings for DMAEngine
>       8) ASoC: rsnd: remove slave_id settings for DMAEngine
>
>  drivers/dma/sh/shdma-base.c       |   73 +++++++++++++++++++++++++++----------
>  drivers/mmc/host/sh_mmcif.c       |   12 +++---
>  drivers/mmc/host/sh_mobile_sdhi.c |    2 -
>  drivers/mmc/host/tmio_mmc.h       |    2 -
>  drivers/mmc/host/tmio_mmc_dma.c   |    4 --
>  drivers/mtd/nand/sh_flctl.c       |    2 -
>  drivers/spi/spi-rspi.c            |    1 -
>  drivers/spi/spi-sh-msiof.c        |    1 -
>  include/linux/shdma-base.h        |    1 +
>  sound/soc/sh/fsi.c                |    3 +-
>  sound/soc/sh/rcar/core.c          |    3 +-
>  11 files changed, 61 insertions(+), 43 deletions(-)
>
>
> Best regards
> ---
> Kuninori Morimoto

Kind regards
Uffe
