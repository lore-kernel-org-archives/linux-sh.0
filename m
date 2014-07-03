From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 03 Jul 2014 08:48:34 +0000
Subject: Re: [PATCH] dma: sh: inherit debug options from the subsystem for sh
Message-Id: <20140703084834.GB3012@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="EuxKj2iCbKjpUGkD"
List-Id: <linux-sh.vger.kernel.org>
References: <1404033022-3014-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1404033022-3014-1-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

> With dynamic debug, these flags dont make much sense unless you want something
> to be printed *always* during boot.

Yes, this was exactly what I wanted. So, for consistency reasons I
copied the existing mechanism over to sh. If it turns out that the
desired default is something different, I'll send patches for that.

Thanks,

   Wolfram


--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTtRjiAAoJEBQN5MwUoCm27f8QALC0MlQ1PfQgRVtV/kbDeT3M
DcN/AgeyzsDlnUIE+JHqxoQPit+kcElonjdtngtjBJLfOs9r7NSQNJZVy4i2GxOL
LtMqd98fEUe9+OqyJ7cygZknsqBTlwBeDhBVGyjvgr+BMbSwZ1EwSkA3K1YyVaQe
dn4iua2bdjpkp1U+01lOWyf2hJF/vvUg3Ej3oaUwvSwnfximKOqRBF+CmyrQzDQZ
622E0ys24JxqsVJnVa0+MmhwS3ucFUKBGYXiHb5pdgm8Csvl7tv84D+mm04ZpcPy
NO2LTNYCIuNzleGjbKNm/6dLwQFPf6A1ImPBQqVVSTMPkjLzAzQuSdy/Qve1HkiB
0TT59w8j9Xv9l2eb1oCfMcwJnltB2uI+Ze9SN6EEfrUHbukUQ7MgSafRT1d9vWyz
npCeQBT4s+JKuLDpmk8bGe9VhdeVyfP1DXyGsdYwBYtq+qjOceUfbxeKTRPQ0MUZ
aAb8lQtSK+G/S0vRzTXsJtmbQZ+jd+QuIJ+bIjZseSsHT2uuYw+63NV7zCC4tXqf
VC0gx41GZhUN1fmcCMxdNo8Ij2u1JMGienIs+Nx0J+KBw8POwJ0VDMWfx8qUMy8Z
qczyhH5xEEGo9BUa2M3I7oSr4RgZbUShIQn1R02fvgSJJE+rlBk2LHNff5TTOaeY
UDxmQhBRTGH+Hp3GSpU7
=i6Lr
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
