From: Simon Horman <horms@verge.net.au>
Date: Tue, 12 Jun 2012 01:27:43 +0000
Subject: Re: [PATCH 18/27] ARM: shmobile: armadillo800eva: enable camera
Message-Id: <20120612012741.GE16346@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87wr3epkkt.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wr3epkkt.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jun 11, 2012 at 02:57:17AM -0700, kuninori.morimoto.gx@renesas.com wrote:
> 
> Hi Simon
> 
> > > This patch enable camera support on CON1
> > 
> > Hi Morimoto-san,
> > 
> > could you suggest a simple way to test this, preferably from the command line?
> 
> I'm using mplayer.
> 
> mplayer -tv widthd0:heightH0 tv:// -tv outfmt=uyvy -tv device=/dev/video0

Thanks, looking good :)

Tested-by: Simon Horman <horms@verge.net.au>

