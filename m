From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 11 Mar 2015 13:15:54 +0000
Subject: Re: [PATCH] kernfs: remove outdated and confusing comment
Message-Id: <20150311131554.GA10067@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="pf9I7BMVVzbSWLtt"
List-Id: <linux-sh.vger.kernel.org>
References: <1426069565-7933-1-git-send-email-wsa@the-dreams.de>
 <20150311114531.GB25944@htj.duckdns.org>
In-Reply-To: <20150311114531.GB25944@htj.duckdns.org>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Hmm... poll isn't hooked up for bin files and the behavior isn't well

Ah, thanks! I assumed something like that but could not find the
relevant code.

> defined either.  The open file's event counter is never synchronized
> to the backing node's.  Before the first kernfs_notify(), it won't
> trigger and after always.  We'll prolly need to define that better.
> What's the use case that you're interested in?

I wanted to add notification to drivers/i2c/i2c-slave-eeprom.c which is
a software backend when the Linux system is acting as an I2C slave
device.  This is basically a dual mem driver. One side is exposed to the
system as a bin-file in sysfs. The other side is accessible like an
EEPROM for other I2C masters connected to the bus. The notification
should report to userspace when a remote master has written something
to us so the memory contents changed.

I know this is not the best way of notification because we don't know
what changed and would need to compare. However, the whole I2C slave
framework is still very young and I wanted to play with it for the case
where only a few bytes are exposed.


--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVAEAKAAoJEBQN5MwUoCm2Vy4P/1l//HJnGsC1DFiEvEjCDtCQ
Oj8JTlUaCMQvy2f1p//opPP8ULLjRZWK18zY+39j5pXwnU7U9QF5mgSR/GJNpILe
563qPa70XeHk02OgW4j9n1+qbonyQpkTQ0b+kWlN5q+Bed1URl2Aczu4z1rGngcG
08pB4O5Oh+zLkXSAyfEzvWHyVfysSVT7ya/FG8HvGNsBUYFsIesfFnqO4z6rpuB1
Jw3i1nPCvGq0LLHJcffoiSbXsYXGtVVn2RrscvcEcay/4syaHWLsY7/tuVoHEs+7
M57jYS7gLxE0jBPtE+O+c47voAkBMEweKuhYRiJJotGRBnAnnmU6SyGL+4OcpE12
vSI3N2U+qvW5M/LL0UXWH8XdZvo1GFbsCpC8KRgFllK7kUluRkDVws12n5ZqI2K+
N2qQeXqRgYpU7kJxc3TaAQqRJzs0F2OdwJ3x71U+ntPmSiNl0QSvArm1Yp6e6FwX
MNZmwlvvS0kBKBbFv2UnQwU9ARt/DVUqj3hYIrt/LxpePXKemP+J3GTo2NSWOq1y
nRZr86b939OFU5J2HzsGAtl4GLV3zMRMblV+ZTJphZl1/yPE+hZfBWhqJ2XeKtsP
+BHY1SscXFo6z19YCNrVNUY4xm+CNRYt6yhlq2Py5gZ1znuSbO+aNVb/tMTm52oL
0XdMfyWAFyazp71DgX94
=SX7g
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
