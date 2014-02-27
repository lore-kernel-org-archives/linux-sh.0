From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 27 Feb 2014 15:34:05 +0000
Subject: Re: [PATCH v5] sh_eth: update OF PHY registeration
Message-Id: <530F5AED.3000902@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1393505560-32597-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1393505560-32597-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>, netdev@vger.kernel.org
Cc: linux-sh@vger.kernel.org, nobuhiro.iwamatsu.yj@renesas.com, magnus.damn@opensource.se, horms@verge.net.au

Hello.

On 27-02-2014 16:52, Ben Dooks wrote:

> If the sh_eth device is registered using OF, then the driver
> should call of_mdiobus_register() to register the PHYs described
> in the devicetree and then use of_phy_connect() to connect the
> PHYs to the device.

> This ensures that any PHYs registered in the device tree are
> appropriately connected to the parent devices nodes so that
> the PHY drivers can access their OF properties.

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

> --
> v2:
> 	- allocate mdio->irq array at init time
> 	- set devdata after succesful mdio registration
> v3:
> 	- do not parse phy->irq in of setup (done by of_mdiobus)
> 	- use of_phy_connect to connect phy
> v4:
> 	- fix review comments on code
> 	- reword patch description
> 	- change if to be two way in mdio init code
> v5:
> 	- fix comment duplication
> 	- move error to out of mdio init
> 	- updated patch description
> 	- add copyright codethink to header

    The patch seems OK now, except some minor nits...

> ---
>   drivers/net/ethernet/renesas/sh_eth.c | 59 +++++++++++++++++++++++------------
>   1 file changed, 39 insertions(+), 20 deletions(-)

> diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
> index a18cbe1..b739038 100644
> --- a/drivers/net/ethernet/renesas/sh_eth.c
> +++ b/drivers/net/ethernet/renesas/sh_eth.c
[...]
> @@ -1761,22 +1763,37 @@ static void sh_eth_adjust_link(struct net_device *ndev)
[...]
>   	if (IS_ERR(phydev)) {
> -		dev_err(&ndev->dev, "phy_connect failed\n");
> +		dev_err(&ndev->dev, "failed to connect phy\n");

     I'd prefer "PHY" upppercased.

> @@ -2638,13 +2655,19 @@ static int sh_mdio_init(struct net_device *ndev, int id,
>   		goto out_free_bus;
>   	}
>
> -	for (i = 0; i < PHY_MAX_ADDR; i++)
> -		mdp->mii_bus->irq[i] = PHY_POLL;
> -	if (pd->phy_irq > 0)
> -		mdp->mii_bus->irq[pd->phy] = pd->phy_irq;
> +	if (ndev->dev.parent->of_node) {
> +		ret = of_mdiobus_register(mdp->mii_bus,
> +					  ndev->dev.parent->of_node);
> +	} else {
> +		for (i = 0; i < PHY_MAX_ADDR; i++)
> +			mdp->mii_bus->irq[i] = PHY_POLL;
> +		if (pd->phy_irq > 0)
> +			mdp->mii_bus->irq[pd->phy] = pd->phy_irq;
> +
> +		/* register mdio bus */

    That comment should have been left before *if* I think.

> +		ret = mdiobus_register(mdp->mii_bus);
> +	}
>
> -	/* register mdio bus */
> -	ret = mdiobus_register(mdp->mii_bus);
>   	if (ret)
>   		goto out_free_bus;
>
[...]
> @@ -2896,8 +2913,10 @@ static int sh_eth_drv_probe(struct platform_device *pdev)
>
>   	/* mdio bus init */
>   	ret = sh_mdio_init(ndev, pdev->id, pd);
> -	if (ret)
> +	if (ret) {
> +		dev_err(&ndev->dev, "failed to initialised mdio\n");

    s/initialised/initialize/. And I would prefer "MDIO" uppercased.

>   		goto out_unregister;
> +	}

WBR, Sergei

