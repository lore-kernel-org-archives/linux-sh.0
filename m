From: Simon Horman <horms@verge.net.au>
Date: Tue, 24 Jul 2012 01:20:28 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: Add compilation support for dtbs using 'make dtbs'
Message-Id: <20120724012027.GJ22631@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1343033857-9053-1-git-send-email-koba@kmckk.co.jp>
In-Reply-To: <1343033857-9053-1-git-send-email-koba@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jul 23, 2012 at 05:57:37PM +0900, Tetsuyuki Kobayshi wrote:
> From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
> 
> Add compilation support for dtbs using 'make dtbs'

I see the following with this patch applied to the next branch
of Rafael's renesas tree.

# make armadillo800eva_defconfig
# make dtb
make[1]: *** No rule to make target `arch/arm/boot/r8a7740-armadillo800eva.dts', needed by `arch/arm/boot/dtbs'.  Stop.
make: *** [dtbs] Error 2

> Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Cc: Simon Horman <horms@verge.net.au>
> Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
> ---
>  arch/arm/mach-shmobile/Makefile.boot |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-shmobile/Makefile.boot b/arch/arm/mach-shmobile/Makefile.boot
> index 498efd9..a1227ce 100644
> --- a/arch/arm/mach-shmobile/Makefile.boot
> +++ b/arch/arm/mach-shmobile/Makefile.boot
> @@ -7,3 +7,7 @@ __ZRELADDR	:= $(shell /bin/bash -c 'printf "0x%08x" \
>  #
>  #params_phys-y (Instead: Pass atags pointer in r2)
>  #initrd_phys-y (Instead: Use compiled-in initramfs)
> +
> +dtb-$(CONFIG_MACH_KZM9G) += sh73a0-kzm9g.dtb
> +dtb-$(CONFIG_MACH_KZM9D) += emev2-kzm9d.dts
> +dtb-$(CONFIG_MACH_ARMADILLO800EVA) += r8a7740-armadillo800eva.dts
> -- 
> 1.7.9.5
> 
