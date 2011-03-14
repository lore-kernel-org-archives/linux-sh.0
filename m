From: David Miller <davem@davemloft.net>
Date: Mon, 14 Mar 2011 21:10:50 +0000
Subject: Re: [PATCH v2 2/6] net: sh_eth: remove the SH_TSU_ADDR
Message-Id: <20110314.141050.59668181.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <4D75E1E6.10108@renesas.com>
In-Reply-To: <4D75E1E6.10108@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yoshihiro.shimoda.uh@renesas.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 08 Mar 2011 16:59:34 +0900

> The defination is hardcoded in this driver for some CPUs. This patch
> modifies to get resource of TSU address from platform_device.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Applied.
