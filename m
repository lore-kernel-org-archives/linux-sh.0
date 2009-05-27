From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 27 May 2009 00:04:05 +0000
Subject: RE: [PATCH] sched: Support current clocksource handling in fallback
Message-Id: <alpine.LFD.2.00.0905270150031.1762@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <20090526061532.GD9188@linux-sh.org>  <63386a3d0905260731m655bfee3q82a6f52d71fa3cef@mail.gmail.com>  <1243348681.23657.14.camel@twins>  <1243369423.3275.5.camel@localhost>  <1243369815.6600.2.camel@laptop>  <1243370439.3275.13.camel@localhost> 
 <1243371309.6600.8.camel@laptop> <1243378835.3275.30.camel@localhost> <68887236814FB54BBC1D0E0556DD510D4CCB0F09E2@orsmsx509.amr.corp.intel.com>
In-Reply-To: <68887236814FB54BBC1D0E0556DD510D4CCB0F09E2@orsmsx509.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mangalampalli, JayantX" <jayantx.mangalampalli@intel.com>
Cc: john stultz <johnstul@us.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Linus Walleij <linus.ml.walleij@gmail.com>, Paul Mundt <lethal@linux-sh.org>, Ingo Molnar <mingo@elte.hu>, Andrew Victor <linux@maxim.org.za>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, John Stultz <johnstul@linux.vnet.ibm.com>

On Tue, 26 May 2009, Mangalampalli, JayantX wrote:

1) please do not top post.
2) please fix your mail client to do proper line breaks at ~78 chars

(see http://www.tux.org/lkml/)

> Isn't rdtsc inherently dependent on CPU tick rate, which is somewhat
> variable? Shouldn't HPET be more reliable? Or can constant_tsc be
> relied on for important things like scheduler?

1) Please understand that there is an universe which has useful timer
implementations. i.e. almost everything except arch/x86

2) rdtsc is not inherently dependent on CPU frequency. It just depends
on the CPU frequency for most of the CPU implementations which have
the ability to change the CPU core frequency. Newer CPUs have core
frequency invariant TSC implementations, but they are not perfect yet
as the TSC stops in deeper C-states.

3) HPET is reliable but the hardware access to HPET is way more
expensive than the access to TSC. Also it does not scale on SMP
machines as the HPET access is serialized and worse than a global
lock. So there is a damned good reason why we went there to add the
horror of sched_clock.c to utilize TSC for hot code pathes.

Thanks,

	tglx
