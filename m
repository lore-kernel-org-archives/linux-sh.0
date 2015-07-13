From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Mon, 13 Jul 2015 16:15:45 +0000
Subject: RE: [PATCH v6] usb: renesas_usbhs: Allow an OTG PHY driver to provide VBUS
Message-Id: <SIXPR06MB0639917B138CE5B09A764623F59C0@SIXPR06MB0639.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <SIXPR06MB0639856FCA734EC44BF54CFAF59C0@SIXPR06MB0639.apcprd06.prod.outlook.com>
 <1436801418-24411-1-git-send-email-phil.edworthy@renesas.com>
 <2017299.IS5RLqp2tB@avalon>
In-Reply-To: <2017299.IS5RLqp2tB@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Ulrich Hecht <ulrich.hecht@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Hi Laurent,

On 13 July 2015 16:51, Laurent wrote:
> Hi Phil,
> 
> Thank you for the patch.
> 
> On Monday 13 July 2015 16:30:18 Phil Edworthy wrote:
> > These changes allow a PHY driver to trigger a VBUS interrupt and
> > to provide the value of VBUS.
> >
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> 
> I don't see any further show stopper for this patch, so
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Do you plan to submit a patch to move PHY handling from gadget code to core
> code ?
Not at the moment... I am concentrating on the usb PHY driver and max3355
extcon driver. 

<snip>

Thanks
Phil
