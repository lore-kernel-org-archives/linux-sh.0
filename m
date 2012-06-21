From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Thu, 21 Jun 2012 11:45:31 +0000
Subject: Re: [PATCH] r8a7779: Route all interrupts to ARM
Message-Id: <201206211345.31969.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <1340109108-9354-1-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1340109108-9354-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

Can you please provide a changelog describing why the change is being made?

Rafael


On Tuesday, June 19, 2012, Phil Edworthy wrote:
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
>  arch/arm/mach-shmobile/intc-r8a7779.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/intc-r8a7779.c b/arch/arm/mach-shmobile/intc-r8a7779.c
> index 550b23d..f04fad4 100644
> --- a/arch/arm/mach-shmobile/intc-r8a7779.c
> +++ b/arch/arm/mach-shmobile/intc-r8a7779.c
> @@ -35,6 +35,9 @@
>  #define INT2SMSKCR3 0xfe7822ac
>  #define INT2SMSKCR4 0xfe7822b0
>  
> +#define INT2NTSR0 0xfe700060
> +#define INT2NTSR1 0xfe700064
> +
>  static int r8a7779_set_wake(struct irq_data *data, unsigned int on)
>  {
>  	return 0; /* always allow wakeup */
> @@ -49,6 +52,10 @@ void __init r8a7779_init_irq(void)
>  	gic_init(0, 29, gic_dist_base, gic_cpu_base);
>  	gic_arch_extn.irq_set_wake = r8a7779_set_wake;
>  
> +	/* route all interrupts to ARM */
> +	__raw_writel(0xffffffff, INT2NTSR0);
> +	__raw_writel(0x3fffffff, INT2NTSR1);
> +
>  	/* unmask all known interrupts in INTCS2 */
>  	__raw_writel(0xfffffff0, INT2SMSKCR0);
>  	__raw_writel(0xfff7ffff, INT2SMSKCR1);
> 

