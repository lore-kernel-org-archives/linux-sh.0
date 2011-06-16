From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 16 Jun 2011 06:40:02 +0000
Subject: Re: [PATCH 0/3 v2] dmaengine: shdma: tidyup shdma
Message-Id: <20110616063959.GD7252@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pd3ieicu5.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pd3ieicu5.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jun 16, 2011 at 02:07:14PM +0900, Kuninori Morimoto wrote:
> These are v2 patches of tidyup shdma
> 
> Kuninori Morimoto (3)
>           dmaengine: shdma: add to_sh_dev define
>           dmaengine: shdma: tidyup spin_unlock_bh on sh_chan_xfer_ld_queue
>           dmaengine: shdma: fixup parameter definition on dmae_set_dmars
> 
> v1 -> v2
> 
> - drop below 2 patches
>           dmaengine: shdma: tidyup addr definition
>           dmaengine: shdma: tidyup parameter change method on dmae_start
> 
> - remake patches for non-conflict
> - modify email address of From and Signed-off-by

Looks fine to me. Applied, thanks.
