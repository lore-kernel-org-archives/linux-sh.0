From: Richard Purdie <rpurdie@openedhand.com>
Date: Thu, 07 Feb 2008 10:15:31 +0000
Subject: Re: [PATCH/HP6XX] - Add leds support to the HP Jornada 6xx handheld
Message-Id: <1202379331.9519.14.camel@dax.rpnet.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080205191356.ae2e8948.Kristoffer.ericson@gmail.com>
In-Reply-To: <20080205191356.ae2e8948.Kristoffer.ericson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: linux-main <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>

On Tue, 2008-02-05 at 19:13 +0100, Kristoffer Ericson wrote:
> Richard, I've been told from paul that I should seek another solution
> for my hd6446x.h merger (perhaps mfd driver). So this patch
> is against linux-2.6.git with the header and defines changed back to
> old style. Tested to compile. I tested the "old" patch and that worked
> and I've only changed 5-6 names so it really should work as before.

I've added this to the LED tree with a couple of tweaks to the Kconfig
entry.

Cheers,

Richard

