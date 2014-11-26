From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 26 Nov 2014 12:22:50 +0000
Subject: Re: [PATCH 2/3] i2c: slave-eeprom: add eeprom simulator driver
Message-Id: <20141126122250.GA4397@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
List-Id: <linux-sh.vger.kernel.org>
References: <1416326695-13083-1-git-send-email-wsa@the-dreams.de>
 <1416326695-13083-3-git-send-email-wsa@the-dreams.de>
 <CAOY=C6FSXWn2AKn9gp0oU69U8VkkyJAE7MMUTZsToy0P_Tf6AA@mail.gmail.com>
 <20141122181229.GB9698@katana>
 <CAOY=C6F6TMyeDvNneBV6K5hVjoG+qk-1Y_R3oJkEiGxhLOoQ0A@mail.gmail.com>
In-Reply-To: <CAOY=C6F6TMyeDvNneBV6K5hVjoG+qk-1Y_R3oJkEiGxhLOoQ0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> My bad, will minimize the overhead in the future.

Thanks!

> I think usable semantics could be that a slave driver can indicate at any
> point during an I2C read transaction that the next X bytes should be
> returned from a buffer and for a write transaction, that the next X bytes
> should be buffered before passed on to the driver. When the transaction

Yes, if we have something like that it should definately be that the
slave driver offers a buffer and the bus driver may accept the buffer or
not. Buffers should be opt-in and slave drivers will always have to
support byte-based transactions as the ultimate fallback because this is
how the vast majority of HW works (at least those I checked).

That makes me really wonder if there will be a case where performance is
so important that buffer handling is coded on top of the always needed
byte based handling?

More so, I'd think most slaves will have stuff like registers. So,
buffered writes usually won't make sense because setting bits should
cause an action immediately. And reading bits will have the problem of
data getting stale. I'd think this is the biggest use case of I2C.
Except for reading an EEPROM _once_ ;)

> ends or the adapter reaches the end of the buffer, it indicates this to
> the driver which can then either cleanup or otherwise act accordingly.

Or the adapter encounters an unexpected STOP. Cleanups need to handle
interrupted transactions as well. I'd think this is a bit more error
prone, because people would need to check a return value and compare it
to the number of bytes they wanted. Not a show stopper, but also nothing
I want to throw in too easily.

> But as you say, this can be added later on when the need arises.

I'd really say so.

> Just checked components we're using and stop/repeated-start both
> transition into the same state.

Good, thanks for checking! May I ask which components you are using?

   Wolfram


--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUdcYaAAoJEBQN5MwUoCm2Ut8P/jSG+L8qB4j4mF7C6yNtd3nR
xYbGz0te3282ritSJONOtP4GXVkz2v8TL3/1ZkEvmVyaZAclMTceFRoyIyVUrNxn
4t1tnJxDqM2+8fYq7OWhIAAVPjynWcNxM7EkJs4sSRzrfQyc6A+s8rGUYc8Ol37L
VEVCW76tlhwiBLohZAD8QF8/s9q9NAXmMBeXYfw5lVeUS02Cuvmmdsf697HrkWOr
OGd6wSPjXT9SZKFLY1D7MxvUnbEDZK0vU8GGDMDsQJjO91/rJb+0ptpB5yHEFF+/
TMoVMIpf/nheH/gRQP9bbQrS9mslun3bZ+26zcPDnX0Ao59N1zScXYiFCKfqKcR3
HczLZzBWGeS6oY+9Y03dmqD9aQ6Ix+O3BwYe8RZ66YANuiIUIq36WBtrCLZoUI3x
jPZLDFlFEsvQWZkWMkFWc8udKbHV7EHlaNj8Ce7g3VVqCakcIJBvaLkMmy0DmZMb
gUhj/vz8fdZQkT2VwwKq6TrlZExJ1cL7H2KasKNxoHd7ki+Tlz/Np8zd7xWOH28C
GylIwCsd9JU4kHuumvF+brCVV0nBTtvpNBgIznPZ4YkJ0VEbu8mUiyQUegszyUyA
1Z6BChvQhMROl0DJIEG56HbBMeE8RxjkXRE3x6ylP3aocaOobJCLmIXl8dHa0FVd
dAvlShGnoRlikm9aV+bI
=+RhW
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
