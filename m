From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 02 Oct 2013 00:09:09 +0000
Subject: Re: [PATCH 2/6] arm: shmobile: lager: Add USBHS support
Message-Id: <878uyc1ql9.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1380652251-8143-3-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1380652251-8143-3-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Valentine

> This adds USBHS phy control callbacks to the Lager board and
> registers USBHS device if the driver is enabled.
> 
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> ---
>  arch/arm/mach-shmobile/board-lager.c | 142 +++++++++++++++++++++++++++++++++++
>  1 file changed, 142 insertions(+)
> 
> diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
> index a8d3ce6..e408fc7 100644
> --- a/arch/arm/mach-shmobile/board-lager.c
> +++ b/arch/arm/mach-shmobile/board-lager.c
(snip)

> +static int usbhs_hardware_init(struct platform_device *pdev)
> +{
> +	struct usbhs_private *priv = usbhs_get_priv(pdev);
> +	struct clk *clk;
> +
> +	clk = clk_get(NULL, "hsusb");
> +	if (IS_ERR(clk))
> +		return -ENODEV;

It is automatically enable/disabled by driver
if MSTP704 clock name was "renesas_usbhs".

Best regards
---
Kuninori Morimoto
