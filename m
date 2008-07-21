From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Mon, 21 Jul 2008 12:46:33 +0000
Subject: Re: [RFT PATCH] SuperH HSPI controller driver.
Message-Id: <20080721124633.GB17848@roarinelk.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20080721090744.GA16714@roarinelk.homelinux.net>
In-Reply-To: <20080721090744.GA16714@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jul 21, 2008 at 09:39:25PM +0900, Paul Mundt wrote:
> On Mon, Jul 21, 2008 at 11:07:44AM +0200, Manuel Lauss wrote:
> > +out2:
> > +	release_resource(priv->ioarea);
> > +	kfree(priv->ioarea);
> 
> What is this kfree() for?
> 
> > +static int __devexit hspi_remove(struct platform_device *pdev)
> > +{
> > +	struct hspi_priv *priv = platform_get_drvdata(pdev);
> > +
> > +	spi_bitbang_stop(&priv->bitbang);
> > +	iowrite32(0, priv->io + SPCR);
> > +	iowrite32(0, priv->io + SPSCR);
> > +	iowrite32(0, priv->io + SPSR);
> > +	free_irq(priv->irq, priv);
> > +	iounmap(priv->io);
> > +	release_resource(priv->ioarea);
> > +	kfree(priv->ioarea);
> 
> Likewise here.

__request_region() kzalloc's a new struct resource and returns it;
release_resource doesn't free it.

Manuel Lauss
