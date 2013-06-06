From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 06 Jun 2013 07:39:07 +0000
Subject: Re: [PATCH] mmc: mmcif: don't clear masked interrupts
Message-Id: <Pine.LNX.4.64.1306060938310.32566@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1305150746480.10596@axis700.grange>
 <519349BB.6080200@jinso.co.jp> <87mwrvwhsn.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mwrvwhsn.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Nguyen Viet Dung <nv-dung@jinso.co.jp>, linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

Hi Chris

On Wed, 15 May 2013, Kuninori Morimoto wrote:

> Hi
> At Wed, 15 May 2013 17:39:23 +0900,
> Nguyen Viet Dung wrote:
> > 
> > On 05/15/2013 02:50 PM, Guennadi Liakhovetski wrote:
> > > Masking events on MMCIF means, an occurrence of the masked event won't raise
> > > an interrupt, but the event bit will still be set in the interrupt status
> > > register. If simultaneously a different event occurs, that was enabled, both
> > > flags will be set. However, only the unmasked event bit should be cleared in
> > > the status register in such a case. Clearing also the masked bit can lead to
> > > lost interrupts, which indeed can be observed on the armadillo800eva r8a7740
> > > board with an eMMC chip. The problem has been introduced by the recent "mmc:
> > > sh_mmcif: simplify IRQ processing" patch. Fix the problem by only clearing
> > > enabled interrupts.
> > >
> > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > 
> > tested-by: Nguyen Viet Dung<nv-dung@jinso.co.jp>
> 
> on Bock-W board
> 
> Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Here's one more for you.

Thanks
Guennadi

> Best regards
> ---
> Kuninori Morimoto
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
