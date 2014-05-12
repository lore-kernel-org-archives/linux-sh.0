From: Joe Perches <joe@perches.com>
Date: Mon, 12 May 2014 00:10:35 +0000
Subject: Re: [PATCH] sh_eth: replace devm_kzalloc() with devm_kmalloc()
Message-Id: <1399853435.9156.1.camel@joe-AO725>
List-Id: <linux-sh.vger.kernel.org>
References: <201405120005.51199.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201405120005.51199.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

On Mon, 2014-05-12 at 00:05 +0400, Sergei Shtylyov wrote:
> Now that devm_kmalloc() has become available, we can avoid the needless
> zeroing out of the PHY IRQ array.
[]
> net-next/drivers/net/ethernet/renesas/sh_eth.c
[]
> @@ -2627,7 +2627,7 @@ static int sh_mdio_init(struct sh_eth_pr
[]
> -	mdp->mii_bus->irq = devm_kzalloc(dev, sizeof(int) * PHY_MAX_ADDR,
> +	mdp->mii_bus->irq = devm_kmalloc(dev, sizeof(int) * PHY_MAX_ADDR,

perhaps

	mdp->mii_bus->irq = devm_kmalloc_array(dev, PHY_MAX_ADDR, sizeof(int),



