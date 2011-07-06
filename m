From: David Miller <davem@davemloft.net>
Date: Wed, 06 Jul 2011 06:43:02 +0000
Subject: Re: [PATCH 2/2] net: sh_eth: fix the parameter for the ETHER of
Message-Id: <20110705.234302.2191506063329521897.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <4E1401D5.60506@renesas.com>
In-Reply-To: <4E1401D5.60506@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yoshihiro.shimoda.uh@renesas.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 06 Jul 2011 15:33:57 +0900

> If the driver didn't set this parameter on the ETHER, the CPU will
> encounter the "data address error" exception.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Applied.
