From: Simon Horman <horms@verge.net.au>
Date: Mon, 27 Oct 2014 03:56:57 +0000
Subject: Re: [PATCH v3 04/11] ARM: shmobile: armadillo800eva legacy: Add missing A4S pm domain devices
Message-Id: <20141027035657.GC31487@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1414063141-8856-1-git-send-email-geert+renesas@glider.be>
 <1414063141-8856-5-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1414063141-8856-5-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Oct 23, 2014 at 01:18:54PM +0200, Geert Uytterhoeven wrote:
> Commit 8459293c27bcd13a ("ARM: shmobile: r8a7740: add A4S pm domain
> support") added the A4S power domain, but forgot to hook up the GbEther
> hardware block.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up.

> ---
> v3:
>   - No changes,
> v2:
>   - No changes.
> ---
>  arch/arm/mach-shmobile/board-armadillo800eva.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
> index 64a68450c28a072c..735036038951868d 100644
> --- a/arch/arm/mach-shmobile/board-armadillo800eva.c
> +++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
> @@ -1234,6 +1234,7 @@ static void __init eva_init(void)
>  	static struct pm_domain_device domain_devices[] __initdata = {
>  		{ "A4LC", &lcdc0_device },
>  		{ "A4LC", &hdmi_lcdc_device },
> +		{ "A4S",  &sh_eth_device },
>  		{ "A3SP", &pwm_device },
>  		{ "A3SP", &sdhi0_device },
>  		{ "A3SP", &sh_mmcif_device },
> -- 
> 1.9.1
> 
