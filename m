From: Simon Horman <horms@verge.net.au>
Date: Mon, 25 May 2015 00:50:08 +0000
Subject: Re: [PATCH 0/3 v6] mmc: sh_mmcif: add parent clk support
Message-Id: <20150525005005.GJ19830@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87iobhjxxc.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87iobhjxxc.wl%kuninori.morimoto.gx@renesas.com>
 <87k2vxjyj9.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Laurent <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, kobayashi <keita.kobayashi.ym@renesas.com>

Hi Morimoto-san,

On Mon, May 25, 2015 at 12:24:59AM +0000, Kuninori Morimoto wrote:
> 
> Hi Simon, Ulf
> 
> > > Kuninori Morimoto (5):
> > >       1) mmc: sh_mmcif: add sh_mmcif_host_to_dev() macro and use it.
> > >       2) mmc: sh_mmcif: use sh_mmcif_xxx prefix for all functions
> > >       3) mmc: sh_mmcif: calculate best clock with parent clock
> > >       4) ARM: shmobile: r8a7790: add MMCIF max-frequency
> > >       5) ARM: shmobile: r8a7791: add MMCIF max-frequency
> (snip)
> > Thanks, applied patch 1->3. I leave 4->5 to Simon.
> 
> Thank you Ulf.
> Simon, please check 4) 5)
> 
> Best regards
> ---
> Kuninori Morimoto
> 

On Mon, May 25, 2015 at 12:38:08AM +0000, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > > Thanks, applied patch 1->3. I leave 4->5 to Simon.
> > 
> > Thanks Ulf.
> > 
> > Morimoto-san, can I confirm that I should go ahead and queue up 4->5 ?
> 
> Thank you for your help.
> Yes, please. you don't need to care about 1) - 3) for 4) - 5) patches.
> 

Thanks, I have queued up 5 & 5 for v4.2.
