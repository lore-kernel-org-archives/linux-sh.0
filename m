From: Thierry Reding <thierry.reding@gmail.com>
Date: Mon, 05 Oct 2015 14:42:55 +0000
Subject: Re: [PATCH v7 2/2] pwm: Add support for R-Car PWM Timer
Message-Id: <20151005144255.GD27759@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="3Pql8miugIZX0722"
List-Id: <linux-sh.vger.kernel.org>
References: <1443602873-4316-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1443602873-4316-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1443602873-4316-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-pwm@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org


--3Pql8miugIZX0722
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2015 at 05:47:53PM +0900, Yoshihiro Shimoda wrote:
> This patch adds support for R-Car SoCs PWM Timer. The PWM timer of
> R-Car H2 has 7 channels. So, we can use the channels if we describe
> device tree nodes.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  drivers/pwm/Kconfig    |  11 ++
>  drivers/pwm/Makefile   |   1 +
>  drivers/pwm/pwm-rcar.c | 266 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 278 insertions(+)
>  create mode 100644 drivers/pwm/pwm-rcar.c

Applied (with some bikeshedding changes squashed in), thanks.

Thierry

--3Pql8miugIZX0722
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWEoxvAAoJEN0jrNd/PrOhsnIP/2CXmF6Y1u326gTyl77w9BG/
godw6Py+huXzSe/g7GFGJ71CaxzDiIjAO7yX1Y8xJudIYkN+/SCxhFOkNXRkV3G2
tDJ3RIwXHsS8RZrCpTSVZIPHPgB4HYtYVKzF4lwkl+w7hTiGiGiLlhkb8PAIODCI
vr5ep5UX/x17YyNULk+O4JhYOiT+8Ri9n7iXW/KP6k28U9vFfVIGoK3syu/JsAfM
tGeEk4An2LVZzOrhKHP6saZlu/VrgD+z1qzUuhwiK950XIDVg3mZQ7BGdZ5AJQn1
vlqqDD6kveqDtU7oD4jla7aeo3IgkCcMjb/xmeU1MWxQ+iPVz6fFwNpNubmUiV04
RRzjgEhknsSs3EybAp37e5WEVIvPY3F/RFi/7mmmu1RBqwNMyHl84uoIU2nrXNrS
63kTbjZZEmWvIhg2SFHohV6BhTA4zIKHIwGgADGdgFfTrwkTyykNZWWWrff0jKk7
i7JiG1ok/gN1KKJq6saQXbdOQYiJt6LJgk+c96r2VcOLXk6T7ck7+NPzrMxjJig9
XgJKIfn4nY1OjuvmPqh5G1pCOYD2aqpGNPcbGX7yMOBm30e3gp2LSKsmQgCbFV6f
cWmtxnL8ib2QWYBC8hqOb4RfZiH6XKdFY4gmykssmbXBnc2e5qlIFRRJw7133UL+
EmUrjW/qznHK3vzc6UDG
=6udF
-----END PGP SIGNATURE-----

--3Pql8miugIZX0722--
