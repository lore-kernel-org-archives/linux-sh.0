From: David Daney <ddaney@caviumnetworks.com>
Date: Mon, 29 Nov 2010 18:49:58 +0000
Subject: Re: [PATCH] SuperH on-chip EHCI glue
Message-Id: <4CF3F5D6.3010309@caviumnetworks.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20101125080349.GG3270@linux-sh.org>
In-Reply-To: <20101125080349.GG3270@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 11/25/2010 12:03 AM, Paul Mundt wrote:
[...]
> diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> index 67eb377..22a9173 100644
> --- a/drivers/usb/Kconfig
> +++ b/drivers/usb/Kconfig
> @@ -66,6 +66,7 @@ config USB_ARCH_HAS_EHCI
>   	default y if ARCH_AT91SAM9G45
>   	default y if ARCH_MXC
>   	default y if ARCH_OMAP3
> +	default y if CPU_SUBTYPE_SH7786
>   	default PCI
>

How about moving that to your archecture Kconfig as:

  '        select USB_ARCH_HAS_EHCI'

We should be working towards reducing this per-chip churn in the Kconfig 
files if possible.

David Daney
