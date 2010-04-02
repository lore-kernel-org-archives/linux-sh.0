From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 02 Apr 2010 07:26:05 +0000
Subject: Re: Setting 31250 bps in ttySCx
Message-Id: <20100402072605.GA14056@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 31, 2010 at 06:35:12PM +0200, Fabio Giovagnini wrote:
> Hi All,
> I'd like to set B31250 to have 31250 bps on ttySC1.
> Do I have to define B31250 in  asm/sh/termio.h and add in serial_core the 
> couple
> 31250,B31250?
> Or do I need to add more over infos in other files?
> 
No. If you want to use a custom baud rate that the internal baud rate
generator can deal with, then we can look at expanding the serial driver
to handle that via a custom speed setting, but that crap absolutely does
not belong in the common definitions which are only concerned with
standard rates.

This shouldn't be that much work, we can also support higher speeds today
that we don't presently wire up, so it should be possible to support both
fairly easily. I'll look in to adding this when I have some spare cycles.
