From: Alexandre Courbot <gnurou@gmail.com>
Date: Tue, 18 Nov 2014 03:11:18 +0000
Subject: Re: [PATCH/RFC] gpio: em: Use dynamic allocation of GPIOs
Message-Id: <CAAVeFuKGYM56KP8TOZAwSjDGWrVNoK1phpxoOdEJ=Ng9haSnmg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1416234632-16166-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1416234632-16166-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-SH <linux-sh@vger.kernel.org>

On Mon, Nov 17, 2014 at 11:30 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Use dynamic allocation of GPIOs instead of looking at the gpio%u alias
> in DT.
> ---
>   - Is this correct? Not having to care about the alias would simplify the
>     to-be-written DT binding documentation.
>   - Completely untested.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
>  drivers/gpio/gpio-em.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/gpio/gpio-em.c b/drivers/gpio/gpio-em.c
> index 21d34d4d473dcefe..c3434146f605748b 100644
> --- a/drivers/gpio/gpio-em.c
> +++ b/drivers/gpio/gpio-em.c
> @@ -330,12 +330,7 @@ static int em_gio_probe(struct platform_device *pdev)
>                         goto err0;
>                 }
>
> -               ret = of_alias_get_id(pdev->dev.of_node, "gpio");
> -               if (ret < 0) {
> -                       dev_err(&pdev->dev, "Couldn't get OF id\n");
> -                       goto err0;
> -               }
> -               pdata->gpio_base = ret * 32; /* 32 GPIOs per instance */
> +               pdata->gpio_base = -1;

User-space might break because of GPIO renumbering. Why not setting
gpio_base to -1 when the property is not present (instead of
triggering an error), keeping support for the property so existing
boards remain safe, and marking the property as deprecated in the
bindings documentation?
