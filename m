From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 16 Mar 2009 22:52:07 +0000
Subject: Re: [PATCH] sh: Move IRQ multi definition of DMAC to defconfig
Message-Id: <20090316225206.GK21433@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <49BDC5DF.6070108@renesas.com>
In-Reply-To: <49BDC5DF.6070108@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 16, 2009 at 10:49:29PM +0000, Adrian McMenamin wrote:
> On Mon, 2009-03-16 at 20:12 +0900, Paul Mundt wrote:
> > On Mon, Mar 16, 2009 at 12:22:07PM +0900, Nobuhiro Iwamatsu wrote:
> > > When SuperH CPU has IRQ multi of DMAC, SH_DMA_IRQ_MULTI becomes enable.
> > > The following CPU's are Multi IRQ of DMAC now.
> > >  - SH775X and SH7091
> > >  - SH776X
> > >  - SH7780
> > >  - SH7785
> > > 
> > > If SH_DMA_IRQ_MULTI becomes enable, dma-sh api driver is optimized
> > > for Multi IRQ.
> > > 
> > > Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
> > 
> > Applied, thanks.
> > 
> > Adrian, please see if there are any outstanding issues on the dreamcast
> > dma now.
> 
> Have just tested the current kernel in your (Paul's) git repo and
> although it doesn't (seem) to be suffering from the DMA issue now, it is
> still not booting - oom problems killing init:
> 
And with DMA disabled, this does not show up?
