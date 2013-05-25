From: Simon Horman <horms@verge.net.au>
Date: Sat, 25 May 2013 01:52:24 +0000
Subject: Re: [PATCH 05/17 v2] sh-pfc: r8a7778: add MMCIF pin groups
Message-Id: <20130525015222.GE28458@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <8761ya4c7m.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8761ya4c7m.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, May 22, 2013 at 08:17:04PM -0700, Kuninori Morimoto wrote:
> Add MMCIF CLK/CMD/DATA groups to R8A7778 PFC driver.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v1 -> v2
> 
>  - alphabetical change
> 
>  drivers/pinctrl/sh-pfc/pfc-r8a7778.c |   38 ++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)

Thanks, I will queue this up for v3.11 in the pinmux branch.
