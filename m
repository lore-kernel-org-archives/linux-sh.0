From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 08 Dec 2013 10:16:02 +0000
Subject: Re: [PATCH/RFC] sh: Always link in helper functions extracted from libgcc
Message-Id: <CAMuHMdVLjruEChvHjzTLuNqaR9YpDG7hQ7Ukbwrm4phmm6HfNA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1369815408-12719-1-git-send-email-geert@linux-m68k.org>
	<CABMQnV+mYYmSKK6ayeDbaiOnNSOgUhN4TjZV50eYmQwaQ3rHhQ@mail.gmail.com>
In-Reply-To: <CABMQnV+mYYmSKK6ayeDbaiOnNSOgUhN4TjZV50eYmQwaQ3rHhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Cc: Paul Mundt <lethal@linux-sh.org>, Linux-sh <linux-sh@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, stable <stable@vger.kernel.org>

Hi Iwamatsu-san,

On Thu, Dec 5, 2013 at 7:49 AM, Nobuhiro Iwamatsu
<nobuhiro.iwamatsu.yj@renesas.com> wrote:
> I was just creating a patch as your patch.... I noticed your patch by chance.
> I think your proposal is good.
>
> But Paul does not maintain the SH tree.
> Andrew, Could you pickup this patch ?

As Andrew wasn't CCed on the original submission, I forwarded the original
patch to him.

> Tested-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
