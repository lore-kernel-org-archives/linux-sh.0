From: Marc Zyngier <maz@kernel.org>
Date: Mon, 16 Nov 2020 10:51:00 +0000
Subject: Re: [patch 06/19] arm64: irqstat: Get rid of duplicated declaration
Message-Id: <813afa3a895b0da8974fac72832a03b3@kernel.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20201113140207.499353218@linutronix.de>
 <20201113141733.392015387@linutronix.de>
In-Reply-To: <20201113141733.392015387@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Rich Felker <dalias@libc.org>, Paul McKenney <paulmck@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Frederic Weisbecker <frederic@kernel.org>, Valentin Schneider <valentin.schneider@arm.com>, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Richard Weinberger <richard@nod.at>, linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>, Russell King <linux@armlinux.org.uk>, linux-um@lists.infradead.org, Will Deacon <will@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arm-kernel@lists.infradead.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On 2020-11-13 14:02, Thomas Gleixner wrote:
> irq_cpustat_t is exactly the same as the asm-generic one. Define
> ack_bad_irq so the generic header does not emit the generic version of 
> it.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  arch/arm64/include/asm/hardirq.h |    7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> --- a/arch/arm64/include/asm/hardirq.h
> +++ b/arch/arm64/include/asm/hardirq.h
> @@ -13,11 +13,8 @@
>  #include <asm/kvm_arm.h>
>  #include <asm/sysreg.h>
> 
> -typedef struct {
> -	unsigned int __softirq_pending;
> -} ____cacheline_aligned irq_cpustat_t;
> -
> -#include <linux/irq_cpustat.h>	/* Standard mappings for irq_cpustat_t 
> above */
> +#define ack_bad_irq ack_bad_irq
> +#include <asm-generic/hardirq.h>
> 
>  #define __ARCH_IRQ_EXIT_IRQS_DISABLED	1

Acked-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Jazz is not dead. It just smells funny...
