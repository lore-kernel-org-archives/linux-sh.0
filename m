From: Simon Horman <horms@verge.net.au>
Date: Fri, 13 Jun 2014 07:49:16 +0000
Subject: Re: [PATCH 3/3] ARM: shmobile: r8a7791: add R-Car sound support on DTSI
Message-Id: <20140613074913.GD15286@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87k38menyv.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k38menyv.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jun 11, 2014 at 09:44:26PM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch support PIO transfer only at this point

I have marked this patch as an RFC in patchwork.

As discussed privately I think we should wait until we
can enable audio with DMA as my understanding is that
audio with PIO is not particularly usable.
