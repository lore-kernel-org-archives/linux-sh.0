From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 06 May 2014 10:45:32 +0000
Subject: Re: [PATCH] drivers: sh: compile drivers/sh/pm_runtime.c if ARCH_SHMOBILE_MULTI
Message-Id: <5368BD4C.1000002@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1398906582-29888-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1398906582-29888-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 01/05/14 02:09, Geert Uytterhoeven wrote:
> If the kernel is built to support multi-ARM configuration with shmobile
> support built in, then drivers/sh is not built. This contains the PM
> runtime code in drivers/sh/pm_runtime.c, which implicitly enables the
> module clocks for all devices, and thus is quite essential.
> Without this, the state of clocks depends on implicit reset state, or on
> the bootloader.
>
> If ARCH_SHMOBILE_MULTI then build the drivers/sh directory, but ensure that
> bits that may conflict (drivers/sh/clk if the common clock framework is
> enabled) or are not used (drivers/sh/intc), are not built.
> Also, only enable the PM runtime code when actually running on a shmobile
> SoCs that needs it.
>
> ARCH_SHMOBILE_MULTI was added a while ago by commit
> efacfce5f8a523457e9419a25d52fe39db00b26a ("ARM: shmobile: Introduce
> ARCH_SHMOBILE_MULTI"), but drivers/sh was compiled for both
> ARCH_SHMOBILE_LEGACY and ARCH_SHMOBILE_MULTI until commit
> bf98c1eac1d4a6bcf00532e4fa41d8126cd6c187 ("ARM: Rename ARCH_SHMOBILE to
> ARCH_SHMOBILE_LEGACY").
>
> Inspired by a patch from Ben Dooks <ben.dooks@codethink.co.uk>.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This is a minimal solution to fix the issue for multi-platform shmobile
> kernels in a multi-platform-friendly way.
> As it touches drivers/sh-specific code only, Simom should still be able to
> get it in v3.15, and backported to v3.14-stable.
>
> This is an RFC for several reasons:
>    1. I'm at ELC, and away from my hardware to test it properly (also on
>       non-shmobile).
>    2. Can we already reduce the list of SoCs to check for?
>       E.g. is this needed for emev2, which doesn't have MSTP clocks?

 From what I remember the EMEV2 does have hardware clock gates for
IP, just not the same way as the newer SoCs have. I have not tried
any newer kernels with this as the project I was on which used this
device is no-longer going.

> v3:
>    - Add of_machine_is_compatible() checks for multi-platform
>    - Remove Reviewed-by, Tested-by, as too much has changed,
>    - Assumed authorship, as not much is left from the original patch from
>      Ben (Ben: is that OK?),

Yes, that would fine. It looks like there is enough changes to
drop that. Thanks for sorting this out.

> -static int __init sh_pm_runtime_init(void)
> +static bool default_pm_on;
> +
> +int __init sh_pm_runtime_init(void)
>   {
> +#ifdef CONFIG_ARCH_SHMOBILE_MULTI
> +	if (!of_machine_is_compatible("renesas,emev2") &&
> +	    !of_machine_is_compatible("renesas,r7s72100") &&
> +	    !of_machine_is_compatible("renesas,r8a73a4") &&
> +	    !of_machine_is_compatible("renesas,r8a7740") &&
> +	    !of_machine_is_compatible("renesas,r8a7778") &&
> +	    !of_machine_is_compatible("renesas,r8a7779") &&
> +	    !of_machine_is_compatible("renesas,r8a7790") &&
> +	    !of_machine_is_compatible("renesas,r8a7791") &&
> +	    !of_machine_is_compatible("renesas,sh7372") &&
> +	    !of_machine_is_compatible("renesas,sh73a0"))
> +		return 0;
> +#endif

Is there a more generic compatible that could be matched on?

Could we do an if (IS_ENABLED(CONFIG_ARCH_SHMOBILE_MULTI)) instead
of an #ifdef block?

> +
> +	default_pm_on = true;
>   	pm_clk_add_notifier(&platform_bus_type, &platform_bus_notifier);
>   	return 0;
>   }
> @@ -59,7 +76,9 @@ core_initcall(sh_pm_runtime_init);
>
>   static int __init sh_pm_runtime_late_init(void)
>   {
> -	pm_genpd_poweroff_unused();
> +	if (default_pm_on)
> +		pm_genpd_poweroff_unused();
>   	return 0;
>   }
> +
>   late_initcall(sh_pm_runtime_late_init);
>


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
