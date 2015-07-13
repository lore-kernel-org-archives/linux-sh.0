From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Mon, 13 Jul 2015 15:02:26 +0000
Subject: RE: [PATCH v3] phy: rcar-gen2 usb: Add Host/Function switching for USB0
Message-Id: <SIXPR06MB0639D6F8EC3D9091D139FC36F59C0@SIXPR06MB0639.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <SG2PR06MB0919835888EBD162D4B86C24D8930@SG2PR06MB0919.apcprd06.prod.outlook.com>
 <1436270121-25924-1-git-send-email-phil.edworthy@renesas.com>
 <559FF47A.5000001@cogentembedded.com>
 <SIXPR06MB0639B9810214ACE6C7F91FB6F59C0@SIXPR06MB0639.apcprd06.prod.outlook.com>
 <55A39030.1030601@cogentembedded.com>
In-Reply-To: <55A39030.1030601@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Kishon Vijay Abraham I <kishon@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Hi Sergei,

On 13 July 2015 11:17, Sergei wrote:
> Hello.
> 
> On 7/13/2015 12:04 PM, Phil Edworthy wrote:
> 
> >>> Instead of statically selecting the PHY connection to either the
> >>> USBHS (Function) or PCI0 (Host) IP blocks, this change allows the
> >>> dts to specifiy gpio pins for the vbus and id signals. Additional
> 
> >>      These GPIOs don't have anything to do with the PHY, they're interfacing
> 
>     Perhaps that was too strong statement but nevertheless...
Looking at your MAX3355 extcon driver, I can't see how it would work on it's
own. The system needs to sense vbus in order to determine that the board
has been plugged into a USB Host. Since the MAX3355 device doesn't
directly provide any vbus signals, this shouldn't be part of the extcon driver,
so where should it be?

On the other hand, the MAX3355 has a pair of status pins that can be used
to get vbus instead. If these pins aren't used for other functions, maybe
it's better to use these in the extcon driver.

My intention is to make the USB PHY driver listen for extcon events instead
of directly accessing the ID and VBUS signals, but otherwise behave in the
same way it currently does.

After reading some other threads, I also intend to set up a fixed regulator
for the MAX3355 device to setup the shutdown and vbus enable pins. I know
that the vbus enable should really be controlled some other way depending
on the role, but for the moment I think it's ok just to enable it always.

Do you think that is the correct way to progress this?

> >> Maxim MAX3355 OTG chip for which I have submitted the extcon driver.
> 
> > Hmm, I see what you mean... could you post your latest version of that
> > driver as it seems to have stalled 6 months ago?
> 
>     I haven't worked on that driver since then.
> 
> > Thanks
> > Phil
> 
> WBR, Sergei

Thanks
Phil
