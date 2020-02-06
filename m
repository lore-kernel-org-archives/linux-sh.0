From: Rob Landley <rob@landley.net>
Date: Thu, 06 Feb 2020 18:08:31 +0000
Subject: Re: No newer system calls for SuperH64?
Message-Id: <8944a60f-26a9-5880-6498-a782d16074db@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <939c9260-213f-cfd7-f81a-e9b635a6aa10@juszkiewicz.com.pl>
In-Reply-To: <939c9260-213f-cfd7-f81a-e9b635a6aa10@juszkiewicz.com.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 2/4/20 8:23 AM, Rich Felker wrote:
>> Note: I do not own nor plan to own SuperH64 hardware. I do not even
>> remember where it was used. Just noticed weird state of it.
> 
> One reason you don't own it is that it essentially doesn't exist. :-)
> GCC dropped SH64 support a few years ago because the arch essentially
> never materialized and keeping it around was a lot of cruft. It should
> be removed from the kernel too; I just haven't gotten around to
> figuring out how to do that.

To elaborate: sh1-sh4 were developed by Hitachi in 1990's, and it was the best
selling chip line in the world for about 3 years. But after the 1997 asian
economic crisis Hitachi cut funding to its chip business (as in they didn't even
bother to pay for die shrinks to move existing designs to a new fab process at
higher clock speeds), and a few years later they spun their chip business off as
a new company "Renesas" (in partnership with NEC I think).

Renesas inherited the old designs but did _not_ get most of the design engineers
who'd made them, so they hired new guys and had them try to produce a new 64 bit
superh chip (sh5), and in doing so they made the same mistake Intel made with
the Itanium. They bolted a whole second processor on to the side of superh with
a completely different instruction set, instead of the x86-64 approach of making
a mode bit that changes register size with otherwise mostly the same circuitry
implementing mostly the same instructions for 32 bit and 64 bit modes.

The resulting sh5 design was completely uninteresting, nobody who bought the few
prototype systems they made wound up liking it, and Renesas abandoned sh5
instead of going into mass production.

Rob

P.S. The j-core guys have talked about a x86-64 mode bit style approach for
extending their superh clone into "j64". They haven't shipped that yet either,
but it's at least further confirmation that sh5 isn't coming back.
