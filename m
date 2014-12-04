From: Simon Horman <horms@verge.net.au>
Date: Thu, 04 Dec 2014 07:13:51 +0000
Subject: Re: [PATCH v2] ARM: shmobile: Fix is_e2 warning
Message-Id: <20141204071349.GB25806@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20141203114804.5871.51568.sendpatchset@w520>
In-Reply-To: <20141203114804.5871.51568.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Dec 03, 2014 at 08:48:04PM +0900, Magnus Damm wrote:
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

Thanks Magnus,

I have queued this up.

>  Changes since V1:
>  - Use of_machine_is_compatible()
> 
>  arch/arm/mach-shmobile/setup-rcar-gen2.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> --- 0001/arch/arm/mach-shmobile/setup-rcar-gen2.c
> +++ work/arch/arm/mach-shmobile/setup-rcar-gen2.c	2014-11-28 12:55:44.000000000 +0900
> @@ -52,15 +52,13 @@ void __init rcar_gen2_timer_init(void)
>  {
>  #if defined(CONFIG_ARM_ARCH_TIMER) || defined(CONFIG_COMMON_CLK)
>  	u32 mode = rcar_gen2_read_mode_pins();
> -	bool is_e2 = (bool)of_find_compatible_node(NULL, NULL,
> -		"renesas,r8a7794");

One less cast in the world, awesome!!!

>  #endif
>  #ifdef CONFIG_ARM_ARCH_TIMER
>  	void __iomem *base;
>  	int extal_mhz = 0;
>  	u32 freq;
>  
> -	if (is_e2) {
> +	if (of_machine_is_compatible("renesas,r8a7794")) {
>  		freq = 260000000 / 8;	/* ZS / 8 */
>  		/* CNTVOFF has to be initialized either from non-secure
>  		 * Hypervisor mode or secure Monitor mode with SCR.NS=1.
> 
