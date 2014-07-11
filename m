From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 11 Jul 2014 07:28:38 +0000
Subject: Re: [PATCH V2] dmaengine: inherit debug settings from the subsystem for subdirectories
Message-Id: <20140711072837.GA2786@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
List-Id: <linux-sh.vger.kernel.org>
References: <1405024603-4023-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1405024603-4023-1-git-send-email-wsa@the-dreams.de>
To: linux-sh@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Going thru Kbuild doc again, looks like we can do this using subdir-ccflags-, so
> the below patch can be simplified by doing

Great find! I looked for such a solution but somehow missed it :( Will
update!


--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTv5IlAAoJEBQN5MwUoCm2hqEP/A4vhjXlOg7ZJ9AFpdzWgQeM
OEQN3FlcRnGxmSBUGXmE8ZrLXZs89rPq+zNVyrxB8P3DmT3yDDXzgVZpxScMPhnx
D6nAklt9JO+5uuyZmJAlHqscmwA0NM5Wb9gCKfxwK2zME/1ZEYhcs9P7egdytAF4
WqnA+apLv5R8rLYOSLcRGU5ibFvCBoqqH7FSanpZ4ZaULJJI8NjrjJKfSHmekd9v
y6P4jBSVVnt4wn/Ckd1tEOEMvci09OVEqn3PY/oNwHZzDIwkRkn9YS1zFoZRCS30
OhwDmrTgrPmN0Evn0Pk1AuoXLpw3EOfVBnmRbiwDUtG7P78dQHTIcXWMfiHBmtIa
4gRLUD8+vUiOgEW3WR7Liox/Tb8B/pKtIzQ8mU1NhZT/RyfuCbPU02mHTXN00rqn
3l7aVamiE0M5NXCCAb6BZOO/K+BwlqTSX7nIUBhVLiHBhKXnkbG7opgQJVRHlDwQ
NhHwzI6jIhgEIBwfJgwIeIW1NkqpoGFomA6ExtWP3FcnHmpN0jWg40OFg5BTF78d
vLYaw2YL7E4klufh9KvTEq+FPzKb0IPKj1efSayPXwDawHbDAw2p1g7O0Y6LDyy3
XD+bde1YJX5SiyfoWlCFBCmgMGUaNvVkZ+8GS+LmGzu6kqHw0pxWQz1IMcM9zjNK
PZIcKxYyf5SW5JU7vQcJ
=uK0P
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
