From: Simon Horman <horms@verge.net.au>
Date: Mon, 24 Feb 2014 23:47:19 +0000
Subject: Re: [PATCH 2/4] ARM: shmobile: r8a7791: add IIC(B) clocks to dtsi
Message-Id: <20140224234718.GB8327@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1389082976-22254-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1389082976-22254-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Feb 24, 2014 at 12:36:40PM +0100, Laurent Pinchart wrote:
> Hi Wolfram,
> 
> On Monday 24 February 2014 11:38:32 Wolfram Sang wrote:
> > > >  			renesas,clock-indices = <
> > > >  			
> > > >  				R8A7791_CLK_TPU0 R8A7791_CLK_SDHI2 R8A7791_CLK_SDHI1
> > > >  				R8A7791_CLK_SDHI0 R8A7791_CLK_MMCIF0 R8A7791_CLK_CMT1
> > > > 
> > > > +				R8A7791_CLK_IIC0 R8A7791_CLK_IIC1
> > > 
> > > That's an arbitrary rule but we've followed it so far, could you please
> > > keep the entries sorted by value as well, here and in patch 3/4 ?
> > 
> > OK, can do. Will create a less easy to parse diff, though. Another
> > question: What about loosening the 80-char rule and have four values per
> > line? This suits a 32 bit register much better IMO.
> 
> I'd be fine with that. There has never been a strict 80-char rule for .dts 
> files anyway.

I am fine with that too.

