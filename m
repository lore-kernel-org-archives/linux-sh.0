From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 13 Apr 2009 21:02:29 +0000
Subject: Re: [PATCH] ap325: use edge control for ov772x camera
Message-Id: <20090413210229.GB14847@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uprfhgibw.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uprfhgibw.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Apr 13, 2009 at 03:40:04PM +0900, Kuninori Morimoto wrote:
> 
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
> This patch is for Linux 2.6.30-rc1
> 
>  arch/sh/boards/board-ap325rxa.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/sh/boards/board-ap325rxa.c b/arch/sh/boards/board-ap325rxa.c
> index 912458f..39e4691 100644
> --- a/arch/sh/boards/board-ap325rxa.c
> +++ b/arch/sh/boards/board-ap325rxa.c
> @@ -349,6 +349,7 @@ static int ov7725_power(struct device *dev, int mode)
>  static struct ov772x_camera_info ov7725_info = {
>  	.buswidth  = SOCAM_DATAWIDTH_8,
>  	.flags = OV772X_FLAG_VFLIP | OV772X_FLAG_HFLIP,
> +	.edgectrl = OV772X_AUTO_EDGECTRL(0xf, 0),
>  	.link = {
>  		.power  = ov7725_power,
>  	},

While I don't mind empty changelogs for obvious and trivial changes,
things like this really want some explanation. I don't know if this fixes
a regression, adds a new feature, what the impact is for different
versions of the board, etc.

If a change is not immediately obvious from the description, you really
want a changelog for it.
