From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 04 Sep 2013 18:38:18 +0000
Subject: Re: [PATCH 4/5 v2] ARM: shmobile: bockw: add R-Car sound support (PIO)
Message-Id: <52277E1A.6060803@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87bo4kvnow.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bo4kvnow.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 08/26/2013 12:52 PM, Kuninori Morimoto wrote:

> This patch enables R-Car sound,
> AK4643 (CN19) and AK4554 (CN20/CN21) codec chip
> on Bock-W.

> But, it supports PIO transfer only at this point.
> User can check sound settings (Dip-switch/PFC etc)
> via this patch, but will get under/over flow error
> when playback/capture.
> Because PIO transfer via SSI will be interrupted
> "sampling rate" times per 1 second.

> DMA transfer will be supported when HPB-DMAC was
> enabled on r8a7778.

    Looks like Vinod Koul has queued HPP-DMAC for 3.12-rc1 in his 'next' 
branch, so you can start looking at addign DMA for 3.13. I'll submit the 
patches enabling HPB-DMAC in {marzen|bockw}_defconfig later...

WBR, Sergei

