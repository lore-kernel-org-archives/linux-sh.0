From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Wed, 18 Dec 2013 12:44:15 +0000
Subject: [PATCH 0/5] arm: shmobile: Lager Add USB and SATA support
Message-Id: <1387370660-20481-1-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

I've decided to bundle USB and SATA patches together, since I've done SATA =
on top of USB.
Most of the SATA/USBHS/PCI USB host support patches for Lager are available=
 in the respective
susbsystem git trees (for 3.14) but are still missing from the Renesas tree.

So, in order to test these, the following patches from other subsystem tree=
s are needed:
USB:
https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=3Dpc=
i/host-rcar&id=FB178d8b2fab3f2a9f203c13ffe80cfd6e01bdf1
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=
=C8ba8115a21226fba3211085f570b128fa271e31
https://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/commit/?h=3Dnext=
&id=C3e5d2985ef720cbbdc63546a5c545ac4450d96e
https://git.kernel.org/cgit/linux/kernel/git/gregkh/usb.git/commit/?h=3Dusb=
-next&id=103e127d1f8f985e8a662da6537ebc5e08902ee3
https://git.kernel.org/cgit/linux/kernel/git/gregkh/usb.git/commit/?h=3Dusb=
-next&id=1Ae5799ef63176cc75ec10e545cb65f620a82747

SATA:
https://git.kernel.org/cgit/linux/kernel/git/tj/libata.git/commit/?h=3Dfor-=
3.14&id=E67adb4e669db834c1f95cbdf99bb4e9ec8455b3

The USB channel 0 (CN6) is configured as PCI USB host if USB_RENESAS_USBHS_=
UDC is disabled.
Otherwise it is configured as USBHS device.
Please note that the following switches have to be set correctly as well:
PCI USB Host: SW5 - pin1;    SW6 - pin1
USBHS device: SW5 - neutral; SW6 - pin3

Valentine Barshak (5):
  arm: shmobile: r8a7790: Add PCI USB host clock support
  arm: shmobile: r8a7790: Add SATA clock
  arm: shmobile: lager: Add USBHS support
  arm: shmobile: lager: Add internal PCI support
  arm: shmobile: lager: Add SATA support

 arch/arm/mach-shmobile/board-lager.c   | 203 +++++++++++++++++++++++++++++=
++++
 arch/arm/mach-shmobile/clock-r8a7790.c |  25 +++-
 2 files changed, 227 insertions(+), 1 deletion(-)

--=20
1.8.3.1

