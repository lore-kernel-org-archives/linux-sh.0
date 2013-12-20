From: Valentine <valentine.barshak@cogentembedded.com>
Date: Fri, 20 Dec 2013 14:07:46 +0000
Subject: Re: [PATCH 0/5] arm: shmobile: Lager Add USB and SATA support
Message-Id: <52B44F32.80803@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387370660-20481-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1387370660-20481-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On 12/18/2013 04:44 PM, Valentine Barshak wrote:
> I've decided to bundle USB and SATA patches together, since I've done SAT=
A on top of USB.
> Most of the SATA/USBHS/PCI USB host support patches for Lager are availab=
le in the respective
> susbsystem git trees (for 3.14) but are still missing from the Renesas tr=
ee.
>
> So, in order to test these, the following patches from other subsystem tr=
ees are needed:
> USB:
> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=3D=
pci/host-rcar&id=FB178d8b2fab3f2a9f203c13ffe80cfd6e01bdf1
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?i=
d=C8ba8115a21226fba3211085f570b128fa271e31
> https://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/commit/?h=3Dne=
xt&id=C3e5d2985ef720cbbdc63546a5c545ac4450d96e
> https://git.kernel.org/cgit/linux/kernel/git/gregkh/usb.git/commit/?h=3Du=
sb-next&id=103e127d1f8f985e8a662da6537ebc5e08902ee3
> https://git.kernel.org/cgit/linux/kernel/git/gregkh/usb.git/commit/?h=3Du=
sb-next&id=1Ae5799ef63176cc75ec10e545cb65f620a82747
>
> SATA:
> https://git.kernel.org/cgit/linux/kernel/git/tj/libata.git/commit/?h=3Dfo=
r-3.14&id=E67adb4e669db834c1f95cbdf99bb4e9ec8455b3
>
> The USB channel 0 (CN6) is configured as PCI USB host if USB_RENESAS_USBH=
S_UDC is disabled.
> Otherwise it is configured as USBHS device.
> Please note that the following switches have to be set correctly as well:
> PCI USB Host: SW5 - pin1;    SW6 - pin1
> USBHS device: SW5 - neutral; SW6 - pin3
>
> Valentine Barshak (5):
>    arm: shmobile: r8a7790: Add PCI USB host clock support
>    arm: shmobile: r8a7790: Add SATA clock
>    arm: shmobile: lager: Add USBHS support
>    arm: shmobile: lager: Add internal PCI support
>    arm: shmobile: lager: Add SATA support
>
>   arch/arm/mach-shmobile/board-lager.c   | 203 ++++++++++++++++++++++++++=
+++++++
>   arch/arm/mach-shmobile/clock-r8a7790.c |  25 +++-
>   2 files changed, 227 insertions(+), 1 deletion(-)
>

I've rebased the series on top of the latest renesas-devel-v3.13-rc4-201312=
19 branch
and split it into separate USB and SATA ones. The SATA support was posted y=
esterday.
I'll resend the USB part for both Lager/Koelsch boards in a bit.

Thanks,
Val.
