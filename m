From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 17 Jun 2015 10:53:09 +0000
Subject: Re: [PATCH] i2c-tools: enable static use of libi2c
Message-Id: <20150617105309.GF1517@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="WlEyl6ow+jlIgNUh"
List-Id: <linux-sh.vger.kernel.org>
References: <1434420079-3029-1-git-send-email-wsa@the-dreams.de>
 <20150617110615.7c7cb411@endymion.delvare>
In-Reply-To: <20150617110615.7c7cb411@endymion.delvare>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org


--WlEyl6ow+jlIgNUh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jean,

> > When debugging embedded systems, it is often nice to simply TFTP the
> > desired i2ctool to the target without the hazzle of dealing with shared
> > libs. Using -static is overkill, too, so let's add a switch which will
> > only link functions from libi2c statically.
>=20
> Fine with me.

Hooray!

> >  BUILD_STATIC_LIB ?=3D 1
> > +# Uncomment to use static libi2c
> > +#USE_STATIC_LIB :=3D 1
>=20
> Any reason for not using ?=3D as above, with the default being unset?

Agreed.

> Unrelated to your patch, but shouldn't this -Llib rather been written
> -L$(LIB_DIR)?

Yes, makes sense.

> Also it might make sense to check if USE_STATIC_LIB is set when
> BUILD_STATIC_LIB isn't and complain about it?

For easier usage, I'd rather enforce BUILD_STATIC_LIB in that case.

Thanks,

   Wolfram


--WlEyl6ow+jlIgNUh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVgVGVAAoJEBQN5MwUoCm25qkQAJVwD7xBKuFRU2HmKYubFxRU
7xfEbOZL6NeWdw3dK339FctPze34hnt7NUz0iZFiv940tQFuBIqz4wn9Bg88LY/g
flhzsxQcy76oBWy249smpMwsOtngHCP5JOrENVPUo4HlGxa/t4TE7VO89rrbCDNP
a/zOowdIcHkaN87lXOW1trj0G47z4We2gyZkN/LXkv6aR0VD+fgnLZw0PdSDoSKb
r5K30CFo6sdRlLptLjIGM9hHhNFdtKD3AM5KKqmWFXy8I+qXksruGnvf96ScqeHu
ZjHDDePod6nRXNJSu9TPHg7GTUYWpRVZLdW6htBN4fa7K7+JJnMGUW0cxQw++B7e
IkRvlhAg9XKXJ0gBVyYbFFcTXS+VgNkwlXmcXdjmuvY7Hw0l84Mde1faE6kiBh24
SRbnW1L1xio92RIbOkAQntBDEfKujNVGOaS3q98ZsJc5Rr6sNJvCxGJr5bOzIwbc
svs1Rgx4zjehbrnLoKKWly8eS/i6ebHRnhBXYq5huu4rVsc9zT5KJk0YuqZ9yQGE
lIeIUxqJSIgXrdrHCWoUp/JzWYpYjsEN7C/QVUUw9NzJKQV0fYQmFH0tuqg9it6k
8FhNmxc6YwdxqO2RsU3cqLP7ec9l5RE1EO+zmC48TaNQ65Z51VM+NAIaJICgk4zZ
DwIYGpiQZvcWOcBkW4SW
=iEKz
-----END PGP SIGNATURE-----

--WlEyl6ow+jlIgNUh--
