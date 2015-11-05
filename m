From: David Miller <davem@davemloft.net>
Date: Thu, 05 Nov 2015 01:59:39 +0000
Subject: Re: [PATCH] sh_eth: merge sh_eth_free_dma_buffer() into sh_eth_ring_free()
Message-Id: <20151104.205939.1680085474215420643.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <6672379.kyQ5eFYq8y@wasted.cogentembedded.com>
In-Reply-To: <6672379.kyQ5eFYq8y@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 04 Nov 2015 00:55:13 +0300

> While the ring allocation is done by a single function, sh_eth_ring_init(),
> the ring deallocation was split into two functions (almost always called
> one after the other) for no good reason. Merge  sh_eth_free_dma_buffer()
> into sh_eth_ring_free() which allows us  to save space not only on the
> direct calls  of the former function but also on the sh_eth_ring_init()'s
> simplified error path...
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied.
