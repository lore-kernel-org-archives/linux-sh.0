From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 09 Dec 2013 20:32:37 +0000
Subject: Re: [PATCH V2] usb: phy: R-Car Gen2: Use usb_add_phy_dev
Message-Id: <20131209203237.GA9225@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1386618033-27670-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1386618033-27670-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Dec 10, 2013 at 12:16:13AM +0400, Valentine wrote:
> On 12/09/2013 11:41 PM, Felipe Balbi wrote:
> > Hi,
> >
> > On Mon, Dec 09, 2013 at 11:40:33PM +0400, Valentine Barshak wrote:
> >> Use usb_add_phy_dev instead of usb_add_phy, so that devices can
> >> be bound to the phy. This is needed to set up USB phy for
> >> some internal PCI USB host controllers on R-Car Gen2.
> >>
> >> Changes from previous version:
> >> * Fixed function names in the commit log
> >>
> >> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> >
> > Was this a regression on v3.13 or can it wait for v3.14 ?
> >
> 
> I hope it's OK to have it on 3.13.
> 
> The major reason for the change is to use the USB HCD phy handling
> updates that are available now in the usb-next branch of Greg's tree:
> commit 1ae5799ef6: usb: hcd: Initialize USB phy if needed

But that patch isn't going to Linus until 3.14, so this has to wait
until then as well.

sorry,

greg k-h
