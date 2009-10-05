From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 05 Oct 2009 15:20:48 +0000
Subject: Re: [PATCH 1/2] SH: add support for the RJ54N1CB0C camera for the
Message-Id: <Pine.LNX.4.64.0910051719040.4337@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0910031319320.5857@axis700.grange>
 <Pine.LNX.4.64.0910031320170.5857@axis700.grange> <20091005022500.GD3185@linux-sh.org>
In-Reply-To: <20091005022500.GD3185@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, linux-sh@vger.kernel.org

On Mon, 5 Oct 2009, Paul Mundt wrote:

> On Sat, Oct 03, 2009 at 01:21:30PM +0200, Guennadi Liakhovetski wrote:
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> >  arch/sh/boards/mach-kfr2r09/setup.c |  139 +++++++++++++++++++++++++++++++++++
> >  1 files changed, 139 insertions(+), 0 deletions(-)
> > 
> This seems to depend on the RJ54N1CB0C driver, so I'll queue this up
> after that has been merged in the v4l tree. If it's available on a topic
> branch upstream that isn't going to be rebased, then I can pull that in,
> but this is not so critical either way.

It actually shouldn't depend on the driver patch. The driver has no 
headers, so... I haven't verified, but it should work either way. OTOH, 
waiting for the driver patch is certainly a safe bet:-)

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
