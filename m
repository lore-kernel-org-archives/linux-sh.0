From: Peter Zijlstra <peterz@infradead.org>
Date: Mon, 16 Nov 2020 12:17:48 +0000
Subject: Re: [patch 10/19] preempt: Cleanup the macro maze a bit
Message-Id: <20201116121748.GD3121378@hirez.programming.kicks-ass.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20201113140207.499353218@linutronix.de>
 <20201113141733.864469886@linutronix.de>
In-Reply-To: <20201113141733.864469886@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>, Rich Felker <dalias@libc.org>, Catalin Marinas <catalin.marinas@arm.com>, Paul McKenney <paulmck@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, Richard Weinberger <richard@nod.at>, Frederic Weisbecker <frederic@kernel.org>, Valentin Schneider <valentin.schneider@arm.com>, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, linux-parisc@vger.kernel.org, Helge Deller <deller@gmx.de>, Russell King <linux@armlinux.org.uk>, linux-um@lists.infradead.org, Will Deacon <will@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-arm-kernel@lists.infradead.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Fri, Nov 13, 2020 at 03:02:17PM +0100, Thomas Gleixner wrote:

> -#define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK \
> -				 | NMI_MASK))
> +#define irq_count()	(nmi_count() | hardirq_count() | softirq_count())


> +#define in_task()		(!(in_nmi() | in_hardirq() | in_serving_softirq()))
> -#define in_task()		(!(preempt_count() & \
> -				   (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))

How horrible is the code-gen? Because preempt_count() is
raw_cpu_read_4() and at least some old compilers will refuse to CSE it
(consider the this_cpu_read_stable mess).
