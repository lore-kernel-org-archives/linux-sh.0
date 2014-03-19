From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 19 Mar 2014 15:28:05 +0000
Subject: Re: [PATCH/RFC 3/5] sh_eth: Simplify MDIO bus initialization and release
Message-Id: <1741671.DqoOs9ymeJ@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1395185156-6681-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1395185156-6681-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei,

On Wednesday 19 March 2014 19:20:40 Sergei Shtylyov wrote:
> On 19-03-2014 3:25, Laurent Pinchart wrote:
> > The network device passed to the sh_mdio_init and sh_mdio_release
> > functions is only used to access the sh_eth_private instance. Pass it
> > directly to those functions.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >   drivers/net/ethernet/renesas/sh_eth.c | 27 +++++++++------------------
> >   1 file changed, 9 insertions(+), 18 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/renesas/sh_eth.c
> > b/drivers/net/ethernet/renesas/sh_eth.c index 7f7085e..55715f3 100644
> > --- a/drivers/net/ethernet/renesas/sh_eth.c
> > +++ b/drivers/net/ethernet/renesas/sh_eth.c
> > @@ -2592,29 +2592,23 @@ static void sh_eth_tsu_init(struct sh_eth_private
> > *mdp)
> >   }
> >   
> >   /* MDIO bus release function */
> > -static int sh_mdio_release(struct net_device *ndev)
> > +static int sh_mdio_release(struct sh_eth_private *mdp)
> >  {
> > -	struct mii_bus *bus = dev_get_drvdata(&ndev->dev);
> 
> I think you should have kept the variable, just changed the initializer, so
> that repetitive 'mdp->mii_bus' derefs could be avoided.

I've actually pondered about that, but given that mdp->mii_bus is used twice 
only I've decided to remove the local variable.

> > -
> >   	/* unregister mdio bus */
> > -	mdiobus_unregister(bus);
> > -
> > -	/* remove mdio bus info from net_device */
> > -	dev_set_drvdata(&ndev->dev, NULL);
> > +	mdiobus_unregister(mdp->mii_bus);
> > 
> >   	/* free bitbang info */
> > -	free_mdio_bitbang(bus);
> > +	free_mdio_bitbang(mdp->mii_bus);
> > 
> >   	return 0;
> >   
> >   }
> 
> [...]
> 
> > @@ -2654,10 +2648,9 @@ static int sh_mdio_init(struct net_device *ndev,
> > int id,
> >   		goto out_free_bus;
> >   	}
> > 
> > -	/* register mdio bus */
> > -	if (ndev->dev.parent->of_node) {
> > -		ret = of_mdiobus_register(mdp->mii_bus,
> > -					  ndev->dev.parent->of_node);
> > +	/* register MDIO bus */
> > +	if (dev->of_node) {
> > +		ret = of_mdiobus_register(mdp->mii_bus, dev->of_node);
> 
> This change looks like it belongs to another, earlier patch, where you
> introduce the 'dev' variable. Although... it seems to only be necessiated by
> this patch, so you're probably right.

That's also a question I've asked myself :-) Both options make sense, and I've 
decided to pick this one.

-- 
Regards,

Laurent Pinchart

