From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 09 Jan 2015 13:32:32 +0000
Subject: [SERIES 0/3] ARM: shmobile: sh73a0/kzm9g multiplatform
Message-Id: <CAMuHMdWDsqYOPKqPmZ8oDuf28YrAtu+zcnikOhmehKFQNXfekQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon, Magnus,

This is a meta cover letter for the three patch series I've just  sent:
   - [PATCH 0/4] ARM: shmobile: sh73a0/kzm9g: Introduce multiplatform
                 support
   - [PATCH v3 0/4] drivers: bus: Add Simple Power-Managed Bus
   - [PATCH 0/4] ARM: shmobile: sh73a0/kzm9g: Complete multiplatform
                 support

After applying these series, kzm9g-multiplatform has the same feature
set as current kzm9g-reference, and the latter is removed.

Note that the third series depends functionally on the second. Without
the second series, Ethernet will not work (this also applies to a future
r8a73a4/ape6evm-multiplatform).

It would be great if you could apply all three series, as I have more patches
queued that depend on them.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
