From: Simon Horman <horms@verge.net.au>
Date: Fri, 25 Sep 2015 01:19:43 +0000
Subject: Re: [PATCH v4] arm64: renesas: r8a7795: add AUDIO_DMAC support
Message-Id: <20150925011941.GA4106@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <874mikuw3e.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874mikuw3e.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Sep 24, 2015 at 07:19:43AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3 -> v4
> 
>  - tidyup MSTP5 definition order
> 
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 75 +++++++++++++++++++++++++++++++
>  include/dt-bindings/clock/r8a7795-clock.h |  2 +
>  2 files changed, 77 insertions(+)

I have left the topic/r8a7795-sound-v3 branch unchanged.
This updated patch is present in the new topic/r8a7795-sound-v3.update branch.
