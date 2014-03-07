From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 07 Mar 2014 15:45:32 +0000
Subject: Re: [PATCH V7 0/3] clocksource: Consolidate SH and ARM mach-shmobile Kconfig bits
Message-Id: <20140307154532.GE28943@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="r7U+bLA8boMOj+mD"
List-Id: <linux-sh.vger.kernel.org>
References: <1392897287-11614-1-git-send-email-wsa@the-dreams.de>
 <5305FA60.7040904@linaro.org>
In-Reply-To: <5305FA60.7040904@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-kernel@vger.kernel.org, khilman@linaro.org, arnd@arndb.de, linux-sh@vger.kernel.org, horms@verge.net.au, john.stultz@linaro.org, olof@lixom.net, Magnus Damm <magnus.damm@gmail.com>


--r7U+bLA8boMOj+mD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Thu, Feb 20, 2014 at 01:51:44PM +0100, Daniel Lezcano wrote:
> On 02/20/2014 12:54 PM, Wolfram Sang wrote:
> >This is V7 of the SH and ARM mach-shmobile clocksource Kconfig consolida=
tion
> >series. It is a rebased version of V5 on top of timers/core. This series=
 is not
> >just an optimization, it also makes it possible to enable the clocksourc=
e for
> >the r7s72100 platform. I successfully tested the patches on r7s72100 and
> >r8a7791 platforms. The branch can be found here:
> >
> >git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/rewo=
rk-clock-config-for-daniel
>=20
> Thanks Wolfram,
>=20
> applied to my tree for 3.15

I see the patches in your tree, but not in linux-next?

Regards,

   Wolfram


--r7U+bLA8boMOj+mD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTGemcAAoJEBQN5MwUoCm2K2YQAKcXb3hQPG9uqX3bIlBcZ4nJ
pL5M2cFKx9z+BoTAkwyvwP9/zJOA/ifZhbfrTUpCtzYPVh+A3xe57qmQzmFLeeMw
26lpW2Q5O5GP5t6+nJlV9uuPTTadpDS/+ud+79ue5E3rhLKEovmKGMvBJCnm9MXM
n0aNXeTUjnj+8ebH5/D5ZmwC9dRbceiHhOwgVxCKF3zdCGLcIVRWsXIsQEcE2weg
ZsqOgxqbjuT1xFta1gPvUSYWgCgrMiEIkrle91spq6ZUhK8dHGMlW1Plm42WvfXW
xcI5yaYoiSOodRly1I0TJvDnwoj5XEwyExayMhTsqFYk4uKKsUsETiZHkCRGVlGP
+Nz/6NoecjQ8IcBrwtiKSa18kAo+1W6SnLavrmDdD2gDxJVNu7qhWRE/ItvktGxy
wakPM6/y+AmdR5OLyBtOugWGMmMqV83mxLEdfxs9Ux/eEGeOZLsL7Kp/rUiIyWPV
5yQ05UdL/DWLykmims0tfog3m7/8LBWmUvlQZ4DeNIvwgxZYIzaRUuVm/VazIOZw
+G4gD/ntvukto/LNxa2z37Qt3/sJ+ZvRf3isrShYAw4CMkyasumYI06pCq6KbMxS
xEju5h+L+jZEfi/LB2INSckmOHNc+QQc5bUjHJ7G6B2N4X0nioe2rQ7gCsgI+RpT
6krOjsQrPZ5ucD1prJrp
=a2Vn
-----END PGP SIGNATURE-----

--r7U+bLA8boMOj+mD--
