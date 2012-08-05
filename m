From: Mike Frysinger <vapier@gentoo.org>
Date: Sun, 05 Aug 2012 02:01:58 +0000
Subject: pci dma addresses missing offset on sh7750
Message-Id: <201208042201.58615.vapier@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart6792413.ZUELsqtHWb"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org

--nextPart6792413.ZUELsqtHWb
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

i got back to looking at the landisk not working since 2.6.31.  linux-3.5=20
boots up with better information, so we can get further in figuring out wha=
t=20
went wrong.  for a recap, 99f95f117848088f2708b45c70be73152e78bb8a was the=
=20
last rev i could boot.

with 2.6.30.9, i see these address ranges:
Autoconfig PCI channel 0x8c3543e0
Scanning bus 00, I/O 0xfe240000:0xfe280000, Mem 0xfd000000:0xfe000000
00:00.0 Class 0200: 10ec:8139 (rev 20)
        I/O at 0xfe240000 [size=3D0x100]
        Mem at 0xfd000000 [size=3D0x100]
00:01.0 Class 0180: 1191:0009 (rev 07)
        I/O at 0xfe240100 [size=3D0x8]
        I/O at 0xfe240108 [size=3D0x4]
        I/O at 0xfe240110 [size=3D0x8]
        I/O at 0xfe240118 [size=3D0x4]
        I/O at 0xfe240120 [size=3D0x10]
00:02.0 Class 0c03: 1033:0035 (rev 43)
        Mem at 0xfd001000 [size=3D0x1000]
00:02.1 Class 0c03: 1033:0035 (rev 43)
        Mem at 0xfd002000 [size=3D0x1000]
00:02.2 Class 0c03: 1033:00e0 (rev 04)
        Mem at 0xfd003000 [size=3D0x100]

but with 3.5, i see:
PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [io  0x1000-0x3fffff]
pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfdffffff]
pci 0000:00:01.0: BAR 6: assigned [mem 0xfd000000-0xfd00ffff pref]
pci 0000:00:02.0: BAR 0: assigned [mem 0xfd010000-0xfd010fff]
pci 0000:00:02.1: BAR 0: assigned [mem 0xfd011000-0xfd011fff]
pci 0000:00:00.0: BAR 0: assigned [io  0x1000-0x10ff]
pci 0000:00:00.0: BAR 1: assigned [mem 0xfd012000-0xfd0120ff]
pci 0000:00:02.2: BAR 0: assigned [mem 0xfd012100-0xfd0121ff]
pci 0000:00:01.0: BAR 4: assigned [io  0x1400-0x140f]
pci 0000:00:01.0: BAR 0: assigned [io  0x1410-0x1417]
pci 0000:00:01.0: BAR 2: assigned [io  0x1418-0x141f]
pci 0000:00:01.0: BAR 1: assigned [io  0x1420-0x1423]
pci 0000:00:01.0: BAR 3: assigned [io  0x1424-0x1427]

notice how the dma ranges are completely in the wrong region.  any quick id=
eas=20
where to fix this ? :)
=2Dmike

--nextPart6792413.ZUELsqtHWb
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJQHdQWAAoJEEFjO5/oN/WB3pIQAJGWYc8VmjFTMvmMEo/hChLT
665ERjqM003abMlNLgVk4dFk7k2jylK0GhutBrvXtwK3eEn9E+0IqeKZ3O2as0D3
3I3Nmw1pUdjhM0nhpNkRd1Ep2jWZG1tm4tHrjV2kLz93Ytpp+2+4+3SPjuXoB1K9
ddblSTnd1TsvkMedPtn3A33yA32TjqyszuTV13nn80yx9SGWmM/M1O68Mqu89wt/
8aKjXFA179Fm3dz2/owkblQxYPDR2np4c/ky0TihC4schwaPjk5P3xqSnBdVgWBf
2JLFg+9QAFXPjT3vo8/mHK4UUzyes5bfG33nR0h9CDr73XFRMwOZS1ZkAIl7gdru
fHYLfZ8JKizqTD0f6RLAcp+qBT2kxBJts1laYqfMptuz/3R2Kdj9+53cqPDh3pRd
rTeCJMUPqvIWUrwfgX9NJ+AU/iuKjRJOyZqhgnoTjKWSvIpgcjJLYNv3tugq9TBr
2ap2ZxY7X/5fXlB6E1aCx6yNQ0jnjfC+g+XUtmoDgZ9CRur5A7/0iXYA0mcS2lpK
7cxCxYBBo3zImhO0EMpXrswhlRPmAeYz7Yk8O5urSNeRDosCvZ9rYWw6vKqvv+UP
3QOtC9NMSscQgXd8pLH1ZGKX9/zPr9L/ItEniX35KCPPrnGTEEbos6MYRjC8lxUe
vQu/gaKdx7Mv1IYZCFAL
=JxQ+
-----END PGP SIGNATURE-----

--nextPart6792413.ZUELsqtHWb--
