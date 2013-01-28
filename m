From: David Miller <davem@davemloft.net>
Date: Mon, 28 Jan 2013 01:28:55 +0000
Subject: Re: [PATCH 2/2] net: sh-eth: Use pr_err instead of printk
Message-Id: <20130127.202855.2183638663551956921.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1350350279-8693-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
	<1350350279-8693-2-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
	<20130128012640.GB27896@verge.net.au>
In-Reply-To: <20130128012640.GB27896@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: horms@verge.net.au
Cc: nobuhiro.iwamatsu.yj@renesas.com, netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Simon Horman <horms@verge.net.au>
Date: Mon, 28 Jan 2013 10:26:40 +0900

> [Cc David Miller, linux-sh]
> 
> On Tue, Oct 16, 2012 at 10:17:59AM +0900, Nobuhiro Iwamatsu wrote:
>> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> 
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Dave, I know this is an oldie, but it appears to still be a goodie.
> Could you consider it for 3.8?

Why would I consider it for 3.8?  We're in critical-but-fix-only
state and this just modifies kernel log messages in what should
be rare error paths, so entirely not appropriate for 3.8
