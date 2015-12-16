From: Thierry Reding <thierry.reding@gmail.com>
Date: Wed, 16 Dec 2015 16:03:34 +0000
Subject: Re: [PATCH] pwm: rcar: Improve accuracy of frequency division setting
Message-Id: <20151216160334.GK28947@ulmo>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="huBJOJF9BsF479P6"
List-Id: <linux-sh.vger.kernel.org>
References: <1447029745-3648-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1447029745-3648-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: ryo.kodama.vz@renesas.com, linux-pwm@vger.kernel.org, linux-sh@vger.kernel.org


--huBJOJF9BsF479P6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2015 at 09:42:25AM +0900, Yoshihiro Shimoda wrote:
> From: Ryo Kodama <ryo.kodama.vz@renesas.com>
>=20
> From: Ryo Kodama <ryo.kodama.vz@renesas.com>
>=20
> When period_ns is set to the same value of RCAR_PWM_MAX_CYCLE in
> rcar_pwm_get_clock_division(), this function should allow such value
> for improving accuracy of frequency division setting.
>=20
> Signed-off-by: Ryo Kodama <ryo.kodama.vz@renesas.com>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pwm/pwm-rcar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--huBJOJF9BsF479P6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWcYtVAAoJEN0jrNd/PrOha80QAKYWtLT8IrX1Bq5JzGnLOUII
LlgxnXEQYolTgaE5g7BBMP4jrwSR2JqQZuSGlCrlBH7LL6PHaG1MBOnhapb474Yf
vp6tcgZmZmjR0wNm0dAQonJ2yRSACWN5OcseUOvy/UTjaYRIgwaJwipcGgGvCnCu
vgzPRIyMr19t/J0vaw3PGU1O15QxfPLs1G3VyhcFrj4Fg/WornLcaq92YFT53eeR
cZPs5gS2QUR0fVxjqnkV3DfWK6qQfFRhZonPqDHmcXF2wfoScacdRU/K0WXwuOPm
J3JktExa22n0lZCtevCYikVNb4PRgeLOd7h+PEYkYkc6aYKEpDd/K7W2ynBNFDhJ
jO4vEFermV9GmV6JE44pE2AArUNEufYQ/kYtz9XXqe8mFXKJHlho1Zn36TE7CZAM
177kzuMrkM8kzZ8Dad9hF1o/F/20wldmXA3AdjC7nPvAxRIArIf/3JRkrmmFkVkU
tqZragSymJlEXa+EnT4gNminfvOZoQFJccC88Xhzw9+6TjDslBxIGrdpt6WU7wMW
TDcUUtSdxWoUHGigHZASq4AHJOtMD28i9WULfemR/m1F3hk989i0jXAJYycCCdKF
ofuOWnmRMAfnlF1BEj4Ijfx8hYC+DenZEA6vXN/HVgE798rhqAAZjC3D8gTkKsSm
P31MPGCWK7V4epCGQuF0
=EQOx
-----END PGP SIGNATURE-----

--huBJOJF9BsF479P6--
