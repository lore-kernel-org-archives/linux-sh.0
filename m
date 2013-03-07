From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 07 Mar 2013 23:39:37 +0000
Subject: Re: [PATCH v3 00/29] SH pinctrl and pinmux implementation
Message-Id: <7368388.U4RWszQhVD@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1362574370-17889-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1362574370-17889-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Linus,

On Thursday 07 March 2013 09:41:27 Linus Walleij wrote:
> On Wed, Mar 6, 2013 at 1:52 PM, Laurent Pinchart,
> > Here's the third version of the SuperH and SH Mobile pin controllers (PFC)
> > pinctrl and pinmux support patches. The patches have been rebased on top
> > of v3.9-rc1
> 
> The series:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> For the stuff I've not already ACKed.

Thank you.

> Basically I see two annoying things in this driver set that would be
> nice to have fixed:
> 
> - Alter the pinctrl.c file to register the GPIO range from the gpiochip
>   side of things, essentially taking out pinctrl_add_gpio_range() and
>   use gpiochip_add_pin_range() from the gpio.c code instead.

OK, I'll do that for v4. Is pinctrl_add_gpio_range() getting deprecated ?

> - Change gpio.c to get rid of the complex code in sh_gpio_to_irq()
>   by using irqdomain. It'll need a custom mapping function but that makes
>   it simpler overall. Change all mappings between Linux and hardware
>   irq numbers to use the irqdomain.

I plan to split the GPIO handling functions to a separate driver, I'll try to 
address that then.

-- 
Regards,

Laurent Pinchart

