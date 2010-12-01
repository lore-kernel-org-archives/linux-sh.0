From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 01 Dec 2010 07:02:15 +0000
Subject: Re: [PATCH] SuperH on-chip EHCI glue
Message-Id: <20101201070215.GD19838@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20101125080349.GG3270@linux-sh.org>
In-Reply-To: <20101125080349.GG3270@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Nov 29, 2010 at 10:49:58AM -0800, David Daney wrote:
> On 11/25/2010 12:03 AM, Paul Mundt wrote:
> [...]
> >diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> >index 67eb377..22a9173 100644
> >--- a/drivers/usb/Kconfig
> >+++ b/drivers/usb/Kconfig
> >@@ -66,6 +66,7 @@ config USB_ARCH_HAS_EHCI
> >  	default y if ARCH_AT91SAM9G45
> >  	default y if ARCH_MXC
> >  	default y if ARCH_OMAP3
> >+	default y if CPU_SUBTYPE_SH7786
> >  	default PCI
> >
> 
> How about moving that to your archecture Kconfig as:
> 
>  '        select USB_ARCH_HAS_EHCI'
> 
> We should be working towards reducing this per-chip churn in the Kconfig 
> files if possible.
> 
Good idea, I didn't realize other architectures were doing this already.
I've now ended up doing this for all of the SH subtypes with EHCI/OHCI
support, which will follow in an updated patch.
