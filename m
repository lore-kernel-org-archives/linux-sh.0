From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 24 Apr 2013 08:13:04 +0000
Subject: Re: r8a7779_init_irq_extpin
Message-Id: <CANqRtoQpQjh1dRAtURkg1NPh914fZsiOKNqL80cOU8U3Bxtwtw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130417063526.GA21490@verge.net.au>
In-Reply-To: <20130417063526.GA21490@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Apr 20, 2013 at 9:28 AM, Simon Horman <horms@verge.net.au> wrote:
> On Fri, Apr 19, 2013 at 04:11:34AM +0900, Magnus Damm wrote:
>> Hi Simon,
>>
>> On Thu, Apr 18, 2013 at 9:22 PM, Simon Horman <horms@verge.net.au> wrote:
>> > On Thu, Apr 18, 2013 at 02:23:57PM +0900, Magnus Damm wrote:
>> >> Hi Simon,
>> >>
>> >> On Wed, Apr 17, 2013 at 3:35 PM, Simon Horman <horms@verge.net.au> wrote:
>> >> > Hi Magnus,
>> >> >
>> >> > r8a7779_init_irq_extpin() and related code was added in your
>> >> > patch "ARM: shmobile: Use Renesas INTC External IRQ pin driver"
>> >> > but appears to be unused.
>> >> >
>> >> > Are you still planning to use it?
>> >>
>> >> Perhaps I'm misunderstanding, but isn't it used by the Marzen board code in:
>> >> [PATCH 03/03] ARM: shmobile: INTC External IRQ pin driver on r8a7779
>> >
>> > Thanks. Some how I that portion got lost and isn't present
>> > in the tree. I'll post a patch with the missing portions shortly.
>>
>> Ok, thanks for dealing with this!
>
> One more question, is the code in r8a7779_init_irq_extpin()
> before the call to platform_device_register() needed if
> irqpin is registered using DT? IF so, perhaps it needs to
> go into the driver? With a binding?

Thanks for dealing with DT support of external IRQ signals on r8a7779.

The background is that r8a7779 and many older SH based SoCs allows
mode selection of the IRQ0->IRQ3 signals. There are two modes: IRQ
mode and IRL mode.

The INTC irqpin driver supports IRQ mode only, and the marzen board
seems to want to use IRQ mode for the ethernet driver IRQ signal.
Other boards may however want to use IRL mode on r8a7779, and because
of that is the r8a7779_init_irq_extpin() function called only for
board code that uses IRQ mode. This is how we used to do things on SH
too.

Please note that we lack software support for IRL mode. Older SH socs
may have used it at some point in history. Which mode to use is
however still a choice that the board designer needs to make, and I
prefer to make that choice something that should be selected by the
board code instead of assuming some configuration that may not be
true. Using the INTC irqpin driver in IRL mode is going to result in
strange behavior, so let's try to avoid doing that.

The above describes C board code selecting IRQ mode, but in the case
of DT support it all becomes slightly more complex.

In the DT case I don't think we should modify any driver. Perhaps it
is a good and simple tradeoff to put device data for INTC irqpins in
the board DT file for r8a7779 in case IRQ mode is used? Boards using
IRL mode simply omit that portion in the DT board file. Other SoCs
that cannot select mode of IRQ pins can have their INTC irqpin
description in the SoC DTSI file as usual.
Thanks,

/ magnus
