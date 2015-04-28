From: Felipe Balbi <balbi@ti.com>
Date: Tue, 28 Apr 2015 17:01:41 +0000
Subject: Re: [PATCH] usb: phy: Remove the phy-rcar-gen2-usb driver
Message-Id: <20150428170141.GL18263@saruman.tx.rr.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="RNRUMt0ZF5Yaq/Aq"
List-Id: <linux-sh.vger.kernel.org>
References: <1430222647-1845-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1430222647-1845-1-git-send-email-geert+renesas@glider.be>
To: linux-sh@vger.kernel.org

--RNRUMt0ZF5Yaq/Aq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2015 at 06:55:37PM +0200, Geert Uytterhoeven wrote:
> Hi Felipe,
>=20
> On Tue, Apr 28, 2015 at 6:50 PM, Felipe Balbi <balbi@ti.com> wrote:
> > On Tue, Apr 28, 2015 at 02:04:07PM +0200, Geert Uytterhoeven wrote:
> >> The phy-rcar-gen2-usb driver, which supports legacy platform data only,
> >> is no longer used since commit a483dcbfa21f919c ("ARM: shmobile: lager:
> >> Remove legacy board support").
> >>
> >> This driver was superseded by the DT-only phy-rcar-gen2 driver, which
> >> was introduced in commit 1233f59f745b237d ("phy: Renesas R-Car Gen2 PHY
> >> driver").
> >>
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> ---
> >>  drivers/usb/phy/Kconfig                         |  13 --
> >>  drivers/usb/phy/Makefile                        |   1 -
> >>  drivers/usb/phy/phy-rcar-gen2-usb.c             | 246 ---------------=
---------
> >>  include/linux/platform_data/usb-rcar-gen2-phy.h |  22 ---
> >>  4 files changed, 282 deletions(-)
> >>  delete mode 100644 drivers/usb/phy/phy-rcar-gen2-usb.c
> >>  delete mode 100644 include/linux/platform_data/usb-rcar-gen2-phy.h
> >>
> >> diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
> >> index 2175678e674ebf44..3cd3bee54ca6f9b3 100644
> >> --- a/drivers/usb/phy/Kconfig
> >> +++ b/drivers/usb/phy/Kconfig
> >> @@ -186,19 +186,6 @@ config USB_RCAR_PHY
> >>         To compile this driver as a module, choose M here: the
> >>         module will be called phy-rcar-usb.
> >>
> >> -config USB_RCAR_GEN2_PHY
> >
> > $ git grep -e USB_RCAR_GEN2_PHY
> > arch/arm/configs/multi_v7_defconfig:448:CONFIG_USB_RCAR_GEN2_PHY=3Dm
> > arch/arm/configs/shmobile_defconfig:163:CONFIG_USB_RCAR_GEN2_PHY=3Dy
> >
> > Are you sending patches to fix both defconfigs ?
>=20
> http://www.spinics.net/lists/arm-kernel/msg414542.html
> http://www.spinics.net/lists/arm-kernel/msg414543.html
>=20
> The driver doesn't work anyway in these (DT-only) configs, as it supports
> platform data only.

thanks, this patch is now in my testing/next.

--=20
balbi

--RNRUMt0ZF5Yaq/Aq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVP7z1AAoJEIaOsuA1yqREvqgQAKR41jHI00u8hQW0oLB3/dJj
cbjZRCNV32ePYc0+mNXvYzxPVK3N8I6E+WcuAZFIeTSUsVT/jrL0iik0q64cx+Vf
OU8Zu7k0v5E7fMgEh/XvtxQ1FB9kJzaOH47gxpIAhjaJNGD/rurPOXWq8ApabvHs
tgMPY0NaKEJP+NppimVtu+G8whgfxBdmP52aYPHISt2BohlUb6iDs61KwFsXKWPT
Zdd1kXIxbcXvYrlfe4gUye4EFXAO/ClfxpIcv7ISBL3lHdRgfA7JCMIQneEwCKDb
H+VP3Q20xgZUAzPcWXX8tC2lwP/cEdWaY64gFSGK1kmqrpeulD4BFHLSxich5Wah
ZsVcAF9bSX4L9N8bBFxJoY7120CcjU4QoEyaV2C+1sQHyV0DbR7t0njIYDLrJFPO
dtGeU9q8RIFnk1XIU8viFJ0eCgLSO6ZMewoZtt5ipR0OpF32JUZknJVQSJo2/rhf
bBnUapyD5DkLEk5KDpE/vDmOTPHv29YCgSSwQc58zxFdX+HcO4A6pLslx3hjYtJW
S1m8A3e/cgnRE50ENJhsKjJyJF6m8apAbr2EZqcqPisUNHPWeQs+2oV2WsOyemA3
6drWXXAyuHYxndzwiHJ1jWIjR/A5+77mnEJwFw9qpbvPwK5UxY7ldpzb/k03t0VJ
adnQ4mvyHykBjm3aebpe
=2A4L
-----END PGP SIGNATURE-----

--RNRUMt0ZF5Yaq/Aq--
