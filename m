From: Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 16 Jan 2017 10:20:58 +0000
Subject: Re: SH builds broken due to kisskb toolchain upgrade
Message-Id: <87mvercnlh.fsf@concordia.ellerman.id.au>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdWmo9bnpWucQP6ZYbpFXVL73DDmfJE+ZgeTKAxC6LcrrQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWmo9bnpWucQP6ZYbpFXVL73DDmfJE+ZgeTKAxC6LcrrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Michael,
>
> sh4/magicpanelr2_defconfig started failing on Nov 16:
>
>     http://kisskb.ellerman.id.au/kisskb/target/2194/
>
> Last good version:
>
>     http://kisskb.ellerman.id.au/kisskb/buildresult/12857088/
>     sh4-linux-gcc (GCC) 4.6.3
>
> First bad version:
>
>     http://kisskb.ellerman.id.au/kisskb/buildresult/12857629/
>     sh4-linux-gcc.br_real (Buildroot 2016.11-git-00613-ge98b4dd) 5.4.0
>
> Both versions build fine with the compiler I'm using (gcc 4.6.3 from
> kernel.org crosstool).

Sorry, I thought I tested it before switching.

Using the buildroot compilers was an attempt to move to something
vaguely modern, and a toolchain that I don't have to build myself :)

For now I've gone back to the 4.6.3 one we were using previously.

cheers
