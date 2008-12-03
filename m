From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 03 Dec 2008 09:38:52 +0000
Subject: Re: [PATCH 1/2] Add support ov772x driver setting for Migo-R
Message-Id: <20081203093852.GA14321@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <u3ah7m2kz.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <u3ah7m2kz.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Dec 02, 2008 at 04:38:34PM +0900, Kuninori Morimoto wrote:
> 
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
> this patch is for linux 2.6.29
> V4L2 maintainer said ov772x driver will be added to linux 2.6.29
> 
As these depend on new headers and data structures, I will include these
with the second round of updates for the merge window, after the V4L2
merge has taken place.

>  arch/sh/boards/mach-migor/setup.c |   22 ++++++++++++++++++++++
>  1 files changed, 22 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
> index 03d2dea..4b348d8 100644
> --- a/arch/sh/boards/mach-migor/setup.c
> +++ b/arch/sh/boards/mach-migor/setup.c
> @@ -441,6 +452,13 @@ static struct platform_device migor_ceu_device = {
>  	},
>  };
>  
> +struct ov772x_camera_info ov7725_info = {
> +	.buswidth  = SOCAM_DATAWIDTH_8,
> +	.link = {
> +		.power  = ov7725_power,
> +	},
> +};
> +
>  static struct platform_device *migor_devices[] __initdata = {
>  	&smc91x_eth_device,
>  	&sh_keysc_device,

Also note that ov7725_info should be static, as you are assigning it to
platform_data and nothing outside of this file is using it otherwise.
