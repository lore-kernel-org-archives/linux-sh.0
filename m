From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 17 Feb 2014 15:40:07 +0000
Subject: Re: [PATCH] sh_eth: call of_mdiobus_register() to register phys
Message-Id: <53023B60.4030201@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1392650895-1422-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1392650895-1422-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>, netdev@vger.kernel.org
Cc: horms+renesas@verge.net.au, linux-sh@vger.kernel.org, magnus@opensource.se, linux-kernel@lists.codethink.co.uk

Hello.

On 02/17/2014 06:28 PM, Ben Dooks wrote:

> If the sh_eth device is registered using OF, then the driver

    Which is not supported yet as my DT patch hasn't been merged.
This patch seems somewhat premature.

> should call of_mdiobus_register() to register any PHYs connected
> to the system.

    That's not necessary (but good to have).

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>   drivers/net/ethernet/renesas/sh_eth.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)

> diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
> index 06970ac..165f0c4 100644
> --- a/drivers/net/ethernet/renesas/sh_eth.c
> +++ b/drivers/net/ethernet/renesas/sh_eth.c
[...]
> @@ -2629,6 +2630,18 @@ static int sh_mdio_init(struct net_device *ndev, int id,
>   	snprintf(mdp->mii_bus->id, MII_BUS_ID_SIZE, "%s-%x",
>   		 mdp->pdev->name, id);
>
> +	if (ndev->dev.parent->of_node) {
> +		dev_set_drvdata(&ndev->dev, mdp->mii_bus);
> +		ret = of_mdiobus_register(mdp->mii_bus,
> +					  ndev->dev.parent->of_node);
> +		if (ret != 0) {
> +			dev_err(&ndev->dev, "of_mdiobus_register() failed\n");
> +			goto out_free_bus;
> +		}
> +
> +		return 0;
> +	}
> +
>   	/* PHY IRQ */
>   	mdp->mii_bus->irq = devm_kzalloc(&ndev->dev,
>   					 sizeof(int) * PHY_MAX_ADDR,
>

     Hm, I can only hope this works with PHY IRQ in DT mode.
Would you mind if I include your patch into my Ether DT patch?

WBR, Sergei

