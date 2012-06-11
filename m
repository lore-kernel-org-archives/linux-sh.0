From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 11 Jun 2012 03:59:27 +0000
Subject: Re: [PATCH 03/27] ARM: shmobile: shareing extra gpio setting functions
Message-Id: <20120611035927.GE10170@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87ipeyqzdr.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ipeyqzdr.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Jun 10, 2012 at 08:52:03PM -0700, Kuninori Morimoto wrote:
> diff --git a/arch/arm/mach-shmobile/include/mach/gpio.h b/arch/arm/mach-shmobile/include/mach/gpio.h
> index de795b4..7c1e4ab 100644
> --- a/arch/arm/mach-shmobile/include/mach/gpio.h
> +++ b/arch/arm/mach-shmobile/include/mach/gpio.h
> @@ -13,6 +13,7 @@
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
>  #include <linux/sh_pfc.h>
> +#include <asm/io.h>
>  
>  #ifdef CONFIG_GPIOLIB
>  
Minor nit, but please use linux/ headers when they are available.
