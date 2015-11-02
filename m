From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 02 Nov 2015 09:15:31 +0000
Subject: Re: [RFC v3 5/5] watchdog: renesas-rwdt: add driver
Message-Id: <CAMuHMdX-9Bf7S6swc7L7PuOY24t+NrHe5gF50eAQHwe0AuYwww@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1446405579-5367-6-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1446405579-5367-6-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Wolfram,

On Sun, Nov 1, 2015 at 8:19 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Add support for an RCLK watchdog found in at least all RCar Gen2 and
> Gen3 based SoCs from Renesas. It probably works even for the "Secure
> watchdog" of some of those SoCs according to the specs I have. A restart
> handler is in place, too.

Thanks for your patches!

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/watchdog/Kconfig        |   8 ++
>  drivers/watchdog/Makefile       |   1 +
>  drivers/watchdog/renesas_rwdt.c | 222 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 231 insertions(+)
>  create mode 100644 drivers/watchdog/renesas_rwdt.c

No DT binding documentation?

> --- /dev/null
> +++ b/drivers/watchdog/renesas_rwdt.c

> +static const struct of_device_id rwdt_ids[] = {
> +       { .compatible = "renesas,rwdt", },

Please use SoC-specific compatible values only.

Given we know there exist at least 3 different versions:
  1. R-Car Gen2/Gen3, R-Mobile APE6,
  2. Older SH/R-Mobile (e.g. AP4, AG5, A1),
  3. RZ,
I strongly recommend not having "renesas,rwdt" out there in the wild, especially
in the BSP.

> +       { /* sentinel */ }
> +};

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
