From: Felipe Balbi <balbi@ti.com>
Date: Tue, 27 Oct 2015 14:45:15 +0000
Subject: RE: [PATCH v3 1/7] usb: host: xhci: fix hcd private size
Message-Id: <87a8r49xqc.fsf@saruman.tx.rr.com>
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
> Hi,
>
>> From: Felipe Balbi [mailto:balbi@ti.com]
>> Sent: Monday, October 26, 2015 11:27 PM
>>=20
>> Hi,
>>=20
>> Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com> writes:
>> > This patch fixes the hcd private size to sutabile size.
>>                                            ^^^^^^^^
>>                                            suitable
>
> Oops, Thank you for the point.
>
>> > The previous code has "sizeof(struct xhci_hcd *)" in xhci_hc_driver
>> > as hcd_priv_size and sizeof(struct xhci_hcd) in xhci_plat_overrides
>> > or xhci_pci_overrides as extra_priv_size. However, the xhci driver
>> > uses a "sizeof(struct xhcd_hcd)" memory space in each hcd
>> > (main_hcd and shared_hcd) actually.
>>=20
>> Nothing against the patch itself, but you're describing what exactly
>> you're fixing. Did you find a bug because of this or is this basically a
>> cleanup ? Your subject says you're "fixing" hcd private size, but I
>> don't how this could be fixing anything. Care to explain ?
>
> My description is wrong. This is basically a cleanup. I don't find any bu=
gs.
> So, I will fix this subject and description in v4.

thank you :-)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWL438AAoJEIaOsuA1yqREu4YP/iMF2IMHAdwWxYLSkCkopiNV
8aYwhvjjGH3MZ2pgesMye13N4yCsnQGZ8BtoYHxtz/KIQr5HlWVNwq0A0hoH4lNf
8YFFJNpFuOJJyf4snjL3i/UzbDXg/jSWjR4m34l/nFIHOk/3iDHRxeOnTN7rsVo0
kE+Xr5TsojBHdsSWtExXDsne+ln6JA8Mo6yyBeXyskgE5x7LFN1ZheyxO/VhfUeg
eG45CfEE3x0xSxFwj39I5R8Oi8f4FbtIaFFyS10vCqssUPzypHH0rvZznW2OldZU
bdEQXEgGdZRdvCemCb2IYdaLeDmoV6hQDDfk5H+FIYP8fV8RY+2Z1UGTokomSqPl
BMpkw6BuX6pn8oWO5Ct67iWQLtA5cbc+KjMzksHIGK4k9Lit8pJjg3VTjTAqLKU6
gdfZWSsrAoRR5uYdQvrsuEAfoNpvsIb10f2a+2Z4c9xmbkoKyTbhgx59BYFbz+Jw
7EZxUxI3qFArFhTeR+zoz55XjsFtgOEG0FGocnucLLTenxDyCq0L/KWXM2VphqUS
P9vgnqASdsXtoQnKHy0f7ZhY0j5TLGl7j1lK8sSPSyofl+ClJYrhsr/P9DG+SRUT
B4rs6RG96Ci295hJ1pZY+xjB/VoZ/kRTkNe2hubvS1fvFrQul0nkd+y/Tyrk+nJo
ughXsxQcfi3PGGtKTTfI
=DxmE
-----END PGP SIGNATURE-----
--=-=-=--
