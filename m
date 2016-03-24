From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 24 Mar 2016 08:50:16 +0000
Subject: Re: Availability of SH hardware?
Message-Id: <CANqRtoTQHahXvJ9GHcDg7gw0BGsnVqPFWvUOVKQP-p4DNCn-Tg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20160317032441.GA22517@brightrain.aerifal.cx>
In-Reply-To: <20160317032441.GA22517@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert, Rich,

On Thu, Mar 24, 2016 at 1:17 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Rich,
>
> On Wed, Mar 23, 2016 at 5:09 PM, Rich Felker <dalias@libc.org> wrote:
>> On Wed, Mar 23, 2016 at 11:11:04AM +0100, John Paul Adrian Glaubitz wrote:
>>> On 03/23/2016 11:05 AM, Magnus Damm wrote:
>>> > I have a couple of old SH boards that I can hook up to remote access
>>> > for you if that would help. Probably sh775x-based ones and maybe also
>>> > something with sh2a. Need to go through my old boxes in the attic to
>>> > find more detail. =)
>>>
>>> I think it would be much better for actual kernel development to have
>>> physical access to the hardware. And if your SH boards are gaining
>>> dust in your attic anyway, why not send them out to support the
>>> new SH kernel maintainers?
>>
>> Indeed. I appreciate the offer, but I don't think there's much that
>> can be done in the way of kernel development with only remote access,
>> at least not without a fancy setup to facilitate remote reboot and
>> reset to a known-working state. Magnus, do you mind if I contact you
>> again some point later if I find there's something where remote
>> testing would be helpful?
>
> Magnus' Development Board Farm does have remote power control facilities.

Indeed - thanks for clarifying Geert!

Of course for I/O related development physical access is most
convenient. My remote access setup allows power control, network boot
and in special cases video over VNC. It is not the best system in the
universe but probably beats nothing.

For the SH architecture it seems to me that things like DT for
interrupt controllers and CCF are the most serious blockers for modern
kernel support. Those two or at least the latter should be possible to
develop over remote access. And then you of course also have SMP. =)

I recall hearing that Dreamcast hardware was historically used for
some SH development. Can't be that difficult to find such hardware,
however I highly doubt that the boot process is very convenient.
Hardware wise Dreamcast probably contains something like sh775x so it
should be similar to whatever is in QEMU.

Thanks,

/ magnus
