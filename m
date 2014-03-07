From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Fri, 07 Mar 2014 16:27:11 +0000
Subject: Re: [PATCH RFC] ARM: shmobile: r8a7791 legacy: Disable RMSTP clocks
Message-Id: <5319F35F.8050706@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1394135648-10193-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1394135648-10193-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 07/03/14 16:17, Geert Uytterhoeven wrote:
> On Fri, Mar 7, 2014 at 4:44 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>>>>     - How to tell the system that it should (not) disable the RMSTP
>>>> clocks?
>>>>       Someone may want to run something on the SH core, and we don't want
>>>> to
>>>>       interfere with that.
>>>
>>>
>>> Those are tricky questions. RMSTPCRs are supposed to be managed by the
>>> SH-4A
>>> core. If the SH-4A core isn't booted the only option we have is to manage
>>> them
>>> elsewhere. In that case the registers should be configured at boot time to
>>> disable all modules from the SH-4A side. This could be done either when
>>> booting the kernel, or in the boot loader.
>>>
>>> If the SH-4A core is booted by Linux we could require the SH-4A code to
>>> disable all unused clocks, but we could also do so before booting it
>>> without
>>> any drawback (I expect the SH-4A firmware to enable the clocks it needs).
>>>
>>> The SH-4A core could be booted first, and then only boot the ARM cores
>>> running
>>> Linux. I don't know if that configuration is commonly used, or even
>>> supported,
>>> but in theory that should be possible. In that case the Linux kernel must
>>> not
>>> touch the RMSTPCRs.
>>>
>>> We could disable all realtime clocks from the Linux kernel at boot time
>>> (with
>>> a way to bypass that depending on whether booting the SH-4A first is a use
>>> case we need to support), or decide to leave this to the boot loader.
>>
>> I agree with Laurent, we don't really have a good way yet to know
>> if the SH-4A is going to be used.
>
> If the SH-4A is used, there must be some synchronization between the
> two cores, to avoid both cores touching the same hardware at the same time.
>
> If there is no sharing (which CPU uses which hardware block is fixed),
> Linux can just disable the RMSTP clocks for the hardware blocks that are
> used by Linux only (i.e. those that are enabled in DT --- I'm ignoring
> the legacy
> case for now). This requires adding new regs to the bindings[*].
>
> If there is sharing (both CPUs access the same hardware block, but not
> at the same time), synchronization code needs to be written.
>
> As the sharing case needs new code anyway, I think we can ignore it for now?

No it doesn't... it could be hidden behind trustzone or similar hiding
technology

> That leaves us with the hardware blocks that are not used by Linux. I.e.
> (1) blocks we have in the .dtsi, but not enabled in the .dts, and
> (2) blocks that are not in the .dtsi because we don't have a driver yet.
> These may or may not be used by the SH-4A, but if not, we want to disable
> the clocks for power management reasons.
>
> [*] Currently the bindings in renesas,cpg-mstp-clocks.txt say:
>
>      "reg: Base address and length of the I/O mapped registers used by the MSTP
>      clocks. The first register is the clock control register and is mandatory.
>      The second register is the clock status register and is optional when not
>      implemented in hardware."
>
>      The RMSTPCR registers can be the third (optional) register, unless there
>      exist SoCs with RMSTPCR registers but no MSTPSR registers (one more
>      reason for going with reg-names rather sooner than later ;-).
>
> <going wild>
> As DT describes the hardware, we could have both ARM and SH in the DTS,
> too? Anyone who wants to run an AMP system? ;-)
> </going wild>

Already doing it.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
