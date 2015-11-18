From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 18 Nov 2015 02:30:46 +0000
Subject: RE: [PATCH 1/3] usb: renesas_usbhs: gadget: Fix NULL pointer dereference in usbhsg_ep_dequeue()
Message-Id: <TY1PR06MB0928099452BF6A9F55E52343D81C0@TY1PR06MB0928.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1447307130-6072-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1447307130-6072-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

> From: Felipe Balbi [mailto:balbi@ti.com]
> Sent: Wednesday, November 18, 2015 12:32 AM
> 
> Hi,
> 
> Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com> writes:
> > This patch fixes an issue that NULL pointer dereference happens when
> > a gadget driver calls usb_ep_dequeue() after usb_ep_disable().
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> and which gadget driver is that ? Let's fix it. We should _not_ call
> usb_ep_dequeue() after usb_ep_disable().

Thank you for your comment.
I assumed that a gadget driver called usb_ep_dequeue() after usb_ep_disable().
However, it was wrong. This driver will call usbhsg_ep_dequeue() in usbhsg_try_stop().
So, if I disconnect a usb cable, and I uninstall a gadget driver, this issue happens
because the dcp->pipe is NULL after disconnected a usb cable.

So, I will revise the commit log as v2.
(Also I would like to fix this issue fundamentally, but it is tough because behavior of
 start/stop and connect/disconnect in this driver is complicated.)

Best regards,
Yoshihiro Shimoda

> --
> balbi
