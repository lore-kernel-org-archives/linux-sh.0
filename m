From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
Date: Fri, 17 Aug 2012 05:54:31 +0000
Subject: kzm9g boot fail (was Re: irqdomain breaks ap4 boot)
Message-Id: <502DDC97.5080501@kmckk.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello, Paul

I tried kzm9g board on v3.6-rc2 and got the same error as Morimoto's.

(2012/08/10 21:38), Paul Mundt wrote:
> On Thu, Aug 09, 2012 at 11:10:43PM -0700, Kuninori Morimoto wrote:

>> ecovec/armadillo/marzen board were OK on this patch,
>> but kzm9g board still has problem.
>> I'm using "linus/master + paul/sh-latest"
>>
>> ========= kernel log ==============-
>> ....
>> Preemptible hierarchical RCU implementation.
>>          RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=1.
>> NR_IRQS:16 nr_irqs:16 16
>> intc: Registered controller 'sh73a0-intcs' with 77 IRQs
>> intc: Registered controller 'sh73a0-intca-irq-pins' with 32 IRQs
>> ------------[ cut here ]------------
>> WARNING: at /opt/usr/src/WORK/morimoto/gitlinux/linux-2.6/kernel/irq/irqdomain.)
>> error: irq_desc already associated; irqU2 hwirq=0x228
>
> I screwed up the multi-evt case, it should be trying to associate irq2,
> not irq. Try this:
>
> ---
>
> diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
> index 32c26d7..8f32a13 100644
> --- a/drivers/sh/intc/core.c
> +++ b/drivers/sh/intc/core.c
> @@ -355,7 +355,7 @@ int __init register_intc_controller(struct intc_desc *desc)
>   			if (unlikely(res)) {
>   				if (res = -EEXIST) {
>   					res = irq_domain_associate(d->domain,
> -								   irq, irq);
> +								   irq2, irq2);
>   					if (unlikely(res)) {
>   						pr_err("domain association "
>   						       "failure\n");

I tried this patch but there is still the same error.
I checked quickly by debugger, and I found the failing 
irq_domain_associate() is not called here (line 357) but the one at line 
328.





