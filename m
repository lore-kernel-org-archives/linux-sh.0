From: Matt Fleming <matt@console-pimps.org>
Date: Sat, 20 Feb 2010 00:08:56 +0000
Subject: Re: Unaligned kernel access for __udivsi3_i4i
Message-Id: <20100220000856.GA9774@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
References: <5ec3d7931002191551g21c0cda9le17729529b1afd78@mail.gmail.com>
In-Reply-To: <5ec3d7931002191551g21c0cda9le17729529b1afd78@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Feb 20, 2010 at 12:51:38AM +0100, Drasko DRASKOVIC wrote:
> Hi all,
> I am getting Unaligned kernel access on 0x809b7662

Hi Drasko,

I suspect that the reason that you're seeing these unaligned accesses is
because you are dividing by zero. That's what happens when you divide by
zero when using the libgcc softfpu divide functions; an unaligned access
is intentionally generated because SH has no other way of signalling
that an error occurred while doing the division.

To quote from gcc/config/sh/lib1func.asm in the GCC source,

"/* Lookup table translating positive divisor to index into table of
   normalized inverse.  N.B. the '0' entry is also the last entry of the
 previous table, and causes an unaligned access for division by zero.  */"
