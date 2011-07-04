From: David Miller <davem@davemloft.net>
Date: Mon, 04 Jul 2011 03:10:57 +0000
Subject: Re: [PATCH] net: sh_eth: remove __flush_purge_region
Message-Id: <20110703.201057.720436216770672101.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <4E0D8ABD.9030102@renesas.com>
In-Reply-To: <4E0D8ABD.9030102@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yoshihiro.shimoda.uh@renesas.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 01 Jul 2011 17:52:13 +0900

> It is a function of SuperH architecture. There is no good to use
> the function on a driver generally. So, the driver uses
> dma_map_single() instead of __flush_purge_region.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Applied.
