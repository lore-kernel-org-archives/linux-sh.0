From: Shawn Guo <shawn.guo@freescale.com>
Date: Mon, 01 Sep 2014 13:27:38 +0000
Subject: Re: [GIT PULL] MFD: ARM (IMX & R8): Immutable branch for Dialog Semiconductor - vendor prefix consol
Message-Id: <20140901132736.GG3135@dragon>
List-Id: <linux-sh.vger.kernel.org>
References: <201408221446.s7MEkNVF001775@swsrvapps-01.diasemi.com>
 <20140829091359.GF24579@lee--X1>
In-Reply-To: <20140829091359.GF24579@lee--X1>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Lee,

On Fri, Aug 29, 2014 at 10:13:59AM +0100, Lee Jones wrote:
> IMX and R8 sub-arch Maintainers,
>=20
> The following changes since commit 52addcf9d6669fa439387610bc65c92fa0980c=
ef:
>=20
>   Linux 3.17-rc2 (2014-08-25 15:36:20 -0700)
>=20
> are available in the git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-a=
rm-v3.18
>=20
> for you to fetch changes up to bd597f47ca4bf7a522a0298a95c7f9b2f0a75b9e:
>=20
>   devicetree: Dialog Semiconductor consolidate existing vendor prefixes t=
o standardise on 'dlg' (2014-08-29 09:26:29 +0100)
>=20
> ----------------------------------------------------------------
> Immutable branch between MFD and some ARM sub-arch maintainers.

I assume that I need to pull it into my tree only when it turns out
there are merge conflicts, but otherwise it can just go through your
tree, right?

Shawn

> ----------------------------------------------------------------
> Steve Twiss (1):
>       devicetree: Dialog Semiconductor consolidate existing vendor prefix=
es to standardise on 'dlg'
>=20
>  .../devicetree/bindings/i2c/trivial-devices.txt    |  2 +-
>  .../devicetree/bindings/regulator/da9210.txt       |  4 ++--
>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>  arch/arm/boot/dts/imx53-smd.dts                    |  2 +-
>  arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi       |  2 +-
>  arch/arm/boot/dts/r8a7790-lager.dts                |  2 +-
>  arch/arm/boot/dts/r8a7791-koelsch.dts              |  2 +-
>  drivers/mfd/da9055-core.c                          | 26 +++++++++++-----=
------
>  8 files changed, 21 insertions(+), 20 deletions(-)
>=20
> --=20
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
