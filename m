From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 16 Jun 2011 05:07:14 +0000
Subject: Re: [PATCH 0/3 v2] dmaengine: shdma: tidyup shdma
Message-Id: <w3pd3ieicu5.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul

These are v2 patches of tidyup shdma

Kuninori Morimoto (3)
          dmaengine: shdma: add to_sh_dev define
          dmaengine: shdma: tidyup spin_unlock_bh on sh_chan_xfer_ld_queue
          dmaengine: shdma: fixup parameter definition on dmae_set_dmars

v1 -> v2

- drop below 2 patches
          dmaengine: shdma: tidyup addr definition
          dmaengine: shdma: tidyup parameter change method on dmae_start

- remake patches for non-conflict
- modify email address of From and Signed-off-by
