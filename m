From: Simon Horman <horms@verge.net.au>
Date: Thu, 23 May 2013 01:39:50 +0000
Subject: Re: [PATCH v2 1/2] pinctrl: sh-pfc: fix r8a7790 Function Select register tables
Message-Id: <20130523013949.GL22608@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1305151238040.10596@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1305151238040.10596@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, May 20, 2013 at 01:15:54PM +0200, Laurent Pinchart wrote:
> Hi Linus,
> 
> On Monday 20 May 2013 09:36:59 Linus Walleij wrote:
> > On Wed, May 15, 2013 at 12:46 PM, Guennadi Liakhovetski wrote:
> > > Fix several errors in Peripheral Function Select register tables for
> > > r8a7790, which prevent various function pins from being correctly
> > > configured.
> > > 
> > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > > ---
> > > 
> > > v2: fix a fixed bit-count, thanks to Laurent for catching
> > 
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > 
> > I was a bit confused first and tried to apply this for v3.10 fixes, but it
> > appears this is for the v3.11 stuff queued in Simon's tree right?
> 
> That's correct. We will still need one kernel version to stabilize the sh-pfc 
> driver with DT support. After that it should be easier to push the patches 
> through your tree.

Thanks, queued up for v3.11 in the pinmux branch of the renesas tree.
