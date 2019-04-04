From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 04 Apr 2019 10:02:53 +0000
Subject: Re: [PATCH] spi: sh-msiof: Convert to use GPIO descriptors
Message-Id: <CACRpkdY-hgGAnLexxurTVJaHarmXUrN24YJTCFJcue5h5gnzkg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20190403150852.8002-1-geert+renesas@glider.be>
In-Reply-To: <20190403150852.8002-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Mark Brown <broonie@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Jacopo Mondi <jacopo+renesas@jmondi.org>, linux-spi <linux-spi@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-sh@vger.kernel.org

On Wed, Apr 3, 2019 at 10:08 PM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> Convert GPIO chip selects in the Renesas MSIOF SPI driver from legacy
> GPIO numbers to GPIO descriptors.
>
> Notes:
>   - The board file for the SH7724-based Ecovec24 development board now
>     registers a GPIO descriptor lookup, instead of passing a GPIO number
>     through controller_data,
>   - sh_msiof_get_cs_gpios() must release all GPIOs, else
>     spi_get_gpio_descs() cannot claim them during SPI controller
>     registration.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

I saw Mark already applied the patch, just wanted to say thanks :)

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
