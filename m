From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 12 May 2014 12:52:24 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: genmai-reference: Switch to new style MTU device
Message-Id: <20140512125222.GA6860@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="T4sUOijqQbZv57TR"
List-Id: <linux-sh.vger.kernel.org>
References: <1399898169-22067-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1399898169-22067-1-git-send-email-geert+renesas@glider.be>
To: linux-sh@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2014 at 02:36:09PM +0200, Geert Uytterhoeven wrote:
> The MTU2 (Multi-Function Timer Pulse Unit 2) driver implements a new
> style of platform data that handles the timer as a single device with
> multiple channels. Switch from the old-style platform data to the
> new-style platform data.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Huh? Right, I had this once but seems to have been lost in some rebase
:( Thanks for the heads up!

Acked-by: Wolfram Sang <wsa@sang-engineering.com>


--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTcMQGAAoJEBQN5MwUoCm23fMP/09u7yw9T1FuEeinl0Hsp5Pw
0mgXyGkjDQSazi31Ps+1ESxm05PXtaUTqSRzx2Cdbz4+QJM5+CQuLU6qehmMwbSm
QObGzn0MrE2bUCgR1sJfeUho4iYbtYzkM89j9xEFpEEazX8HIVIFg7Ph8oQOK1Rd
21RMpx93xvdAVqLaXG0Np1CvSjy2PMmRNPC0ZpRZW+WuU4n+4SVBZwZsug2qvbxW
aTswZREIA6Dvcph5YEQhIijylIfPLOTpa1A9IuNht8dU4tTDoGyx/u4MC6h05aAe
7NUhmYBmUmQ0UUrPvMV2huc50j37GNITQWPocH+4ssuWqo9qeh4FMMdCUAl7BHYB
qXGd2NcJJUhjJgLz5BmcX3ogl4Eb9wV0FXSNV7FhKvon73/Pg4BQ3nLu8qN9x53a
pwrOv1VmYcRAyNUfxHzeJnWxIdHtfbyiVMIeRdCATjcPSqjgK1aY3ipTXfBUBbDu
cS5u1+zQ3iPavy+xYBVcWEfqX5o4KTCaM0vdG0do7aNQKkkzPKpoC+u9LqGKNr/g
OlPHrZ4ZkwR8Sc7t7HKGI7P0dwp6hWb+Ous9lVsE8GKC0/c/+bKdps6F2pNmIMjx
adWHr4QKnhKqUIU/CYiDPYBTiOOBeguR67XneJezWIE9Mw9tJALG8Qi4mh5A+zsc
ZG3bZqJL42ailgfQdvqd
=rccL
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
