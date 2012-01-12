From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Thu, 12 Jan 2012 23:48:09 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: fix A3SP suspend method
Message-Id: <201201130048.09751.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thursday, January 12, 2012, Guennadi Liakhovetski wrote:
> Fix the reverted condition in sh7372_a3sp_suspend().
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> diff --git a/arch/arm/mach-shmobile/pm-sh7372.c b/arch/arm/mach-shmobile/pm-sh7372.c
> index 77b8fc1..43baa97 100644
> --- a/arch/arm/mach-shmobile/pm-sh7372.c
> +++ b/arch/arm/mach-shmobile/pm-sh7372.c
> @@ -276,7 +276,7 @@ static int sh7372_a3sp_suspend(void)
>  	 * Serial consoles make use of SCIF hardware located in A3SP,
>  	 * keep such power domain on if "no_console_suspend" is set.
>  	 */
> -	return console_suspend_enabled ? -EBUSY : 0;
> +	return console_suspend_enabled ? 0 : -EBUSY;
>  }
>  
>  struct sh7372_pm_domain sh7372_a3sp = {

Magnus, the patch is correct, but I need your ACK here.

Thanks,
Rafael
