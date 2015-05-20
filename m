From: Jiang Liu <jiang.liu@linux.intel.com>
Date: Wed, 20 May 2015 15:24:34 +0000
Subject: Re: [RFC v1 10/25] sh: intc: Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc
Message-Id: <555CA732.3050600@linux.intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1432116013-25902-1-git-send-email-jiang.liu@linux.intel.com> <1432116013-25902-11-git-send-email-jiang.liu@linux.intel.com> <alpine.DEB.2.11.1505201705110.4225@nanos>
In-Reply-To: <alpine.DEB.2.11.1505201705110.4225@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-sh@vger.kernel.org

On 2015/5/20 23:12, Thomas Gleixner wrote:
> On Wed, 20 May 2015, Jiang Liu wrote:
> 
>> Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc while we
>> already have a pointer to corresponding irq_desc.
>>
>> Also replace generic_handle_irq with generic_handle_irq_desc() to avoid
>> looking up irq_desc again.
>>
>> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
>> ---
>>  drivers/sh/intc/core.c |    2 +-
>>  drivers/sh/intc/virq.c |   14 ++++++++------
>>  2 files changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
>> index 81f22980b2de..e4ca964ca840 100644
>> --- a/drivers/sh/intc/core.c
>> +++ b/drivers/sh/intc/core.c
>> @@ -67,7 +67,7 @@ void intc_set_prio_level(unsigned int irq, unsigned int level)
>>  
>>  static void intc_redirect_irq(unsigned int irq, struct irq_desc *desc)
>>  {
>> -	generic_handle_irq((unsigned int)irq_get_handler_data(irq));
>> +	generic_handle_irq_desc(irq, desc);
> 
> This looks wrong. It's a redirector of irq to some other irq.
> 
>      	redir_irq = (unsigned int)irq_get_handler_data(irq);
> 
> which should be:
> 
>         redir_irq = (unsigned int)irq_desc_get_irq_handler_data(desc);
> 
> And redir_irq is certainly not the same as irq. So this wants a
> conversion to irq_desc_get_irq_handler_data() first. That makes the
> irq argument unused.

Good catch, will fix it in next version.

> 
> Thanks,
> 
> 	tglx
> 
