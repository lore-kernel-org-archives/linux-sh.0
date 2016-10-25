From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 25 Oct 2016 19:54:22 +0000
Subject: Re: [sh]: glibc file offset problems since 2.24
Message-Id: <ecd87c98-f07e-56b8-0612-d370b8473c18@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <53fb3565-53cc-fa22-403f-b7220a5fa4d4@physik.fu-berlin.de>
In-Reply-To: <53fb3565-53cc-fa22-403f-b7220a5fa4d4@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On 10/22/2016 03:36 AM, Rich Felker wrote:
> Debugging this is complicated by the fact that qemu-sh4 is _wrong_,
> i.e. mismatches the real kernel in the opposite direction, so if
> someone tested on qemu they would find it working (or if they fixed it
> on real hardware, you would find it broken on qemu). Someone should
> file a qemu bug for this too but I haven't gotten around to it yet.

Just a quick heads-up:

The bug was indeed introduced by this commit and it was therefore easy
to fix for the original author. After verifying his suggested patch fixed
the issue (I tested his patch on my SH7785LCR), he's committed the patch
to glibc upstream [1,2].

Adrian

> [1] https://sourceware.org/git/?p=3Dglibc.git;a=3Dcommit;h!52cf7edadb7673=
ea1e216de6fdfa658ec4ac1f
> [2] https://sourceware.org/git/?p=3Dglibc.git;a=3Dcommit;h=CCebcff824e76f=
2d3905185b8ae9ff1b51607791

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
