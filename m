From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 06 Nov 2014 10:32:19 +0000
Subject: Re: [PATCH] leds: leds-gpio: Convert gpio_blink_set() to use GPIO descriptors
Message-Id: <CAMuHMdWtcZcpW=r60s9auENZxChiLwr14R0p_soKr7C3yGYOMQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414755658-96293-1-git-send-email-mika.westerberg@linux.intel.com>
	<545843B1.3020101@nvidia.com>
	<2455157.3p7mHhT8im@vostro.rjw.lan>
	<CAMuHMdXn9W2S7N+YGfjDxQozMtRZCVdTzzdDps6YfOv2FqVBmw@mail.gmail.com>
	<20141106103033.GK1618@lahna.fi.intel.com>
In-Reply-To: <20141106103033.GK1618@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alexandre Courbot <acourbot@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Mika,

On Thu, Nov 6, 2014 at 11:30 AM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>> "leds: leds-gpio: Add support for GPIO descriptors" broke leds-gpio on
>> non-DT platforms for me:
>>
>>     gpiod_direction_output: invalid GPIO
>>     leds-gpio: probe of leds-gpio failed with error -22
>>
>> (desc is NULL in gpiod_direction_output()).
>>
>> DT shmobile reference/multi-platform are fine.
>>
>> I noticed the hard way, as I wanted to add some LEDs to a new platform,
>> but couldn't get it work. It turned out it also had stopped working on
>> r8a7740/armadillo-legacy, so I started bisecting...
>
> Which board file that is?
>
> There is a bug that gpio_to_desc() returns NULL instead if ERR_PTR() in
> that patch but I wonder why gpio_is_valid() and devm_gpio_request_one()
> do not complain about that prior.

arch/arm/mach-shmobile/board-armadillo800eva.c

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
