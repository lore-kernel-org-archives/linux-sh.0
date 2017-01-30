From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 30 Jan 2017 11:21:38 +0000
Subject: Re: Bug#576242: gdb: Please support Renesas SH(sh4)
Message-Id: <c184d5b5-4ec4-96e8-70f0-3ea61ce480db@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

We're currently working on improving SuperH support in Debian and Linux
in general since the architecture is currently being redeveloped as an
open source architecture called J-Core [1]. J-Core supports the SH-2
instruction set only, but it's expected to extend to SH-3 and SH-4
in the future. Hence, having working native SH support for gdb on Linux
would be very desirable.

>  * Tom Tromey <tromey@redhat.com> pointed out that any significant
>    contributors would need to sign copyright assignment papers, since
>    the patch is far from trivial.  Otherwise, GNU won't merge it, and it
>    will bitrot constantly.
>    <http://www.cygwin.com/ml/gdb-patches/2011-11/msg00499.html>

This would actually the first and most important thing to do. I have
tried contacting Takashi YOSHII but so far I had no success. One that
could help would be Nobuhiro Iwamatsu, so I put him in CC. There is
also Yutaka Niibe whom we can ask.

Adrian

> [1] http://j-core.org/

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
