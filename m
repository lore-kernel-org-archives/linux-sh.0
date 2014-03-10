From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 10 Mar 2014 11:45:18 +0000
Subject: Re: [PATCH RFC] ARM: shmobile: r8a7791 legacy: Disable RMSTP clocks
Message-Id: <3007182.i4IcvHnv9P@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1394135648-10193-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1394135648-10193-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Monday 10 March 2014 10:00:29 Geert Uytterhoeven wrote:
> On Fri, Mar 7, 2014 at 5:34 PM, Laurent Pinchart wrote:
> > On Friday 07 March 2014 17:17:04 Geert Uytterhoeven wrote:
> >> On Fri, Mar 7, 2014 at 4:44 PM, Ben Dooks wrote:
> >> >>>  - How to tell the system that it should (not) disable the RMSTP
> >> >>>    clocks? Someone may want to run something on the SH core, and we
> >> >>>    don't want to interfere with that.
> >> >> 
> >> >> Those are tricky questions. RMSTPCRs are supposed to be managed by the
> >> >> SH-4A core. If the SH-4A core isn't booted the only option we have is
> >> >> to manage them elsewhere. In that case the registers should be
> >> >> configured at boot time to disable all modules from the SH-4A side.
> >> >> This could be done either when booting the kernel, or in the boot
> >> >> loader.
> >> >> 
> >> >> If the SH-4A core is booted by Linux we could require the SH-4A code
> >> >> to disable all unused clocks, but we could also do so before booting
> >> >> it without any drawback (I expect the SH-4A firmware to enable the
> >> >> clocks it needs).
> >> >> 
> >> >> The SH-4A core could be booted first, and then only boot the ARM cores
> >> >> running Linux. I don't know if that configuration is commonly used, or
> >> >> even supported, but in theory that should be possible. In that case
> >> >> the Linux kernel must not touch the RMSTPCRs.
> >> >> 
> >> >> We could disable all realtime clocks from the Linux kernel at boot
> >> >> time (with a way to bypass that depending on whether booting the SH-4A
> >> >> first is a use case we need to support), or decide to leave this to
> >> >> the boot loader.
> >> > 
> >> > I agree with Laurent, we don't really have a good way yet to know
> >> > if the SH-4A is going to be used.
> >> 
> >> If the SH-4A is used, there must be some synchronization between the
> >> two cores, to avoid both cores touching the same hardware at the same
> >> time.
> >> 
> >> If there is no sharing (which CPU uses which hardware block is fixed),
> >> Linux can just disable the RMSTP clocks for the hardware blocks that are
> >> used by Linux only (i.e. those that are enabled in DT --- I'm ignoring
> >> the legacy case for now). This requires adding new regs to the
> >> bindings[*].
> >> 
> >> If there is sharing (both CPUs access the same hardware block, but not
> >> at the same time), synchronization code needs to be written.
> >> 
> >> As the sharing case needs new code anyway, I think we can ignore it for
> >> now?
> >> 
> >> That leaves us with the hardware blocks that are not used by Linux. I.e.
> >> (1) blocks we have in the .dtsi, but not enabled in the .dts, and
> >> (2) blocks that are not in the .dtsi because we don't have a driver yet.
> >> These may or may not be used by the SH-4A, but if not, we want to disable
> >> the clocks for power management reasons.
> > 
> > As soon as SH-4A is involved I believe Linux shouldn't touch the RMSTPCRs.
> > As we currently have no standard way to handle this, I would be inclined
> > to leave the responsibility of disabling clocks for unused peripherals to
> > the boot loader. If the boot loader doesn't behave we'll end up using
> > more power than we should, but I don't think there would be any other
> > adverse effect. On the other hand, it's tempting to let the kernel cover
> > the bugs introduced by the boot loader developers, especially when the
> > boot loader is not easily modifiable.
> 
> Sounds reasonable.
> 
> Currently I'm most worried by bugs slipping in in our drivers' clock
> handling due to the clock still being enabled on the SH-4A side.

I can share that concern. One possible solution would be a debug option to 
force disabling of all RMSTPCRs from the Linux side. It's a bit hackish 
though. Another one would be to fix the boot loader for our development 
boards, but I don't know where the sources are located, and whether we could 
push the modification "upstream" internally.

Magnus, I'd also like to hear your opinion on all this.

-- 
Regards,

Laurent Pinchart

