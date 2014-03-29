From: Mark Brown <broonie@kernel.org>
Date: Sat, 29 Mar 2014 10:09:06 +0000
Subject: Re: [PATCH] ASoC: rsnd: SSI needs to prepare clocks before enabling
Message-Id: <20140329100906.GE21628@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="47eKBCiAZYFK5l32"
List-Id: <linux-sh.vger.kernel.org>
References: <1396009626-24699-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1396009626-24699-1-git-send-email-ben.dooks@codethink.co.uk>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com, linux-sh@vger.kernel.org, magnus.damm@opensource.se, linux-kernel@lists.codethink.co.uk, William Towle <william.towle@codethink.co.uk>


--47eKBCiAZYFK5l32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2014 at 12:27:06PM +0000, Ben Dooks wrote:
> From: William Towle <william.towle@codethink.co.uk>
>=20
> The rsnd_ssi_hw_{stop|start} functions need to call clk_prepare_enable()
> and clk_disable_unprepare(), otherwise the following warning occurs on
> attempt to play sound:

This doesn't apply cleanly against current code, can you please check and
resend - I can't apply this anyway since...

> Signed-off-by: William Towle <william.towle@codethink.co.uk>
> [ben.dooks@codethink.co.uk: add more bug info to report]
> Tested-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---

=2E..you forgot to sign off.  I'm also not seeing the debug info you
mention in the changelog, indeed there's no error checking.

--47eKBCiAZYFK5l32
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNpu/AAoJELSic+t+oim9R+IP/A7WdVksu5G5IKiJYsaizLwn
1EJz2Z2+Xnut3xxD8YI2PQ4AzSgMI1YrvzruUTIg+BGkWUtbmQrRmmc5bRwyBswZ
uW8XDMFh0DcweigMdAn0soKs4M8CIJi7DTGnfSmDUkkXU+y46mOTUmh40xC/Ju1C
F2iSO0G9HqPXw+apxvsaJgaPM+wifRU9TgRmgBzF4/H7Cp+DTFm5Y95vekc4mD83
6RQE4K32Va4Y99FkOAuCWlV8NC9IeQQhMRVhJX2OM51CT9r6GqDluJNt6uMqRwy5
8zU76Du11TKu58jiMfxQlsQZmzm47WpiO8JlmqEXLALyBY/nuwNQz7SIICqJPTjM
j1FyIdYPEykPnyM0HoWQ5Otlt1kqb/yhfEEu4cGhIYuJPY6A833oCOC06tKhLSsS
DToOSibV/YFuVCwXhBx/UVTH3qZEfJn/msOKHV+cpAN8yMUSZYDDiOJo2BjR+5m6
4ogd3WYbtfJ/yXJX3d7nDmGCZZ2k8kGIG8HT3HItdc03vJWxKrz/CfDzNJV+bs0H
troG23U+ek2+fGB/eQa5Ept14o4AVrcJwvOZdvRIMg82Tm5JP4kMFX1c8qtRCRgP
cWRwTFZ6beelF/hp/ay68fWqroqubBbY2NGbqauVBL/tYHW+QEl1ue/tGVTVAW09
G9aeYkFYcxBzdux2lhrQ
=boXr
-----END PGP SIGNATURE-----

--47eKBCiAZYFK5l32--
