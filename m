From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 19 Dec 2013 10:09:59 +0000
Subject: Re: [PATCH 0/5] arm: shmobile: Lager Add USB and SATA support
Message-Id: <CANqRtoQyXiTOCUeZrFDchfV2q4hXZzS-d-igUuZT=3WDbUEMqQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387370660-20481-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1387370660-20481-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Valentine,

Thanks for posting this patch series.

On Wed, Dec 18, 2013 at 9:44 PM, Valentine Barshak
<valentine.barshak@cogentembedded.com> wrote:
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

So let me clarify about the above, this is for USB Host 2.0 support
only? Or is USB Function also included? If both are included, can you
please show me the dependencies for USB Function by itself?

> SATA:
> https://git.kernel.org/cgit/linux/kernel/git/tj/libata.git/commit/?h=3Dfo=
r-3.14&id=E67adb4e669db834c1f95cbdf99bb4e9ec8455b3

This patch looks like a small enough dependency for us to handle
easily. I propose that we begin getting this one merged.

> The USB channel 0 (CN6) is configured as PCI USB host if USB_RENESAS_USBH=
S_UDC is disabled.
> Otherwise it is configured as USBHS device.
> Please note that the following switches have to be set correctly as well:
> PCI USB Host: SW5 - pin1;    SW6 - pin1
> USBHS device: SW5 - neutral; SW6 - pin3
>
> Valentine Barshak (5):
>   arm: shmobile: r8a7790: Add PCI USB host clock support
>   arm: shmobile: r8a7790: Add SATA clock
>   arm: shmobile: lager: Add USBHS support
>   arm: shmobile: lager: Add internal PCI support
>   arm: shmobile: lager: Add SATA support

May I ask you to break out the SATA bits and submit them as a separate
series. I'd like to try them on both Lager and Koelsch, so if you
happen to have patches for both boards then that would be great
(platform device style for now is acceptable to me).

Timing wise we're a bit unfortunate with the holidays and all, but I
will do my best to work with Simon to get your code merged. I will
probably ask you to add support for DT via CCF and MULTIPLATFORM in
the not too distant future, hope that's ok.

When we're done with SATA then i'd like to give USB Function a go too,
please let me know those dependencies.

Cheers,

/ magnus
