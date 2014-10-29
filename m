From: Simon Horman <horms@verge.net.au>
Date: Wed, 29 Oct 2014 23:57:49 +0000
Subject: Re: [PATCH v2 2/2] ARM: shmobile: lager: enable USB3.0
Message-Id: <20141029235748.GD4599@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1414147307-4584-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1414147307-4584-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CANqRtoQTBd23z4uVK-EB7JJuJ_K0GkV6ueVfnywShqe6Dx0T5w@mail.gmail.com>
 <5450CD42.9070101@renesas.com>
In-Reply-To: <5450CD42.9070101@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-USB <linux-usb@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>

On Wed, Oct 29, 2014 at 08:19:30PM +0900, Yoshihiro Shimoda wrote:
> Hi Magnus-san,
> 
> (2014/10/29 15:53), Magnus Damm wrote:
> > On Fri, Oct 24, 2014 at 7:41 PM, Yoshihiro Shimoda
> > <yoshihiro.shimoda.uh@renesas.com> wrote:
> >> Since the PHY of USB3.0 and EHCI/OHCI ch2 are the same, the USB3.0
> >> driver cannot use the phy driver when the EHCI/OHCI ch2 already used it:
> >>
> >> phy phy-e6590100.usb-phy.3: phy init failed --> -16
> >> xhci-hcd: probe of ee000000.usb failed with error -16
> >>
> >> If so, we have to unbind the EHCI/OHCI ch2, and then we have to bind
> >> the USB3.0 driver as the following:
> >>
> >>   echo 0000:02:02.0 > /sys/bus/pci/drivers/ehci-pci/unbind
> >>   echo 0000:02:01.0 > /sys/bus/pci/drivers/ohci-pci/unbind
> >>   echo ee000000.usb > /sys/bus/platform/drivers/xhci-hcd/bind
> >>
> >> Note that there will be pinctrl-related error messages if both
> >> internal PCI and USB3.0 are enabled but they should be just ignored:
> >>
> >> sh-pfc e6060000.pfc: pin GP_5_22 already requested by ee0d0000.pci; cannot claim for ee000000.usb
> >> sh-pfc e6060000.pfc: pin-182 (ee000000.usb) status -22
> >> ata1: SATA link down (SStatus 0 SControl 300)
> >> sh-pfc e6060000.pfc: could not request pin 182 (GP_5_22) from group usb2  on device sh-pfc
> >>
> >> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> >> ---
> >>  arch/arm/boot/dts/r8a7790-lager.dts |    6 ++++++
> >>  1 file changed, 6 insertions(+)
> > 
> > Hi Shimoda-san,
> > 
> > Thanks for your patch. I'm fine with this patch as a first step, but
> > I'm wondering what the reason is to prioritize USB 2.0 over USB 3.0?
> 
> I investigated this reason today, and I found the reason is
> request_firmware().  I checked the following environments:
> 
>  Case 1: xHCI and EHCI and OHCI are enabled "=y" Case 2: xHCI and EHCI
>  and OHCI are loadable modules "=m" Case 3: xHCI and EHCI and OHCI are
>  enabled "=y", and CONFIG_EXTRA_FIRMWARE is enabled
> 
> The results are: - In "Case 1", EHCI and OHCI are probed first because
> xHCI didn't find the firmware.  - In "Case 2" and "Case 3", xHCI is
> probed first.
> 
> > Is the current order just based on device init order? In my mind the
> > expected behavior would be to always use USB 3.0 if it happens to be
> > available in the hardware, specified in the DTS, enabled by the kernel
> > configuration and firmware is loadable. Or does some case exist where
> > it is better to use USB 2.0? I suspect no.
> 
> I agree with you.
> 
> > So I wonder if you have any plans how to make USB 3.0 enabled by
> > default on Lager?
> 
> It depends on a kernel config. I'm not sure of the shmobile_defconfig
> strategy.  But, in my opinion, one of a solution is kernel modules (this
> means the "Case 2".)

It sounds like we should enable CONFIG_EXTRA_FIRMWARE in
shmobile_defconfig. I wonder what if any fallout we can foresee occurring
if we do that.
