From: Bastian Hecht <hechtb@gmail.com>
Date: Tue, 12 Mar 2013 14:50:42 +0000
Subject: Re: Serial port RTPM/Suspend issues
Message-Id: <CABYn4sysatHuM3dZH3hwc9D4jorYuSMy4PBJqU4kwTmq2OYnEQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CABYn4szDUQpgsSErNV6e+f8z9-FdpzzZkhafC5qELdK=kWk6=w@mail.gmail.com>
In-Reply-To: <CABYn4szDUQpgsSErNV6e+f8z9-FdpzzZkhafC5qELdK=kWk6=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

> Hi,
>
> when going to suspend-to-mem on my Armadillo board with runtime power
> management enabled my serial line outputs garbage.
> I found 3 ways to make it work:
>  - use the bootarg no_console_suspend
>  - add the flag CLK_ENABLE_ON_INIT to the SCIF.1 clock in
> mach-shmobile/clock-r8a7740.c
>  - remove the power domain association to A3SP in mach-shmobile/setup-r8a7740.c
>
> The obvious difference I can observe is that without any of these
> methods, the clocks are halted dynamically before shutdown and
> reenabled before serial_console_write() is used.
> I tried to skip the stopping of the sci.1 MSTP bit in
> drivers/sh/clk/cpg.c to simulate the working behaviour but without
> success.
> During resume I verified that sh_clk_mstp_enable() is called before
> serial_console_write() is used. Furter I check the MSTP bit before
> each write or read. I played around with adding a udelay(100) after
> enabling the clocks. No success.
> The A3SP power domain is not shut down during this process (.gov
>      = &pm_domain_always_on_gov).
>
> This all looks like the solution lies on a silver plate, but I can't see it.
>
> Any quick hints?
>
> I tested on Simon's topic/all+next branch with the armadillo defconfig.
>
> Cheers,
>
>  Bastian

To avoid confusion, let me add: Garbage is produced when waking, not
in the shutdown process.
