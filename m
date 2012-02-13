From: Felipe Balbi <balbi@ti.com>
Date: Mon, 13 Feb 2012 12:09:57 +0000
Subject: Re: [PATCH 1/2] usb: renesas_usbhs: (cosmetic) simplify list operations
Message-Id: <20120213120953.GQ6614@legolas.emea.dhcp.ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="WTbgq2twYBxfsYA6"
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1202092313560.18719@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1202092313560.18719@axis700.grange>
To: linux-sh@vger.kernel.org


--WTbgq2twYBxfsYA6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 09, 2012 at 11:17:47PM +0100, Guennadi Liakhovetski wrote:
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

if (patch_has_no_commit_log(path)) {
	kfree(patch);
	continue;
}

--=20
balbi

--WTbgq2twYBxfsYA6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPOP2RAAoJEIaOsuA1yqREAY4QAJ2ktiIpzIy+FxS+5AlpGk6q
lYA4oPy+rtVocMwyZFlyQU+hhbG5vZZP4RaNyYrj6/GaAT4IL0RJvP6DlJ/0Q43t
+u6tgWzzcTDsLPIC9MudC9RpLVpjbAoi/9lbNLapDnb7jtQaHBB0pAcT7Tri6Oxg
A8ZB93B8VMZITffIEd5bhW9oCKIBjWmaXkZFAsREK8DlakPzJgWGA6F9TahDbw4k
ulhbsRleeo9FkFYl7IMqtolnWrvmyr+P7hcS4iagRW2gHeJID9zOnX2VqiXmmZik
FN9fShTopA/m0YuBmbK1QvLH9moew/cR4miakfw8Hji0IbuvaWLPBfALIaBNTtzB
2HQR4S3x/cXVEv1YXNibQxh6n9nyosPRvLaTQekAVUu4dl3NcTNIOeRDHBFH28eR
nX4YyJwPUA8rRu1Knmsg9mtcToT7aflyPj44Q9VtZlCiXX0HayPmK2K6Sp22Glh6
wBYtpBo9CUlWxdy2hY+wL/ZV19RzSCPn+fxYygRmgmuzZwkfkJSWduMx4F/Il2yj
ZNV+6dtIfA7qNNEjrc7Q88Cp6u9d1g6T9wvLd1JOWxADHW7Tr4wS1dIni5mfTrUR
eeRW6U+vwCIrFVbkK7frJwJt/yfGDwna8V8Zb4f7ASEC6Nnjxojtkw+eTpyyv2G6
UYAO11ogwSTwu/Nmt9DC
=smfD
-----END PGP SIGNATURE-----

--WTbgq2twYBxfsYA6--
