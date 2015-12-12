From: Wolfram Sang <wsa@the-dreams.de>
Date: Sat, 12 Dec 2015 16:20:57 +0000
Subject: Re: [PATCH] i2c: allow building emev2 without slave mode again
Message-Id: <20151212162057.GA1530@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
List-Id: <linux-sh.vger.kernel.org>
References: <201512102224.cVm7Hcp0%fengguang.wu@intel.com>
 <2592093.cGKEcKVqLU@wuerfel>
In-Reply-To: <2592093.cGKEcKVqLU@wuerfel>
To: linux-arm-kernel@lists.infradead.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Arnd,

thanks for looking into this, but I don't get your point yet.

> The slave_cb callback function is supposed to set the 'value'
> here,

Only if a master wants to READ from us.

> but it might return an error not assign the pointer,

An error is only returned if a WRITE from a master was not accepted by
the slave backend.

> It might be best to change the callback to return 'void' and not
> allow it to fail.

We need that because in case of an errno, the slave should send NACK to
the master instead of ACK.

> At least the eeprom slave cannot fail anyway, and it is the only
> implementation we have at the moment.

True. But giving a slave the possibility to NACK a write should be
present IMO.

> Alternatively, the  inline could return an error, and both bus
> drivers check for the error before using 'value'.

Hum, it does return an error?

	return client->slave_cb(client, event, val);

You probably mean something else?

Regards,

   Wolfram


--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWbElpAAoJEBQN5MwUoCm2krMQAI0nNyDHSSGT8QjrPwaJIU2H
s2UEXp3np8CNek2xWRWB2UmSe8LO9YJEr2Zx0ojBQmxaL7v+NAkiC+FSMndMsS1b
fy5OC83UQqFdqUt/sUPJlGm4uua/Ebbrlxwl0AlSwJQXzGxp8xn8wVe8asdfjPf2
riVvUX619uenEpjL/uAanZOd5oDwmTRF80rVwGe6aKmE/pBd6jVbUEfoGMuf0U+m
WofdJgqAt7Ef3s5Ll1xWW6HTXem7jQSw/5lfyE2GkAukFCJNh0ZgGjbYaBnqJ6l9
FL6ySoleBBV6iPll28zJcr/hcCILYcmRCXw/EyUopv1oE69baAwjXhUdHz4uIqRy
FeSS32bWmnB66EH8LrJWEZn9AyrUe2n4TzQ/V+X2IfgNVvro6NM1j3EGGAIcPq29
vJOh5dGi2tdRBal+QF6HBsP8ANZ2dyOkn8ng0XiNwdLdLZ1k7KPbgr6bXi0KarPb
ky5xO6uhe7Uyq3AsZpqiOpGq5vKmonq8KJGDnc3rUlJlV9nI4i+uU22cw+YpHFHS
BWIoK2iw9b3Rtj8MdG5Mq3inbjfp+dvEqov6TXbUK21/G0XaP7lwc70cg6XVwQIl
+CVmjOfYcAgAa7TT/WvteCEck4UMGSbpC2zLv71djSgeCeek9G2Ff6RYILMFKh11
pi9kGwkm3RBVPZc/TI/T
=YMMR
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
