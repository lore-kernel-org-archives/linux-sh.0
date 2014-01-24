From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 24 Jan 2014 17:12:54 +0000
Subject: Re: [PATCH 4/4] i2c: rcar: use devm_clk_get to ensure clock is properly ref-counted
Message-Id: <20140124171254.GE2629@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="QNDPHrPUIc00TOLW"
List-Id: <linux-sh.vger.kernel.org>
References: <1389982298-23143-1-git-send-email-ben.dooks@codethink.co.uk>
 <1389982298-23143-5-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1389982298-23143-5-git-send-email-ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
To: Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Cc: linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--QNDPHrPUIc00TOLW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2014 at 06:11:38PM +0000, Ben Dooks wrote:
> The current i2c-rcar driver does clk_get() without a corresponding
> clk_put(). Add the clk to the driver private data and then get it
> with the devm functions so that it is released when the driver is
> unbound.
>=20

> =20
> +	priv->clk =3D devm_clk_get(dev, NULL);
> +	if (IS_ERR(priv->clk)) {
> +		dev_err(dev, "cannot get clock\n");
> +		return -ENOENT;
> +	}

Return the error here?


--QNDPHrPUIc00TOLW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJS4p8WAAoJEBQN5MwUoCm26A8QALU2GTJBY8Hoyl3rF7cbV+WP
t3946sfgdBh9HTeetqljSqzcG549t3oOUpHk3K9cBbGlgH+r9Gev6B5haPthuDDN
9jLmLMxua+HzUdU0qbcnX/mmWdMlpm03+Z3he+g/c25KwPsSD1sfbr7xPzW6/Mu3
SYZugF3d7BKqYXBCbagbuSeG4Fw0tlikEK1k4571lYyU9HRAYISH9FFX+MYNORJi
Dy07zJXWfXJgDjkQx79yMf7X/S/VO8hO443N72I424XdthA5IQuBJ4GlXJE4WC2S
p0QMAesFHlLjImvk6ygV28P9FEEDLYj/Uk4NTbTXYGECeiuxq4EqrEVfValtfR5/
eEhF3WwW35UYY/RXlTPSl8bAmLupsVqnRpmSXVmKLX0IBc1nLpRwE1Kcqn1+XydC
+fgqNUD+4LqaLVln2eyeb7gAobBWP3UR07CIxn3n0UQMEyT4SiuddQv4Y7ILG/6l
/55WnSrT8FXE/5eTqVdrTD/HWRRt2cTJWdZ4Mg30a0CCamvXU5C4nYXOU2fpHDE4
1aGX9ufRp6VNK1VKdVQjXQxuv54ib1h+2mfyMwZvsx1p/62upHm7pcj37+e4Ar9x
HTms39XAcRmn5sQ5GoMUDWTyTY+1rgSmjJRuwi+uSYd8Yg4kCLELljXUgCHwOpPz
LmQeeguUNkC/LSI6aJvE
=JRwL
-----END PGP SIGNATURE-----

--QNDPHrPUIc00TOLW--
