From: David Miller <davem@davemloft.net>
Date: Tue, 29 May 2012 21:23:07 +0000
Subject: Re: [PATCH] net: sh_eth: fix the rxdesc pointer when rx descriptor empty happens
Message-Id: <20120529.172307.2230306328587848147.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <4FC491EB.4040002@renesas.com>
In-Reply-To: <4FC491EB.4040002@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yoshihiro.shimoda.uh@renesas.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 29 May 2012 18:07:55 +0900

> When Receive Descriptor Empty happens, rxdesc pointer of the driver
> and actual next descriptor of the controller may be mismatch.
> This patch fixes it.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Applied.
