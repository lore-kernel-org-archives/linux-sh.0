From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 01 Sep 2014 13:38:54 +0000
Subject: Re: [GIT PULL] MFD: ARM (IMX & R8): Immutable branch for Dialog Semiconductor - vendor prefix consol
Message-Id: <20140901133854.GA8796@lee--X1>
List-Id: <linux-sh.vger.kernel.org>
References: <201408221446.s7MEkNVF001775@swsrvapps-01.diasemi.com>
 <20140829091359.GF24579@lee--X1> <20140901132736.GG3135@dragon>
In-Reply-To: <20140901132736.GG3135@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Mon, 01 Sep 2014, Shawn Guo wrote:
> On Fri, Aug 29, 2014 at 10:13:59AM +0100, Lee Jones wrote:
> > IMX and R8 sub-arch Maintainers,
> >=20
> > The following changes since commit 52addcf9d6669fa439387610bc65c92fa098=
0cef:
> >=20
> >   Linux 3.17-rc2 (2014-08-25 15:36:20 -0700)
> >=20
> > are available in the git repository at:
> >=20
> >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd=
-arm-v3.18
> >=20
> > for you to fetch changes up to bd597f47ca4bf7a522a0298a95c7f9b2f0a75b9e:
> >=20
> >   devicetree: Dialog Semiconductor consolidate existing vendor prefixes=
 to standardise on 'dlg' (2014-08-29 09:26:29 +0100)
> >=20
> > ----------------------------------------------------------------
> > Immutable branch between MFD and some ARM sub-arch maintainers.
>=20
> I assume that I need to pull it into my tree only when it turns out
> there are merge conflicts, but otherwise it can just go through your
> tree, right?

If someone realises there's a conflict the chances are we've already
hacked someone off.  If the first person to realise is Linus during
the merge-window, you'd have to go to the effort of re-spinning your
pull-request.  Something else you'd probably like to avoid.

I would suggest for each affected Maintainer to pull this in.

> > ----------------------------------------------------------------
> > Steve Twiss (1):
> >       devicetree: Dialog Semiconductor consolidate existing vendor pref=
ixes to standardise on 'dlg'
> >=20
> >  .../devicetree/bindings/i2c/trivial-devices.txt    |  2 +-
> >  .../devicetree/bindings/regulator/da9210.txt       |  4 ++--
> >  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
> >  arch/arm/boot/dts/imx53-smd.dts                    |  2 +-
> >  arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi       |  2 +-
> >  arch/arm/boot/dts/r8a7790-lager.dts                |  2 +-
> >  arch/arm/boot/dts/r8a7791-koelsch.dts              |  2 +-
> >  drivers/mfd/da9055-core.c                          | 26 +++++++++++---=
--------
> >  8 files changed, 21 insertions(+), 20 deletions(-)
> >=20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
