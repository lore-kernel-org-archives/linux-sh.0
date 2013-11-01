From: Greg KH <greg@kroah.com>
Date: Fri, 01 Nov 2013 15:30:53 +0000
Subject: Re: [PATCH] usb: phy: Move R-Car Gen2 driver registration to postcore_inictall
Message-Id: <20131101153053.GA21250@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383063666-4291-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1383063666-4291-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Nov 01, 2013 at 07:26:51PM +0400, Valentine wrote:
> On 11/01/2013 06:32 PM, Greg KH wrote:
> >On Fri, Nov 01, 2013 at 05:59:40PM +0400, Valentine wrote:
> >>I'm not sure how this problem should be addressed using USB HCD PCI deferred probing.
> >>However, at the same time I see that six usb phy drivers use subsys_initcall and one
> >>uses postcore_initcall to adjust the initialization order.
> >
> >Then they are all wrong and should be fixed.  Again, this is _why_ we
> >created the deferred probing logic, and it should be used for this type
> >of thing, as trying to juggle init call levels is madness and you will
> >loose in the end (think multi-system kernel images, how is that going to
> >work?)
> 
> I'm sorry, I don't see how moving driver registration from
> device_initcall to postcore_initcall alone breaks multi-system kernel
> image.

Ok, in this specific case, it probably doesn't make a difference, but
it's still a mess, right?  What happens if everyone uses
postcore_initcall, then we need to add another level after that because
someone wants to be there instead?

Again, that is why we added the deferred probing logic, use it please.

I should just go rip those changes out and put everything at
device_initcall in order to get people to fix the code properly...

thanks,

greg k-h
