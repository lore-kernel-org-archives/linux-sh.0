From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 12 May 2011 08:17:25 +0000
Subject: Re: [PATCH] mmc: tmio: fix PM in DMA mode
Message-Id: <Pine.LNX.4.64.1105121015490.24486@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1104291909290.17813@axis700.grange>
 <m3fwom6niy.fsf@pullcord.laptop.org>
In-Reply-To: <m3fwom6niy.fsf@pullcord.laptop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Ball <cjb@laptop.org>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, Ian Molton <ian@mnementh.co.uk>

Hi Chris

On Tue, 10 May 2011, Chris Ball wrote:

> Hi Guennadi,
> 
> On Fri, Apr 29 2011, Guennadi Liakhovetski wrote:
> > DMA mode has to be re-enabled during a resume.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> >  drivers/mmc/host/tmio_mmc_dma.c |   21 ++++++++++++---------
> >  drivers/mmc/host/tmio_mmc_pio.c |    1 +
> >  2 files changed, 13 insertions(+), 9 deletions(-)

[snip]

> Please could you send a full patchset against mmc-next for tmio for .40?

Can I also base my patches on next-2.6? I need both - latest mmc and pm, 
so, using next would make it much easier.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
