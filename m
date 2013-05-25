From: Simon Horman <horms@verge.net.au>
Date: Sat, 25 May 2013 01:51:59 +0000
Subject: Re: [PATCH 03/17 v2] sh-pfc: r8a7778: add I2C pin groups
Message-Id: <20130525015158.GC28458@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <878v364c9l.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878v364c9l.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, May 22, 2013 at 08:15:53PM -0700, Kuninori Morimoto wrote:
> Add I2C SDA/SCL pin groups to R8A7778 PFC driver.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v1 -> v2
> 
>  - alphabetical change
> 
>  drivers/pinctrl/sh-pfc/pfc-r8a7778.c |   54 ++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)

Thanks, I will queue this up for v3.11 in the pinmux branch.
