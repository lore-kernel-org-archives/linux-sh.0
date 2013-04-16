From: Simon Horman <horms@verge.net.au>
Date: Tue, 16 Apr 2013 06:16:25 +0000
Subject: Re: [PATCH 1/4 v2] ARM: shmobile: use do{ }while() on SH_CLK_SET_RATIO()
Message-Id: <20130416061621.GB27462@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87vc7snqls.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vc7snqls.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Apr 12, 2013 at 12:41:07AM -0700, Kuninori Morimoto wrote:
> SH_CLK_SET_RATIO() will be trouble without this patch

Thanks, queued-up for v3.11 to the soc-common branch.
