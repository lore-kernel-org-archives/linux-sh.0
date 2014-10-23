From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 23 Oct 2014 09:19:48 +0000
Subject: Re: [RESEND 2] cpufreq: dt: disable unsupported OPPs
Message-Id: <CAMuHMdV2gPOZoV62rSNjpD=dJ43EE+s0wtRW4ncLWU-J-eHLDg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <48734362.lRa73hezrZ@vostro.rjw.lan>
	<1413454100-23009-1-git-send-email-l.stach@pengutronix.de>
	<8590662.lsNXszcTd0@vostro.rjw.lan>
In-Reply-To: <8590662.lsNXszcTd0@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lucas Stach <l.stach@pengutronix.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Rafael, Lucas,

On Tue, Oct 21, 2014 at 4:19 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrot=
e:
> On Thursday, October 16, 2014 12:08:20 PM Lucas Stach wrote:
>> If the regulator connected to the CPU voltage plane doesn't
>> support an OPP specified voltage with the acceptable tolerance
>> it's better to just disable the OPP instead of constantly
>> failing the voltage scaling later on.
>>
>> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> Applied, thanks!

This commit
(http://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=
=3Dlinux-next&id=D7bbd4cd0359d781b67c9e621d4bbfd1bb2f3783)
causes a boot regression on r8a7791/koelsch. It hangs after:

    TCP: cubic registered
    Initializing XFRM netlink socket
    NET: Registered protocol family 17
    NET: Registered protocol family 15
    ata1: link resume succeeded after 1 retries
    ata1: SATA link down (SStatus 0 SControl 300)
    random: nonblocking pool is initialized

With more debugging, it seems to end up in an infinite loop
calling runtime_{suspend,resume}():

    cpufreq-dt cpufreq-dt: pm_clk_notify() 4
    i2c-sh_mobile e60b0000.i2c: pm_clk_resume()
    MSTP i2c6 ON
    i2c-sh_mobile e60b0000.i2c: pm_clk_suspend()
    MSTP i2c6 OFF
    i2c-sh_mobile e60b0000.i2c: pm_clk_resume()
    MSTP i2c6 ON
    i2c-sh_mobile e60b0000.i2c: pm_clk_suspend()
    MSTP i2c6 OFF
    i2c-sh_mobile e60b0000.i2c: pm_clk_resume()
    MSTP i2c6 ON
    i2c-sh_mobile e60b0000.i2c: pm_clk_suspend()
    MSTP i2c6 OFF
    i2c-sh_mobile e60b0000.i2c: pm_clk_resume()
    MSTP i2c6 ON
    i2c-sh_mobile e60b0000.i2c: pm_clk_suspend()
    MSTP i2c6 OFF
    i2c-sh_mobile e60b0000.i2c: pm_clk_resume()
    ...

Reverting this commit fixes the issue, and makes the boot continue with:

    cpufreq: __cpufreq_add_dev: CPU0: Running at unlisted freq: 1300000 KHz
    cpufreq: __cpufreq_add_dev: CPU0: Unlisted initial frequency
changed to: 1312500 KHz
    cpu cpu1: failed to get cpu-2 clock: 1
    cpufreq_dt: cpufreq_init: Failed to allocate resources: -2

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
