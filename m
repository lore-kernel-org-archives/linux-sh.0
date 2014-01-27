From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 27 Jan 2014 09:59:58 +0000
Subject: Re: [PATCH V3 0/3] ARM: shmobile: lager: Add USB support
Message-Id: <52E62E1E.5040806@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1390602529-11867-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1390602529-11867-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On 24/01/14 22:28, Valentine Barshak wrote:
> The first patch adds USBHS device and the rest add PCI USB host support t=
o Lager board.
> The patches depend on the following commits:
> USBHS and PCI USB host:
> * http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?=
id=C8ba8115a21226fba3211085f570b128fa271e31
> * http://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/commit/?id=C3=
e5d2985ef720cbbdc63546a5c545ac4450d96e
> PCI USB host:
> * http://git.kernel.org/cgit/linux/kernel/git/gregkh/usb.git/commit/?h=3D=
usb-next&id=103e127d1f8f985e8a662da6537ebc5e08902ee3
> * http://git.kernel.org/cgit/linux/kernel/git/gregkh/usb.git/commit/?h=3D=
usb-next&id=1Ae5799ef63176cc75ec10e545cb65f620a82747
> * http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=
=3Dpci/host-rcar&id=FB178d8b2fab3f2a9f203c13ffe80cfd6e01bdf1

Hi, when doing this have you come across a problem where the OHCI
controller on USB0 fails to start with an initialisation error? I
think it is something to do with the bridge setup but have yet to
have enough time to look into this issue.

--=20
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
