From: yoshihiro shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 19 Dec 2014 01:33:55 +0000
Subject: RE: [PATCH v2] renesas_usbhs: fix platform init error message
Message-Id: <HKNPR06MB322521AB197256204283974D86B0@HKNPR06MB322.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5384843.KGcHOMgQLi@wasted.cogentembedded.com>
In-Reply-To: <5384843.KGcHOMgQLi@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

> -----Original Message-----
> From: Sergei Shtylyov [mailto:sergei.shtylyov@cogentembedded.com]
> Sent: Thursday, December 18, 2014 8:32 PM
> 
> Hello.
> 
> On 12/18/2014 4:46 AM, yoshihiro shimoda wrote:
> 
> [...]
> 
> >>>>> There is a typo ("prove" instead of "probe") in the error message printed when
> >>>>> the platform initialization fails. Replace that word with more fitting "init".
> 
> >>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> >>>> this actually goes through me, I'll take it in a bit.
> 
> >>>     Er, OK. Could you update MAINTAINERS?
> 
> >> there is no entry for renesas driver in MAINTAINERS.
> 
> >> Shimoda-san, care to send a patch adding yourself or Morimoto-san as
> >> maintainers for Renesas driver and pointing to my tree in kernel.org ?
> 
> > I would like to move the renesas_usbhs driver to drivers/usb/gadget/udc somehow.
> > Because the driver is almost used for a gadget driver.
> > The driver has a host driver support now. But, it is not used recently.
> 
> > After that, this MAINTAINERS issue becomes clear, I think.
> > Felipe-san and Sergei-san, what do you think?
> 
>     I'm against such move.

Thank you for the reply. But, I would like to know why you are against such move.

Best regards,
Yoshihiro Shimoda

> > Best regards,
> > Yoshihiro Shimoda
> 
> WBR, Sergei

