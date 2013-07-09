From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 09 Jul 2013 11:52:48 +0000
Subject: Re: [PATCH 1/4] ARM: shmobile: r8a7778: add usb phy power control function
Message-Id: <51DBF990.4080600@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87ehb8th3c.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ehb8th3c.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 09-07-2013 9:52, Kuninori Morimoto wrote:

> USB phy initialisation function is needed from not only
> USB Host but also USB Function too.
> This patch adds usb phy common control function.

> Tested-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   arch/arm/mach-shmobile/setup-r8a7778.c |   35 ++++++++++++++++++++++----------
>   1 file changed, 24 insertions(+), 11 deletions(-)

> diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
> index 2a101eb..cd98079 100644
> --- a/arch/arm/mach-shmobile/setup-r8a7778.c
> +++ b/arch/arm/mach-shmobile/setup-r8a7778.c
> @@ -109,29 +109,44 @@ void __init r8a7778_add_usb_phy_device(struct rcar_phy_platform_data *pdata)
>   					  pdata, sizeof(*pdata));
>   }
>
> -/* USB */

    Why move this comment?

> -static struct usb_phy *phy;
> -
> -static int usb_power_on(struct platform_device *pdev)
> +static int r8a7778_usb_phy_power(int enable)

    Why not 'bool enable'?

WBR, Sergei

