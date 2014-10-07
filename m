From: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Date: Tue, 07 Oct 2014 00:50:01 +0000
Subject: Re: [PATCH] ARM: shmobile: Handle CA7 arch timer delay
Message-Id: <543338B9.8010308@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20141005235920.3532.40364.sendpatchset@w520>
In-Reply-To: <20141005235920.3532.40364.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus-san,



Thanks for your patch.



I have 2 points to confirm.

Please kindly share your opinions.
On 10/6/2014 8:59 AM, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Update the delay code to include arch timer checks
> for CA7. From a arch timer availability perspective
> CA7 should be treated same as CA15.

> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  Written against renesas-devel-20141002-v3.17-rc7
> 
>  arch/arm/mach-shmobile/timer.c |   23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> --- 0001/arch/arm/mach-shmobile/timer.c
> +++ work/arch/arm/mach-shmobile/timer.c	2014-10-06 08:44:21.000000000 +0900
> @@ -45,6 +45,7 @@ void __init shmobile_init_delay(void)
>  	struct device_node *np, *cpus;
>  	bool is_a7_a8_a9 = false;
>  	bool is_a15 = false;
> +	bool has_arch_timer = false;
>  	u32 max_freq = 0;
>  
>  	cpus = of_find_node_by_path("/cpus");
> @@ -57,12 +58,16 @@ void __init shmobile_init_delay(void)
>  		if (!of_property_read_u32(np, "clock-frequency", &freq))
>  			max_freq = max(max_freq, freq);
>  
> -		if (of_device_is_compatible(np, "arm,cortex-a7") ||
> -		    of_device_is_compatible(np, "arm,cortex-a8") ||
> -		    of_device_is_compatible(np, "arm,cortex-a9"))
> +		if (of_device_is_compatible(np, "arm,cortex-a8") ||
> +		    of_device_is_compatible(np, "arm,cortex-a9")) {
>  			is_a7_a8_a9 = true;
> -		else if (of_device_is_compatible(np, "arm,cortex-a15"))
> +		} else if (of_device_is_compatible(np, "arm,cortex-a7")) {
> +			is_a7_a8_a9 = true;
> +			has_arch_timer = true;
> +		} else if (of_device_is_compatible(np, "arm,cortex-a15")) {
>  			is_a15 = true;
> +			has_arch_timer = true;

Because has_arch_timer set true here, below delay setting for a15 will never be entered.
However, before this patch, it will be executed in case CONFIG_ARM_ARCH_TIMER is disable.
Is it your intention ?

> +		}
>  	}
>  
>  	of_node_put(cpus);
> @@ -70,10 +75,12 @@ void __init shmobile_init_delay(void)
>  	if (!max_freq)
>  		return;
>  
> -	if (is_a7_a8_a9)
> -		shmobile_setup_delay_hz(max_freq, 1, 3);
> -	else if (is_a15 && !IS_ENABLED(CONFIG_ARM_ARCH_TIMER))
> -		shmobile_setup_delay_hz(max_freq, 2, 4);
> +	if (!has_arch_timer || !IS_ENABLED(CONFIG_ARM_ARCH_TIMER)) {

Above condition checking will apply to all cortex cores, including a8 and a9.
However, before this patch, delay setting will be set for a8 and a9, 
regardless of CONFIG_ARM_ARCH_TIMER.
Is it your intention ?

> +		if (is_a7_a8_a9)
> +			shmobile_setup_delay_hz(max_freq, 1, 3);
> +		else if (is_a15)
> +			shmobile_setup_delay_hz(max_freq, 2, 4);
> +	}
>  }
>  
>  static void __init shmobile_late_time_init(void)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Best regards,
KHIEM Nguyen
