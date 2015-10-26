From: Felipe Balbi <balbi@ti.com>
Date: Mon, 26 Oct 2015 14:26:35 +0000
Subject: Re: [PATCH v3 1/7] usb: host: xhci: fix hcd private size
Message-Id: <87a8r5bt9g.fsf@saruman.tx.rr.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-=-="
List-Id: <linux-sh.vger.kernel.org>
References: <1445847155-5468-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1445847155-5468-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
To: linux-sh@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com> writes:
> This patch fixes the hcd private size to sutabile size.
                                           ^^^^^^^^
                                           suitable

> The previous code has "sizeof(struct xhci_hcd *)" in xhci_hc_driver
> as hcd_priv_size and sizeof(struct xhci_hcd) in xhci_plat_overrides
> or xhci_pci_overrides as extra_priv_size. However, the xhci driver
> uses a "sizeof(struct xhcd_hcd)" memory space in each hcd
> (main_hcd and shared_hcd) actually.

Nothing against the patch itself, but you're describing what exactly
you're fixing. Did you find a bug because of this or is this basically a
cleanup ? Your subject says you're "fixing" hcd private size, but I
don't how this could be fixing anything. Care to explain ?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWLjgcAAoJEIaOsuA1yqREhigQAIrKzlgQ8kk4EN6dR/T7k+Wu
X8aMrG9hjxSO/uZKwjVtl1OQwWxM3hEKCFHmvgEefj8GUALXC1WHSRxwD8kpAGNW
BZDxl6Wrh2bmkk3FY1XmVO1XgPFU6I9JTh6zn233aIGPwNmrUJmXO3HT+1fNeilE
x1MW452oZiM88xJU6z3a2eJ58liWG6xit7Ba/e9tNbNjSB7UooRSeYFw+M652eWH
wih5aT96ZuRwAocPG/gb5sXvpjQwQ94cXIP5TgIOGnWocXN1K+Y1mQFKc3g1WMxL
tNrITlMSqU9J+vv0gLEQULjffRJNonKSf7C0x0PiGVReCKc9qbKEyOitSFvjG36l
T6GJa7rLSS1bdUqtHkMm/Bce0J0MkLy4IaNjeRMpMmgHseBrQT6ZQkm+hreOiYxp
kjOloIbWA3NBaRTChqdn2hcx95sCOtDZ+OR9F2LeTfI9pZzg7jWGP+5jgRNp0NW/
/hjDSLWc50JWrYUJZtPM2rNve6sJXcFwhBBnoyt1vD0I5LGiEH9uVgmG0LcaorU5
YcWvH/bFi68HOoYsbMzAOnroVCx20/TTMtIGfReAyzrbIHMApK9K7AG7zQI8l/Ae
M2149SipCPuSVDuqmG85a/+WxjoILZADUUr0KYlnJhKrG1J6MrP1uzJLrQd8x6Ly
sbJLjX6G0FnpNUPTdxem
=X0LR
-----END PGP SIGNATURE-----
--=-=-=--
