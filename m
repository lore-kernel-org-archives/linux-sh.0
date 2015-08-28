From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 28 Aug 2015 08:29:59 +0000
Subject: Re: [PATCH/RFC 10/10] Local: Hack: arm64: dts: r8a7795: add ravb phy max-speed 100 for Salvator-X bo
Message-Id: <CANqRtoR1=4HtOb5xdzmhAsWmFHk1SRdXknrrsYo9q+knMGT85Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-11-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-11-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Fri, Aug 28, 2015 at 2:23 PM, Simon Horman <horms@verge.net.au> wrote:
> On Fri, Aug 28, 2015 at 09:46:16AM +0900, Magnus Damm wrote:
>> Hi Geert,
>>
>> On Thu, Aug 27, 2015 at 8:59 PM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>> > On Thu, Aug 27, 2015 at 1:57 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> >> On Thu, Aug 27, 2015 at 06:24:10PM +0900, Simon Horman wrote:
>> >>> From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
>> >>>
>> >>> This is a work-around for limitations in the driver implementation.
>> >>
>> >> I know this is marked "local: hack:", still: If this is a driver
>> >> limitation, shouldn't it rather be in the dtsi then?
>> >
>> > You mean, in the driver?
>>
>> I also think it would make sense to have this kind of short term hack
>> in the _driver_ and not in the DTS.
>
> I agree having it in DTS is not nice.
> Which driver would you see it fitting into?

Based on the commit message it must be "in the driver implementation". =)

Cheers,

/ magnus
