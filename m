From: Artem Bityutskiy <dedekind1@gmail.com>
Date: Wed, 02 May 2012 14:51:54 +0000
Subject: Re: [PATCH v3 0/10] sh_flctl hardware ECC mode cleanup
Message-Id: <1335970314.13013.2.camel@sauron.fi.intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-pNDvmTzQvzApXi9hvLXA"
List-Id: <linux-sh.vger.kernel.org>
References: <1335951710-9390-1-git-send-email-hechtb@gmail.com>
 <1335955122.10293.39.camel@sauron.fi.intel.com>
 <CABYn4szhjH0N_DsGc=O0TtJZNUja1KDzZ7HWTnR5nQvnxZEVPQ@mail.gmail.com>
 <1335960145.10293.48.camel@sauron.fi.intel.com>
 <CABYn4swraZL0Zi56xfPyZQ4vo1jK9f4KFLUZxEPrZRO4K83URg@mail.gmail.com>
 <1335966905.10293.59.camel@sauron.fi.intel.com>
 <CABYn4sz-_VCLUExgT7Bzr_mLCeYEnCV7ayhWCpkcH_2HyVFgjQ@mail.gmail.com>
 <1335967727.10293.63.camel@sauron.fi.intel.com>
 <CABYn4sxfw_qucyHK5Cj_yaM9yFKQQ24SCUJu2AcugXSzCbEYZw@mail.gmail.com>
In-Reply-To: <CABYn4sxfw_qucyHK5Cj_yaM9yFKQQ24SCUJu2AcugXSzCbEYZw@mail.gmail.com>
To: Bastian Hecht <hechtb@googlemail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Brian Norris <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, Laurent Pichart <laurent.pinchart@ideasonboard.com>, linux-sh@vger.kernel.org


--=-pNDvmTzQvzApXi9hvLXA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-05-02 at 16:40 +0200, Bastian Hecht wrote:
> The log looks like this:
> HEAD is now at 07126b9 for test compiling
> [2012-05-02 15:51:43] test-patchset: Build non-patched kernel
> ("/tmp/test-patchset.IxuP/before/src", configuration
> "l2_mackerel_defconfig,arm,arm-none-linux-gnueabi-")
> mkdir: created directory
> `/tmp/test-patchset.IxuP/before/obj.l2_mackerel_defconfig,arm,arm-none-li=
nux-gnueabi-'
> [2012-05-02 15:51:43] make-kernel: Making target
> "l2_mackerel_defconfig" for "/tmp/test-patchset.IxuP/before/src
> (O=3D/tmp/test-patchset.IxuP/before/obj.l2_mackerel_defconfig,arm,arm-non=
e-linux-gnueabi-)"
> [2012-05-02 15:51:49] make-kernel: Making target "all" for
> "/tmp/test-patchset.IxuP/before/src
> (O=3D/tmp/test-patchset.IxuP/before/obj.l2_mackerel_defconfig,arm,arm-non=
e-linux-gnueabi-)"
> [2012-05-02 15:52:16] make-kernel: Failed to make target "all" for
> "/tmp/test-patchset.IxuP/before/src
> (O=3D/tmp/test-patchset.IxuP/before/obj.l2_mackerel_defconfig,arm,arm-non=
e-linux-gnueabi-)"
> [2012-05-02 15:52:16] make-kernel: Failed to make a target, exiting

Do you have arm-none-linux-gnueabi-gcc in your PATH? Look at he
workdir/before/l2_mackerel_defconfig,arm,arm-none-linux-gnueabi-.stderr
file - it should contain the build log - what it says?

--=20
Best Regards,
Artem Bityutskiy

--=-pNDvmTzQvzApXi9hvLXA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJPoUoKAAoJECmIfjd9wqK0O7cP/2EGC5nOh98g9ugIeVqlpSn4
RVbGSSgYWBv7AXNxH33YbttK6ppFeS6oyIMKtMAleN5kV0drd7RNarcY/Yp5w7ZP
pZQjyl+Kg5wmheDZ9AlTsdccMadht+6SIEs4xAvZ8GtTth0d4aKKl5yJQOsGX+OR
/7wYCsF/SCKPoOv6rD0QojJQLQOtZ0CqmClH8Wp8AJZYtT82sw8ATM0YVavWH/wX
NA0ezOSmc691gqzX4YFIeB1WJLpB4isMSS//VD3Rb3eRf+FxOgl6f5jahDdrriDs
1GUN3bAyb75Ne3RM3t9oyLPyPJTxQyw8hRYwlesQ1kabgo0ZjTfaP3j6nzs38hh+
eE3DATSgtebpG8ZxBBfl/2NK5gFtVoL5sgWdUnwQj4eBAsE2/AOg9YXPufcFnlQK
JwdG877yyIYeeQSeb6JS/FnXWhKMEGT34olrW2xKk9yLcEYCoTj9nXX8CIiVS71o
fNAiSJyi4dHlRolXqfkHWGrRY8t8F2iotC7xxYzy47N286AhM0lgKU9cwYTaa0dB
/F6qsJM72++KVq2/31FUPMIo+7/FlDVJHVZXEUpUxiiek0ILhdm0c3+0h+++ywHb
54LyGlnxJCrVuOSNMPHAtaxPR+aE1F51cPU1oFwf/zUuDoiRWml85/tAZn5Pa/JG
cnUDftdNL9MqF6MhE1R/
=KcGc
-----END PGP SIGNATURE-----

--=-pNDvmTzQvzApXi9hvLXA--

