From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Date: Mon, 17 Mar 2014 11:43:23 +0000
Subject: Re: [Linux-kernel] [RFC 5/6] drivers: move drivers/sh/pm_runtime.c to drivers/base
Message-Id: <1395056603.12161.122.camel@xylophone>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, 2014-03-17 at 11:15 +0000, Ben Dooks wrote:
> Move the drivers/sh/pm_runtime.c code to drivers/base as it may be of
> use to any systems that need some generic platformbus power management.
[...]
> --- /dev/null
> +++ b/drivers/base/pm_runtime_platform.c
[...]
> +#if defined(CONFIG_ARCH_SHMOBILE_LEGACY) || defined(CONFIG_SH)
> +core_initcall(platformbus_pm_runtime_init);
> +#endif

It looks like this bit is actually needed in patch 2/6.  I'm not sure
how these different platform config symbols are used, though.

[...]
> --- a/drivers/sh/pm_runtime.c
> +++ /dev/null
[...]
> -int __init sh_pm_runtime_init(void)
> -{
> -	default_pm_on = true;
> -	pm_clk_add_notifier(&platform_bus_type, &platform_bus_notifier);
> -	return 0;
> -}
[...]

This appears to break SHMobile until 6/6 "ARM: shmobile: change to use
platformbus_pm_runtime_init" is also applied.  They should be folded
together.

Ben.


