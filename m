From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 20 Jun 2015 18:53:54 +0000
Subject: Re: [PATCH 2/2] i2c: sh_mobile: use adapter default for timeout
Message-Id: <20150620185354.GA3333@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
List-Id: <linux-sh.vger.kernel.org>
References: <1434826104-16346-1-git-send-email-wsa@the-dreams.de>
 <1434826104-16346-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1434826104-16346-3-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> -				       5 * HZ);
> +				       adap->timeout);

This should be adapter->timeout :(


--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVhbbCAAoJEBQN5MwUoCm2bOsP/2hStK77b2hqkhQHX33bMeWS
ow3SfKWHZK5OBGuV6KDq2nSsYgelvIh3LzZtsJpH2SZo0j1j0dXDAO7oDPHvdapc
pSPUEt23qEI5TpVeSzikXKAI3O5G3lUIXr5oyEqIOw06ahgKfNndhkO6PPo74JY2
kOr0udcPbUdfrxB/IRdsMUW5FDZyE1WK6g6PLbV0+IdwzttHt+UlWSZwTms+0MJN
zQ2QyW4dHzaZt3RWoZMU+FgZQj/MThwmd7/LiHYo9IS6ISZRYZgX4c4f72F2stwz
PMLVjBPzsb1zzlLTS3oNXOZ7S2/ak4uEGzzojxauOxNI+36mIh00F4+zy6vsh9PK
ZGqTRnH0zQXNRkodNqYIArLPHG/jiF6xmhMsjC5keduDtWxUdNQ06Cz9qNHOasVS
fCZlz6bkPgGUQlBRt1+EL2AW0IrFpMHZnAo6ofTAAqcusg4iNRlyBCeuhuCm7prx
UKmsoImXRd0bOsIZa20A4L/+T/bRXugCi89A+mFQaPRTTRa8oNCVzVARrTyi0KwH
88Hxa1KIlxbidpEgJsDALCDUFGFD0qCyZGuA0zTa1GXb1v4A4FPLTN0yrv/YvHp1
kOlbTu2lylEvZUjWE22VDQs96kw3T4pGtTOT6dWKGCI/7LNx1awoUtAIMDhvj/Vs
3X3u7HNCzMeOROjnpVjp
=UlMG
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
