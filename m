From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 12 Aug 2014 12:11:07 +0000
Subject: rcar-dmac: DMAOR initialization failed
Message-Id: <CAMuHMdUbJ2DyL2wpV6SDDyxmoBiQEycUYiBpN8BigWTh5jiEyQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

When resuming from s2ram on Koelsch ("echo mem > /sys/power/state" to
suspend, and press any of the SW3x to resume), DMAOR initialization fails:

PM: Entering mem sleep
Suspending console(s) (use no_console_suspend to debug)
r2a1130x spi1.0: ... can't suspend
m25p80 spi0.2: ... can't suspend
m25p80 spi0.1: ... can't suspend
m25p80 spi0.0: ... can't suspend
PM: suspend of devices complete after 4.011 msecs
PM: late suspend of devices complete after 2.665 msecs
PM: noirq suspend of devices complete after 2.686 msecs
Disabling non-boot CPUs ...
CPU1: shutdown
Enabling non-boot CPUs ...
CPU1: Booted secondary processor
CPU1 is up
PM: noirq resume of devices complete after 1.660 msecs
PM: early resume of devices complete after 1.850 msecs
rcar-dmac e6700000.dma-controller: DMAOR initialization failed.
dpm_run_callback(): platform_pm_resume+0x0/0x54 returns -5
PM: Device e6700000.dma-controller failed to resume: error -5
rcar-dmac e6720000.dma-controller: DMAOR initialization failed.
dpm_run_callback(): platform_pm_resume+0x0/0x54 returns -5
PM: Device e6720000.dma-controller failed to resume: error -5
m25p80 spi0.0: ... can't resume
m25p80 spi0.1: ... can't resume
m25p80 spi0.2: ... can't resume
r2a1130x spi1.0: ... can't resume
PM: resume of devices complete after 2.739 msecs
PM: Finishing wakeup.
Restarting tasks ... done.

DMA still works afterwards, though, as verified by reading from QSPI FLASH.

The "can't suspend/resume" messages are due lack of PM support in the
SPI slave drivers. To rule out any influence, I disabled the RSPI and
MSIOF drivers, and retried. DMAOR initialization still failed.

It turns out the issue is that rcar_dmac_resume() calls rcar_dmac_init()
while the sys-dmacX MSTP clock is disabled.

I tried a few things to fix this, but I'm not so sure what's the best solution:

Works:
  - Calling clk_enable(dmac->clk)/clk_disable(dmac->clk) before resp.
    after the call to rcar_dmac_init(). This also needs rcar_dmac.clk setup,
    cfr. the first version of the rcar-dmac driver.

Does not work:
  - Calling pm_runtime_get_sync()/pm_runtime_put() instead, as
    this is inside a runtime PM resume call,
  - Calling pm_clk_resume()/pm_clk_syspend() instead, as this doesn't
    support nesting.

Any better solution?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
