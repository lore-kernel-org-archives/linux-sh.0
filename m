From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 17 Dec 2014 08:01:10 +0000
Subject: Re: [PATCH v7 0/6] sh73a0 common clock framework implementation
Message-Id: <CAMuHMdXrBJ=Xu4AZ7YoywGZpmsAVUa0ETpNjLvaFSivOhTAf8A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418222727-19888-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1418222727-19888-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Wed, Dec 17, 2014 at 8:54 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> This series looks like it has been receiving both plenty of review and
> testing. What's your plan regarding merge?

I plan to collect all clk-related patches in a branch, and ask Mike to pull it
(after New year).

Is that OK?

Note that there were still some comments on [PATCH 1/6].

And I have to repost a new version of the renesas,bsc series first, as we
need to for working Ethernet with CCF on kzm9g.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
