From: David Miller <davem@davemloft.net>
Date: Thu, 03 Jul 2014 00:38:03 +0000
Subject: Re: [PATCH] sh_eth: remove checks around dev_kfree_skb() calls
Message-Id: <20140702.173803.1384383650865317087.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <201406280410.01146.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201406280410.01146.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 28 Jun 2014 04:10:00 +0400

> Since consume_skb() (and hence dev_kfree_skb() macro) checks the passed pointer
> for NULL, there's no need to check for NULL before invoking dev_kfree_skb().
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied, thanks.
