From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 02 Jun 2009 13:44:18 +0000
Subject: Re: [PATCH 00/04][RFC] PM: Runtime platform device PM
Message-Id: <aec7e5c30906020644y5234b95fg5472638662cda5b5@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Sat, May 30, 2009 at 3:18 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday 29 May 2009, Alan Stern wrote:
>> On Fri, 29 May 2009, Magnus Damm wrote:
>>
>> > > (And by the way, the _noirq ops don't run in atomic context. =A0They=
 run
>> > > in process context with most interrupt deliveries disabled. =A0It's =
not
>> > > the same thing -- they are allowed to sleep.)
>> >
>> > Huh, so if they are allowed to sleep then clock events are still
>> > running. And probably some clocksource as well. I guess that's why you
>> > say "most" interrupts disabled instead of all. Sharing the timer IRQ
>> > is not allowed then?
>>
>> Rafael can tell you. =A0But notice I didn't say the interrupts were
>> disabled -- I said that interrupt _delivery_ was disabled. =A0In general
>> the interrupts themselves _are_ enabled; the kernel fields them but
>> then does not call the drivers' interrupt handler routines.
>
> That's correct, except for the platforms where __disable_irq() actually m=
asks
> the IRQ. =A0I'm not sure if SuperH is one of these.

We make use of CONFIG_GENERIC_HARDIRQS so the __disable_irq() suspend
logic should work for us as well.

>> (Except perhaps for IRQs which are explicitly marked as wakeup sources..=
.)
>
> No, they are treated just like the other ones except that we check if any=
 of
> them are pending right at the beginning of sysdev_suspend().
>
>> > I wonder if the PM code assumes that the clock event is a sys device?
>
> Yes, it does.

I note the IRQF_TIMER check in __disable_irq(). I wonder if we can
make a second not bus-specific round where we disable only IRQF_TIMER
interrupts.

>> > We use platform drivers for clock events on SuperH...
>
> Argh. =A0This is going to hurt, but I'm not sure how badly. =A0At least on
> multiprocessor.

Luckily most boards around here are still UP. =3D)

/ magnus
