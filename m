From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 29 Aug 2011 07:47:12 +0000
Subject: Re: [PATCH v2] ARM: mach-shmobile: clock-sh7372: fixup USB-DMAC1 settings
Message-Id: <20110829074712.GH31809@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <874o16up7v.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874o16up7v.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Aug 24, 2011 at 08:47:42PM -0700, kuninori.morimoto.gx@renesas.com wrote:
> USB-DMAC1 needs SMSTPCR4/MSTP407 controls, not MSTP214
> this patch tested on mackerel board
> 
> Reported-by: Magnus Damm <damm@opensource.se>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v1 -> v2
> 
> - tested on mackerel board
> - fix comment
> - fix MSTPxxx order
> 
Applied, thanks.
