From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 26 Aug 2011 09:22:00 +0000
Subject: Re: [PATCH v8 4/4] ARM: shmobile: ag5evm, ap4: Named SDHI IRQ sources
Message-Id: <Pine.LNX.4.64.1108261121280.25272@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1314235648-8959-1-git-send-email-horms@verge.net.au>
 <1314235648-8959-5-git-send-email-horms@verge.net.au>
 <Pine.LNX.4.64.1108261042450.25272@axis700.grange> <20110826091407.GB5380@verge.net.au>
In-Reply-To: <20110826091407.GB5380@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>

On Fri, 26 Aug 2011, Simon Horman wrote:

> On Fri, Aug 26, 2011 at 10:44:16AM +0200, Guennadi Liakhovetski wrote:
> > On Thu, 25 Aug 2011, Simon Horman wrote:
> > 
> > > This allows specific (non-multiplexed) IRQ handlers to be used.
> > 
> > Could you also prepare a similar patch for g4evm and ap4evb? No need to 
> > change this one, just prepare another one, please.
> 
> Sure, though I do not have access to those boards to test
> (as far as I know).

Ok, I've got an ap4evb, so, I'll prepare that patch myself.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
