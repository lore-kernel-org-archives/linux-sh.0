From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 24 Apr 2012 09:07:05 +0000
Subject: [PATCH 0/8] ARM: mach-shmobile: armadillo800eva: USB/SDHI/MMIF support patch set
Message-Id: <87bomhfqh7.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org


Hi Rafael, Magnus
Cc Simon

These are incremental patch set for armadillo800eva.

Kuninori Morimoto (8):
      ARM: mach-shmobile: clock-r8a7740: add USB clock
      ARM: mach-shmobile: clock-r8a7740: add SDHI clock
      ARM: mach-shmobile: clock-r8a7740: add MMCIF clock
      ARM: mach-shmobile: armadillo800eva: add USB function support
      ARM: mach-shmobile: armadillo800eva: add SDHI0 support
      ARM: mach-shmobile: armadillo800eva: add SDHI1 support
      ARM: mach-shmobile: armadillo800eva: add MMCIF support
      ARM: mach-shmobile: r8a7740: Reserve DMA memory for the frame buffer

This patch set include v3 of USB support.
Some R8A7740 clocks, for example, SUB/SPU/CEU/ clocks, use "usb24s" clock a=
s parent.
"usb24s" clock is parent clock of "usb24", and this "usb24" is the main clo=
ck for USB.
These are very confusing naming, but based on R8A7740 chip datasheet.

#5 support SDHI0, but it use polling mode.
Because CD (=CArd Detect) pin didn't connected to SDHI0_CD pin, but connect=
ed IRQ31.
We can use IRQ31 for CD, but it needs chattering removal operation.
So, I selected very simple solution (=3D polling mode).
But polling mode is very enough at this point.

If you use USB function, please select

CONFIG_USB_RENESAS_USBHS=3Dy
CONFIG_USB_RENESAS_USBHS_UDC=3Dy

and select USB Gadget driver.
I used CONFIG_USB_ETH for test.

And set SW1.6 ON, then you can use CN24.

# insmod g_ether.ko
# ifconfig usb0 xxx.xxx.xxx.xxx up


Best regards
---
Kuninori Morimoto
