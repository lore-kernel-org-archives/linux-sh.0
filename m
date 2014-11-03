From: Simon Horman <horms@verge.net.au>
Date: Mon, 03 Nov 2014 23:30:41 +0000
Subject: Re: [PATCH 03/12] ARM: shmobile: r8a7791: Add Audio DMAC devices to DT
Message-Id: <20141103233041.GB22642@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87wq7g1xcl.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87wq7g1xcl.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Nov 03, 2014 at 11:19:59AM +0100, Geert Uytterhoeven wrote:
> On Fri, Oct 31, 2014 at 9:01 AM, Kuninori Morimoto
> <kuninori.morimoto.gx@gmail.com> wrote:
> > --- a/arch/arm/boot/dts/r8a7791.dtsi
> > +++ b/arch/arm/boot/dts/r8a7791.dtsi
> > @@ -301,6 +301,62 @@
> >                 dma-channels = <15>;
> >         };
> >
> > +       audma0: dma-contorller@ec700000 {
> 
> dma-controller

Morimoto-san, please consider making an incremental patch for this.
