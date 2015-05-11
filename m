From: Simon Horman <horms@verge.net.au>
Date: Mon, 11 May 2015 23:56:26 +0000
Subject: Re: [PATCH v3 0/2] ARM: shmobile: r8a7791: add for USB-DMAC
Message-Id: <20150511235626.GD445@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1431069214-8052-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1431069214-8052-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: magnus.damm@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, devicetree@vger.kernel.org, linux-arm-kernel@vger.kernel.org, linux-sh@vger.kernel.org

On Fri, May 08, 2015 at 04:13:32PM +0900, Yoshihiro Shimoda wrote:
> This patch set is based on renesas.git / renesas-devel-20150507-v4.1-rc1
> tag. (commit id =3D c3059b3fff4ed6568783fdabdee1d62a55aa469c)
>=20
> This patch set is related to the usb-dmac driver and renesas_usbhs driver.
> Almost all patches for the drivers have been merged in Linus tree.
> And a fixed patch for renesas_usbhs driver have beed merged in the subsys=
tem:
>=20
> [ linux repository ]
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/dr=
ivers/dma/sh/usb-dmac.c?id=0C1c8ff32fa29e425b4938934c21afdb81104431
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/dr=
ivers/dma/sh/usb-dmac.c?id=D7d8e892aa6fe280a2e2974d9fd1ec9253ee1a05
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/dr=
ivers/usb/renesas_usbhs?idz96b78464bd8ba72c1c3095c543c1402db59e35
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/dr=
ivers/usb/renesas_usbhs?id=9B53d9af7aac09cf249d72bfbf15f08e47c4f7fe
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/dr=
ivers/usb/renesas_usbhs?id=AB330cf3888d8e0779fa05a243d53ba9f53a7ba9
>=20
> [ usb repository ]
> https://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/commit/?h=3Dte=
sting/next&idZ294e5469891d0701183049c4a9678887fa7091

Thanks, I have queued these up for v4.2.
