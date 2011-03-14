From: David Miller <davem@davemloft.net>
Date: Mon, 14 Mar 2011 21:11:17 +0000
Subject: Re: [PATCH 6/6] net: sh_eth: add set_mdio_gate in bb_info
Message-Id: <20110314.141117.246516850.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <4D75E1FB.6000607@renesas.com>
In-Reply-To: <4D75E1FB.6000607@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yoshihiro.shimoda.uh@renesas.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 08 Mar 2011 16:59:55 +0900

> The SH7757's ETHER and GETHER use common MDIO pin. The MDIO pin is
> selected by specific register. So this patch adds new interface in
> bb_info, and when the sh_eth driver use the mdio, the register can
> be changed by the function.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Applied.
