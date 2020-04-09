From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 09 Apr 2020 08:16:49 +0000
Subject: Re: [PATCH] Fix verbose arch/sh panic messages.
Message-Id: <CAMuHMdWUCtpP3_roXz4Mfb9pLGdhksUHzM8LbViWZZT2w1JfOg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1da19521-b70c-272c-51bb-9416ece62772@landley.net>
In-Reply-To: <1da19521-b70c-272c-51bb-9416ece62772@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Rob,

On Thu, Apr 9, 2020 at 10:03 AM Rob Landley <rob@landley.net> wrote:
> From: Rob Landley <rob@landley.net>
>
> These days printk() adds a newline, so 8 lines of memory dump becomes 80.
>
> Signed-off-by: Rob Landley <rob@landley.net>

See also "[PATCH 2/7] sh: dump_stack: Fix broken lines and ptrval in
calltrace dumps" of series "[PATCH 0/7] sh: Modernize printing of kernel
messages"
https://lore.kernel.org/lkml/20191203162645.19950-1-geert+renesas@glider.be/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
