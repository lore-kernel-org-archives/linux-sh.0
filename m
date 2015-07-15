From: Simon Horman <horms@verge.net.au>
Date: Wed, 15 Jul 2015 02:44:06 +0000
Subject: Re: [PATCH] ARM: multi_v7_defconfig: add Renesas DPCM Sound Card
Message-Id: <20150715024336.GA27005@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87mvyyw99t.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mvyyw99t.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jul 15, 2015 at 12:39:18AM +0000, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> > This patch enables Renesas DPCM related sound card.
> > It is used for...
> >  - Sampline rate convert
> >  - CTU/MIXer
> > 
> > Note: you need to enable these settings on DTS file
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Sorry, please ignore this patch.
> I noticed that there is compile error on this patch

As discussed elsewhere, the build looks good to me as does the patch.
I have queued it up.
