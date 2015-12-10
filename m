From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 10 Dec 2015 15:17:41 +0000
Subject: Re: [PATCH] i2c: allow building emev2 without slave mode again
Message-Id: <20151210151741.GE1573@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="pY3vCvL1qV+PayAL"
List-Id: <linux-sh.vger.kernel.org>
References: <201512102224.cVm7Hcp0%fengguang.wu@intel.com>
 <2592093.cGKEcKVqLU@wuerfel>
In-Reply-To: <2592093.cGKEcKVqLU@wuerfel>
To: linux-arm-kernel@lists.infradead.org


--pY3vCvL1qV+PayAL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> Alternatively, the  inline could return an error, and both bus
> drivers check for the error before using 'value'.

I'll try to check these options tomorrow.


--pY3vCvL1qV+PayAL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWaZeVAAoJEBQN5MwUoCm24/IP/AqRzOe/mC1ip6rf6i1QwnUu
0x+1fjbJVOZmanGJN7TfB9/pn4VBtcv5auYNPNy83aMfF9oDOOW1gZkMF3609Zco
2IIK6qWunqM0Hw8QSbsR8Rk3ayBjjO8Q93u6VGU4/LTjMLCOQYFcWHU+CKRoCGPM
EEi4DctTMNxzc41YMBljO9Iqs8LeddDe39k7pJIHpA0SgEdmA2Ps6A/fxlYUlYTQ
2pYH049Nrfpxccxco2HUJYkB/QpjyqX9YoRUiIB61VnLj0laO9KS/OWnDyBmO7Av
bc7fJQVsRqP8E8RRjU3epAqJI6kVSzG/SmEhL1jw4zMdT3ORaDsxN6BRDq6yJ+SU
6g8XelP+y+Zr3wDx3zocAz+TYrqPsAGCbbihbNiLtTJTHXYVBAZeT6Fl9xBXcyUR
MRQ5DIbvzbmE1Qu0vgYowwkxJwKhec3pQisM8iDBogLRCz+bij0TUWi/D78TBdAH
d2R/Ao9NtTXswxAwkoNEPVth98LhY0PIyz30qIhlxil0TWQAD9VCH9PEh9fIcPpr
+8hHwHMuV8Onn2ARQLB5cpeb2DkrDF7dZD6goKbPpmYlwxubfSmrcystfSHz82kN
o8/8X1As0xeb8sif0/DwRvpZWKOkd6DmhZbcgadWQe9/m97HKajhC5cyBsFOJDnk
opNmqP0Q4JmkebRVnP+S
=Nk7R
-----END PGP SIGNATURE-----

--pY3vCvL1qV+PayAL--
