From: Simon Horman <horms@verge.net.au>
Date: Thu, 09 Jan 2014 08:08:36 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: r8a7790: add Audio DMAC support
Message-Id: <20140109080834.GB9267@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <c223d986b953a4686f2540091f82e44030a50daa.1377652063.git.horms+renesas@verge.net.au>
In-Reply-To: <c223d986b953a4686f2540091f82e44030a50daa.1377652063.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jan 06, 2014 at 12:32:54AM -0800, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> R-Car H2 has many DMACs
> (ex SYS-DMAC, 2D-DMAC, Audio-DMAC, USB-DMAC etc)
> and, these DMAEngine needs DMA slave IDs to use it.
> 
> This patch adds new DMA slave ID list for r8a7790.
> There, common part has RCAR_DMA_xxx prefix,
> and Audio DMAC part has AUDIO_DMAC_SLAVE_xxx prefix.
> 
> Audio DMAC can be controlled via sh-dma-engine
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, I will queue this up.
