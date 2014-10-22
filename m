From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 22 Oct 2014 16:08:01 +0000
Subject: Re: [PATCH v2] ARM: shmobile: Add early debugging support using SCIF(A)
Message-Id: <20141022160800.GB1895@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="zx4FCpZtqtKETZ7O"
List-Id: <linux-sh.vger.kernel.org>
References: <1413993263-10444-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1413993263-10444-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


>     I'm wondering whether this can be fixed in the i2c driver? Does it
>     really have to enable and disable the clock?

=46rom a power-saving PoV, this makes sense. I assume serial output works
again as soon as the regular scif driver takes over? Isn't that a
generic problem of early_printk drivers that they are not refcounted for
the clocks?


--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUR9ZgAAoJEBQN5MwUoCm2e7AP/iy6TnZmWVT6Nuy2WHsPAF7v
Jm4j4bJGuGOlmC8XrKI7TSMuyJvvRWibn84DakC+lVtGrfmXtpN6AEAuJqdSd1ep
Dp7CNaX0L+sz8z+294p3QRx2KPrf7NQFU8ywBpq1NuqFhpzTuFBvjeYN2MwPXfwd
HMoqR96KGUIxcJvIVD4+HJ8IMWdKu5gKnOtsKpq/xZuLDcB3q/vkLCBTgUJo8ZEC
XArLCakDP8N/JnJlcg1niw11OR6iJdNUZ7vTbjDIRgtaK4E3wKX+TKMGuaTjnBUu
uQptx4ibVU2uOiXmfwmk7w/FJq43x0ZdbNEQxd7qR0HJNVarnydX+8qQZewVkTA9
wMnf72lgj343rq+MSSutl3rcYS7G0zmdxX+4sBdd+JPejdr6sG1azFFPQqWVG112
45RRouW5RWfI45GK627U1cc8RnofLxyrl/LrBmOS2uYfQvwzXUdzesM/Qx0N+KkR
fmVWMOqdLWKiAgRCL6wZWbgT/26SWzUD8gZV4XiB7oawAHKapCXpc1HFmOil+m2z
4tZalkXgpPDpKgviCEaiok3z1m1Gh/kheE/uhzldW03VGv26PAAfBps4hwHmuxsO
TntokmmbPJDg9QTBdK7OXM2nwEG1xZOokjiJVhVpLmYh6ePYpAuZYQeRI//m+rJa
DgtuZMJ9W9O8QklcwoE9
=U18Y
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
