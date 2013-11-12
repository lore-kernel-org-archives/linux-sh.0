From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 12 Nov 2013 19:59:21 +0000
Subject: Re: [PATCH] gpio: Renesas RZ GPIO driver
Message-Id: <CACRpkdZC+hvChpDMasj0avRTTbprVn8ro7NxywNUPw+SOr10bw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20131106234737.8971.37405.sendpatchset@w520>
In-Reply-To: <20131106234737.8971.37405.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Alexandre Courbot <acourbot@nvidia.com>, Arnd Bergmann <arnd@arndb.de>

On Thu, Nov 7, 2013 at 12:47 AM, Magnus Damm <magnus.damm@gmail.com> wrote:

> From: Magnus Damm <damm@opensource.se>
>
> This patch adds a GPIO driver for the RZ series of SoCs from
> Renesas. The driver can be used as platform device with dynamic
> or static GPIO assignment or via DT using dynamic GPIOs.

So given that this is for a new system which should only ever
be booted using device tree, why are we bothering with supporting
platform data passing at all?

Is it so that arch/sh is more soft on this for example...?
Can some arch maintainer like SH/Paul ACK this approach?

Read: SH is not moving to device tree...?

(...)
> Tested with yet-to-be-posted platform device and DT devices on
> r7s72100 and Genmai using LEDs, DIP switches and I2C bitbang.

Do you think the maintainers will merge the platform
device approach?

> --- /dev/null
> +++ work/include/linux/platform_data/gpio-rz.h  2013-11-06 14:18:46.000000000 +0900
> @@ -0,0 +1,13 @@
> +#ifndef __GPIO_RZ_H__
> +#define __GPIO_RZ_H__
> +
> +struct gpio_rz_config {
> +       int gpio_base;

Passing these static base offsets around is not good for the
kernel and we're trying to get rid of it :-(

> +       const char *pctl_name;

Ho hum... This needs some kerneldoc describing that this is
used to map the GPIO range to the right pin controller.

> +};
> +
> +#define RZ_GPIOS_PER_PORT 16

This is only used in the driver so move it into the driver.

> +#define RZ_PORT_PIN(bank, pin) (((bank) * RZ_GPIOS_PER_PORT) + (pin))

This is not used anywhere so delete it.

If it is to be kept I'd like "pin" replaced with "line" to avoid
confusion with the pin control business.

Yours,
Linus Walleij
