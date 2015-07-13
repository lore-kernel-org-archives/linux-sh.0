From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Mon, 13 Jul 2015 09:04:14 +0000
Subject: RE: [PATCH v3] phy: rcar-gen2 usb: Add Host/Function switching for USB0
Message-Id: <SIXPR06MB0639B9810214ACE6C7F91FB6F59C0@SIXPR06MB0639.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <SG2PR06MB0919835888EBD162D4B86C24D8930@SG2PR06MB0919.apcprd06.prod.outlook.com>
 <1436270121-25924-1-git-send-email-phil.edworthy@renesas.com>
 <559FF47A.5000001@cogentembedded.com>
In-Reply-To: <559FF47A.5000001-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Sergei,

On 10 July 2015 17:36, Sergei wrote:
> Hello.
> 
> On 07/07/2015 02:55 PM, Phil Edworthy wrote:
> 
> > Instead of statically selecting the PHY connection to either the
> > USBHS (Function) or PCI0 (Host) IP blocks, this change allows the
> > dts to specifiy gpio pins for the vbus and id signals. Additional
> 
>     These GPIOs don't have anything to do with the PHY, they're interfacing
> Maxim MAX3355 OTG chip for which I have submitted the extcon driver.
Hmm, I see what you mean... could you post your latest version of that
driver as it seems to have stalled 6 months ago?
 

> > gpio pins are used to control power to an external OTG device and
> > an override to turn vbus on/off.
> 
> > Note: the R-Car USB PHY only allows this Host/Function switching
> > on channel 0.
> 
> > This has been tested on a r8a7791 based Koelsch board, which uses
> > a MAX3355 device to supply vbus power when needed.
> 
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> 
>     I'm inclined to NAK this. You're modifying the wrong driver, I think.
> 
> WBR, Sergei

Thanks
Phil
