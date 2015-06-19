From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 19 Jun 2015 09:38:51 +0000
Subject: Re: [PATCH v2 0/2] ARM: shmobile: r8a7791: add for USB-DMAC
Message-Id: <3233557.4LoILFSoWF@avalon>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hello Shimoda-san,

(Dropping the DT maintainers from CC and adding Linus Walleij, Kishon Vijay=
=20
Abraham and Felipe Balbi)

On Tuesday 07 April 2015 16:53:49 Yoshihiro Shimoda wrote:
> This patch set is based on renesas.git / renesas-devel-20150406-v4.0-rc6
> tag. (commit id =3D 8acf8f0880b6a142e6291b9a7d81f2f38c9425ac)
>=20
> This patch set is related to the usb-dmac driver and renesas_usbhs driver.
> And these drivers have been merged in each subsystem:
>=20
> [ slave-dma repository ]
> https://git.kernel.org/cgit/linux/kernel/git/vkoul/slave-dma.git/commit/?=
h=3Df
> or-linus&id=A7267831565030ab94dab76eb1afe5d4b63a1009
> https://git.kernel.org/cgit/linux/kernel/git/vkoul/slave-dma.git/commit/?=
h> for-linus&id=0C1c8ff32fa29e425b4938934c21afdb81104431
>=20
> [ usb repository ]
> https://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/commit/?h=3Dte=
sting
> /next&idz96b78464bd8ba72c1c3095c543c1402db59e35
> https://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/commit/?h=3Dte=
stin
> g/next&id=9B53d9af7aac09cf249d72bfbf15f08e47c4f7fe
> https://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/commit/?h=3Dte=
stin
> g/next&id=AB330cf3888d8e0779fa05a243d53ba9f53a7ba9
>=20
> Changes from v1:
>  - Rebase the latest renesas-devel tag.
>=20
> Yoshihiro Shimoda (2):
>   ARM: shmobile: r8a7791: add USB-DMAC device nodes
>   ARM: shmobile: r8a7791: Enable DMA for HSUSB

I've successfully tested USB-DMAC integration (congratulations for the good=
=20
work !), but ran into several issues that I wanted to discuss with you.

Both issues are I believe related to the fact that the HSUSB and EHCI/OHCI =

controllers share the same PHY and the same pins.

When both drivers are loaded, the following messages are printed to the ker=
nel=20
log.

[    8.917418] sh-pfc e6060000.pfc: pin GP_7_23 already requested by=20
ee090000.pci; cannot claim for e6590000.usb
[    8.927594] sh-pfc e6060000.pfc: pin-247 (e6590000.usb) status -22
[    8.933913] sh-pfc e6060000.pfc: could not request pin 247 (GP_7_23) fro=
m=20
group usb0  on device sh-pfc
[    8.943990] renesas_usbhs e6590000.usb: Error applying setting, reverse =

things back

This is caused by the pci0 and hsusb DT nodes referencing the same default =
pin=20
configuration node. There should be no issue in practice as the pin=20
configuration is already applied through the other device, but I'd still li=
ke=20
to find a fix to avoid the error message.

The other issue is that the renesas_hsusb and ehci drivers compete to contr=
ol=20
the same PHY. The phy-rcar-gen2 driver creates two Linux PHYs for each=20
physical PHY (called channel in the driver) to ensure that each driver can =
get=20
its own PHY instance. Arbitration is then handled in the PHY .init() handle=
r=20
which returns -EBUSY if another driver already controls the channel. The er=
ror=20
value is propagated up to usbhsc_power_ctrl() where it's then ignored. This=
=20
doesn't look like a good way to handled the shared PHY, but I'm not familia=
r=20
enough with the PHY subsystem to know how to fix it.

>  arch/arm/boot/dts/r8a7791.dtsi | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

--=20
Regards,

Laurent Pinchart
