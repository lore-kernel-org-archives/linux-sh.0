From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 05 Mar 2012 08:01:20 +0000
Subject: Re: [PATCH] sh_tmu / PM: Prevent power from being removed from TMU devices
Message-Id: <CANqRtoTQ++Khe_yuXvrk-w+itYDobHR4q6TZHS=UTxkQnu_XXA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201203030041.30244.rjw@sisk.pl>
In-Reply-To: <201203030041.30244.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Mon, Mar 5, 2012 at 2:47 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Sun, Mar 04, 2012 at 10:50:53PM +0100, Rafael J. Wysocki wrote:
>> On Sunday, March 04, 2012, Paul Mundt wrote:
>> > On Sat, Mar 03, 2012 at 12:41:30AM +0100, Rafael J. Wysocki wrote:
>> > > From: Rafael J. Wysocki <rjw@sisk.pl>
>> > >
>> > > To prevent TMU devices from losing power define a fake "always busy"
>> > > suspend callback in the sh_tmu driver that will cause all attempts to
>> > > suspend the system to fail. =A0In addition to that, make the driver
>> > > change the runtime PM settings of TMU devices so that they appear to
>> > > be always "active" and make SH7372 add them to the A4R domain (where
>> > > they physically belong), to make the PM domains core take those
>> > > settings into consideration when attempting to remove power from A4R.
>> > >
>> > > Proprer power management support will be added to the sh_tmu driver
>> > > in the future.
>> > >
>> > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
>> >
>> > Presumably we also need the same for the MTU2 and CMT drivers?
>>
>> Yes, we do in principle, although this isn't strictly necessary for thin=
gs to
>> work at the moment.
>>
>> I can post analogous patches for the other drivers if you want me to.
>>
> It would be nice to ensure that we don't run in to the same problems on
> the other drivers in the interim at least. I'll take a look at getting
> proper PM support taken care of for them afterwards.

I agree, but I wonder how much of an actual issue it is at this point.
In the long run of course the drivers should be fixed up, but this
patch more looks like a workaround for 3.3-rc.

As for actual hardware timers, MTU2 is not used on any platform with
power domain support today and the CMT is located in a always-on power
domain. So they should not cause any issues for 3.3-rc.

/ magnus
