From: David Miller <davem@davemloft.net>
Date: Wed, 04 Jun 2014 02:29:32 +0000
Subject: Re: [PATCH] sh_eth: fix SH7619/771x support
Message-Id: <20140603.192932.2118723287281804842.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <201406032342.27160.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201406032342.27160.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org, yoshihiro.shimoda.uh@renesas.com

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 3 Jun 2014 23:42:26 +0400

> Commit 4a55530f38e4 (net: sh_eth: modify the definitions of register) managed
> to leave out the E-DMAC register entries in sh_eth_offset_fast_sh3_sh2[], thus
> totally breaking SH7619/771x support.  Add the missing entries using  the data
> from before that commit.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied.

I'll queue both of these sh_eth changes for -stable.
