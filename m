From: David Daney <ddaney@caviumnetworks.com>
Date: Fri, 25 Feb 2011 18:41:42 +0000
Subject: Re: [PATCH] usb: add EHCI and OHCI support for SH7757
Message-Id: <4D67F7E6.4000700@caviumnetworks.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4D660C04.9070800@renesas.com>
In-Reply-To: <4D660C04.9070800@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 02/24/2011 01:47 AM, Yoshihiro Shimoda wrote:
> Signed-off-by: Yoshihiro Shimoda<yoshihiro.shimoda.uh@renesas.com>
> ---
>   about v2:
>    - fix the condition for other CPU in ehci-hcd.c.
>
>   drivers/usb/host/ehci-hcd.c |    3 ++-
>   drivers/usb/host/ohci-hcd.c |    1 +
>   2 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
> index 4c77a81..b396567 100644
> --- a/drivers/usb/host/ehci-hcd.c
> +++ b/drivers/usb/host/ehci-hcd.c
> @@ -1184,7 +1184,8 @@ MODULE_LICENSE ("GPL");
>   #define PLATFORM_DRIVER		ehci_mxc_driver
>   #endif
>
> -#ifdef CONFIG_CPU_SUBTYPE_SH7786
> +#if defined(CONFIG_CPU_SUBTYPE_SH7757) || \
> +    defined(CONFIG_CPU_SUBTYPE_SH7786)
>   #include "ehci-sh.c"
>   #define PLATFORM_DRIVER		ehci_hcd_sh_driver
>   #endif
> diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
> index 759a12f..257974e 100644
> --- a/drivers/usb/host/ohci-hcd.c
> +++ b/drivers/usb/host/ohci-hcd.c
> @@ -1070,6 +1070,7 @@ MODULE_LICENSE ("GPL");
>
>   #if defined(CONFIG_CPU_SUBTYPE_SH7720) || \
>       defined(CONFIG_CPU_SUBTYPE_SH7721) || \
> +    defined(CONFIG_CPU_SUBTYPE_SH7757) || \
>       defined(CONFIG_CPU_SUBTYPE_SH7763) || \
>       defined(CONFIG_CPU_SUBTYPE_SH7786)
>   #include "ohci-sh.c"

I wonder if all that #ifdefery could be moved into the arch/sh Kconfig.

Patching the core ehci/ohci code each time a new sh CPU variant is 
released seems like the wrong approach.

David Daney
