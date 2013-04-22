From: Simon Horman <horms@verge.net.au>
Date: Mon, 22 Apr 2013 05:24:24 +0000
Subject: Re: [PATCH 2/3 v3] sh-pfc: r8a7778: add SDHI support
Message-Id: <20130422052423.GB16026@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <871ua76wuz.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871ua76wuz.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Apr 18, 2013 at 08:08:23PM -0700, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v2 -> v3
> 
>  - sdhi has cd, ctrl, data1, data2, wp
> 
>  drivers/pinctrl/sh-pfc/pfc-r8a7778.c |  141 ++++++++++++++++++++++++++++++++++
>  1 file changed, 141 insertions(+)

Thanks, queued-up for v3.11 in the pinmux branch.
