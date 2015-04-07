From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 07 Apr 2015 07:53:49 +0000
Subject: [PATCH v2 0/2] ARM: shmobile: r8a7791: add for USB-DMAC
Message-Id: <1428393231-5272-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: horms@verge.net.au, magnus.damm@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk
Cc: devicetree@vger.kernel.org, linux-arm-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

This patch set is based on renesas.git / renesas-devel-20150406-v4.0-rc6
tag. (commit id =3D 8acf8f0880b6a142e6291b9a7d81f2f38c9425ac)

This patch set is related to the usb-dmac driver and renesas_usbhs driver.
And these drivers have been merged in each subsystem:

[ slave-dma repository ]
https://git.kernel.org/cgit/linux/kernel/git/vkoul/slave-dma.git/commit/?h=
=3Dfor-linus&id=A7267831565030ab94dab76eb1afe5d4b63a1009
https://git.kernel.org/cgit/linux/kernel/git/vkoul/slave-dma.git/commit/?h=
=3Dfor-linus&id=0C1c8ff32fa29e425b4938934c21afdb81104431

[ usb repository ]
https://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/commit/?h=3Dtest=
ing/next&idz96b78464bd8ba72c1c3095c543c1402db59e35
https://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/commit/?h=3Dtest=
ing/next&id=9B53d9af7aac09cf249d72bfbf15f08e47c4f7fe
https://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/commit/?h=3Dtest=
ing/next&id=AB330cf3888d8e0779fa05a243d53ba9f53a7ba9

Changes from v1:
 - Rebase the latest renesas-devel tag.

Yoshihiro Shimoda (2):
  ARM: shmobile: r8a7791: add USB-DMAC device nodes
  ARM: shmobile: r8a7791: Enable DMA for HSUSB

 arch/arm/boot/dts/r8a7791.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

--=20
1.9.1

