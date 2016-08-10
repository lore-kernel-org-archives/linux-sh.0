From: Simon Horman <horms@verge.net.au>
Date: Wed, 10 Aug 2016 09:19:23 +0000
Subject: Re: [PATCH 1/2] net: ethernet: renesas: sh_eth: use phydev from struct net_device
Message-Id: <20160810091923.GE6276@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1470780289-27496-1-git-send-email-tremyfr@gmail.com>
In-Reply-To: <1470780289-27496-1-git-send-email-tremyfr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Philippe Reynes <tremyfr@gmail.com>
Cc: sergei.shtylyov@cogentembedded.com, davem@davemloft.net, geert+renesas@glider.be, andrew@lunn.ch, netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

[CC linux-sh as some of those boards use this driver]

On Wed, Aug 10, 2016 at 12:04:48AM +0200, Philippe Reynes wrote:
> The private structure contain a pointer to phydev, but the structure
> net_device already contain such pointer. So we can remove the pointer
> phy_dev in the private structure, and update the driver to use the
> one contained in struct net_device.
> 
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>

I have looked over this and it seems good to me.
I have also tested it on the r8a7790/Lager board and it appears to work.

Tested-by: Simon Horman <horms+renesas@verge.net.au>
