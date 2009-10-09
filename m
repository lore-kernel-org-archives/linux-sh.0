From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 09 Oct 2009 01:44:13 +0000
Subject: Re: [PATCH 1/2] SH: add support for the RJ54N1CB0C camera for the kfr2r09 platform
Message-Id: <20091009014412.GD31816@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0910031319320.5857@axis700.grange> <Pine.LNX.4.64.0910031320170.5857@axis700.grange> <20091005022500.GD3185@linux-sh.org> <Pine.LNX.4.64.0910051719040.4337@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0910051719040.4337@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, linux-sh@vger.kernel.org

On Mon, Oct 05, 2009 at 05:20:48PM +0200, Guennadi Liakhovetski wrote:
> On Mon, 5 Oct 2009, Paul Mundt wrote:
> 
> > On Sat, Oct 03, 2009 at 01:21:30PM +0200, Guennadi Liakhovetski wrote:
> > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > > ---
> > >  arch/sh/boards/mach-kfr2r09/setup.c |  139 +++++++++++++++++++++++++++++++++++
> > >  1 files changed, 139 insertions(+), 0 deletions(-)
> > > 
> > This seems to depend on the RJ54N1CB0C driver, so I'll queue this up
> > after that has been merged in the v4l tree. If it's available on a topic
> > branch upstream that isn't going to be rebased, then I can pull that in,
> > but this is not so critical either way.
> 
> It actually shouldn't depend on the driver patch. The driver has no 
> headers, so... I haven't verified, but it should work either way. OTOH, 
> waiting for the driver patch is certainly a safe bet:-)
> 
I thought it had a header dependency, but I must have been imagining
things. So in that regard it looks fine, I'll split out my 2.6.32 stuff
in to a separate branch momentarily and then roll this in when I start
taking 2.6.33 stuff. This should at least allow us to start testing in
-next when the driver is merged.
