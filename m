From: Simon Horman <horms@verge.net.au>
Date: Thu, 03 Oct 2013 04:20:29 +0000
Subject: Re: [PATCH 02/10] ARM: shmobile: Use r8a7791_add_standard_devices() on Koelsch
Message-Id: <20131003042028.GK7925@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20131001081143.4136.46925.sendpatchset@w520>
 <20131001081202.4136.63858.sendpatchset@w520>
In-Reply-To: <20131001081202.4136.63858.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Oct 01, 2013 at 05:12:02PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Use r8a7791_add_standard_devices() on Koelsch to let
> the C version of the board code add on-chip devices.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  arch/arm/mach-shmobile/board-koelsch.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- 0001/arch/arm/mach-shmobile/board-koelsch.c
> +++ work/arch/arm/mach-shmobile/board-koelsch.c	2013-10-01 16:25:46.000000000 +0900
> @@ -29,7 +29,7 @@
>  static void __init koelsch_add_standard_devices(void)
>  {
>  	r8a7791_clock_init();
> -	r8a7791_add_dt_devices();
> +	r8a7791_add_standard_devices();
>  }
>  
>  static const char * const koelsch_boards_compat_dt[] __initconst = {
> 

Thanks, I have queued this up in the boards3 branch.
It should make it into v3.13 but if not I'll rename the branch
soc after rebasing it on v3.13-rcX which will then be targeted at v3.14.

The boards3 branch includes boards code previously queued up for v3.13
and a merge with soc changes previously queued up for v3.13. The reason
for the merge is to provide various build and run-time dependencies
including the r8a7791 SoC code which this board code uses.
