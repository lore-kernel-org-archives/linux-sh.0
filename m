From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 17 Feb 2014 09:12:37 +0000
Subject: Re: [PATCH 2/5] ARM: shmobile: r8a7791: add i2c master nodes to dtsi
Message-Id: <20140217091237.GC2633@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="XMCwj5IQnwKtuyBG"
List-Id: <linux-sh.vger.kernel.org>
References: <1392543658-5030-1-git-send-email-wsa@the-dreams.de>
 <1392543658-5030-3-git-send-email-wsa@the-dreams.de>
 <20140217075410.GA2633@katana>
 <CANqRtoSDxQfSw5PJB6-UcL-UuMySBkoCqfC+1H=o-EBA18ouLQ@mail.gmail.com>
In-Reply-To: <CANqRtoSDxQfSw5PJB6-UcL-UuMySBkoCqfC+1H=o-EBA18ouLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--XMCwj5IQnwKtuyBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Why is that? From my knowledge, you start with the exact compatible
> > property and hardware compatible entries may follow.
>=20
> I think this boils down to if they really are compatible or not. If
> for instance a 16550 port would be compatible with 8250 on a hardware
> level then using them in the order of "16550", "8250" makes sense. In
> this case the r8a7791 i2c is not really strictly based on r8a7790 i2c,
> it is just that r8a7790 has support in the driver. So it's a short cut
> instead of actual hardware compatibility.

I don't get this point. The legacy board code for koelsch and lager both
create a platform_device with "i2c-rcar_gen2", so the cores surely must
be compatible? Maybe the cores are not strictly based on each other, but
compatible, yes, I'd say.

> So far we've dealt with this by updating the driver and only relying
> on the actual SoC name as suffix.

OK, for consistency reasons I will resend.


--XMCwj5IQnwKtuyBG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTAdKFAAoJEBQN5MwUoCm2q3QP/3vvKPepf5Tr2ZsfHVPINPtN
IiRVNct1NDOoX/dgJRiFCxIzThy5+Moidrji8ROuC4F1USy8MmLNaeFPPjQNXRJw
+0QlRqxxmWs435R+B6dN5bW3LK9CuVkCBO965Gqpu8CFZBfT55rjl5tmvkcxkzCf
1EDUCFr5Mqo0v8t/AVnCTAnET8TbfztwXM/+dfV0XJCUp99swFe4JEUfHfJ3qzC7
6M/Ynvr8cyShssMSJIROGnwB630/w1iL/B58MZFHJJwDVsoVDARWjLxgViH+X6DR
R/vY9wsH00QYZJUw0Hu83XZKqMYiGCXnQ3PusMG9hDbKbxNlaJYcSWuWsqXALajZ
ntSlw63a1tBWdJYJo/c4Fl5UudQroNc89rEg7rGBqZg3yrvJp14ITi0MqOgslCkF
wmIor7SdBCyjhk3eFL5SRHn3Zl+VqOGOQ/WGG6m4Gk79k7kcYneRCcvlQfZ5sH3R
bgibm/6ItNh51k1lHcwDMKus+1AI8rvpObom52wm43TmeKuykl1hnIBb/RaBofdX
DB7WOK4bWpES+xPQPzg1MjKclrGc0rAeVbrWo9kOgLHLV76eR6kVsNBd5W90cmP3
hPknEiYIyy2l1u8LWA/2XM7h8HjjtoqTHmCS3Nrh1JYRe/lmsyv+eWjd2i294Ro4
hN8U0rXIjqZzvdpejond
=2S0v
-----END PGP SIGNATURE-----

--XMCwj5IQnwKtuyBG--
