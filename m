From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 22 Jul 2013 23:37:06 +0000
Subject: Re: [PATCH v2 04/15] DMA: shdma: make a pointer const
Message-Id: <2697597.tfSXoJkJMv@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1374251374-30186-1-git-send-email-g.liakhovetski@gmx.de> <15445605.PE49oOgv4F@avalon> <Pine.LNX.4.64.1307220941160.7852@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1307220941160.7852@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Vinod Koul <vinod.koul@intel.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Hi Guennadi,

On Monday 22 July 2013 09:53:51 Guennadi Liakhovetski wrote:
> On Sun, 21 Jul 2013, Laurent Pinchart wrote:
> > On Friday 19 July 2013 18:29:29 Guennadi Liakhovetski wrote:
> > > Platform data shouldn't be changed at run-time, so, pointers to it
> > > should be const.
> > 
> > If you move this patch to the beginning of the series you could make the
> > pdata structures const in 02/15 and 03/15.
> 
> Are these actually related? I think they can be made const regardless?

Right, the compiler will probably not complain, as the platform data pointer 
introduced by patches 02 and 03 are cast to an unsigned long.

-- 
Regards,

Laurent Pinchart

