From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Sun, 01 Apr 2012 23:57:29 +0000
Subject: Re: [PATCH] ASoC: fsi: update for dmaengine prep_slave_sg fallout.
Message-Id: <8762dj9fa4.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20120330082058.GE26543@linux-sh.org>
In-Reply-To: <20120330082058.GE26543@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi

> Leading up to the ->device_prep_slave_sg change in
> 185ecb5f4fd43911c35956d4cc7d94a1da30417f 'dmaengine: add context
> parameter to prep_slave_sg and prep_dma_cyclic' a generic wrapper was
> added in place to guard against the API change, though the fsi driver
> wasn't updated in the process (presumably its dmaengine support hadn't
> been merged yet at the time). This trivially switches over to the new
> wrapper and gets it building again.
> 
> Signed-off-by: Paul Mundt <lethal@linux-sh.org>
> 
> ---

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Best regards
---
Kuninori Morimoto
