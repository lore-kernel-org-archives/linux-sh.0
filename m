From: David Miller <davem@davemloft.net>
Date: Wed, 06 Jul 2011 06:42:55 +0000
Subject: Re: [PATCH 1/2] net: sh_eth: fix cannot work half-duplex mode
Message-Id: <20110705.234255.878921838613449258.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <4E1401CF.4080804@renesas.com>
In-Reply-To: <4E1401CF.4080804@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yoshihiro.shimoda.uh@renesas.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 06 Jul 2011 15:33:51 +0900

> When link was down, the bit of DM in ECMR was always set.
> So, we could not use half-duplex mode on the controller.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Applied.
