From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 29 Oct 2014 06:53:45 +0000
Subject: Re: [PATCH v2 2/2] ARM: shmobile: lager: enable USB3.0
Message-Id: <CANqRtoQTBd23z4uVK-EB7JJuJ_K0GkV6ueVfnywShqe6Dx0T5w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414147307-4584-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1414147307-4584-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1414147307-4584-3-git-send-email-yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: "Simon Horman [Horms]" <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-USB <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Fri, Oct 24, 2014 at 7:41 PM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Since the PHY of USB3.0 and EHCI/OHCI ch2 are the same, the USB3.0
> driver cannot use the phy driver when the EHCI/OHCI ch2 already used it:
>
> phy phy-e6590100.usb-phy.3: phy init failed --> -16
> xhci-hcd: probe of ee000000.usb failed with error -16
>
> If so, we have to unbind the EHCI/OHCI ch2, and then we have to bind
> the USB3.0 driver as the following:
>
>   echo 0000:02:02.0 > /sys/bus/pci/drivers/ehci-pci/unbind
>   echo 0000:02:01.0 > /sys/bus/pci/drivers/ohci-pci/unbind
>   echo ee000000.usb > /sys/bus/platform/drivers/xhci-hcd/bind
>
> Note that there will be pinctrl-related error messages if both
> internal PCI and USB3.0 are enabled but they should be just ignored:
>
> sh-pfc e6060000.pfc: pin GP_5_22 already requested by ee0d0000.pci; cannot claim for ee000000.usb
> sh-pfc e6060000.pfc: pin-182 (ee000000.usb) status -22
> ata1: SATA link down (SStatus 0 SControl 300)
> sh-pfc e6060000.pfc: could not request pin 182 (GP_5_22) from group usb2  on device sh-pfc
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  arch/arm/boot/dts/r8a7790-lager.dts |    6 ++++++
>  1 file changed, 6 insertions(+)

Hi Shimoda-san,

Thanks for your patch. I'm fine with this patch as a first step, but
I'm wondering what the reason is to prioritize USB 2.0 over USB 3.0?

Is the current order just based on device init order? In my mind the
expected behavior would be to always use USB 3.0 if it happens to be
available in the hardware, specified in the DTS, enabled by the kernel
configuration and firmware is loadable. Or does some case exist where
it is better to use USB 2.0? I suspect no.

So I wonder if you have any plans how to make USB 3.0 enabled by
default on Lager?

Thanks,

/ magnus
