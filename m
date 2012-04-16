From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 16 Apr 2012 04:55:02 +0000
Subject: Re: [PATCH 0/3 v2] ARM: mach-shmobile: r8a7740: USB Function support
Message-Id: <87zkac5l99.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Rafael, Simon

These are v2 of USB Function support patches for Armadillo board.

Kuninori Morimoto (3):
      ARM: mach-shmobile: r8a7740: add usb clock support
      ARM: mach-shmobile: armadillo800eva: tidyup dipswitch explain for SDHI
      ARM: mach-shmobile: armadillo800eva: add USB function support

#1, #2 are same as v1
I added explain for workaround on #3.

>> Simon

Please add below on your .config

CONFIG_USB_RENESAS_USBHS=y
CONFIG_USB_RENESAS_USBHS_UDC=y

and select USB Gadget driver.
I used CONFIG_USB_ETH for test.

And set SW1.6 ON, then you can use CN24.

# insmod g_ether.ko
# ifconfig usb0 xxx.xxx.xxx.xxx up

Best regards
---
Kuninori Morimoto
