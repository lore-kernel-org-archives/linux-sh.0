From: David Miller <davem@davemloft.net>
Date: Sun, 31 Mar 2013 23:44:54 +0000
Subject: Re: [PATCH] sh_eth: make 'link' field of 'struct sh_eth_private' *int*
Message-Id: <20130331.194454.590712799179779794.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <201304010011.04950.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304010011.04950.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, nobuhiro.iwamatsu.yj@renesas.com, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 1 Apr 2013 00:11:04 +0400

> The 'link' field of 'struct sh_eth_private' has type 'enum phy_state' while the
> 'link' field of 'struct phy_device' is merely *int* (having values 0 and 1) and
> the former field gets assigned from the latter. Make the field match, getting
> rid of incorrectly used PHY_DOWN value in assignments/comparisons.  
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied.
