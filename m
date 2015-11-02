From: David Miller <davem@davemloft.net>
Date: Mon, 02 Nov 2015 21:32:53 +0000
Subject: Re: [PATCH net-next] ravb: use pdev rather than ndev for error messages
Message-Id: <20151102.163253.1073537023536414920.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1446428417-10895-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1446428417-10895-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: horms+renesas@verge.net.au
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org, magnus.damm@gmail.com

From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon,  2 Nov 2015 10:40:17 +0900

> This corrects what appear to be typos, making the code consistent with
> itself, and allowing meaningful prefixes to be displayed with the errors in
> question.
> 
> Before:
>  (null): failed to initialize MDIO
>  (null): Cannot allocate desc base address table (size 176 bytes)
> 
> After:
> ravb e6800000.ethernet: failed to initialize MDIO
> ravb e6800000.ethernet: Cannot allocate desc base address table (size 176 bytes)
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Applied.
