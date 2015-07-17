From: David Miller <davem@davemloft.net>
Date: Fri, 17 Jul 2015 07:11:41 +0000
Subject: Re: [PATCH] ravb: do not invalidate cache for RX buffer twice
Message-Id: <20150717.001141.1945286438330434553.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <4759713.2ulGRKsd9L@wasted.cogentembedded.com>
In-Reply-To: <4759713.2ulGRKsd9L@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sergei.shtylyov@cogentembedded.com
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 15 Jul 2015 00:56:52 +0300

> First, dma_sync_single_for_cpu() shouldn't have been called in the first place
> (it's a streaming DMA API). dma_unmap_single() should have been called instead.
> Second, dma_unmap_single() call after handing the buffer to napi_gro_receive()
> makes little sense.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied with fixed up commit log message, thanks.
