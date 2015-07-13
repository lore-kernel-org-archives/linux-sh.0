From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 13 Jul 2015 16:37:11 +0000
Subject: Re: [PATCH v3] phy: rcar-gen2 usb: Add Host/Function switching for USB0
Message-Id: <55A3E937.2050804@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <SG2PR06MB0919835888EBD162D4B86C24D8930@SG2PR06MB0919.apcprd06.prod.outlook.com> <1436270121-25924-1-git-send-email-phil.edworthy@renesas.com> <559FF47A.5000001@cogentembedded.com> <SIXPR06MB0639B9810214ACE6C7F91FB6F59C0@SIXPR06MB0639.apcprd06.prod.outlook.com> <55A39030.1030601@cogentembedded.com> <SIXPR06MB0639D6F8EC3D9091D139FC36F59C0@SIXPR06MB0639.apcprd06.prod.outlook.com>
In-Reply-To: <SIXPR06MB0639D6F8EC3D9091D139FC36F59C0-ptTgG45MbEnxWRUYInhZt20DtJ1/0DrXvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Phil Edworthy <phil.edworthy-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 07/13/2015 06:02 PM, Phil Edworthy wrote:

>>>>> Instead of statically selecting the PHY connection to either the
>>>>> USBHS (Function) or PCI0 (Host) IP blocks, this change allows the
>>>>> dts to specifiy gpio pins for the vbus and id signals. Additional

>>>>       These GPIOs don't have anything to do with the PHY, they're interfacing

>>      Perhaps that was too strong statement but nevertheless...

> Looking at your MAX3355 extcon driver, I can't see how it would work on it's
> own.

    I've added the 'extcon' support into the Renesas USBHS driver, so that it 
should be able to sense the ID pin status.

> The system needs to sense vbus in order to determine that the board
> has been plugged into a USB Host.

> Since the MAX3355 device doesn't
> directly provide any vbus signals,  this shouldn't be part of the extcon driver,
> so where should it be?

    Sure, MAX3355 does provide voltage on Vbus, controlled by -OFFVBUS input.
It's just that the driver has only ID sensing support.
    Do you have the MAX3355 datasheet at all?

> On the other hand, the MAX3355 has a pair of status pins that can be used
> to get vbus instead.

    Sure, these bits reflect 4 OTG Vbus thresholds.

> If these pins aren't used for other functions, maybe
> it's better to use these in the extcon driver.

    They are not.

> My intention is to make the USB PHY driver listen for extcon events instead
> of directly accessing the ID and VBUS signals, but otherwise behave in the
> same way it currently does.

    I'm not sure the PHY driver should be interested in that...

> After reading some other threads, I also intend to set up a fixed regulator
> for the MAX3355 device to setup the shutdown and vbus enable pins.  I know
> that the vbus enable should really be controlled some other way depending
> on the role, but for the moment I think it's ok just to enable it always.

    It's OK only in the host mode.
    I don't think we need regulators. SHDN- is already supported by the driver
(though it only drives it high at start-up time), in fact it was the only reason
not to use gpio.

> Do you think that is the correct way to progress this?

    I didn't have a clear picture how to implement the OTG support at the time 
of writing the MAX3355 driver; actually, I was tasked to only support ID p[in 
sensing.
    Note that there's some ongoing effort now on linux-usb to support OTG 
functionality.

> Thanks
> Phil

WBR, Sergei

