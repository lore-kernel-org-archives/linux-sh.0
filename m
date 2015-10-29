From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 29 Oct 2015 23:11:08 +0000
Subject: Re: [PATCH 2/2] sh_eth: fix WARNING in dma_free_coherent()
Message-Id: <5632A78C.4090807@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5844359.Wmo6777QiE@wasted.cogentembedded.com>
 <1503970.kr1SvaSeoy@wasted.cogentembedded.com>
In-Reply-To: <1503970.kr1SvaSeoy@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-sh@vger.kernel.org

On 10/30/2015 12:52 AM, Sergei Shtylyov wrote:

> Iff the first dma_alloc_coherent()  call fails in sh_eth_ring_init(), the
> following  is printed to the kernel console:
>
> WARNING: CPU: 0 PID: 1 at drivers/base/dma-mapping.c:334 dma_common_free_remap+0x48/0x6c()

    Oops, I got the function name wrong in the subject. David, can you fix 
this while applying or should I repost?

MBR, Sergei

