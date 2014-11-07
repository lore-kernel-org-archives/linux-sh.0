From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 07 Nov 2014 17:53:23 +0000
Subject: Re: [PATCH 2/5] i2c: sh_mobile: Add support for r8a73a4 and sh73a0
Message-Id: <20141107175323.GD3656@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="VV4b6MQE+OnNyhkM"
List-Id: <linux-sh.vger.kernel.org>
References: <1415274730-310-1-git-send-email-geert+renesas@glider.be>
 <1415274730-310-3-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1415274730-310-3-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--VV4b6MQE+OnNyhkM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 06, 2014 at 12:52:07PM +0100, Geert Uytterhoeven wrote:
> Add support for r8a73a4 (R-Mobile APE6) and sh73a0 (SH-Mobile AG5).
> On these SoCs, the operating clock runs faster that on previous SoCs,
> and the internal SCL clock counter gets incremented every 2 clocks of
> the operating clock, just like on R-Car Gen2.
>=20
> Cfr. the "/2" in the calculation of ICCL/ICCH in section "I2C Bus
> Interface (IIC)", subsection "Transfer Rate" of the datasheets.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied to for-next, thanks!


--VV4b6MQE+OnNyhkM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUXQcTAAoJEBQN5MwUoCm2jH4P/2dP04mLCaa1eghhcgN4hplT
0OBGXidOscuRVoHI+np8XrpQmpr93v8rvMOS5Txt1YmsW+NlurxsgOSd3UGeLqNa
mmn+C67gQ2JTjwR2xPybKk7Wj9aNh893Mp+K5mNqi0sHt43Elisi1IDqzEaXmaNg
1W5YsFwTW4Ab8p38fsV+W+caO8cjDZ2WWS3OtvDlDy1OkgOqo2yy01Sy2uTuhLUW
3zKZt0oppPgDAYMB9cEmxqOKMUxwDmOTFokdp8xjXTq9ijKmAZ9Pc96a5ZhVPwQp
fUxriASAqR6uDNFUiq21iAFZERq57F7Iv5m++y0+OROQe9HqeWhAtdJJrf9poVZX
7S4K5bUts478wHUBKG7nwTPSNjNpNE1sSL3di89ptrDtJusB2nxhiRCYgpB4H9cp
YlGiAQ47y5ifVSVH6/5xXzgBrI9RDDkIhHViKoN8lKaZkRq1SwO2NSeFZS2I90CY
kOuh/0oF9zmk2v1oQw99t1ges1TkaHkzYn++GEANODRvtGBbiuo5iRf2PNAJSAz7
sz87oJuqrs2bXEOGU0gh7Q+ke1mRdYMlatEJUFR9BqfcWqITRzg1FCgy6F7zs5tU
E6+GpdbG5fgciG6Qhw9HfJSpHBURo5WBCnTIbao7tmrWxn9fteVpG3ipPOj7FUFn
L8xkIfNunPxa+pAbLGvk
=ZyDk
-----END PGP SIGNATURE-----

--VV4b6MQE+OnNyhkM--
