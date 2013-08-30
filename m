From: Simon Horman <horms@verge.net.au>
Date: Fri, 30 Aug 2013 03:47:46 +0000
Subject: Re: [PATCH] emev2: GPIOLIB: Enable support for OF
Message-Id: <20130830034746.GB17800@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1377623069-32678-1-git-send-email-ian.molton@codethink.co.uk>
 <1377623069-32678-2-git-send-email-ian.molton@codethink.co.uk>
 <CACRpkdZB+Dm1jhWRu+rdT0V7Q0iwozsd2gQ6M+=55h2SJHQHWw@mail.gmail.com>
In-Reply-To: <CACRpkdZB+Dm1jhWRu+rdT0V7Q0iwozsd2gQ6M+=55h2SJHQHWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ian Molton <ian.molton@codethink.co.uk>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Thu, Aug 29, 2013 at 07:41:42PM +0200, Linus Walleij wrote:
> On Tue, Aug 27, 2013 at 7:04 PM, Ian Molton <ian.molton@codethink.co.uk> wrote:
> 
> > Signed-off-by: Ian Molton <ian.molton@codethink.co.uk>
> > ---
> >  drivers/gpio/gpio-em.c |    1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpio/gpio-em.c b/drivers/gpio/gpio-em.c
> > index 5cba855..279821e 100644
> > --- a/drivers/gpio/gpio-em.c
> > +++ b/drivers/gpio/gpio-em.c
> > @@ -303,6 +303,7 @@ static int em_gio_probe(struct platform_device *pdev)
> >         }
> >
> >         gpio_chip = &p->gpio_chip;
> > +       gpio_chip->of_node = pdev->dev.of_node;
> 
> This doesn't work on non-DT compiles.
> 
> Look at struct gpio_chip:
> 
> #if defined(CONFIG_OF_GPIO)
>         /*
>          * If CONFIG_OF is enabled, then all GPIO controllers described in the
>          * device tree automatically may have an OF translation
>          */
>         struct device_node *of_node;
>         int of_gpio_n_cells;
>         int (*of_xlate)(struct gpio_chip *gc,
>                         const struct of_phandle_args *gpiospec, u32 *flags);
> #endif
> 
> Either the statement needs to be inside #ifdef CONFIG_OF_GPIO
> or the Emma driver need to select OF_GPIO in its Kconfig
> entry.

This may be somewhat naieve, but it seems to me that the latter would be a
better choice at this stage because AFIK the only in-tree emev2 board is
the kzm9d and it uses USE_OF.
