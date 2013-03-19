From: Simon Horman <horms@verge.net.au>
Date: Tue, 19 Mar 2013 04:14:09 +0000
Subject: Re: [PATCH 0/2] ARM: shmobile: bockw: Reference DT implementation
Message-Id: <20130319041407.GD21444@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87sj4amjnn.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87sj4amjnn.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 04, 2013 at 10:43:12PM -0800, Kuninori Morimoto wrote:
> 
> Hi Simon, Magnus
> 
> Thank you for your help/advice
> 
> The problem was "memory size" on dts file.
> These are R-Car M1 / Bock-W DT support patches.

Magnus, what is your opinion on this mini-series?


For the record, I am awaiting fresh versions of all remaining
bockw/r8a7779 patches.


> 
> Kuninori Morimoto (2):
>       ARM: shmobile: r8a7778: add SoC DT support
>       ARM: shmobile: bockw: add DT reference
> 
>  arch/arm/boot/dts/Makefile                     |    1 +
>  arch/arm/boot/dts/r8a7778-bockw-reference.dts  |   32 ++++++++++
>  arch/arm/boot/dts/r8a7778.dtsi                 |   35 +++++++++++
>  arch/arm/mach-shmobile/Kconfig                 |   12 ++++
>  arch/arm/mach-shmobile/Makefile                |    1 +
>  arch/arm/mach-shmobile/board-bockw-reference.c |   80 ++++++++++++++++++++++++
>  arch/arm/mach-shmobile/include/mach/common.h   |    3 +
>  arch/arm/mach-shmobile/intc-r8a7778.c          |   27 ++++++--
>  arch/arm/mach-shmobile/setup-r8a7778.c         |   49 +++++++++++++--
>  9 files changed, 229 insertions(+), 11 deletions(-)
> 
> 
> This is my command for DT uImage
> 
> PC> make bockw_defconfig
> PC> make menuconfig
>    [Boot options]
>      - [Flattened Device Tree support]
>      - [Use appended device tree blob to zImage (EXPERIMENTAL)]
>    [System Type]
>      - [BOCK-W platform - Reference Device Tree Implementation]
> 
> PC> make zImage
> PC> make dtbs
> PC> duImage r8a7778-bockw-reference
> PC> cp arch/sh/boot/duImage ${PATH}
> 
> ---- duImage --------------------------------
> #! /bin/sh
> 
> # create zImage + dtb = dzImage
> cat arch/arm/boot/zImage arch/arm/boot/dts/${1}.dtb > arch/arm/boot/dzImage
> 
> # create duImage
> DUIMAGE=`cut -f 3- -d ' ' < arch/arm/boot/.uImage.cmd | sed -e "s/zImage/dzImage/" | sed -e "s/uImage/duImage/"`
> ${DUIMAGE}%
> ----------------------------------------------
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
