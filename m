From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 28 Apr 2011 02:46:37 +0000
Subject: Re: [PATCH] i2c: i2c-sh_mobile bus speed platform data
Message-Id: <BANLkTimSM-9XYy0UrwoWK8CGjp0qAqeF4A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20110421132254.3725.84300.sendpatchset@t400s>
	<20110427221357.GA12273@verge.net.au>
	<BANLkTi=YbtWYKLdcEkv6TDRfm-BbXGXa4w@mail.gmail.com>
	<20110428011757.GB15883@verge.net.au>
	<20110428022214.GB13539@linux-sh.org>
In-Reply-To: <20110428022214.GB13539-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>
Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org

On Thu, Apr 28, 2011 at 11:22 AM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Thu, Apr 28, 2011 at 10:18:01AM +0900, Simon Horman wrote:
>> On Thu, Apr 28, 2011 at 10:06:38AM +0900, Magnus Damm wrote:
>> > On Thu, Apr 28, 2011 at 7:14 AM, Simon Horman <horms@verge.net.au> wrote:
>> > > I believe that on the sh73a0 and so far only the sh73a0
>> > > denom needs to be doubled.
>> >
>> > Uhm, I don't think this patch is specific to any SoC type. It may of
>> > course be used on sh73a0 to adjust the denom value, but setting the
>> > I2C bus speed is something that can be used on any SoC. So I'd say
>> > that this is a fairly generic feature.
>>
>> I'm just saying that that I've observed the value being doubled for sh73a0.
>>
> The general rule of thumb is that whatever unusual behaviour is observed
> in the latest CPU we will see become the standard for future ones.

This may also be an attempt to simply double the I2C bus speed on that
particular platform for that particular application. So in the end it
may have nothing to do with sh73a0. Actually, now when I think about
it, I recall hacking up a prototype to control the LCD backlight via
I2C on sh73a0 and AG5EVM, and I did not have to modify any part of the
I2C bus driver to get that going as expected.

> Abstracting the denom value seems reasonable as a cautionary measure, and
> it does do the NORMAL_SPEED as a default fallback so there is no adverse
> impact for normalized platforms.
>
> This really should be going in to include/linux/i2c/ or so though, no
> need to dump these tiny stubs in to include/linux/ directly.

I guess I just followed what other i2c drivers do, but yes, putting
the header file in include/linux/i2c/ makes more sense.

I'll cook up a V2.

Thanks,

/ magnus
