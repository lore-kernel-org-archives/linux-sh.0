From: Simon Horman <horms@verge.net.au>
Date: Mon, 27 Aug 2012 08:48:18 +0000
Subject: Re: [PATCH] ARM: shmobile: armadillo800eva: fixup: sound card detection order
Message-Id: <20120827084817.GH29274@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87fw7w38mf.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fw7w38mf.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Aug 08, 2012 at 11:03:07PM -0700, Kuninori Morimoto wrote:
> Since armadillo800eva has 2 sound cards,
> and had reversed deferred probe order issue,
> it was purposely registered in reverse order.
> 
> But it was solved by
> 1d29cfa57471a5e4b8a7c2a7433eeba170d3ad92
> (driver core: fixup reversed deferred probe order)
> 
> armadillo800eva board is expecting that
> FSI-WM8978 is the 1st, and FSI-HDMI is the 2nd sound card.
> This patch fixes it up
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, I have queued this up and will push it to the armadillo800eva
branch of my renesas tree once my outstanding pull request is either
accepted or rejected.
