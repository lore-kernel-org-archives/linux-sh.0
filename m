From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Wed, 09 Nov 2011 23:57:03 +0000
Subject: Re: [PATCH] PM / Clocks: Only disable enabled clocks in pm_clk_suspend()
Message-Id: <201111100057.03775.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <20111109111351.901.52164.sendpatchset@w520>
In-Reply-To: <20111109111351.901.52164.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wednesday, November 09, 2011, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Refrain from running clk_disable() on clocks that
> have not been enabled. A typical case when this can
> happen is during Suspend-to-RAM for devices that have
> no driver associated with them. In such case the clock
> may be in default ACQUIRED state.
> 
> Without this patch the sh7372 Mackerel board crashes
> in __clk_disable() during Suspend-to-RAM with:
> "Trying to disable clock 0xdeadbeef with 0 usecount"
> This happens for the CEU device which is added during
> boot. The test case has no CEU driver included in the
> kernel configuration. Needed for v3.2-rc1.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Applied to linux-pm/pm-fixes.

Thanks,
Rafael


> ---
> 
>  drivers/base/power/clock_ops.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- 0001/drivers/base/power/clock_ops.c
> +++ work/drivers/base/power/clock_ops.c	2011-11-09 19:28:03.000000000 +0900
> @@ -229,7 +229,8 @@ int pm_clk_suspend(struct device *dev)
>  
>  	list_for_each_entry_reverse(ce, &psd->clock_list, node) {
>  		if (ce->status < PCE_STATUS_ERROR) {
> -			clk_disable(ce->clk);
> +			if (ce->status = PCE_STATUS_ENABLED)
> +				clk_disable(ce->clk);
>  			ce->status = PCE_STATUS_ACQUIRED;
>  		}
>  	}
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

