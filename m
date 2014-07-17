From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 17 Jul 2014 13:04:24 +0000
Subject: Re: [PATCH 1/5] i2c: Don't start transfers when suspended
Message-Id: <20140717130424.GH2740@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="LZFKeWUZP29EKQNE"
List-Id: <linux-sh.vger.kernel.org>
References: <1405165771-8732-1-git-send-email-hechtb@gmail.com>
 <20140717130047.GF2740@katana>
In-Reply-To: <20140717130047.GF2740@katana>
To: Bastian Hecht <hechtb@gmail.com>
Cc: linux-i2c@vger.kernel.org, Linux-SH <linux-sh@vger.kernel.org>, Tomoya MORINAGA <tomoya.rohm@gmail.com>, Naveen Krishna Chatradhi <ch.naveen@samsung.com>, Taekgyun Ko <taeggyun.ko@samsung.com>, Ben Dooks <ben@simtec.co.uk>, Magnus Damm <magnus.damm@gmail.com>


--LZFKeWUZP29EKQNE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2014 at 03:00:48PM +0200, Wolfram Sang wrote:
> Hi Bastian,
>=20
> On Sat, Jul 12, 2014 at 01:49:27PM +0200, Bastian Hecht wrote:
> > i2c transfer requests come in very uncontrolled, like from interrupt ro=
utines.
> > We might be suspended when this happens. To avoid i2c timeouts caused by
> > powered down busses we check for suspension.
> >=20
> > Signed-off-by: Bastian Hecht <hechtb@gmail.com>
>=20
> Thanks for doing this! I add linux-pm to CC because of two questions.

And in case of resending, please add at least alkml to the CC list. Or
better: use 'get_maintainer.pl' as cc-cmd with git-send-email.


--LZFKeWUZP29EKQNE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTx8nYAAoJEBQN5MwUoCm2wTgP/jkzKBKzo5LV8hEahU5TQFcf
nMLlbmOhXcMktwWGTfljdMDb4t4g40tM+hXB3C5qj981fS2XknBHMK7i8865E+dB
V1ILt1cHiZU9qBW+MBSxS0XeWlH/tNXyvrWcnzOFrDLF1s8WI5ii+c7DyLl0Ie7/
3VruFWBuJYg4GLKoWgVQsqZHvGp5e1CA1FWDlZvIgHtQy9tOqe74msNavGUXk6j+
faMaCnwswQjbZBXFgkxwKdf3ma1YqC8gUQEQFRFklBZl0Fv6hfelUkDQfLajNBZw
bI/UtsrMFN04zMh6jKltYSQUOFlRhs+ciCyUw1hWKFWjmlFz+/1XfSCh2WrstgO0
pu2bMuKVqvq6R38aSvdy/XsCgNSbqfgBdSZAKisXntoVOtkYoStkVRO4rPKlV22N
8NY2/iQDmxDE636T+pyjPDxMVFdS2egPzq+slnpBrE416AVDTjWydunlMPQI8iXv
yV3rp1Y1eOoyRgPGD9uSDuSHVRb8pbdqaQ3Agt+4+tpr5rulW815c003+neTIR+/
+ZaEvg4bUZBsc30ttIn+bTosTnanIaqQdqzNczz0kMw6B7PI0tSGeWJadnHTjAQc
TOgcs3xIyHDAhNfGfMGZG9eLEU59aTlmlfJ/K2L3DJHwy+M8GdOTKEyVeARcyNoi
W3kdXilhPUeaCn1H4dRr
=9YrQ
-----END PGP SIGNATURE-----

--LZFKeWUZP29EKQNE--
