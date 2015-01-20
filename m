From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 20 Jan 2015 13:16:40 +0000
Subject: Re: [PATCH 0/2 v5] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE
Message-Id: <17156476.ZJmUQj3YaX@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87y4oyb4zu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y4oyb4zu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

Thank you for the patches.

On Tuesday 20 January 2015 01:43:29 Kuninori Morimoto wrote:
> Hi Vinod, Arnd, Simon
> 
> # I added Arnd
> 
> > These are Audio DMAC peri peri v4 patches.
> > 1) removes old drivers, and 2) replaces it.
> > These are based on vinod/topic/rcar
> > 
> > Kuninori Morimoto (2):
> > 	dmaengine: rcar-audmapp: independent from SH_DMAE_BASE v1
> > 	dmaengine: rcar-audmapp: independent from SH_DMAE_BASE v2
> 
> There is no response from Vinod about these patches.
> So, I re-send these again.
> 
> This time I added SoC/platform side setting patches too (= 3) - 6)).
> SoC/platform side setting needs many entries for this rcar-audmapp,
> because it has many combinations.
> But, I believe this is very normal DMAEngine style, not special.

Vinod commented on 22/12/2014 (Message-ID: <20141222151447.GL16827@intel.com>)

"I think this makes sense. Going thru the driver, it was clear that we were
not really gaining anything for using dmaengine API here. So agree that lets
use dmanegine for 1st dmac thru dmaengine library and then configure this in
your sound driver.."

My understanding is that a solution specific to the sound driver was 
preferred, instead of a generic DMA engine driver. Have I missed something ?

> Kuninori Morimoto (6):
>       1) dmaengine: rcar-audmapp: independent from SH_DMAE_BASE v1
>       2) dmaengine: rcar-audmapp: independent from SH_DMAE_BASE v2
>       3) ARM: shmobile: r8a7790: sound enables Audio DMAC entry on DTSI
>       4) ARM: shmobile: r8a7791: sound enables Audio DMAC entry on DTSI
>       5) ARM: shmobile: r8a7790: sound enables Audio DMAC peri peri entry on
> DTSI 6) ARM: shmobile: r8a7791: sound enables Audio DMAC peri peri entry on
> DTSI
> 
>  arch/arm/boot/dts/r8a7790.dtsi                 |  154 +++++++++
>  arch/arm/boot/dts/r8a7791.dtsi                 |  154 +++++++++
>  drivers/dma/sh/Kconfig                         |   13 +-
>  drivers/dma/sh/Makefile                        |    2 +-
>  drivers/dma/sh/rcar-audmapp.c                  |  420  ++++++++++----------
>  include/linux/platform_data/dma-rcar-audmapp.h |   34 --
>  6 files changed, 514 insertions(+), 263 deletions(-)

-- 
Regards,

Laurent Pinchart

