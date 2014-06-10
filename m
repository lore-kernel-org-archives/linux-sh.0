From: Simon Horman <horms@verge.net.au>
Date: Tue, 10 Jun 2014 01:57:39 +0000
Subject: Re: [PATCH v3 00/05] staging: Emma Mobile USB driver and KZM9D board code V3
Message-Id: <20140610015736.GH30874@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140606104408.4423.36098.sendpatchset@w520>
 <20140606153949.GB13961@kroah.com>
 <CANqRtoSiYGjkR=sXvGcx1JrT6gx37ZcxDHY+ixkK_=e1GPB-DA@mail.gmail.com>
In-Reply-To: <CANqRtoSiYGjkR=sXvGcx1JrT6gx37ZcxDHY+ixkK_=e1GPB-DA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, driverdevel <devel@driverdev.osuosl.org>, Paul Bolle <pebolle@tiscali.nl>, SH-Linux <linux-sh@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Olof Johansson <olof@lixom.net>, Dan Carpenter <dan.carpenter@oracle.com>

On Mon, Jun 09, 2014 at 02:14:38PM +0900, Magnus Damm wrote:
> On Sat, Jun 7, 2014 at 12:39 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Fri, Jun 06, 2014 at 07:44:08PM +0900, Magnus Damm wrote:
> >> staging: Emma Mobile USB driver and KZM9D board code V3
> >>
> >> [PATCH v3 01/05] staging: emxx_udc: Add Emma Mobile USB Gadget driver
> >> [PATCH v3 02/05] staging: emxx_udc: I/O memory and IRQ resource support
> >> [PATCH v3 03/05] staging: emxx_udc: Add TODO file
> >> [PATCH v3 04/05] staging: board: Initial board staging support
> >> [PATCH v3 05/05] staging: board: kzm9d: Board staging support for emxx_udc
> >>
> >> This patch series is V3 of the old USB Gadget driver for Emma Mobile
> >> that gets slightly adjusted to make use of the platform device interface
> >> which in turn is used to add USB Gadget support to the KZM9D board.
> >>
> >> Two separate staging components are included in this series:
> >> 1) the emxx_udc driver - from out-of-tree Android 2.6.35.7
> >> 2) board staging support for KZM9D - platform device for DT-only KZM9D
> >>
> >> The two components above will be used to continously improve the driver
> >> and board integration code until the driver can be moved out of staging
> >> and/or DT bindings are available so the board staging platform device code
> >> can be replaced with a DT node.
> >>
> >> Changes since V2:
> >> - Added CONFIG_OF_ADDRESS dependency for the board staging bits
> >>
> >> Changes since V1:
> >> - Added TODO file for emxx_udc
> >> - Broke out board staging base support, included TODO file
> >> - Added code to avoid registering platform device if DT node exists
> >> - Modified KZM9D board code build condition to use SoC Kconfig entry
> >>
> >> Many thanks to Dan Carpenter, Geert Uytterhoeven, Greg KH and
> >> Paul Bolle for feedback!
> >>
> >> Please let me know if you would like me to rebase this code somehow.
> >
> > At quick glance, this looks good.  I'll queue it up after 3.16-rc1 is
> > out as it's too late for this merge window.
> 
> Thanks, Greg! This sounds perfect to me!

FWIW,

Acked-by: Simon Horman <horms+renesas@verge.net.au>

