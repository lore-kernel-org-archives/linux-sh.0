From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Date: Mon, 17 Mar 2014 11:35:17 +0000
Subject: Re: [Linux-kernel] [RFC 2/6] shmobile: prepare to allow export of sh_pm_runtime_init()
Message-Id: <1395056117.12161.117.camel@xylophone>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, 2014-03-17 at 11:15 +0000, Ben Dooks wrote:
> In a multi-platform kernel, we cannot simply add this as a initcall
> as it may be built and run on archtiectures other than the SHMOBILE
> so export the sh_pm_runtime_init() call to be used from the machine
> specific code.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  drivers/sh/pm_runtime.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/sh/pm_runtime.c b/drivers/sh/pm_runtime.c
> index 5cfbd82..f4f8851 100644
> --- a/drivers/sh/pm_runtime.c
> +++ b/drivers/sh/pm_runtime.c
> @@ -42,16 +42,19 @@ static struct pm_clk_notifier_block platform_bus_notifier = {
>  	.con_ids = { NULL, },
>  };
>  
> -static int __init sh_pm_runtime_init(void)
> +static bool default_pm_on;
> +
> +int __init sh_pm_runtime_init(void)
>  {
> +	default_pm_on = true;
>  	pm_clk_add_notifier(&platform_bus_type, &platform_bus_notifier);
>  	return 0;
>  }
> -core_initcall(sh_pm_runtime_init);

This appears to break initialisation until 4/6 "ARM: shmobile: r8a7790:
call sh_pm_runtime_init()" is applied.  I think patches 2-4 must all be
folded together.

Ben.

>  static int __init sh_pm_runtime_late_init(void)
>  {
> -	pm_genpd_poweroff_unused();
> +	if (default_pm_on)
> +		pm_genpd_poweroff_unused();
>  	return 0;
>  }
>  late_initcall(sh_pm_runtime_late_init);


