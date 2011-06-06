From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Mon, 06 Jun 2011 13:51:05 +0000
Subject: Re: [RFC PATCH V5 1/4] cpuidle: Move dev->last_residency update to
Message-Id: <20110606135105.GA7023@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <20110606133917.5670.54949.stgit@tringupt.in.ibm.com> <20110606133926.5670.4650.stgit@tringupt.in.ibm.com>
In-Reply-To: <20110606133926.5670.4650.stgit@tringupt.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Trinabh Gupta <trinabh@linux.vnet.ibm.com>
Cc: arjan@linux.intel.com, peterz@infradead.org, lenb@kernel.org, venki@google.com, ak@linux.intel.com, len.brown@intel.com, santosh.shilimkar@ti.com, khilman@ti.com, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Jun 06, 2011 at 07:09:26PM +0530, Trinabh Gupta wrote:
> diff --git a/arch/arm/mach-at91/cpuidle.c b/arch/arm/mach-at91/cpuidle.c
> index 1cfeac1..4696a0d 100644
> --- a/arch/arm/mach-at91/cpuidle.c
> +++ b/arch/arm/mach-at91/cpuidle.c
> @@ -41,10 +41,10 @@ static int at91_enter_idle(struct cpuidle_device *dev,
>  
>  	local_irq_disable();
>  	do_gettimeofday(&before);
> -	if (state = &dev->states[0])
> +	if (index = 0)
>  		/* Wait for interrupt state */
>  		cpu_do_idle();
> -	else if (state = &dev->states[1]) {
> +	else if (index = 1) {
>  		asm("b 1f; .align 5; 1:");
>  		asm("mcr p15, 0, r0, c7, c10, 4");	/* drain write buffer */

While looking through this patch, it is probably worth pointing out for
the AT91 folk that this is broken.  Here's an extract from the GCC manual:

|  Similarly, you can't expect a sequence of volatile `asm' instructions
| to remain perfectly consecutive.  If you want consecutive output, use a
| single `asm'.  Also, GCC will perform some optimizations across a
| volatile `asm' instruction; GCC does not "forget everything" when it
| encounters a volatile `asm' instruction the way some other compilers do.

It might be a good idea to fix those two asm() statements into one.
