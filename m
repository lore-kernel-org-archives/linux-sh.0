From: Simon Horman <horms@verge.net.au>
Date: Mon, 01 Oct 2012 05:24:28 +0000
Subject: Re: [PATCH] ARM: shmobile: mackerel: defconfig update
Message-Id: <20121001052427.GB1857@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87ehlirirj.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ehlirirj.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Sep 30, 2012 at 08:08:54PM -0700, Kuninori Morimoto wrote:
> This patch enables following devices by default
>  - I2C
>  - HDMI
>  - USB (host/gadget)
>  - ALSA (FSI)
>  - DMAEngine
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> ---
>  arch/arm/configs/mackerel_defconfig |   18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)

Thanks Morimoto-san,

I have applied this to the defconfig branch of my renesas tree.
I anticipate it will be included in 3.8.
