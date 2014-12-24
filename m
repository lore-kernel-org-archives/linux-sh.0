From: Vinod Koul <vinod.koul@intel.com>
Date: Wed, 24 Dec 2014 05:47:44 +0000
Subject: Re: [GIT PULL FOR v3.20] R-Car DMA engine driver
Message-Id: <20141224053544.GT16827@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <25808042.z3ylOLx5GF@avalon>
In-Reply-To: <25808042.z3ylOLx5GF@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Tue, Dec 23, 2014 at 11:16:52AM +0200, Laurent Pinchart wrote:
> Hi Vinod,
>=20
> The following changes since commit fbde286783f7c1e55e6c33575fa1a56f8ea77c=
90:
>=20
>   dmaengine: nbpfaxi: update the driver comments (2014-12-22 20:28:04 +05=
30)
>=20
> are available in the git repository at:
>=20
>   git://linuxtv.org/pinchartl/fbdev.git dma/next
>=20
> for you to fetch changes up to ee4b876bbee2c5c53518110849f23c117eec099c:
>=20
>   dmaengine: rcar-dmac: Handle hardware descriptor allocation failure=20
> (2014-12-23 11:13:03 +0200)
Merged now, Thanks

--=20
~Vinod

>=20
> ----------------------------------------------------------------
> J=FCrg Billeter (1):
>       dmaengine: rcar-dmac: Handle hardware descriptor allocation failure
>=20
> Laurent Pinchart (5):
>       dmaengine: Add 16 bytes, 32 bytes and 64 bytes bus widths
>       dmaengine: rcar-dmac: Remove duplicate sentence from DT bindings
>       dmaengine: rcar-dmac: Add Renesas R-Car Gen2 DMA Controller (DMAC) =

> driver
>       dmaengine: rcar-dmac: Implement support for hardware descriptor lis=
ts
>       dmaengine: rcar-dmac: Cache hardware descriptors memory
>=20
>  .../devicetree/bindings/dma/renesas,rcar-dmac.txt       |    3 -
>  drivers/dma/Makefile                                    |    2 +-
>  drivers/dma/sh/Kconfig                                  |   14 +-
>  drivers/dma/sh/Makefile                                 |    1 +
>  drivers/dma/sh/rcar-dmac.c                              | 1747 +++++++++=
+++++
>  include/linux/dmaengine.h                               |    3 +
>  6 files changed, 1765 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/dma/sh/rcar-dmac.c
>=20
> --=20
> Regards,
>=20
> Laurent Pinchart
>=20

--=20
