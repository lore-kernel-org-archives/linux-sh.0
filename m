From: Simon Horman <horms@verge.net.au>
Date: Wed, 15 May 2013 01:20:48 +0000
Subject: Re: [PATCH] sh-pfc: r8a7778: fixup IRQ1A settings
Message-Id: <20130515012047.GH12246@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <8738tqurq3.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8738tqurq3.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, May 13, 2013 at 09:10:17PM -0700, Kuninori Morimoto wrote:
> IP2[31] func2 is IRQ1A, not IRQ3A
> 
> Reported-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, queued-up for v3.11 in the pinmux branch.
