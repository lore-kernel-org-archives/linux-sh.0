From: Richard Purdie <rpurdie@openedhand.com>
Date: Sun, 03 Feb 2008 22:07:55 +0000
Subject: Re: [PATCH/LEDS] - Add support for leds on the HP Jornada 6xx
Message-Id: <1202076475.4596.33.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <20080203214615.5cff3eef.Kristoffer.ericson@gmail.com>
In-Reply-To: <20080203214615.5cff3eef.Kristoffer.ericson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-sh <linux-sh@vger.kernel.org>, linux-main <linux-kernel@vger.kernel.org>

On Sun, 2008-02-03 at 21:46 +0100, Kristoffer Ericson wrote:
> shortlog:
> The HP Jornada 6xx series have simple leds thats able to produce green or red light.
> This patch enables the leds to be used by the kernel and/or userland.
> 
> signed-off-by: Kristoffer Ericson <kristoffer.ericson@gmail.com>
> 
> Richard please note that this driver makes use of
> include/asm-sh/hd6446x.h which is a merged header not yet
> available. I've sent patch to paul but gotten no answer yet. If you
> cannot commit it for that reason, then please just look through it.

It shouldn't really go in until thats been merged. I couldn't see
anything wrong with the driver so just let me know when that header has
merged...

Cheers,

Richard



