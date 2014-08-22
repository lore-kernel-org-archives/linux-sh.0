From: Simon Horman <horms@verge.net.au>
Date: Fri, 22 Aug 2014 00:58:25 +0000
Subject: Re: [PATCH 0/3 v2] clk: shmobile: clk: shmobile: add missing 0x0100 for SDCKCR
Message-Id: <20140822005823.GB2783@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <874mxql8eh.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <874mxql8eh.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Aug 20, 2014 at 12:28:36AM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon, Mike
> 
> Could you teach me current status of these patches ?
> 
> > These patches fixup hidden-bug for R-Car Gen2 clock.
> > 
> > Kuninori Morimoto (3):
> >       clk: shmobile: add missing 0x0100 for SDCKCR
> >       ARM: shmobile: r8a7790: add missing 0x0100 for SDCKCR
> >       ARM: shmobile: r8a7791: add missing 0x0100 for SDCKCR

Mike, could you consider picking up the first patch, which I have Acked.

Morimoto-san, I'll pick up the last two patches, sorry for the delay there.

