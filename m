From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 25 Aug 2014 08:39:52 +0000
Subject: Re: [PATCH 03/03] ARM: shmobile: Consolidate Legacy GPIOLIB Kconfig bits
Message-Id: <CAMuHMdUd9e8Wnko93P4D9b9+omm+ngHffmAXVQXQkgG++EtgLg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140825034559.9316.68303.sendpatchset@w520>
In-Reply-To: <20140825034559.9316.68303.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Mon, Aug 25, 2014 at 5:45 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> Consolidate ARCH_WANT_OPTIONAL_GPIOLIB under ARCH_SHMOBILE_LEGACY
> so it can be shared by the legacy ARM mach-shmobile code.

Given
  - all legacy support for shmobile boards except ape6evm, koelsch, and lager
    select ARCH_REQUIRE_GPIOLIB,
  - the ape6evm, koelsch, and lager defconfigs have CONFIG_GPIOLIB=y,
shouldn't we just upgrade from ARCH_WANT_OPTIONAL_GPIOLIB
to ARCH_REQUIRE_GPIOLIB?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
