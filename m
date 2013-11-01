From: Greg KH <greg@kroah.com>
Date: Fri, 01 Nov 2013 14:32:23 +0000
Subject: Re: [PATCH] usb: phy: Move R-Car Gen2 driver registration to postcore_inictall
Message-Id: <20131101143223.GA17660@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383063666-4291-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1383063666-4291-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Nov 01, 2013 at 05:59:40PM +0400, Valentine wrote:
> I'm not sure how this problem should be addressed using USB HCD PCI deferred probing.
> However, at the same time I see that six usb phy drivers use subsys_initcall and one
> uses postcore_initcall to adjust the initialization order.

Then they are all wrong and should be fixed.  Again, this is _why_ we
created the deferred probing logic, and it should be used for this type
of thing, as trying to juggle init call levels is madness and you will
loose in the end (think multi-system kernel images, how is that going to
work?)

thanks,

greg k-h
