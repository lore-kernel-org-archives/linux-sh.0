From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 19 Feb 2013 10:30:46 +0000
Subject: Re: [PATCH] irqchip: Renesas INTC External IRQ pin driver
Message-Id: <CANqRtoQUvojJTDDU8trh-Btt5yyfQUqrCwcm0bnPb00dtNBZEg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130218142834.28739.39417.sendpatchset@w520>
	<20130219010331.GC14932@verge.net.au>
In-Reply-To: <20130219010331.GC14932@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, benh@kernel.crashing.org, grant.likely@secretlab.ca, tglx@linutronix.de

On Tue, Feb 19, 2013 at 10:03 AM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Feb 18, 2013 at 11:28:34PM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> This patch adds a driver for external IRQ pins connected
>> to the INTC block on recent SoCs from Renesas.
>>
>> The INTC hardware block usually contains a rather wide
>> range of features ranging from external IRQ pin handling
>> to legacy interrupt controller support. On older SoCs
>> the INTC is used as a general purpose interrupt controller
>> both for external IRQ pins and on-chip devices.
>>
>> On more recent ARM based SoCs with Cortex-A9 the main
>> interrupt controller is the GIC, but IRQ trigger setup
>> still need to happen in the INTC hardware block.
>>
>> This driver implements the glue code needed to configure
>> IRQ trigger and also handle mask/unmask and demux of
>> external IRQ pins hooked up from the INTC to the GIC.
>>
>> Tested on sh73a0 and r8a7779. The hardware varies quite
>> a bit with SoC model, for instance register width and
>> bitfield widths vary wildly. The driver requires one GIC
>> SPI per external IRQ pin to operate.  Each driver instance
>> will handle up to 8 external IRQ pins.
>>
>> The SoCs using this driver are currently mainly used
>> together with regular platform devices so this driver
>> allows configuration via platform data to support things
>> like static interrupt base address. DT support will
>> be added incrementally in the not so distant future.
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>
> Hi Magnus, Hi all,
>
> I do not expect this code to go through the renesas tree.  However, in
> order to provide a basis for work on renesas SoCs I have added this patch
> to the topic/intc-external-irq topic branch in the reneas tree on
> kernel.org and merged it into topic/all+next.
>
> In other words, I am not picking this series up to merge it or add it to
> linux-next, rather I am storing it for reference.
>
>
> In the course of adding the branch I noticed a 3 whitespace warnings
> from git. I have highlighted them below.

Thanks Simon. I will fix those up in V2!

/ magnus
