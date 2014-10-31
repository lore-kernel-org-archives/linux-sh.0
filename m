From: Simon Horman <horms@verge.net.au>
Date: Fri, 31 Oct 2014 08:37:59 +0000
Subject: Re: [PATCH 0/12] Koelsch sound support
Message-Id: <20141031083757.GD23848@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <871tpo3bz4.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <871tpo3bz4.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Oct 31, 2014 at 01:09:45AM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon, Magnus
> 
> > These patches add sound support (= PIO/DMA) for Koelsch board.
> > These are based on Laurent's R-Car DMA driver patch-set +
> > renesas-devel-20141030-v3.18-rc2
> 
> I had sent H2/M2 sound support patches to ML.
> But, almost all settings are same between H2/M2
> (= sound / Audio DMAC / Audio DMAC periperi / MSTP)
> We can consider to sharing code, and remove duplicate code ?

Are you thinking about a shared DTSI file?
If so I think it is worth considering.
