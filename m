From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 19 Apr 2012 10:36:25 +0000
Subject: Re: [PATCH 3/6] spi: spi-sh-msiof: do not manage PM clocks manually
Message-Id: <CANqRtoQryHcd=nCCxRJuxg7D6dkBahnUnK4PSH0uq9ff2Ggq=A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1204181324590.30514@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1204181324590.30514@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Guennadi,

On Thu, Apr 19, 2012 at 6:59 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Hi Magnus
>
> On Thu, 19 Apr 2012, Magnus Damm wrote:
>
>> On Wed, Apr 18, 2012 at 8:28 PM, Guennadi Liakhovetski
>> <g.liakhovetski@gmx.de> wrote:
>> > On sh-mobile platforms the bus clock frequency for the MSIOF unit is
>> > obtained from the same clock, as the one, that runtime power-manages the
>> > controller. The MSIOF driver has to access that clock directly,
>> > bypassing the runtime PM framework, to get its frequency, but it
>> > shouldn't enable or disable it.
>> >
>> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>>
>> Usually I don't say this, but here's a NAK!
>
> You definitely should say this in such cases - especially when the whole
> series is marked as "RFC" exactly for this reason - because I wasn't sure
> whether my problem-interpretation and solutions were right. So, now we
> came to a conclusion, that we do want clocks to be managed from the two
> APIs - runtime PM and clkdev, however ugly that seems to me:-) ATM there
> just doesn't seem to be a better solution available. And we have to fix
> MMCIF and SDHI to also correctly do the same: hold a clock reference for
> as long as a stable clock frequency is required, and re-read the frequency
> every time the clock is switched on.

Yes, please fix these issues in the MMCIF and SDHI drivers. I wasn't
aware that those issues existed, I assumed that our transaction based
Runtime Pm and clock control was complete as-is.

> One more doubt though: in principle just doing pm_runtime_get_sync() (on
> sh-mobile) also guarantees, that the clock frequency will be stable from
> that point on, because internally it does clk_get() too? We just want
> explicit calls for generic cases, where the bus clock is not managed by
> the runtime PM?

There is nothing stopping anyone from supplying different clocks to
Runtime PM and the clock framework when setting up the platform
device. I don't think the driver should make assumptions that they are
the same. The clock that we use to get the frequency from should also
be enabled during it's use to make sure it stays fixed. Anything else
is begging for trouble from my point of view.

Thanks,

/ magnus
