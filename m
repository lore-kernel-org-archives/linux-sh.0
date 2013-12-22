From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 22 Dec 2013 10:14:49 +0000
Subject: Failure to bring up secondary CPU on koelsch
Message-Id: <CAMuHMdUJYLQ7gcatTKNqgSCT33KT5KBxsu4VwrPGfutMPWLRpA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

When cold-booting koelsch, it sometimes locks up after printing

    Starting kernel ...

Resetting the board and trying again usually helps (sometimes a few tries
are needed).

As koelsch doesn't have early printk support, I made printk() save all
messages to a buffer in RAM, to be inspected by uboot after a reset.
The last lines are:

    CPU0: update cpu_power 1024
    CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
    Setting up static identity map for 0x4028e1b8 - 0x4028e210

On success, the next lines are:

    CPU1: Booted secondary processor
    CPU1: update cpu_power 1024
    CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
    Brought up 2 CPUs

Anyone else seeing this, or knowing what's wrong?

I'm using U-Boot 2013.01.01-gb6af5fc (Nov 12 2013 - 14:33:51) and a
kernel based on renesas-devel-v3.13-rc4-20131219.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
