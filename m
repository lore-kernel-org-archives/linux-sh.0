From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 08 Mar 2013 02:07:32 +0000
Subject: Re: [PATCH v3 00/29] SH pinctrl and pinmux implementation
Message-Id: <CACRpkdZ+dgtAPEJj-A+nwCKhnuH82oSJWbM-wU7mTFA77uyKBA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1362574370-17889-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1362574370-17889-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 8, 2013 at 12:39 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> [Me]
>> - Alter the pinctrl.c file to register the GPIO range from the gpiochip
>>   side of things, essentially taking out pinctrl_add_gpio_range() and
>>   use gpiochip_add_pin_range() from the gpio.c code instead.
>
> OK, I'll do that for v4. Is pinctrl_add_gpio_range() getting deprecated ?

Sort of. We prefer to do it this way for new code, it's using the local
numbers on both the GPIO and the pinctrl side, which is nice (no
reference to the global GPIO numberspace!)

>> - Change gpio.c to get rid of the complex code in sh_gpio_to_irq()
>>   by using irqdomain. It'll need a custom mapping function but that makes
>>   it simpler overall. Change all mappings between Linux and hardware
>>   irq numbers to use the irqdomain.
>
> I plan to split the GPIO handling functions to a separate driver, I'll try to
> address that then.

OK!

Yours,
Linus Walleij
