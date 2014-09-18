From: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Date: Thu, 18 Sep 2014 05:24:28 +0000
Subject: Re: [PATCH] ARM: shmobile: Fix wrong calculation in shmobile_init_delay()
Message-Id: <541A6C8C.1050401@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5412A889.2000209@renesas.com>
In-Reply-To: <5412A889.2000209@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Ping ?

On 9/12/2014 5:02 PM, Khiem Nguyen wrote:
> The processing to get CPU information loop on all available CPUs
> and decide whether calculating preset_lpj for for CA15 or CA7/8/9.
> The calculation will go for CA7/8/9 prior to CA15.
> 
> The commit 0dc50fd ARM: shmobile: support Cortex-A7 in shmobile_init_delay()

As the commit 0dc50fd was already submitted in a PULL request for v3.18,
I think this patch should be considered/reviewed soon.

If this patch made sense, I think this patch should go to v3.18, too.
... or we will introduce a regression in v3.18, I guess.

Although I saw some minor issues in changelog,
I'd like to hear some comments before I sent v2. :)

> introduced wrong CPU selection in case CA15 and CA7/8/9 coexist, e.g R-CarH2.
> At the end, it leads to the wrong calculation of preset_lpj for R-CarH2.
> 
> Fix it by selecting the first CPU in DTS file.
> 
> Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
> ---
>  arch/arm/mach-shmobile/timer.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/timer.c b/arch/arm/mach-shmobile/timer.c
> index 87c6be1..9394cad 100644
> --- a/arch/arm/mach-shmobile/timer.c
> +++ b/arch/arm/mach-shmobile/timer.c
> @@ -59,10 +59,14 @@ void __init shmobile_init_delay(void)
>  
>  		if (of_device_is_compatible(np, "arm,cortex-a7") ||
>  		    of_device_is_compatible(np, "arm,cortex-a8") ||
> -		    of_device_is_compatible(np, "arm,cortex-a9"))
> +		    of_device_is_compatible(np, "arm,cortex-a9")) {
>  			is_a7_a8_a9 = true;
> -		else if (of_device_is_compatible(np, "arm,cortex-a15"))
> +			break;
> +		}
> +		else if (of_device_is_compatible(np, "arm,cortex-a15")) {
>  			is_a15 = true;
> +			break;
> +		}
>  	}
>  
>  	of_node_put(cpus);
> 

-- 
Best regards,
KHIEM Nguyen
