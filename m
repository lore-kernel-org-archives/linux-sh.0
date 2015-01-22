From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 22 Jan 2015 11:21:00 +0000
Subject: Re: [PATCH 0/4 v3] ARM: shmobile: r8a779x: add SDHI DMA support
Message-Id: <1709094.MctbBK8tX8@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87ppa7lanl.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ppa7lanl.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

Thank you for the patches.

On Thursday 22 January 2015 04:07:52 Kuninori Morimoto wrote:
> Hi Simon
> 
> These are v3 of SDHI DMA support for r8a7790/r8a7791.
> These are based on Ulf's
> git.linaro.org/people/ulf.hansson/mmc.git tmio
> 
> Kuninori Morimoto (2):
>       ARM: shmobile: r8a7790: tidyup SDHI register size on DTSI
>       ARM: shmobile: r8a7791: tidyup SDHI register size on DTSI
> 
> Laurent Pinchart (2):
>       ARM: shmobile: r8a7790: Reference DMA channels in SDHI DT nodes
>       ARM: shmobile: r8a7791: Reference DMA channels in SDHI DT nodes
> 
>  arch/arm/boot/dts/r8a7790.dtsi |   12 ++++++++++--
>  arch/arm/boot/dts/r8a7791.dtsi |    8 +++++++-
>  2 files changed, 17 insertions(+), 3 deletions(-)

For the whole series,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart

