From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 17 Feb 2014 10:08:07 +0000
Subject: Re: [PATCH 2/5] ARM: shmobile: r8a7791: add i2c master nodes to dtsi
Message-Id: <20140217100807.GA4424@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Qxx1br4bt0+wmkIi"
List-Id: <linux-sh.vger.kernel.org>
References: <1392543658-5030-1-git-send-email-wsa@the-dreams.de>
 <1392543658-5030-3-git-send-email-wsa@the-dreams.de>
 <20140217075410.GA2633@katana>
 <CANqRtoSDxQfSw5PJB6-UcL-UuMySBkoCqfC+1H=o-EBA18ouLQ@mail.gmail.com>
 <CAMuHMdW8MLknykkfu9XS5CDpuJcRNyPz+GV5bhUNGndxFacnQw@mail.gmail.com>
 <20140217091900.GD2633@katana>
 <CAMuHMdV5KNBcFh5E0bKaLNboZUbuXmMkzdYozqWLvro7Kwjhjw@mail.gmail.com>
 <20140217093126.GE2633@katana>
 <CANqRtoRgMaAzzvD9OK+=_J2Or5HZHzg4RUb899-bXjM7LKHSyw@mail.gmail.com>
In-Reply-To: <CANqRtoRgMaAzzvD9OK+=_J2Or5HZHzg4RUb899-bXjM7LKHSyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> It won't break because anyone who modifies r8a7790 support need to
> make it specific to that SoC to not pull in r8a7791 into some
> assumption.

Geert's assumption was that exactly this can be forgotten. While this is
true, my point was that this is a bug. And as it turned out, neither
this or that solution helps the case :) It needs to be fixed or done
properly right from the beginning.

> realize that there is no shortcut for adding the compatible string to
> the driver. It has to be done sooner or later anyway.

OK, can be seen this way. As said before, I'll resend.


--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTAd+HAAoJEBQN5MwUoCm295kQAKPmEORHuPNhhySitVlSbgbQ
/ESQ+fZGhzfb4kBR9qr45xN2h272fOWiJY9Xd1pu7jDWVfKs2fuOyfy8PpT+UZN3
jbQLLdXw5xb89dQD1NRtudupE4dR0MmS9+WOYSQ7nbjMSjRTGwDkTc2xDNijgG29
SS6GRTeVLjE/hI2YsjAQVFgQzxsEpHQ7t7QwA1aCvKlivuHB2+eJ/5wQ4v7mfst/
QLKGoePdNhCOFz0YPlGXOpoETHuYKr6Rh10ftJ0dju1LapKeSMJNdXz1CALaiSFB
BqF+/Usedo/+3BBUwjTa3ozImkhSMtjK1TXhPUJ3g5MevNLolTMTVCaPSHaQ7jtt
VHZte8Vf9TN0yxse82BWvaSSsmxigUgg9KB+eYjNgMg+Ht+6JcyCpl4UO3eEWepz
kTsKhW5E6iNbaT8aDzsPgpzkqbUTIIAd3ckT/svnUG7OGQgBvZ9C1GJ+qyGN2FZa
2pqpbiq3TtfRLlS/U77r/5fw8gIyvVByzkhIwHFVTHpFUUuEdu6XX8xsFU0a3yTY
RFDrvUC8eNDZVzqcDWfpalJnxkGDFJYtFiW9OSE+/d3M7t03GDd0HYpyYIhEpePM
2JWKrfEhf2RZffV4Ko8PqYl4fo7ZcjjFIacMcQJX8Ng5P8YNE1tirLc3c8KIw3QM
qCwNwfc0fcO5ebAgEbXc
=48C3
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
