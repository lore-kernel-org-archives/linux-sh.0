From: David Miller <davem@davemloft.net>
Date: Tue, 15 Dec 2015 05:25:26 +0000
Subject: Re: [PATCH] sh_eth: fix TX buffer byte-swapping
Message-Id: <20151215.002526.199770124958086952.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <4052048.4A561jYI0l@wasted.cogentembedded.com>
In-Reply-To: <4052048.4A561jYI0l@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 13 Dec 2015 21:27:04 +0300

> For the little-endian SH771x kernels the driver has to byte-swap the RX/TX
> buffers,  however yet unset physcial address from the TX descriptor is used
> to call sh_eth_soft_swap(). Use 'skb->data' instead...
> 
> Fixes: 31fcb99d9958 ("net: sh_eth: remove __flush_purge_region")
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied.
