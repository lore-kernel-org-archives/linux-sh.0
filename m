From: David Miller <davem@davemloft.net>
Date: Fri, 16 Mar 2012 09:11:17 +0000
Subject: Re: [PATCH 4/5] net: sh_eth: add CONFIG_SH_ETH_NUM_RXDESC option
Message-Id: <20120316.021117.1280920754044065090.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <4F62FDD8.9010907@renesas.com>
In-Reply-To: <4F62FDD8.9010907@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yoshihiro.shimoda.uh@renesas.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 16 Mar 2012 17:46:16 +0900

> This patch allows you to configure the number of RX descriptors.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Never decide such things at compile time, use ethtool at runtime
for this.
