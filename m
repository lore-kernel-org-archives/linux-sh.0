From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Mar 2015 13:27:10 +0000
Subject: Re: [PATCH 2/3] Documentation: i2c: describe the new slave mode
Message-Id: <CAMuHMdWHCcS64Cq8n=N+dJ72TaNQRF3aeDn+FMMtW_UUiA9R4Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1426164123-8853-1-git-send-email-wsa@the-dreams.de>
	<1426164123-8853-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1426164123-8853-3-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Andrey Danin <danindrey@mail.ru>, Marc Dietrich <marvin24@gmx.de>, Debora Grosse <debora@mds.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Mar 12, 2015 at 1:42 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> --- /dev/null
> +++ b/Documentation/i2c/slave-interface
> @@ -0,0 +1,178 @@
> +Linux I2C slave interface description
> +==================> +
> +by Wolfram Sang <wsa@sang-engineering.com> in 2014-15
> +
> +Finally, Linux can also be an I2C slave in case I2C controllers have slave
> +support. Besides this HW requirement, one also needs a software backend
> +providing the actual functionality. An example for this is the slave-eeprom
> +driver, which acts as a dual memory driver. While another I2C master on the bus
> +can access it like a regular eeprom, the Linux I2C slave can access the content

EEPROM (to match [PATCH 3/3])
contents

> +via sysfs and retrieve/provide information as needed. The software backend

> +About ACK/NACK
> +--------------
> +
> +It is good behaviour to always ACK the address phase, so the master knows if a
> +device is basically present or if it mysteriously disappeared. Using NACK to
> +state being busy is troublesome. SMBus demands to always ACK the address phase,
> +while I2C specification is more loose on that. Most I2C controllers also

the I2C specification

> +automatically ACK when detecting its slave address, so there is no option to

their slave addresses

> +NACK it. For those reasons, this API does not support NACK in the address

NACK them.

> +phase.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
