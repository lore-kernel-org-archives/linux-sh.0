From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 02 Feb 2015 20:49:32 +0000
Subject: Re: [PATCH] ARM: shmobile: silk: initial device tree
Message-Id: <54CFE2DC.10100@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
 <1608366.HtA9yBksdO@wasted.cogentembedded.com>
In-Reply-To: <1608366.HtA9yBksdO@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 01/31/2015 01:52 AM, Sergei Shtylyov wrote:

> Add the initial device tree for the R8A7794 SoC based SILK low cost board.
> SCIF2 serial port support is included, so that the serial console can work.

> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> ---
> This patch is against the 'renesas-devel-20150129-v3.19-rc6' tag of Simon
> Horman's 'renesas.git' repo.
>
>   arch/arm/boot/dts/Makefile         |    1
>   arch/arm/boot/dts/r8a7794-silk.dts |   41 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 42 insertions(+)
>
> Index: renesas/arch/arm/boot/dts/Makefile
> =================================> --- renesas.orig/arch/arm/boot/dts/Makefile
> +++ renesas/arch/arm/boot/dts/Makefile
> @@ -421,6 +421,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += eme
>   	r8a7791-koelsch.dtb \
>   	r8a7791-porter.dtb \

    Oops, the patch was additionally against the Henninger->Porter rename 
patch. I will fix that.

>   	r8a7794-alt.dtb \
> +	r8a7794-silk.dtb \
>   	sh73a0-kzm9g.dtb

WBR, Sergei

