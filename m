From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 19 Sep 2015 10:08:16 +0000
Subject: topic/gen3-latest
Message-Id: <CAMuHMdW4JcsPiRAiZektJDqaLTh2Vasqz5kBE0yEJdQJf9WwGw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdXLKW4FkwbrhKoToV9BdHruK4VmvnMzofCEUSnuxk-_nQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXLKW4FkwbrhKoToV9BdHruK4VmvnMzofCEUSnuxk-_nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I've updated topic/gen3-latest in
https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git
It now contains the following topics:

  - Drivers:
      - topic/gen3-cpg-v7
      - topic/r8a7795-scif-v1
      - topic/rcar-dmac-residue-v1
      - topic/rcar-dmac-hamza-v1
      - topic/scif-misc-v3
      - topic/scif-dma-v4
      - topic/cs2000-v4
      - topic/r8a7795-i2c-v3
      - git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git#me/r8a7795-ravb-driver-v3

  - PFC:
      - topic/r8a7795-pfc-v2
      - topic/r8a7795-pfc-i2c-v2
      - topic/r8a7795-pfc-sound-v2
      - git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git#me/r8a7795-ravb-pfc-v2

  - Integration:
      - git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git#topic/arm64-rcar-gen3-v9.plus
      - git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git#topic/r8a7795-gpio-v1.rebase
      - git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git#topic/r8a7795-i2c-v3
      - git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git#topic/r8a7795-sound-v3
      - git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git#me/r8a7795-ravb-integration-v3

  - Misc:
      - topic/gen3-modemr-syscon-v1.rebase2
      - git://linuxtv.org/pinchartl/media#vsp1-kms-gen3-20150913

As I've also updated all included for-next branches due to new dependencies,
this is more like a new renesas-drivers release, but without testing on
non-R-Car Gen3 platforms.

Happy consuming ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
