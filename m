From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 30 Apr 2014 22:25:38 +0000
Subject: Re: [PATCH 2/6] i2c: sh_mobile: improve error handling
Message-Id: <CAMuHMdWs=FkAgCpBNQcaRtJRanGQjp1erN+=Jqpekioj+9pk1A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1398896470-24663-1-git-send-email-wsa@the-dreams.de>
	<1398896470-24663-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1398896470-24663-3-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>

Hi Wolfram,

On Thu, May 1, 2014 at 12:21 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> Use standard i2c error codes for i2c failures. Also, don't print
> something on timeout since it happens regularly with i2c. Simplify some,
> logic, too.

You may want to keep the timeout messages with dev_dbg()?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
