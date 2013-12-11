From: David Miller <davem@davemloft.net>
Date: Wed, 11 Dec 2013 03:26:39 +0000
Subject: Re: [PATCH] micrel: add support for KSZ8041RNLI
Message-Id: <20131210.222639.2106376982664488750.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <201312100220.42153.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201312100220.42153.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 10 Dec 2013 02:20:41 +0300

> Renesas R-Car development boards use KSZ8041RNLI PHY which for some reason has
> ID of 0x00221537 that is not documented for KSZ8041-family PHYs and does not
> match the  documented ID of  0x0022151x (where 'x' is the revision).  We have
> to add the new #define PHY_ID_* and new ksphy_driver[] entry, almost the same
> as KSZ8041 one, differing only in the 'phy_id' and 'name' fields. 
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> This patch is atop of DaveM's 'net-next.git' repo.

You said something to Geert about "Though it's not the last version
probably..." are you talking about this patch needing more revisions?
If so, please make it explicit that you are posting something that is
just for feedback and not applying by using "RFC" in the subject line.

Thanks.
