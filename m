From: Greg KH <greg@kroah.com>
Date: Fri, 06 Jun 2008 06:14:26 +0000
Subject: Re: [PATCH] usb: r8a66597-hcd: Add support for SH7723 USB host
Message-Id: <20080606061426.GA6210@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4847DA2C.3040606@renesas.com>
In-Reply-To: <4847DA2C.3040606@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jun 06, 2008 at 02:44:07PM +0900, Paul Mundt wrote:
> On Thu, Jun 05, 2008 at 09:21:00PM +0900, Yoshihiro Shimoda wrote:
> > R8A66597 is similar to SH7723 USB 2.0 Host/Function module.
> > In addition, the USB of SH7366 is compatible with SH7723.
> > It can support SH7723 USB host by changing Kconfig.
> > 
> > Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
> 
> Greg, if you don't have any issues with this I'll just take it in my tree
> with the platform patch.

I don't have any objection to it, if you want to submit it, feel free to
add:
	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>

thanks,

greg k-h
