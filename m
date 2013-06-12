From: David Miller <davem@davemloft.net>
Date: Wed, 12 Jun 2013 21:16:06 +0000
Subject: Re: [PATCH] sh_eth: split 'sh_eth_netdev_ops'
Message-Id: <20130612.141606.1300633926770455407.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <201306130055.34780.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201306130055.34780.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, nobuhiro.iwamatsu.yj@renesas.com, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 13 Jun 2013 00:55:34 +0400

> Commit 9f86134155047720a3685cda21467f68695152d2 (sh_eth: remove SH_ETH_HAS_TSU)
> removes 'const' from 'sh_eth_netdev_ops'  and modifies it in case TSU registers
> are present. I've originally suggested to Iwamatsu-san to split  this structure
> in two instead and afterwards Dave M. suggested doing the same.
> Split 'sh_eth_netdev_ops_tsu' from 'sh_eth_netdev_ops', making both 'const', and
> assigning 'ndev->detdev_ops'  depending on the presence of TSU registers.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied, thanks.
