From: Alexandre Courbot <gnurou@gmail.com>
Date: Thu, 26 Feb 2015 09:39:54 +0000
Subject: Re: [PATCH 0/2] gpio: pcf857x: Use gpiolib irqchip helpers and fix wake-up
Message-Id: <CAAVeFuKbkwkOSF2nDGzyMH9UdV6c+A7OnsV6RqBwKLK=G_HZwg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1423151349-10579-1-git-send-email-geert+renesas@glider.be> <CAMuHMdVsFqB-yyvDA_XZUScdPD7MbdzfPyFG5xgsH2y0csszqw@mail.gmail.com>
In-Reply-To: <CAMuHMdVsFqB-yyvDA_XZUScdPD7MbdzfPyFG5xgsH2y0csszqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, George Cherian <george.cherian@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Feb 24, 2015 at 7:41 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Thu, Feb 5, 2015 at 4:49 PM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>> This patch series switches the PCF857x GPIO driver to use the gpiolib
>> irqchip helpers, as requested by Linus Walleij, and fixes wake-up by
>> propagating the wake-up setting to the parent irq controller.
>>
>> Note that the conversion to gpiolib irqchip helpers removes the checks
>> added in commit 21fd3cd1874a2ac8 ("gpio: pcf857x: call the gpio user
>> handler iff gpio_to_irq is done"), as the interrupt mappings are no
>> longer created on-demand by the driver, but by gpiochip_irqchip_add()
>> during initialization.  I marked the first patch "RFC" because of
>> this.  Does the removal of the checks cause problems for anyone?
>>
>> The second patch was sent before, and rebased on top of the
>> conversion to gpiolib irqchip helpers.
>>
>> This was tested on sh73a0/kzm9g, where I don't see the issue addressed
>> by commit 21fd3cd1874a2ac8 ("gpio: pcf857x: call the gpio user handler
>> iff gpio_to_irq is done").
>>
>> Thanks for your comments!
>
> No comments?

Apologies - I'd like to review this but am not familar enough with the
IRQ helpers. Linus seems to be busy, hopefully he will find time to
check this out...
