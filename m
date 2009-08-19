From: Greg KH <gregkh@suse.de>
Date: Wed, 19 Aug 2009 14:14:18 +0000
Subject: Re: [PATCH] usb: add support R8A66597 peripheral controller driver
Message-Id: <20090819141418.GB31169@suse.de>
List-Id: <linux-sh.vger.kernel.org>
References: <4A8B86BB.1020605@renesas.com>
In-Reply-To: <4A8B86BB.1020605@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Aug 19, 2009 at 07:22:04PM +0900, Magnus Damm wrote:
> Hi Shimoda-san,
> 
> [CC Paul]
> 
> On Wed, Aug 19, 2009 at 1:59 PM, Yoshihiro
> Shimoda<shimoda.yoshihiro@renesas.com> wrote:
> > The R8A66597 is Renesas USB 2.0 host and peripheral controller.
> > This controller supports USB High-speed. This driver supports
> > peripheral side.
> >
> > Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
> 
> Thanks for your work on this. I've tested this driver on a ms7724se
> board together with my two recently posted patches. I tested with
> CONFIG_USB_CDC_COMPOSITE and I can successfully transfer files to my
> PC using the USB connection. So all seems fine.
> 
> Tested-by: Magnus Damm <damm@igel.co.jp>
> 
> Greg, I suggest that this driver and future modifications are picked
> up by Paul. He has a stack of changes already.

No objection from me.

thanks,

greg k-h
