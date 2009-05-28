From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 28 May 2009 06:14:58 +0000
Subject: Re: [PATCH 00/04][RFC] PM: Runtime platform device PM
Message-Id: <aec7e5c30905272314s54364f00u9bf5ecf48081dcda@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Wed, May 27, 2009 at 11:30 PM, Alan Stern <stern@rowland.harvard.edu> wr=
ote:
> On Wed, 27 May 2009, Magnus Damm wrote:
>> PM: Runtime platform device power management

> Have you given any thought as to whether the platform_device_wakeup and
> platform_device_idle calls should be restricted to process context?

Good question. The first thing that pops into my mind is to have same
restrictions as clk_enable() and clk_disable(). To keep things simple
I'd say that it's unlikely that any embedded platform driver would
need to sleep during the dev_pm_ops callbacks. Maybe it makes sense to
only allow _noirq variants of dev_pm_ops, not sure. Any ideas?

> You should consider using a special workqueue for this stuff instead of
> relying on the default workqueue. =A0It can help avoid deadlocks, and it
> has the advantage that you can define the workqueue to be freezable.
> (Generally speaking, you don't want platform-level wakeup and idle
> calls to start running spontaneously in the middle of a system sleep
> transition.)

Yeah, the mockup code needs more work. =3D) For SuperH Mobile I suspect
that we don't need any workqueues since the freeze() and disabling of
power has to be done from cpuidle context. For SoCs with more complex
power domain layouts it may make sense handle each power domain
independently. And on top of this we probably want to have some QoS
information so the runtime pm code can chose which device sleep mode
to enter. Like cpuidle but for devices or power domains.

Thanks for your comments!

/ magnus
