From: Simon Horman <horms@verge.net.au>
Date: Wed, 11 Feb 2015 00:33:19 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: r8a7790: smp: remap whole apmu region
Message-Id: <20150211003319.GD7826@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1422975462-6037-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1422975462-6037-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Feb 03, 2015 at 03:57:41PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Documentation says the last register is at 0x184 (CAxCPUCMCR), so use
> proper length. Current APMU code accesses CAxCPUnCR which is currently
> outside of the remapped area.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, and sorry for letting this slip.
I have queued up this and the subsequent patch for v3.21.


> ---
>  arch/arm/mach-shmobile/smp-r8a7790.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/smp-r8a7790.c b/arch/arm/mach-shmobile/smp-r8a7790.c
> index 9c3da1345b8b..a5bef873d37e 100644
> --- a/arch/arm/mach-shmobile/smp-r8a7790.c
> +++ b/arch/arm/mach-shmobile/smp-r8a7790.c
> @@ -37,11 +37,11 @@ static struct rcar_sysc_ch r8a7790_ca7_scu = {
>  
>  static struct rcar_apmu_config r8a7790_apmu_config[] = {
>  	{
> -		.iomem = DEFINE_RES_MEM(0xe6152000, 0x88),
> +		.iomem = DEFINE_RES_MEM(0xe6152000, 0x188),
>  		.cpus = { 0, 1, 2, 3 },
>  	},
>  	{
> -		.iomem = DEFINE_RES_MEM(0xe6151000, 0x88),
> +		.iomem = DEFINE_RES_MEM(0xe6151000, 0x188),
>  		.cpus = { 0x100, 0x0101, 0x102, 0x103 },
>  	}
>  };
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
