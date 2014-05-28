From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 28 May 2014 20:28:49 +0000
Subject: Re: [PATCH v2 2/3] usb: host: xhci-plat: add support for the R-Car H2 and M2 xHCI controllers
Message-Id: <20140528202849.GA14248@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5385C71D.5060509@renesas.com>
In-Reply-To: <5385C71D.5060509@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: "mathias.nyman@intel.com" <mathias.nyman@intel.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Wed, May 28, 2014 at 08:23:09PM +0900, Yoshihiro Shimoda wrote:
> The R-Car H2 and M2 SoCs come with an xHCI controller that requires
> some specific initializations related to the firmware downloading and
> some specific registers. This patch adds the support for this special
> configuration as an xHCI quirk executed during probe and start.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/usb/host/Kconfig     |    8 +++
>  drivers/usb/host/Makefile    |    3 +
>  drivers/usb/host/xhci-plat.c |   18 +++++
>  drivers/usb/host/xhci-rcar.c |  160 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/usb/host/xhci-rcar.h |   27 +++++++
>  5 files changed, 216 insertions(+)
>  create mode 100644 drivers/usb/host/xhci-rcar.c
>  create mode 100644 drivers/usb/host/xhci-rcar.h

This doesn't apply cleanly to my tree, can you please refresh it and
resend?

thanks,

greg k-h
