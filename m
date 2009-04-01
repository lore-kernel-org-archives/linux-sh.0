From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 01 Apr 2009 04:22:07 +0000
Subject: Re: qemu-sh CF access perormance
Message-Id: <aec7e5c30903312122s46ce25b4g8383cfa68e550dff@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49D2185C.4050909@juno.dti.ne.jp>
In-Reply-To: <49D2185C.4050909@juno.dti.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

2009/3/31 Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>:
> I'd like to ask following questions to linux-sh experts,
>
> =A0- Why such io-traps are used to access CF?
> =A0- Will this io-traps are used for SH7785LCR's SD card access?
>
> I guess these io-traps can be the reason why gcc takes so much time on qe=
mu-sh.

The r2d hardware implements 16-bit only CF interface while driver
software requires 8-bit access. To work around this issue io_trapped
is used to convert 8-bit accesses to 16-bit accesses. This is quite
slow.

For more information, please see the comment in arch/sh/boards/mach-r2d/set=
up.c

To improve performance, consider adding a command line flag to the
kernel that disables io_trapped. This flag can then be set on the
kernel command line by the person running qemu.

Hope this helps!

Cheers,

/ magnus
