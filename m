From: Felipe Balbi <balbi@ti.com>
Date: Fri, 31 Oct 2014 02:57:59 +0000
Subject: Re: [PATCH v4 1/4] usb: renesas_usbhs: gadget: fix NULL pointer dereference in ep_disable()
Message-Id: <20141031025759.GA1080@saruman>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
List-Id: <linux-sh.vger.kernel.org>
References: <1414718664-4568-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1414718664-4568-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
To: linux-sh@vger.kernel.org

--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2014 at 10:24:21AM +0900, Yoshihiro Shimoda wrote:
> From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
>=20
> This patch fixes an issue that the NULL pointer dereference happens
> when we uses g_audio driver. Since the g_audio driver will call
> usb_ep_disable() in afunc_set_alt() before it calls usb_ep_enable(),
> the uep->pipe of renesas usbhs driver will be NULL. So, this patch
> adds a condition to avoid the oops.
>=20
> Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: <stable@vger.kernel.org>

which commit caused this ? You need something like:

Fixes: deadbeef (commit subject line)
Cc: <stable@vger.kernel.org> # v3.14+

So stable folks know how far back this needs to be backported to.

--=20
balbi

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUUvq3AAoJEIaOsuA1yqRET8MQAKdMi8z56atI+Pxp1cwtqZqJ
oXRCQx0xDU5VMXDs8OP4UAAN2pRihPb5eaXnpCesQhG3cZwHKpDOxfhD2f3C0YCg
nQgXciE42UhNqM3J/QO6M9Fwl13gj3K8m2pSg9upK/d5abyBDh1F5kl+f+ksWi5h
fxUA7sWIp2fm3p+mj9hJ+O/GArr40eDr/UqCYj3wu2UbcQkGdH9KUxWKq9lGbYZS
1akddgxwLxocUyPyLbVnzZkZaxx83exVgGhKjI0ZPfbrkJhaWowR+kPCMI4ZJEKU
qUBvnfF3bN00KqkP4IyNiY8tunfJrFFMj0cK1ZXruHIhpQbvqc9yjEWIWwLc1j+W
nDV7vmgRMn4VX58vcM/WX9l+N6FFMxYEGbCCcLAkJs2IVTtFDRM3GGR3I8kQtAp1
D6KsKxiNoN8ZJObWIVQ40//fHcajn7JR8hrmV8m1TC/umnNlp9WqyqLezGNd5yb/
+ydmHvobej3Q3lHqv48c+4eAFM9uAX16QsAyfFeXFrtYa8S9V/yFbwPsyPRyQoht
TzBAsGFzj1X7Ery3aQDdigHmPvP2+6v18/m7m/maPbtb9qJJnoTXJdrb03xKW2iM
J3qpYSTU/O43xCiXgb1pmasCKXErtBBsiQiXfBFaE7PF+yUgq49vDlA8tIvfDu4d
BfI7qsjuteLnqIR3JXwR
=4h2u
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
