From: Paul Mundt <paul.mundt@renesas.com>
Date: Thu, 06 Mar 2008 03:56:48 +0000
Subject: Re: Fwd: SH4 RTC periodic mode
Message-Id: <20080306035648.GB27445@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 05, 2008 at 03:48:46PM +0100, Angelo CASTELLO wrote:
> this patch adds missing features in rtc-sh driver (e.g Periodic IRQs).
> Code tested at user level using the classic example provided within
> Documentation/rtc.txt on sh4 core.
>
Looks like this was discarded from the mailing list on account of
containing an html part.

Anyways, the current version of the driver was 0.1.6, but I've taken your
patch and merged it in by hand on top of this, and subsequently bumped
the version up to 0.2.0.

This is now in the 2.6.26 queue, thanks!
