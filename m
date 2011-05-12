From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 12 May 2011 10:19:10 +0000
Subject: Re: [PATCH] mmc: tmio: fix PM in DMA mode
Message-Id: <Pine.LNX.4.64.1105121212120.24486@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1104291909290.17813@axis700.grange>
 <m3fwom6niy.fsf@pullcord.laptop.org> <Pine.LNX.4.64.1105121015490.24486@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1105121015490.24486@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Ball <cjb@laptop.org>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, Ian Molton <ian@mnementh.co.uk>

On Thu, 12 May 2011, Guennadi Liakhovetski wrote:

> Hi Chris
> 
> On Tue, 10 May 2011, Chris Ball wrote:
> 
> > Hi Guennadi,
> > 
> > On Fri, Apr 29 2011, Guennadi Liakhovetski wrote:
> > > DMA mode has to be re-enabled during a resume.
> > >
> > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > > ---
> > >  drivers/mmc/host/tmio_mmc_dma.c |   21 ++++++++++++---------
> > >  drivers/mmc/host/tmio_mmc_pio.c |    1 +
> > >  2 files changed, 13 insertions(+), 9 deletions(-)
> 
> [snip]
> 
> > Please could you send a full patchset against mmc-next for tmio for .40?
> 
> Can I also base my patches on next-2.6? I need both - latest mmc and pm, 
> so, using next would make it much easier.

I rebased my stack on top of today's next, no changes were required, so, 
here's the order, I have the patches in my tree:

https://patchwork.kernel.org/patch/711251/
https://patchwork.kernel.org/patch/757602/
https://patchwork.kernel.org/patch/757612/
https://patchwork.kernel.org/patch/724081/
https://patchwork.kernel.org/patch/761882/
https://patchwork.kernel.org/patch/761902/
https://patchwork.kernel.org/patch/761922/
https://patchwork.kernel.org/patch/761942/
https://patchwork.kernel.org/patch/777232/
https://patchwork.kernel.org/patch/777262/

As long as we manage to get these in 2.6.40 merge window early enough, 
we'll be able to push related arch patches via shmobile trees.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
