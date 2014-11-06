From: Mika Westerberg <mika.westerberg@linux.intel.com>
Date: Thu, 06 Nov 2014 10:30:33 +0000
Subject: Re: [PATCH] leds: leds-gpio: Convert gpio_blink_set() to use GPIO descriptors
Message-Id: <20141106103033.GK1618@lahna.fi.intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414755658-96293-1-git-send-email-mika.westerberg@linux.intel.com>
 <545843B1.3020101@nvidia.com>
 <2455157.3p7mHhT8im@vostro.rjw.lan>
 <CAMuHMdXn9W2S7N+YGfjDxQozMtRZCVdTzzdDps6YfOv2FqVBmw@mail.gmail.com>
In-Reply-To: <CAMuHMdXn9W2S7N+YGfjDxQozMtRZCVdTzzdDps6YfOv2FqVBmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alexandre Courbot <acourbot@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Thu, Nov 06, 2014 at 10:52:35AM +0100, Geert Uytterhoeven wrote:
> Hi Mika, Rafael,
> 
> On Tue, Nov 4, 2014 at 11:50 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Tuesday, November 04, 2014 12:10:41 PM Alexandre Courbot wrote:
> >> On 10/31/2014 08:40 PM, Mika Westerberg wrote:
> >> > Commit 21f2aae91e902aad ("leds: leds-gpio: Add support for GPIO
> >> > descriptors") already converted most of the driver to use GPIO descriptors.
> >> > What is still missing is the platform specific hook gpio_blink_set() and
> >> > board files which pass legacy GPIO numbers to this driver in platform data.
> >> >
> >> > In this patch we handle the former and convert gpio_blink_set() to take
> >> > GPIO descriptor instead. In order to do this we convert the existing four
> >> > users to accept GPIO descriptor and translate it to legacy GPIO number in
> >> > the platform code. This effectively "pushes" legacy GPIO number usage from
> >> > the driver to platforms.
> >> >
> >> > Also add comment to the remaining block describing that it is legacy code
> >> > path and we are getting rid of it eventually.
> >> >
> >> > Suggested-by: Linus Walleij <linus.walleij@linaro.org>
> >> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> >>
> >> Acked-by: Alexandre Courbot <acourbot@nvidia.com>
> >
> > Patch applied, thanks everyone!
> 
> "leds: leds-gpio: Add support for GPIO descriptors" broke leds-gpio on
> non-DT platforms for me:
> 
>     gpiod_direction_output: invalid GPIO
>     leds-gpio: probe of leds-gpio failed with error -22
> 
> (desc is NULL in gpiod_direction_output()).
> 
> DT shmobile reference/multi-platform are fine.
> 
> I noticed the hard way, as I wanted to add some LEDs to a new platform,
> but couldn't get it work. It turned out it also had stopped working on
> r8a7740/armadillo-legacy, so I started bisecting...

Which board file that is?

There is a bug that gpio_to_desc() returns NULL instead if ERR_PTR() in
that patch but I wonder why gpio_is_valid() and devm_gpio_request_one()
do not complain about that prior.
