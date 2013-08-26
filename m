From: Vinod Koul <vinod.koul@intel.com>
Date: Mon, 26 Aug 2013 14:05:08 +0000
Subject: Re: [PATCH] DMA: shdma: fix a bad merge - remove free_irq()
Message-Id: <20130826135308.GP2748@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1308261426320.1767@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1308261426320.1767@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

On Mon, Aug 26, 2013 at 02:27:51PM +0200, Guennadi Liakhovetski wrote:
> A bad merge resulted in a left-over free_irq() call. This patch removes it.
Applied, thanks

Can you also test this branch and see if anything is remaining

And can you take care then ARM patches in last serries are merged this week...

~Vinod
