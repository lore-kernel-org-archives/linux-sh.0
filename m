From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 30 Sep 2015 19:08:33 +0000
Subject: Re: [PATCH] ARM: shmobile: porter: initial device tree
Message-Id: <560C3331.3030606@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
 <2022535.FYlSB7sRz4@wasted.cogentembedded.com>
In-Reply-To: <2022535.FYlSB7sRz4@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 09/30/2015 02:26 AM, Sergei Shtylyov wrote:

> Add the initial device tree for the R8A7791 SoC based Porter low cost board
> (which  is a  slightly modified version  of the Henninger board).
>
> SCIF0 serial port support is included, so that the serial console can work.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
> This patch is against the 'renesas-devel-20150928-v4.3-rc3' tag of Simon
> Horman's 'renesas.git' repo.

    Forgot to mention I had to disable USB-DMAC.

> Index: renesas/arch/arm/boot/dts/r8a7791-porter.dts
> =================================> --- /dev/null
> +++ renesas/arch/arm/boot/dts/r8a7791-porter.dts
> @@ -0,0 +1,54 @@
> +/*
> + * Device Tree Source for the Porter board
> + *
> + * Copyright (C) 2015 Cogent Embedded, Inc.
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +/dts-v1/;
> +#include "r8a7791.dtsi"
> +
> +/ {
> +	model = "Porter";
> +	compatible = "renesas,porter", "renesas,r8a7791";
> +
> +	aliases {
> +		serial0 = &scif0;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttySC0,115200 ignore_loglevel";

    Oops, scratch that. I thought I removed console= but I forgot to refresh 
the patch. :-/

MBR, Sergei

