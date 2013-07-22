From: Ian Molton <ian.molton@codethink.co.uk>
Date: Mon, 22 Jul 2013 17:15:36 +0000
Subject: EMEV2: debugging a Strange IRQ issue on SMP
Message-Id: <51ED68B8.3070302@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi guys,

I'm currently attempting to debug strange interrupt handling behaviour 
on EMEV2.

I and Ben Dooks undertook a port of much of the EMEV2 (mach-emxx) to 
2.6.39 a couple of weeks ago, and I recall having dealt with similar 
problems before, although they went away with some patches that fixed 
the pl310 cache controller behaviour.

We are now working on mainline (3.10+) and are seeing what appears to be 
the same problem -

IRQs are arriving, usually, but it seems that under some unknown 
circumstances, the interrupts from the STI timer stop arriving when in 
SMP mode.

They often dont stop immediately but work briefly, and then stop 
somewhat randomly, usually causing driver probes to hang during an 
msleep() or such.

I've compared the SCU and GIC (distributor and CPU) registers between 
the working (2.6.39) kernel, and the non-working mainline effort, and 
not found any real differences, other than some oddities in undocumented 
(and possibly irrelevant?) registers. All the documented registers 
contain sane, and substantially identical looking values.

the SCU is enabled, and both CPUs are set to coherent.
the problem occurs despite the L2 cache being completely disabled.
**the problem goes away when booting with nosmp**
Older kernels required the GIC to be mapped in a "Strongly ordered" 
region, however emulating this behaviour in mainline does not appear to 
help.
Older kernels only exhibited this issue with L2 enabled.

I'm wondering if this is some strange IRQ routing issue, but its eluding 
me at present.

Has anyone seem odd IRQ bahaviour on SMP setups before?
