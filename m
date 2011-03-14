From: David Miller <davem@davemloft.net>
Date: Mon, 14 Mar 2011 21:11:03 +0000
Subject: Re: [PATCH 4/6] net: sh_eth: modify the PHY_INTERFACE_MODE
Message-Id: <20110314.141103.48516316.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <4D75E1F1.5090306@renesas.com>
In-Reply-To: <4D75E1F1.5090306@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yoshihiro.shimoda.uh@renesas.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 08 Mar 2011 16:59:45 +0900

> The previous code had hardcoded the PHY_INTERFACE_MODE_MII of phy_connect.
> So some Gigabit PHYs will not behave correctly.
> The patch adds the phy_interface in sh_eth_plat_data, so we can select
> the phy interface.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Applied.
