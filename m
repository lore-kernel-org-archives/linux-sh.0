From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 06 Sep 2018 11:05:58 +0000
Subject: Re: [PATCH 1/2] clocksource: sh_cmt: properly line-wrap sh_cmt_of_table[] initializer
Message-Id: <CAMuHMdVUsWGfXWN9FEUjMZhCicJidrBJ4vcba5giAmAQkGd66Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <3ce24bfe-1edb-1a92-8847-ff998ac86d16@cogentembedded.com> <bccdf54a-70ba-ea8e-275f-9382dab5f1d4@cogentembedded.com>
In-Reply-To: <bccdf54a-70ba-ea8e-275f-9382dab5f1d4@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Wed, Sep 5, 2018 at 10:31 PM Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> There's no good reason for the sh_cmt_of_table[] initializer to
> violate the 80-column limit, especially after the commit 8d50e9476bb4
> ("clocksource/drivers/sh_cmt: Mark "renesas,cmt-48-gen2" deprecated")
> partially fixed it -- fix the R-Car gen2 related entries as well.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
