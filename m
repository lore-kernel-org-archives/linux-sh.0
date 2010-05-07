From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 07 May 2010 10:41:11 +0000
Subject: Re: [PATCH] sh: add some INTC_VECT for SH7757
Message-Id: <20100507104110.GH14009@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4BE3DBEB.5060209@renesas.com>
In-Reply-To: <4BE3DBEB.5060209@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, May 07, 2010 at 07:27:16PM +0900, Yoshihiro Shimoda wrote:
> Paul Mundt wrote:
> > On Fri, May 07, 2010 at 06:22:51PM +0900, Yoshihiro Shimoda wrote:
> >> And I also add the setting of mv_nr_irqs because SH7757 has irqs
> >> more than 256.
> >>
> > Since everything is using sparseirq these days, just bump up NR_IRQS to
> > 512. CPUs should not be touching the machvec under any circumstances.
> > 
> May I change the NR_IRQS in arch/sh/include/asm/irq.h?

Yes.

> I thought that if this define is changed, all CPUs were affected.
> Also I thought that there was not good to add "#ifdef CONFIG_CPU_SUBTYPE_SH7757" here.
> What should I do?

These days everything uses sparseirq, and IRQ descs are allocated when
the vector map is registered, as well as dynamically for the dynamic IRQ
cases. Having a large NR_IRQS is not that much overhead since we no
longer have an entire backing irq_desc[] array that spans the entire
range.

As such, you can just change the NR_IRQS definition to 512
unconditionally without worrying too much about the overhead.
