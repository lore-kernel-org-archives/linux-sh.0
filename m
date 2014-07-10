From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 10 Jul 2014 08:20:34 +0000
Subject: Re: [PATCH v2 0/2] ARM: shmobile: lager: USBHS callback elimination
Message-Id: <87oawxy69b.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1404978840-31917-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1404978840-31917-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


Hi

> Changes in v2:
> - move phy handle to struct usbhs_priv
> - add new default pipe type to driver
> - remove pipe type from Lager board code
> 
> Ulrich Hecht (2):
>   usb: renesas_usbhs: add R-Car Gen. 2 init and power control
>   ARM: shmobile: lager: remove USBHS callbacks
> 
>  arch/arm/mach-shmobile/board-lager.c | 126 ++++-------------------------------
>  drivers/usb/renesas_usbhs/Makefile   |   2 +-
>  drivers/usb/renesas_usbhs/common.c   |  66 ++++++++++++++++--
>  drivers/usb/renesas_usbhs/common.h   |   2 +
>  drivers/usb/renesas_usbhs/rcar2.c    |  76 +++++++++++++++++++++
>  drivers/usb/renesas_usbhs/rcar2.h    |   4 ++
>  include/linux/usb/renesas_usbhs.h    |   6 ++
>  7 files changed, 163 insertions(+), 119 deletions(-)
>  create mode 100644 drivers/usb/renesas_usbhs/rcar2.c
>  create mode 100644 drivers/usb/renesas_usbhs/rcar2.h

For all patches

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

