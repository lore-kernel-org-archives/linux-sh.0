From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Jan 2017 13:39:50 +0000
Subject: SH builds broken due to kisskb toolchain upgrade
Message-Id: <CAMuHMdWmo9bnpWucQP6ZYbpFXVL73DDmfJE+ZgeTKAxC6LcrrQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Michael,

sh4/magicpanelr2_defconfig started failing on Nov 16:

    http://kisskb.ellerman.id.au/kisskb/target/2194/

Last good version:

    http://kisskb.ellerman.id.au/kisskb/buildresult/12857088/
    sh4-linux-gcc (GCC) 4.6.3

First bad version:

    http://kisskb.ellerman.id.au/kisskb/buildresult/12857629/
    sh4-linux-gcc.br_real (Buildroot 2016.11-git-00613-ge98b4dd) 5.4.0

Both versions build fine with the compiler I'm using (gcc 4.6.3 from
kernel.org crosstool).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
