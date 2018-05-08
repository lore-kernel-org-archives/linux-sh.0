From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 08 May 2018 06:45:01 +0000
Subject: Re: [PATCH v3 2/3] platform: move the early platform device support to arch/sh
Message-Id: <CAMuHMdXbTkOHAGFBAz16zV1NKmejzy1SpO7LuqZUmsasVf0-jg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20180504132731.14574-1-brgl@bgdev.pl>
 <20180504132731.14574-3-brgl@bgdev.pl>
In-Reply-To: <20180504132731.14574-3-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Bartosz,

On Fri, May 4, 2018 at 3:27 PM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> SuperH is the only user of the current implementation of early platform
> device support. We want to introduce a more robust approach to early
> probing. As the first step - move all the current early platform code
> to arch/sh.
>
> In order not to export internal drivers/base functions to arch code for
> this temporary solution - copy the two needed routines for driver
> matching from drivers/base/platform.c to arch/sh/drivers/platform_early.c.
>
> Also: call early_platform_cleanup() from subsys_initcall() so that it's
> called after all early devices are probed.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

>  drivers/clocksource/sh_cmt.c           |   7 +
>  drivers/clocksource/sh_mtu2.c          |   7 +
>  drivers/clocksource/sh_tmu.c           |   8 +
>  drivers/tty/serial/sh-sci.c            |   7 +-
>  include/linux/platform_device.h        |  64 +----

The parts used on contemporary ARM/ARM64 Renesas SoCs look fine to me, so
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
