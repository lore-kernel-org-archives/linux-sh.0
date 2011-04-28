From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 28 Apr 2011 03:25:30 +0000
Subject: Re: [PATCH] i2c: i2c-sh_mobile bus speed platform data
Message-Id: <BANLkTi=bcWyKR-DrgHgYPtU8Xcw2gYqT8g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20110421132254.3725.84300.sendpatchset@t400s>
	<20110427221357.GA12273@verge.net.au>
	<BANLkTi=YbtWYKLdcEkv6TDRfm-BbXGXa4w@mail.gmail.com>
	<20110428011757.GB15883@verge.net.au>
	<20110428022214.GB13539@linux-sh.org>
	<BANLkTimSM-9XYy0UrwoWK8CGjp0qAqeF4A@mail.gmail.com>
	<20110428031115.GD13539@linux-sh.org>
In-Reply-To: <20110428031115.GD13539-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org

On Thu, Apr 28, 2011 at 12:11 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Thu, Apr 28, 2011 at 11:46:37AM +0900, Magnus Damm wrote:
>> On Thu, Apr 28, 2011 at 11:22 AM, Paul Mundt <lethal@linux-sh.org> wrote:
>> > On Thu, Apr 28, 2011 at 10:18:01AM +0900, Simon Horman wrote:
>> >> On Thu, Apr 28, 2011 at 10:06:38AM +0900, Magnus Damm wrote:
>> >> > On Thu, Apr 28, 2011 at 7:14 AM, Simon Horman <horms@verge.net.au> wrote:
>> >> > > I believe that on the sh73a0 and so far only the sh73a0
>> >> > > denom needs to be doubled.
>> >> >
>> >> > Uhm, I don't think this patch is specific to any SoC type. It may of
>> >> > course be used on sh73a0 to adjust the denom value, but setting the
>> >> > I2C bus speed is something that can be used on any SoC. So I'd say
>> >> > that this is a fairly generic feature.
>> >>
>> >> I'm just saying that that I've observed the value being doubled for sh73a0.
>> >>
>> > The general rule of thumb is that whatever unusual behaviour is observed
>> > in the latest CPU we will see become the standard for future ones.
>>
>> This may also be an attempt to simply double the I2C bus speed on that
>> particular platform for that particular application. So in the end it
>> may have nothing to do with sh73a0. Actually, now when I think about
>> it, I recall hacking up a prototype to control the LCD backlight via
>> I2C on sh73a0 and AG5EVM, and I did not have to modify any part of the
>> I2C bus driver to get that going as expected.
>>
> Ok, that bit of information was missing from your patch. That's obviously
> a bit more dodgy. We don't want to have the default behaviour out of spec
> for some specific application.

I suspect that I may have chosen my words poorly. By writing "This may
also be an attempt to simply double the I2C bus speed on that
particular platform for that particular application." I am not
referring to this patch. I am commenting on something Simon may see
when he is going though kernel source that has been mangled by people
doing integration.

As for configuring the i2c bus speed, I wouldn't call it dodgy. It is
something that is fairly common but of course needs to be handled with
care. Other drivers handle this through module parameters, but since
we want to configure this with per-device instance granularity
platform data is a better fit.

>> > Abstracting the denom value seems reasonable as a cautionary measure, and
>> > it does do the NORMAL_SPEED as a default fallback so there is no adverse
>> > impact for normalized platforms.
>> >
>> > This really should be going in to include/linux/i2c/ or so though, no
>> > need to dump these tiny stubs in to include/linux/ directly.
>>
>> I guess I just followed what other i2c drivers do, but yes, putting
>> the header file in include/linux/i2c/ makes more sense.
>>
> Other i2c drivers put things in include/linux/i2c, too. There's also an
> include/linux/platform_data/ now as well for things that don't fit
> anywhere else. "This is the way we used to do it" tends to be a pretty
> pointless argument going forward.

I looks like I have been unclear in my writing once again. I'm not
arguing that the header should be kept in include/linux/.

/ magnus
