From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sat, 18 May 2013 06:30:23 +0000
Subject: Re: [RFC/PATCH 2/2] gpio-rcar: Add DT support
Message-Id: <171110063.t2Kcvcq8kf@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1368197317-13169-1-git-send-email-laurent.pinchart@ideasonboard.com> <1368197317-13169-3-git-send-email-laurent.pinchart@ideasonboard.com> <Pine.LNX.4.64.1305171416230.31481@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1305171416230.31481@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <damm@opensource.se>

Hi Guennadi,

On Friday 17 May 2013 14:22:22 Guennadi Liakhovetski wrote:
> On Fri, 10 May 2013, Laurent Pinchart wrote:
> > Add DT bindings for the gpio-rcar driver and read the device
> > configuration from the DT node at probe time if available.
> > 
> > Cc: devicetree-discuss@lists.ozlabs.org
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> > 
> >  .../devicetree/bindings/gpio/renesas,gpio-rcar.txt | 48 +++++++++++++++++
> >  drivers/gpio/gpio-rcar.c                           | 63 +++++++++++++----
> >  2 files changed, 101 insertions(+), 10 deletions(-)
> >  create mode 100644
> >  Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
> Testing this patch reveals, that (at least) one thing is missing here:
> 
> diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
> index a499ea6..e233778 100644
> --- a/drivers/gpio/gpio-rcar.c
> +++ b/drivers/gpio/gpio-rcar.c
> @@ -342,6 +342,7 @@ static int gpio_rcar_probe(struct platform_device *pdev)
> gpio_chip->owner = THIS_MODULE;
>  	gpio_chip->base = p->config.gpio_base;
>  	gpio_chip->ngpio = p->config.number_of_pins;
> +	gpio_chip->dev = &pdev->dev;
> 
>  	irq_chip = &p->irq_chip;
>  	irq_chip->name = name;

Indeed, thank you. I wonder how I managed not to notice this. I'll integrate 
the modification for v2.

-- 
Regards,

Laurent Pinchart

