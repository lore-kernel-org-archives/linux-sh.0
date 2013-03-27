From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 27 Mar 2013 15:46:56 +0000
Subject: Re: [PATCH] gpio: Renesas R-Car GPIO driver V3
Message-Id: <CANqRtoQWKSQYRJDryhMi793jRuODp5gSXY3d3O2CyuRG13eY6A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130326002301.10878.32801.sendpatchset@w520>
	<CACRpkdZO4gF9Zfj0Y2WJL-bZRUpQVxMGG99W5+TWzu--wG8sag@mail.gmail.com>
In-Reply-To: <CACRpkdZO4gF9Zfj0Y2WJL-bZRUpQVxMGG99W5+TWzu--wG8sag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, grant.likely@secretlab.ca, horms@verge.net.au, laurent.pinchart@ideasonboard.com

On Thu, Mar 28, 2013 at 12:16 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Tue, Mar 26, 2013 at 1:23 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>
>> From: Magnus Damm <damm@opensource.se>
>>
>> This patch is V3 of a GPIO driver for the R-Car series of
>> SoCs from Renesas. This driver is designed to be reusable
>> between multiple SoCs that share the same basic building block,
>> but so far it has only been used on R-Car H1 (r8a7779).
>>
>> Each driver instance handles 32 GPIOs with individually
>> maskable IRQs. The driver operates on a single I/O memory
>> range and the 32 GPIOs are hooked up a single interrupt.
>>
>> In the case of R-Car H1 either external IRQ pins or GPIOs
>> with interrupts can be used for on-board interupts. For
>> external IRQs 4 pins are supported, and in the case of GPIO
>> there are 202 GPIOS as 202 interrupts hooked up via 6 driver
>> instances and to the GIC and the Cortex-A9 Quad.
>>
>> At this point this driver is interfacing as a regular
>> platform device driver. In the future DT support will be
>> submitted as an incremental feature patch.
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>
> Gorgeous driver.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks! This particular GPIO hardware block hasn't been around for so
long so it's still not spoiled by special cases like the PFC or INTC
stuff.

Cheers,

/ magnus
