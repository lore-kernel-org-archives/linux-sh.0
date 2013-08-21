From: David Miller <davem@davemloft.net>
Date: Wed, 21 Aug 2013 00:05:29 +0000
Subject: Re: [PATCH 2/2] SolutionEngine7724: fix Ether support
Message-Id: <20130820.170529.2112928097086306489.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <201308180213.23296.sergei.shtylyov@cogentembedded.com>
	<201308180219.09528.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201308180219.09528.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, lethal@linux-sh.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 18 Aug 2013 02:19:09 +0400

> The Ether platform data is behind the declaration of 'struct sh_eth_plat_data'
> as it's lacking the initializers for the 'register_type' and 'phy_interface'
> fields -- it means they'll be implicitly and wrongly set to SH_ETH_REG_GIGABIT
> and PHY_INTERFACE_MODE_NA. Initialize the fields explicitly and fix off-by-one
> error in the Ether memory resource end, while at it...
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied.
