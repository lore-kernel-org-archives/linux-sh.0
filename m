From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 21 Jan 2015 12:58:46 +0000
Subject: Re: [PATCH 0/4 v2] ARM: shmobile: r8a779x: add SDHI DMA support
Message-Id: <1788343.5n1qrCgcHl@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <873874oj1q.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <873874oj1q.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

Thank you for the patches.

On Wednesday 21 January 2015 04:26:03 Kuninori Morimoto wrote:
> Hi Simon
> 
> These are v2 of SDHI DMA support for r8a7790/r8a7791.
> These are based on Ulf's
> git.linaro.org/people/ulf.hansson/mmc.git tmio
> 
> Kuninori Morimoto (4):
>       ARM: shmobile: r8a7790: tidyup SDHI register size on DTSI
>       ARM: shmobile: r8a7791: tidyup SDHI register size on DTSI
>       ARM: shmobile: r8a7790: add SDHI DMA channels on DTSI
>       ARM: shmobile: r8a7791: add SDHI DMA channels on DTSI

I've already submitted patches 3 and 4 a few months ago, as

ARM: shmobile: r8a7790: Reference DMA channels in SDHI DT nodes
ARM: shmobile: r8a7790: Reference DMA channels in SDHI DT nodes

You had tested them back then, and reported a performance regression. Has that 
been fixed ?

>  arch/arm/boot/dts/r8a7790.dtsi |   12 ++++++++++--
>  arch/arm/boot/dts/r8a7791.dtsi |    8 +++++++-
>  2 files changed, 17 insertions(+), 3 deletions(-)

-- 
Regards,

Laurent Pinchart

