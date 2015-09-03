From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 03 Sep 2015 20:34:42 +0000
Subject: Re: [PATCH repost] i2c: rcar: Fix order of restart and clear status
Message-Id: <20150903203442.GA1574@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="mYCpIKhGyMATD0i+"
List-Id: <linux-sh.vger.kernel.org>
References: <1439911206-8736-1-git-send-email-ykaneko0929@gmail.com>
In-Reply-To: <1439911206-8736-1-git-send-email-ykaneko0929-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Yoshihiro Kaneko <ykaneko0929-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2015 at 12:20:06AM +0900, Yoshihiro Kaneko wrote:
> From: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
>=20
> In case of repeated START condition, the restart has to be kicked
> before clear status (MSR register). If it is kicked after clear status,
> R-Car I2C may transfer data (TXD register) or receive data (RXD register)
> instead of transferring slave address (MAR register).
>=20
> Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>

I think I could reproduce the issue but changing the order of clearing
and kicking did not change anything for me. I have CCed you in my new
series regarding the i2c-rcar driver. That made the issue for me go
away. Can you kindly check, too?

Thanks,

   Wolfram


--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV6K7iAAoJEBQN5MwUoCm2nSUP/1SLuI3WKxLk2SbAS+sVm04n
I3bWM77Agy9FEOytwoPdOkP/XwUepeeUZ4jKdeZUn+4hvVyK8SUeYqnXP4/SbxwE
6768VNbImGklrR6WIivPIpsvJ62WnTG6r0ROF5YeS+AH95gb7JvW62BOQ9MEfdlu
DXN73bdloKH3PMhVTxJy5WwvyosDHToSdzPLVCD1JPfotAtCyl4IfyNJUH10gXQk
4pxxvwgRze8BnsQvuVs3Urmi1ZhNIaCj5uRLYx02Sx0K7ewvojRIEgJR7pMYdIVy
RBUOLZojPBGaO5ed3kPLyJD0mGH/mlEVL4YT/IIKBceHrSHjw03XOM98VBZdPuWW
/VADHLrvc5SAGxkfU4rzMbfvdWpfypHoPyWmN4xaqMT4rCre5OizEsg63WUWu+QQ
Y6DZVC6EPu1fuw3DU1jLTmjASrVK/y/uCTQUcBZ7FBrUM80qD+6gKphrQTCQIcaZ
JcxukKCAsSyvf9VS9GQAWep7UtxXfNPXSvTyEG03INi7JMwkPRo7Ns13f7pDSJEh
/uI86OsXuNa/9SSrw6eCY/fCle3NvDueGNZQvwJCsnxbIOdPqn9SeSTUl+5WZvWF
jgQF19y5ew2Ez2FN8NjsQkhZ4ZSbCMy4m0IU86jw2xDh4RB0cWKGT0Pd3W4bSWpQ
qQZMlIwN4gKAjfIEcxAw
=K6N+
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
