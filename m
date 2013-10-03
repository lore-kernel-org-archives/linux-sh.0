From: Simon Horman <horms@verge.net.au>
Date: Thu, 03 Oct 2013 04:13:51 +0000
Subject: Re: [PATCH 2/4 v2] ARM: shmobile: r8a7778: add renesas_intc_irqpin support on DTSI
Message-Id: <20131003041349.GF7925@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87txk3up0q.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87txk3up0q.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 02, 2013 at 01:32:12AM -0700, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v1 -> v2
> 
>  - no change
> 
>  arch/arm/boot/dts/r8a7778.dtsi |   19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Thanks, I have queued this up in the dt3 branch.
It should make it into v3.13 but if not I'll rename the branch
dt after rebasing it on v3.13-rcX which will then be targeted at v3.14.
