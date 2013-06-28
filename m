From: Simon Horman <horms@verge.net.au>
Date: Fri, 28 Jun 2013 08:26:38 +0000
Subject: Re: [PATCH 2/3] ARM: shmobile: r8a73a4: add I2C controller DT nodes
Message-Id: <20130628082638.GC29517@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1372326479-15028-1-git-send-email-g.liakhovetski@gmx.de>
 <1372326479-15028-3-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1372326479-15028-3-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Jun 27, 2013 at 11:47:57AM +0200, Guennadi Liakhovetski wrote:
> Add Device Tree nodes for the 9 I2C controllers on r8a73a4, compatible with
> the i2c-sh_mobile.c driver.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/boot/dts/r8a73a4.dtsi |   81 ++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 81 insertions(+), 0 deletions(-)

Thanks, queued up for v3.12 in the dt branch.
