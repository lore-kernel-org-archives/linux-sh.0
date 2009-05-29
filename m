From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 29 May 2009 07:41:13 +0000
Subject: Re: [PATCH 00/04][RFC] PM: Runtime platform device PM
Message-Id: <aec7e5c30905290041p13cc3e48k3527640fb52c3730@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Fri, May 29, 2009 at 12:33 AM, Alan Stern <stern@rowland.harvard.edu> wr=
ote:
> On Thu, 28 May 2009, Magnus Damm wrote:
>
>> On Wed, May 27, 2009 at 11:30 PM, Alan Stern <stern@rowland.harvard.edu>=
 wrote:
>> > On Wed, 27 May 2009, Magnus Damm wrote:
>> >> PM: Runtime platform device power management
>>
>> > Have you given any thought as to whether the platform_device_wakeup and
>> > platform_device_idle calls should be restricted to process context?
>>
>> Good question. The first thing that pops into my mind is to have same
>> restrictions as clk_enable() and clk_disable(). To keep things simple
>> I'd say that it's unlikely that any embedded platform driver would
>> need to sleep during the dev_pm_ops callbacks. Maybe it makes sense to
>> only allow _noirq variants of dev_pm_ops, not sure. Any ideas?
>
> I don't know what would be appropriate for you. =A0USB power transitions
> cannot be made in an atomic context, but the situation could well be
> different for platform devices. =A0It's just something to be aware of.

For our SuperH platform devices there should be no need to sleep.

> (And by the way, the _noirq ops don't run in atomic context. =A0They run
> in process context with most interrupt deliveries disabled. =A0It's not
> the same thing -- they are allowed to sleep.)

Huh, so if they are allowed to sleep then clock events are still
running. And probably some clocksource as well. I guess that's why you
say "most" interrupts disabled instead of all. Sharing the timer IRQ
is not allowed then?

I wonder if the PM code assumes that the clock event is a sys device?
We use platform drivers for clock events on SuperH...

/ magnus
