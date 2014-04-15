From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 15 Apr 2014 09:10:50 +0000
Subject: Re: [PATCH 2/2] clk: shmobile: clk-mstp: add backwards comapt for indices field
Message-Id: <CAMuHMdUdGQrvxbhNTJ2y1D4hn5Zjfc2780varM6ua5EpdXC13g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1394196400-17112-1-git-send-email-ben.dooks@codethink.co.uk>
 <1394196400-17112-3-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1394196400-17112-3-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Ben,

On Fri, Mar 7, 2014 at 1:46 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> Add comaptibiltiy for older device trees by checking to see if

compatibility (also in the subject line).

> the clock-indices property is there and falling back to the
> older renesas,clock-indices field.
>
> This can be removed once all device-trees are converted.
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
