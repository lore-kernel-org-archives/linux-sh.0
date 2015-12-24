From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date: Thu, 24 Dec 2015 05:54:42 +0000
Subject: Re: [PATCH 0/2] i2c: proper RuntimePM for the adapter device
Message-Id: <CAKfKVtHt8BpakkffRp=_2GUxqK5JO0WCsizCrjtwH5hv+TWvWg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450891169-13708-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1450891169-13708-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-pm@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

On Wed, Dec 23, 2015 at 10:49 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> RuntimePM for the logical adapter device should be handled in a central place
> by the core, and not by drivers. This series does exactly that.

This is good idea.

>
> This is the first step of harmonizing RuntimePM handling in I2C.
>

Also maybe we can add a flag that the driver enables.
that way for a short period till the driver removes the call
the double call is not there.

not an objection to the patch though
>
> Wolfram Sang (2):
>   i2c: always enable RuntimePM for the adapter device
>   i2c: s3c2410: remove superfluous runtime PM calls
>
>  drivers/i2c/busses/i2c-s3c2410.c | 6 ------
>  drivers/i2c/i2c-core.c           | 3 +++
>  2 files changed, 3 insertions(+), 6 deletions(-)
>
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
