From: David Miller <davem@davemloft.net>
Date: Fri, 11 Oct 2013 18:58:06 +0000
Subject: Re: [PATCH] net: sh_eth: Correct fix for RX packet errors on R8A7740
Message-Id: <20131011.145806.1452315588217742239.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1381384276-8077-1-git-send-email-horms+renesas@verge.net.au>
	<1381384276-8077-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1381384276-8077-2-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: horms+renesas@verge.net.au
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org, magnus.damm@gmail.com, sergei.shtylyov@cogentembedded.com, nh-ky@jinso.co.jp

From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 10 Oct 2013 14:51:16 +0900

> Nguyen Hong Ky posted a patch to correct RX packet errors on R8A7740 which
> was applied as 2c6221e4a5aab417 ("net: sh_eth: Fix RX packets errors on
> R8A7740"). Unfortunately sh_eth.c contains many similar instances
> of struct sh_eth_cpu_data and the patch was miss-applied, updating
> sh7734_data instead of r8a7740_data.
> 
> This patch corrects this problem by.
> 1. Reverting the change to sh7734_data and;
> 2. Applying the change to r8a7740_data.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Applied, thanks Somon.
