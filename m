From: David Miller <davem@davemloft.net>
Date: Sat, 29 Aug 2009 07:20:58 +0000
Subject: Re: [PATCH] net: sh_eth: add value of ether_link pin in
Message-Id: <20090829.002058.194253782.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <4A97A26F.4060904@renesas.com>
In-Reply-To: <4A97A26F.4060904@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: shimoda.yoshihiro@renesas.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Fri, 28 Aug 2009 18:25:03 +0900

> The method of ETHER_LINK pin is board dependence.
> This patch adding paramters are:
>  - no_ether_link          : If set to 1, do not use ETHER_LINK
>  - ether_link_active_low  : If set to 1, ETHER_LINK is active low.
> 
> Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>

Applied to net-next-2.6, thanks.
