From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 09 Oct 2015 08:45:56 +0000
Subject: Re: [PATCH 2/4] i2c: rcar: enable RuntimePM before registering to the core
Message-Id: <CAMuHMdWaeuxxuWOvEUbyBC3QOEH4rFS9ah=WnZWJVv330gDGMw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444373693-2372-1-git-send-email-wsa@the-dreams.de>
	<1444373693-2372-2-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1444373693-2372-2-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Wolfram,

On Fri, Oct 9, 2015 at 8:54 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> The core may register clients attached to this master which may use
> funtionality from the master. So, RuntimePM must be enabled before, otherwise
> this will fail. While here, move drvdata, too.

Thanks for your patch!

> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/busses/i2c-rcar.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
> index d8361dada58455..3d7536d78cb366 100644
> --- a/drivers/i2c/busses/i2c-rcar.c
> +++ b/drivers/i2c/busses/i2c-rcar.c
> @@ -690,15 +690,15 @@ static int rcar_i2c_probe(struct platform_device *pdev)
>                 return ret;
>         }
>
> +       pm_runtime_enable(dev);
> +       platform_set_drvdata(pdev, priv);
> +
>         ret = i2c_add_numbered_adapter(adap);
>         if (ret < 0) {
>                 dev_err(dev, "reg adap failed: %d\n", ret);

You forgot to call pm_runtime_disable() in the error path.
I think some of your other patches suffer from the same issue.

>                 return ret;
>         }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
