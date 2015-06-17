From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 17 Jun 2015 13:20:33 +0000
Subject: Re: [PATCH] i2c-tools: enable static use of libi2c
Message-Id: <20150617132033.GJ13393@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="utPK4TBebyzZxMrE"
List-Id: <linux-sh.vger.kernel.org>
References: <1434420079-3029-1-git-send-email-wsa@the-dreams.de>
 <20150617110615.7c7cb411@endymion.delvare>
 <20150617105309.GF1517@katana>
 <20150617151025.1353abe3@endymion.delvare>
In-Reply-To: <20150617151025.1353abe3-R0o5gVi9kd7kN2dkZ6Wm7A@public.gmane.org>
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


--utPK4TBebyzZxMrE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> You mean that USE_STATIC_LIB = 1 would silently imply
> BUILD_STATIC_LIB = 1? Yes, that's much better than my proposal.

Yes, I meant that.

> I'm wondering if we should make it even more flexible, but I'm not sure
> if it's worth the effort... Are you calling "make install" after that?
> I guess not.

No, I am not. I just copy the file to the TFTP dir.


--utPK4TBebyzZxMrE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVgXQhAAoJEBQN5MwUoCm2ZTYQAKauMwW2gYAnmhaBP/rHnLt7
n84/VpwU+KQfkWbt/3f1dKVf8o/qlOrIfxQZTNClOlF53ilBwU3YOIcjRwPEQ/IE
AWeUr+2lJucQX2RfJ6ZhzMKLJHcuThLYbNgWPKTJB8JUN8OoefYOSQXufl93ZXj/
DuPdpn/eCfxkHGByHL/zcsVximB9fhJ/uBb5ASlcHjsF2gxoL14tGwnflC5QEscY
+2G4efJEPFoY+Ly+93+JZ0b2gNeCAIjb3tRpI1pJbae309SxQzdL+g+5Xm3LloZ8
ePrMKWRP8fhaDjPBw+qdwp+xtEDfZcHvf40pL+g2XAIoZ0uhTbUe2Qe/imz7NCf8
L9V/D2fxWTCGgaCpkBU/xlq2NcjP34Ovbv4tZ0Mkh7O+wDEp1yWVexYTfU0CiBYP
CO1LFprO6cJxv+Hd/DoHiAG1DGkXROG/JgxynKEuiJrvyjxDZrXHU9lObLbZlSLB
FlNlS+DYtclrOnhqloqgLz+ysB3k9oIl+44ALBWmkjndDNGtnSC3XE9K4HxPYWd1
TfHDIV5LtDvl6NQxgT6h5FMPBAlZ0uWbCxbSc1aANG7U+GaK0ms3UtyJXWj1MjRy
b0nyAP9Yxf5mJCUWlY8QHyD6m0eP8EYqVIJxtD/UAtlguh2hyxtNXm/Oa0EBTxOF
S3ownsYctnnO3S0zXPWO
=Y1YO
-----END PGP SIGNATURE-----

--utPK4TBebyzZxMrE--
