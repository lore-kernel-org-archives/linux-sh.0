From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 23 Oct 2014 23:25:44 +0000
Subject: Re: rcar-dmac: DMAOR initialization failed
Message-Id: <18870552.GGT2ov4S6n@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdUbJ2DyL2wpV6SDDyxmoBiQEycUYiBpN8BigWTh5jiEyQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUbJ2DyL2wpV6SDDyxmoBiQEycUYiBpN8BigWTh5jiEyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Tuesday 12 August 2014 14:11:07 Geert Uytterhoeven wrote:
> Hi Laurent,
> 
> When resuming from s2ram on Koelsch ("echo mem > /sys/power/state" to
> suspend, and press any of the SW3x to resume), DMAOR initialization fails:
> 
> PM: Entering mem sleep
> Suspending console(s) (use no_console_suspend to debug)
> r2a1130x spi1.0: ... can't suspend
> m25p80 spi0.2: ... can't suspend
> m25p80 spi0.1: ... can't suspend
> m25p80 spi0.0: ... can't suspend
> PM: suspend of devices complete after 4.011 msecs
> PM: late suspend of devices complete after 2.665 msecs
> PM: noirq suspend of devices complete after 2.686 msecs
> Disabling non-boot CPUs ...
> CPU1: shutdown
> Enabling non-boot CPUs ...
> CPU1: Booted secondary processor
> CPU1 is up
> PM: noirq resume of devices complete after 1.660 msecs
> PM: early resume of devices complete after 1.850 msecs
> rcar-dmac e6700000.dma-controller: DMAOR initialization failed.
> dpm_run_callback(): platform_pm_resume+0x0/0x54 returns -5
> PM: Device e6700000.dma-controller failed to resume: error -5
> rcar-dmac e6720000.dma-controller: DMAOR initialization failed.
> dpm_run_callback(): platform_pm_resume+0x0/0x54 returns -5
> PM: Device e6720000.dma-controller failed to resume: error -5
> m25p80 spi0.0: ... can't resume
> m25p80 spi0.1: ... can't resume
> m25p80 spi0.2: ... can't resume
> r2a1130x spi1.0: ... can't resume
> PM: resume of devices complete after 2.739 msecs
> PM: Finishing wakeup.
> Restarting tasks ... done.
> 
> DMA still works afterwards, though, as verified by reading from QSPI FLASH.
> 
> The "can't suspend/resume" messages are due lack of PM support in the
> SPI slave drivers. To rule out any influence, I disabled the RSPI and
> MSIOF drivers, and retried. DMAOR initialization still failed.
> 
> It turns out the issue is that rcar_dmac_resume() calls rcar_dmac_init()
> while the sys-dmacX MSTP clock is disabled.
> 
> I tried a few things to fix this, but I'm not so sure what's the best
> solution:
> 
> Works:
>   - Calling clk_enable(dmac->clk)/clk_disable(dmac->clk) before resp.
>     after the call to rcar_dmac_init(). This also needs rcar_dmac.clk setup,
> cfr. the first version of the rcar-dmac driver.
> 
> Does not work:
>   - Calling pm_runtime_get_sync()/pm_runtime_put() instead, as
>     this is inside a runtime PM resume call,
>   - Calling pm_clk_resume()/pm_clk_syspend() instead, as this doesn't
>     support nesting.
> 
> Any better solution?

Thinking about it, the current system PM code is broken anyway. The system 
suspend handler should wait for the current transfer to complete and stop the 
device, and the system resume handler should restart transfers. This would 
call pm_runtime_get_sync() and pm_runtime_put() (or should it be put_sync in 
at suspend time ?), resulting in proper clock management. The runtime PM 
suspend handler would be a no-op, and the runtime PM resume handler would call 
rcar_dmac_init(), relying on runtime PM to handle clocks. Something like

#ifdef CONFIG_PM_SLEEP
static int rcar_dmac_sleep_suspend(struct device *dev)
{
        /*
         * TODO: Wait for the current transfer to complete and stop the
         * device.
         */
        return 0;
}

static int rcar_dmac_sleep_resume(struct device *dev)
{
        /* TODO: Resume transfers, if any. */
        return 0;
}
#endif

#ifdef CONFIG_PM_RUNTIME
static int rcar_dmac_runtime_suspend(struct device *dev)
{
        return 0;
}

static int rcar_dmac_runtime_resume(struct device *dev)
{
        struct rcar_dmac *dmac = dev_get_drvdata(dev);

        return rcar_dmac_init(dmac);
}
#endif

static const struct dev_pm_ops rcar_dmac_pm = {
        SET_SYSTEM_SLEEP_PM_OPS(rcar_dmac_sleep_suspend,
                                rcar_dmac_sleep_resume)
        SET_RUNTIME_PM_OPS(rcar_dmac_runtime_suspend,
                           rcar_dmac_runtime_resume, NULL)
};

What do you think about that ?

-- 
Regards,

Laurent Pinchart

