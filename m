From: yoshihiro shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 24 Dec 2014 10:02:35 +0000
Subject: RE: [PATCH v2] renesas_usbhs: fix platform init error message
Message-Id: <HKNPR06MB32257F12A07F2218AE2D23ED8540@HKNPR06MB322.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5384843.KGcHOMgQLi@wasted.cogentembedded.com>
In-Reply-To: <5384843.KGcHOMgQLi@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Felipe-san, Sergei-san,

> -----Original Message-----
> From: Felipe Balbi [mailto:balbi@ti.com]
> Sent: Wednesday, December 24, 2014 4:17 AM
> 
> On Fri, Dec 19, 2014 at 03:46:41PM +0300, Sergei Shtylyov wrote:
> > Hello.
> >
> > On 12/19/2014 4:33 AM, yoshihiro shimoda wrote:
> >
> > [...]
> >
> > >>>>>>>There is a typo ("prove" instead of "probe") in the error message printed when
> > >>>>>>>the platform initialization fails. Replace that word with more fitting "init".
> >
> > >>>>>>>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >
> > >>>>>>this actually goes through me, I'll take it in a bit.
> >
> > >>>>>     Er, OK. Could you update MAINTAINERS?
> >
> > >>>>there is no entry for renesas driver in MAINTAINERS.
> >
> > >>>>Shimoda-san, care to send a patch adding yourself or Morimoto-san as
> > >>>>maintainers for Renesas driver and pointing to my tree in kernel.org ?
> >
> > >>>I would like to move the renesas_usbhs driver to drivers/usb/gadget/udc somehow.
> > >>>Because the driver is almost used for a gadget driver.
> > >>>The driver has a host driver support now. But, it is not used recently.
> >
> > >>>After that, this MAINTAINERS issue becomes clear, I think.
> > >>>Felipe-san and Sergei-san, what do you think?
> >
> > >>     I'm against such move.
> >
> > >Thank you for the reply. But, I would like to know why you are against such move.
> >
> >    Because we still need the host mode; RZ/A1H (R7S72100) SoC should need it
> > soon), and bi-modal USBHS hardware is better placed in its own directory.
> 
> yeah, I'll agree with Sergei here. All other dual role IPs have their
> own directories (musb, dwc3, dwc2, isp1760, chipidea...).

Thank you for the reply. I also agree with you.

By the way, about a renesas_usbhs maintainer, I don't know clearly.
If I do as a renesas_usbhs maintainer:
- what should I do as the maintainer?
 - I think I should check patches of renesas_usbhs
 - And, do I just return  ACK or NACK to the patches?

Best regards,
Yoshihiro Shimoda

> --
> balbi
