From: Sergei Shtylyov <sshtylyov@mvista.com>
Date: Thu, 24 Feb 2011 11:26:15 +0000
Subject: Re: [PATCH] usb: add EHCI and OHCI support for SH7757
Message-Id: <4D664057.1080509@ru.mvista.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4D660C04.9070800@renesas.com>
In-Reply-To: <4D660C04.9070800@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 24-02-2011 10:43, Yoshihiro Shimoda wrote:

> Signed-off-by: Yoshihiro Shimoda<yoshihiro.shimoda.uh@renesas.com>
[...]

> diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> index 4c77a81..b5aae43 100644
> --- a/drivers/usb/host/ehci-hcd.c
> +++ b/drivers/usb/host/ehci-hcd.c
> @@ -1184,7 +1184,8 @@ MODULE_LICENSE ("GPL");
>   #define PLATFORM_DRIVER		ehci_mxc_driver
>   #endif
>
> -#ifdef CONFIG_CPU_SUBTYPE_SH7786
> +#if defined(CONFIG_CPU_SUBTYPE_SH7757) || \
> +    defined(CONFIG_CPU_SUBTYPE_SH7785)

    Not CONFIG_CPU_SUBTYPE_SH7786?

>   #include "ehci-sh.c"
>   #define PLATFORM_DRIVER		ehci_hcd_sh_driver
>   #endif

WBR, Sergei
