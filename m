From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 01 Feb 2016 23:09:33 +0000
Subject: ssh crashes kernel at lookup_user_key
Message-Id: <56AFE5AD.6010608@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hello!

I got the news today that SuperH support in the kernel is back to
maintained state which is awesome news! I am the remaining Debian
porter for the sh4 port and I recently experienced some issues with
newer kernel versions on sh4.

Since the kernel bugzilla doesn't allow to select "SH" as a target
platform, I filed the following bug under "other":

> https://bugzilla.kernel.org/show_bug.cgi?id=94901

Basically the problem is that I cannot upgrade ssh on the sh4 machines
to any newer versions as this will reproducibly crash the kernel and
let the machine return to the u-boot prompt. The backtrace can be found
in the bug report above.

This happens with kernel version down to 3.2.0, but I am currently
running 3.16.7-ckt7 from Debian on my SH7785LCR board. I tried newer
versions up to 4.3.0 which will actually boot but crash very quickly
with even more severe problems. I will file a separate bug report for
these.

Cheers,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
