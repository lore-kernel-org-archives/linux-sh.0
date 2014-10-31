From: yoshihiro shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 31 Oct 2014 02:06:14 +0000
Subject: RE: [PATCH v2 2/2] ARM: shmobile: lager: enable USB3.0
Message-Id: <2b89f66c72894bdf8bdce7aab7c69281@HKNPR06MB322.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414147307-4584-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1414147307-4584-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CANqRtoQTBd23z4uVK-EB7JJuJ_K0GkV6ueVfnywShqe6Dx0T5w@mail.gmail.com>
 <5450CD42.9070101@renesas.com> <20141029235748.GD4599@verge.net.au>
In-Reply-To: <20141029235748.GD4599@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-USB <linux-usb@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>

Hi Simon-san,

> On Wed, Oct 29, 2014 at 08:19:30PM +0900, Yoshihiro Shimoda wrote:
> > Hi Magnus-san,
> >
> > (2014/10/29 15:53), Magnus Damm wrote:
< snip >
> > >
> > > Hi Shimoda-san,
> > >
> > > Thanks for your patch. I'm fine with this patch as a first step, but
> > > I'm wondering what the reason is to prioritize USB 2.0 over USB 3.0?
> >
> > I investigated this reason today, and I found the reason is
> > request_firmware().  I checked the following environments:
> >
> >  Case 1: xHCI and EHCI and OHCI are enabled "=y" Case 2: xHCI and EHCI
> > and OHCI are loadable modules "=m" Case 3: xHCI and EHCI and OHCI are
> > enabled "=y", and CONFIG_EXTRA_FIRMWARE is enabled
> >
> > The results are: - In "Case 1", EHCI and OHCI are probed first because
> > xHCI didn't find the firmware.  - In "Case 2" and "Case 3", xHCI is
> > probed first.
> >
> > > Is the current order just based on device init order? In my mind the
> > > expected behavior would be to always use USB 3.0 if it happens to be
> > > available in the hardware, specified in the DTS, enabled by the
> > > kernel configuration and firmware is loadable. Or does some case
> > > exist where it is better to use USB 2.0? I suspect no.
> >
> > I agree with you.
> >
> > > So I wonder if you have any plans how to make USB 3.0 enabled by
> > > default on Lager?
> >
> > It depends on a kernel config. I'm not sure of the shmobile_defconfig
> > strategy.  But, in my opinion, one of a solution is kernel modules
> > (this means the "Case 2".)
> 
> It sounds like we should enable CONFIG_EXTRA_FIRMWARE in shmobile_defconfig. I wonder what if any fallout we can foresee
> occurring if we do that.

According to the firmware/README.AddingFirmware, we are unable to add a new firmware image to the firmware directory now.
So, if we enable CONFIG_EXTRA_FIRMWARE with the xHCI firmware, we will not build kernel because the xHCI firmware doesn't exist in the linux.git.

== from  firmware/README.AddingFirmware ==================This directory is _NOT_ for adding arbitrary new firmware images. The
place to add those is the separate linux-firmware repository:

    git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
=======================================

Best regards,
Yoshihiro Shimoda

