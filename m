From: Felipe Balbi <balbi@ti.com>
Date: Tue, 24 Jan 2012 09:36:15 +0000
Subject: Re: [PATCH v2 1/2] usb: renesas_usbhs: add IRQ resource decoding for IRQF_SHARED
Message-Id: <20120124093614.GP27414@legolas.emea.dhcp.ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Bd2KlmcTHfsQFEJ+"
List-Id: <linux-sh.vger.kernel.org>
References: <4F05451E.7080601@renesas.com>
In-Reply-To: <4F05451E.7080601@renesas.com>
To: linux-sh@vger.kernel.org


--Bd2KlmcTHfsQFEJ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 05, 2012 at 03:37:18PM +0900, Shimoda, Yoshihiro wrote:
> In case of the SH7757, the irq number of USB module and SUDMAC
> are the same. So, we have to set the IRQF_SHARED in such a case.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

applied, thanks

--=20
balbi

--Bd2KlmcTHfsQFEJ+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPHnuOAAoJEIaOsuA1yqREOfYQAJfDLi4LYk3OZ9cXZ4EZWtZd
FZb7lzRBOL27nNabF+UNEy9GThT1k7Rnw0f7cHe/FjtZq8rkKFyfgh8vXm+rlatF
6p3wOlu1ArYXFba8V6uGcn7lsbrEYEqpfsnnYZ49zjvOioIwGkQdeGtXLvV5RQ8B
2tKNNfIdgPAWeeePcQFpX2eRVVqx1mldzvpYa52Y39SReVeBZRgfLTWcpTzFPnQv
coj8IjvAnlmlhxA/h1hvrI7F48ZqRuJq911PA4rm6Y0RrMC0CvF+ORHGXclnirG9
lyA32el+bycoXzCRETyMXfpHtJjIerlsnr+qn3wy3khfJ1XxIrQsjVCTQTh5Xctd
4/xl1OS+V5L58Pc3AtB8TFd899yojkdcSDJ0vqP8hvE/KC0t2gwBxPsa48PrysFa
0j/3FhjK8xSfIeQbEFN1AKnQQBo7fjf0AKRsQpn1xKbDXnoD8S0JBdiScLL4TVCi
InH6qwtt4EocNsPjt6stFLri2KkZOyprLJ+tVDuso27qOzWUIEE06pMMW4Zsw+lv
mY/mQve//sjT0W0mbf+RUjM/qnxKEjafG+8At3XxyHsh4mBzsWOEgYu4lvwbiY4Z
os+foDyoM4jtT4dXMf1O46f5NXO2ljtXJl+G5UNrdcEJw61x8Jcqns4BeSItSSr5
L6nZFapaViGnjh/CG9mB
=B0rT
-----END PGP SIGNATURE-----

--Bd2KlmcTHfsQFEJ+--
