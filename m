From: Simon Horman <horms@verge.net.au>
Date: Tue, 30 Jul 2013 08:28:21 +0000
Subject: Re: [PATCH 2/2 v3] ARM: shmobile: r8a7778: cleanup registration of hspi
Message-Id: <20130730082820.GB12147@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87a9l4edj6.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87a9l4edj6.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jul 30, 2013 at 12:02:24AM -0700, Kuninori Morimoto wrote:
> sh-hspi driver which doesn't need platform data at the time of
> registration can be registerd on SoC.
> And, registering these drivers in the SoC code can avoid
> unwanted device numbering issue.
> (ex. the hspi2 device number will be spi.0 if hspi2 only registered)
> This patch registers it on SoC code as cleanup C code
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v2 -> v3
> 
>  - based on 1/2 patch

Thanks, I have queued this up for v3.12 in the cleanup3 branch.
