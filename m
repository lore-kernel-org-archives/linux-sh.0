From: Simon Horman <horms@verge.net.au>
Date: Thu, 20 Jan 2011 07:07:40 +0000
Subject: Re: SDHC Read Performance
Message-Id: <20110120070738.GA32495@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20110119000909.GA9412@verge.net.au>
 <AANLkTinNtL0v2cnhz7Ci+a8TqQTcQXBMVW5EkX8qujy+@mail.gmail.com>
 <20110119080542.GE1960@verge.net.au>
 <20110120033020.GA32120@verge.net.au>
 <AANLkTi=fw1C0cj9U9=c0PxvOPHZtM66pDc+zpR9p=68c@mail.gmail.com>
In-Reply-To: <AANLkTi=fw1C0cj9U9=c0PxvOPHZtM66pDc+zpR9p=68c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Arnd Hannemann <arnd@arndnet.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Thu, Jan 20, 2011 at 01:01:04PM +0900, Magnus Damm wrote:
> 1) Can you try a different SDHC Class 10 card? I'd just simply buy a
> top-of-the-line SanDisk card myself and try that, but anything
> different from what you're having is probably useful as a contrast.

Sure, will do.

> 2) How about the MMC4.0 down-clocking. Is there anything we can do
> about that software-wise?

As I understand it, the problem is that the SDHI allows a simple
divisor to applied to a clock source. Effectively this means
that the driver may use use 12Mhz, 24Mhz and 50Mhz.

In the case of MMC the desired speed is 20Mhz, but the highest
value from the list above that the driver can use is 12Mhz.

As we discussed (offline) yesterday, it ought to be possible
to change the frequency of the clock source. And in the case of
the mackerel this can probably be done without disturbing anything
else as there are per SHDI clock sources.

I imagine it would be possible to manipulate the frequency
such that MMC can be run closer to 20Mhz than 12Mhz.

However, I am unsure if this would improve performance in any way.

