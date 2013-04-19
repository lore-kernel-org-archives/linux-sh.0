From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 19 Apr 2013 18:27:08 +0000
Subject: Re: [PATCH 3/6] ARM: shmobile: r8a7778: Register SDHI device
Message-Id: <51718C7C.2040705@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87bo9denxa.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bo9denxa.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 04/17/2013 09:17 AM, Kuninori Morimoto wrote:

> This patch adds SDHI register function which needs id number (= 0/1/2)
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   arch/arm/mach-shmobile/include/mach/r8a7778.h |    2 ++
>   arch/arm/mach-shmobile/setup-r8a7778.c        |   24 ++++++++++++++++++++++++
>   2 files changed, 26 insertions(+)
>
> diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
> index 68053fc..ae65b45 100644
> --- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
> +++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
> @@ -18,6 +18,7 @@
>   #ifndef __ASM_R8A7778_H__
>   #define __ASM_R8A7778_H__
>   
> +#include <linux/mmc/sh_mobile_sdhi.h>
>   #include <linux/sh_eth.h>
>   
>   extern void r8a7778_add_standard_devices(void);
> @@ -29,5 +30,6 @@ extern void r8a7778_init_irq_dt(void);
>   extern void r8a7778_clock_init(void);
>   extern void r8a7778_init_irq_extpin(int irlm);
>   extern void r8a7778_pinmux_init(void);
> +extern void r8a7778_sdhi_init(int id, struct sh_mobile_sdhi_info *info);

    You should have called the function r8a7778_add_sdhi_device() to be in
the same vein with already added registration functions. I'll prepare a
renaming patch if you don't beat me to it.

WBR, Sergei

