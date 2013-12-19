From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 19 Dec 2013 09:53:32 +0000
Subject: Re: [PATCH] irq-renesas-irqc: simplify irq_set_type() method
Message-Id: <CANqRtoT9-Pp+6p4gWa=uOh9Wdw8JmxXcduqTiqBApaPbr3YYng@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201312140309.31407.sergei.shtylyov@cogentembedded.com>
	<20131219082453.GA12239@verge.net.au>
In-Reply-To: <20131219082453.GA12239@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Thomas Gleixner <tglx@linutronix.de>, SH-Linux <linux-sh@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Thu, Dec 19, 2013 at 5:24 PM, Simon Horman <horms@verge.net.au> wrote:
> On Sat, Dec 14, 2013 at 03:09:31AM +0300, Sergei Shtylyov wrote:
>> Value 0 of the sense  selection field of CONFIG_n register means "disable event
>> detection" and serves in irqc_sense[] for marking the invalid values of the IRQ
>> type (by just omitting initializers). There is no need for INTC_IRQ_SENSE_VALID
>> and hence INTC_IRQ_SENSE() as all field values matching to the  valid IRQ types
>> are non-zero anyway.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> Magnus, could you review this?

The patch is IMO only cosmetic so I can't say I care that much. But
since you ask. =)

Acked-by: Magnus Damm <damm@opensource.se>

Cheers,

/ magnus
