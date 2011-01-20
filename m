From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 20 Jan 2011 08:55:55 +0000
Subject: Re: SDHC Read Performance
Message-Id: <AANLkTin0gELFYS2qCcB_FyGkAdwMQ_-LosDg2PKprqpp@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20110119000909.GA9412@verge.net.au>
	<AANLkTinNtL0v2cnhz7Ci+a8TqQTcQXBMVW5EkX8qujy+@mail.gmail.com>
	<20110119080542.GE1960@verge.net.au>
	<20110120033020.GA32120@verge.net.au>
	<AANLkTi=fw1C0cj9U9=c0PxvOPHZtM66pDc+zpR9p=68c@mail.gmail.com>
	<20110120070738.GA32495@verge.net.au>
	<AANLkTi=159EcbXdahL+jzeuA5O7dBp=9b6N6y9BY466P@mail.gmail.com>
	<20110120083801.GB13114@linux-sh.org>
In-Reply-To: <20110120083801.GB13114@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: Simon Horman <horms@verge.net.au>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Arnd Hannemann <arnd@arndnet.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Thu, Jan 20, 2011 at 5:38 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Thu, Jan 20, 2011 at 05:28:55PM +0900, Magnus Damm wrote:
>> On Thu, Jan 20, 2011 at 4:07 PM, Simon Horman <horms@verge.net.au> wrote:
>> > I imagine it would be possible to manipulate the frequency
>> > such that MMC can be run closer to 20Mhz than 12Mhz.
>> >
>> > However, I am unsure if this would improve performance in any way.
>>
>> It most likely would. Perhaps it's worth adjusting the shared clock a
>> bit to support 20MHz?
>>
> "Most likely" isn't a constructive performance metric. It's worth trying
> out, and if it helps then of course it makes sense to try and support.
> It's not really worth going through and adding in additional complexity
> in order to support every possible frequency just becase we can, however.

Yes. Thanks for the "constructive performance metric". =)
