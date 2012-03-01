From: Sergei Shtylyov <sshtylyov@mvista.com>
Date: Thu, 01 Mar 2012 10:35:47 +0000
Subject: Re: [PATCH 3/3] sh: sh7786: Add echi-sh of platform data
Message-Id: <4F4F5103.1050504@mvista.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1330569162-9485-3-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1330569162-9485-3-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 01-03-2012 6:32, Nobuhiro Iwamatsu wrote:

> Signed-off-by: Nobuhiro Iwamatsu<nobuhiro.iwamatsu.yj@renesas.com>
> ---
>   arch/sh/kernel/cpu/sh4a/setup-sh7786.c |    7 +++++++
>   1 files changed, 7 insertions(+), 0 deletions(-)

> diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
> index 599022d..9e32e1c 100644
> --- a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
> +++ b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
[...]
> @@ -540,6 +541,11 @@ static struct platform_device dma0_device = {
>   	},
>   };
>
> +static struct ehci_sh_platdata usb_ehci_pdata = {
> +	.phy_init = NULL,
> +	.clkmode = 0,

    Do not init to 0 or NULL explicitly.

> +};
> +
>   #define USB_EHCI_START 0xffe70000
>   #define USB_OHCI_START 0xffe70400
>
> @@ -562,6 +568,7 @@ static struct platform_device usb_ehci_device = {
>   	.dev = {
>   		.dma_mask		= &usb_ehci_device.dev.coherent_dma_mask,
>   		.coherent_dma_mask	= DMA_BIT_MASK(32),
> +		.platform_data      = &usb_ehci_pdata,

    Align the initilaiziuer with other fields above please.

WBR, Sergei
