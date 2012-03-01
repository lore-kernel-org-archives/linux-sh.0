From: Sergei Shtylyov <sshtylyov@mvista.com>
Date: Thu, 01 Mar 2012 10:33:45 +0000
Subject: Re: [PATCH 2/3] sh: sh7757: Add echi-sh of platform data
Message-Id: <4F4F5089.8000407@mvista.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1330569162-9485-2-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1330569162-9485-2-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 01-03-2012 6:32, Nobuhiro Iwamatsu wrote:

> Signed-off-by: Nobuhiro Iwamatsu<nobuhiro.iwamatsu.yj@renesas.com>
> ---
>   arch/sh/kernel/cpu/sh4a/setup-sh7757.c |    7 +++++++
>   1 files changed, 7 insertions(+), 0 deletions(-)

> diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
> index 2875e8b..d791d64 100644
> --- a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
> +++ b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
[...]
> @@ -680,6 +681,11 @@ static struct platform_device spi1_device = {
>   	.resource	= spi1_resources,
>   };
>
> +static struct ehci_sh_platdata usb_ehci_pdata = {
> +	.phy_init = NULL,
> +	.clkmode = 0,

    Do not initialize explicitly to 0 or NULL.

WBR, Sergei
