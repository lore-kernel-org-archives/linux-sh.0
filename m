From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Wed, 09 May 2012 22:48:13 +0000
Subject: Re: [PATCH] mach-shmobile: Use preset_lpj with calibrate_delay()
Message-Id: <201205100048.13290.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <20120509071107.18870.37448.sendpatchset@w520>
In-Reply-To: <20120509071107.18870.37448.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wednesday, May 09, 2012, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Update the mach-shmobile shared delay calibration code for late
> timers. All existing in-tree non-DT socs are however using early
> timers today and they are unaffected by this change.
> 
> The patch modifies shmobile_setup_delay() from using lpj_fine
> to preset_lpj. This change allows us to preset the worst case
> loops-per-jiffy value to all CPU cores on the system.
> 
> The old code which made use of lpj_fine did not affect the 
> secondary CPU cores which made it impossible to boot on SMP
> without early timers.
> 
> Needed for SMP SoCs using late timers like EMEV2 or any other
> mach-shmobile SMP SoC that makes use of late timers via DT.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Applied to the soc branch of the renesas.git tree.

Thanks,
Rafael


> ---
> 
>  arch/arm/mach-shmobile/timer.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- 0003/arch/arm/mach-shmobile/timer.c
> +++ work/arch/arm/mach-shmobile/timer.c	2012-05-08 18:56:03.000000000 +0900
> @@ -36,7 +36,8 @@ void __init shmobile_setup_delay(unsigne
>  
>  	unsigned int value = (1000000 * mult) / (HZ * div);
>  
> -	lpj_fine = max_cpu_core_mhz * value;
> +	if (!preset_lpj)
> +		preset_lpj = max_cpu_core_mhz * value;
>  }
>  
>  static void __init shmobile_late_time_init(void)
> 
> 

