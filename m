From: Simon Horman <horms@verge.net.au>
Date: Wed, 29 Oct 2014 07:42:11 +0000
Subject: Re: [PATCH] ARM: shmobile: Fix is_e2 warning
Message-Id: <20141029074210.GA32305@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20141029073510.357.85076.sendpatchset@w520>
In-Reply-To: <20141029073510.357.85076.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 29, 2014 at 04:35:10PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Fix "is_e2" warning introduced by:
> 
> 9ce3fa6 ARM: shmobile: rcar-gen2: Add CA7 arch_timer initialization for r8a7794
> 
> Only triggers on kernel configurations that have ARCH_ARM_TIMER=n.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  arch/arm/mach-shmobile/setup-rcar-gen2.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- 0001/arch/arm/mach-shmobile/setup-rcar-gen2.c
> +++ work/arch/arm/mach-shmobile/setup-rcar-gen2.c	2014-10-29 16:06:08.000000000 +0900
> @@ -52,10 +52,10 @@ void __init rcar_gen2_timer_init(void)
>  {
>  #if defined(CONFIG_ARM_ARCH_TIMER) || defined(CONFIG_COMMON_CLK)
>  	u32 mode = rcar_gen2_read_mode_pins();
> -	bool is_e2 = (bool)of_find_compatible_node(NULL, NULL,
> -		"renesas,r8a7794");
>  #endif
>  #ifdef CONFIG_ARM_ARCH_TIMER
> +	bool is_e2 = (bool)of_find_compatible_node(NULL, NULL,
> +		"renesas,r8a7794");
>  	void __iomem *base;
>  	int extal_mhz = 0;
>  	u32 freq;

Not strictly related, but I wonder if we can avoid the cast by
changing the type of is_e2 to struct device_node *. Also changing
the variable name might make sense in that scenario.

Casting makes me sad.
