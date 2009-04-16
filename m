From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 16 Apr 2009 01:05:46 +0000
Subject: Re: [PATCH 3/6] Add USB support for SH7724
Message-Id: <20090416010546.GE16961@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uzlej1ubl.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uzlej1ubl.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Apr 16, 2009 at 09:41:55AM +0900, Kuninori Morimoto wrote:
> > > ?static struct platform_device *sh7724_devices[] __initdata = {
> > > ? ? ? ?&sci_device,
> > > ? ? ? ?&rtc_device,
> > > + ? ? ? &usb0_device,
> > > ?};
> > 
> > How about usb1?
> 
> Now, we can not support usb1.
> Because latest manual (Rev 0.11) doesn't have
> explain for usb1 interrupt line number.
> sorry, I didn't explain about it.
> 
This is going to be a pretty common problem, we should make sure that
each of the registered platform devices actually has a working IRQ. The
entire INTC section ought to be thrown out and burned for all the good it
does us today.
