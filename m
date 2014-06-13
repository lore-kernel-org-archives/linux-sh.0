From: Tom Herbert <therbert@google.com>
Date: Fri, 13 Jun 2014 00:59:03 +0000
Subject: Re: [-next] Regression: ssh log in slowdown
Message-Id: <CA+mtBx9BSe2M7-ALT9AL1J0qPXzJP2LcFG5dCJ3DASnh6-p9gA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdU6rrpx6xFw71HKexDJUZtfFtL+um6dxZ=EaycgVO312A@mail.gmail.com>
In-Reply-To: <CAMuHMdU6rrpx6xFw71HKexDJUZtfFtL+um6dxZ=EaycgVO312A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "David S. Miller" <davem@davemloft.net>, Linux-Next <linux-next@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

>     net: Save software checksum complete
>
>     In skb_checksum complete, if we need to compute the checksum for the
>     packet (via skb_checksum) save the result as CHECKSUM_COMPLETE.
>     Subsequent checksum verification can use this.
>
>     Also, added csum_complete_sw flag to distinguish between software and
>     hardware generated checksum complete, we should always be able to trust
>     the software computation.
>
>     Signed-off-by: Tom Herbert <therbert@google.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
>
> Reverting this commit fixes the issue.
>
> Anyone with a clue?
>
Hi Geert,

I'm very sorry that I seemed to have missed your initial bug report,
thanks for bisecting the problem. I have posted a fix for this, please
verify it if you can

Thanks,
Tom

> Thanks!
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
