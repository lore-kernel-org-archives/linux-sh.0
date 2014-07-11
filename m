From: Simon Horman <horms@verge.net.au>
Date: Fri, 11 Jul 2014 09:00:07 +0000
Subject: Re: [PATCH v2 0/2] ARM: shmobile: lager: USBHS callback elimination
Message-Id: <20140711090005.GH12420@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
In-Reply-To: <53BF35B7.9000105@renesas.com>
 <87oawxy69b.wl%kuninori.morimoto.gx@renesas.com>
References: <1404978840-31917-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1404978840-31917-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

[Cc Felipe Balbi]

On Thu, Jul 10, 2014 at 01:20:34AM -0700, Kuninori Morimoto wrote:
> 
> Hi
> 
> > Changes in v2:
> > - move phy handle to struct usbhs_priv
> > - add new default pipe type to driver
> > - remove pipe type from Lager board code
> > 
> > Ulrich Hecht (2):
> >   usb: renesas_usbhs: add R-Car Gen. 2 init and power control
> >   ARM: shmobile: lager: remove USBHS callbacks
> > 
> >  arch/arm/mach-shmobile/board-lager.c | 126 ++++-------------------------------
> >  drivers/usb/renesas_usbhs/Makefile   |   2 +-
> >  drivers/usb/renesas_usbhs/common.c   |  66 ++++++++++++++++--
> >  drivers/usb/renesas_usbhs/common.h   |   2 +
> >  drivers/usb/renesas_usbhs/rcar2.c    |  76 +++++++++++++++++++++
> >  drivers/usb/renesas_usbhs/rcar2.h    |   4 ++
> >  include/linux/usb/renesas_usbhs.h    |   6 ++
> >  7 files changed, 163 insertions(+), 119 deletions(-)
> >  create mode 100644 drivers/usb/renesas_usbhs/rcar2.c
> >  create mode 100644 drivers/usb/renesas_usbhs/rcar2.h
> 
> For all patches
> 
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[snip]

> I tested these patches on Lager legacy, and these patches worked correctly.
> 
> Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Hi,

it seems that the 2nd patch should go through my renesas tree
but it depends on the first patch which should be taken by 
Felipe Balbi (Cced).

Felipe, is there any chance that you could take this for v3.16?
I am quite happy to make a branch for you to pull for renesas_usbhs
if this would make your life easier.
