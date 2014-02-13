From: David Miller <davem@davemloft.net>
Date: Thu, 13 Feb 2014 23:10:24 +0000
Subject: Re: [PATCH] sh_eth: use ETH_ZLEN instead of home-grown #define
Message-Id: <20140213.181024.1230943968416385018.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <201402140305.42833.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201402140305.42833.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 14 Feb 2014 03:05:42 +0300

> The driver #define's and uses ETHERSMALL macro for the minimum Ethernet frame
> size for which we have a standard macro ETH_ZLEN.  Use the latter  instead of
> the home-grown one.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied, thanks.
