From: Simon Horman <horms@verge.net.au>
Date: Tue, 17 Jun 2014 06:09:29 +0000
Subject: Re: [PATCH 3/3] ARM: shmobile: r8a7791: add R-Car sound support on DTSI
Message-Id: <20140617060926.GA18186@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87k38menyv.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k38menyv.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jun 16, 2014 at 12:12:18AM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > 
> > > This patch support PIO transfer only at this point
> > 
> > I have marked this patch as an RFC in patchwork.
> > 
> > As discussed privately I think we should wait until we
> > can enable audio with DMA as my understanding is that
> > audio with PIO is not particularly usable.
> 
> Thank you for your help.
> 
> But, this patch adds "SoC" side sound support,
> not "board/platform" side.
> If you want to use sound, then, both "SoC + board" are needed.
> 
> When I sent r8a7790 sound support, I sent both "SoC" + "board",
> and, you ignored "board (= lager)" patch. This is OK for me.
> 
> This r8a7791 sound support patches, I sent "SoC" patch only,
> I didn't sent "board" side.
> So, koelsch board still cann't use sound :P
> I guess you can apply [3/3] patch ?
> 
> r8a7790 has "SoC" sound support patch on devel branch
> eed8d04e231ea32fa704e4afb5f304ec0e836c4f
> (ARM: shmobile: r8a7790: add R-Car sound support on DTSI)
> 
> Sorry for un-understandable / confusable patches.

Hi Morimoto-san,

sorry for my confusion.

I have re-marked this patch as "Under Review" in patchwork and
I intend to apply it once I have finished attending rebasing
the tree now that v3.16-rc1 has been released.

Please ping me if I have not queued up this patch by the
the end of this week.
