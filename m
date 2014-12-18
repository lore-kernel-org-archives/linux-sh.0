From: yoshihiro shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 18 Dec 2014 01:46:18 +0000
Subject: RE: [PATCH v2] renesas_usbhs: fix platform init error message
Message-Id: <HKNPR06MB322E88E1F8795498C0AAE28D86A0@HKNPR06MB322.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5384843.KGcHOMgQLi@wasted.cogentembedded.com>
In-Reply-To: <5384843.KGcHOMgQLi@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

I'm very sorry for the delayed response.

> -----Original Message-----
> From: linux-usb-owner@vger.kernel.org [mailto:linux-usb-owner@vger.kernel.org] On Behalf Of Felipe Balbi
> Sent: Wednesday, November 05, 2014 8:01 AM
> 
> Hi,
> 
> On Wed, Nov 05, 2014 at 01:55:17AM +0300, Sergei Shtylyov wrote:
> > Hello.
> >
> > On 11/05/2014 01:53 AM, Felipe Balbi wrote:
> >
> > >>There is a typo ("prove" instead of "probe") in the error message printed when
> > >>the platform initialization fails. Replace that word with more fitting "init".
> >
> > >>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >
> > >this actually goes through me, I'll take it in a bit.
> >
> >    Er, OK. Could you update MAINTAINERS?
> 
> there is no entry for renesas driver in MAINTAINERS.
> 
> Shimoda-san, care to send a patch adding yourself or Morimoto-san as
> maintainers for Renesas driver and pointing to my tree in kernel.org ?

I would like to move the renesas_usbhs driver to drivers/usb/gadget/udc somehow.
Because the driver is almost used for a gadget driver.
The driver has a host driver support now. But, it is not used recently.

After that, this MAINTAINERS issue becomes clear, I think.
Felipe-san and Sergei-san, what do you think?

Best regards,
Yoshihiro Shimoda

> Thank you
> 
> --
> balbi
