From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Aug 2015 09:26:41 +0000
Subject: Re: [PATCH] SH: use PFN_DOWN macro
Message-Id: <CAMuHMdV6OPg23AKEU=YaaW5OVMOR9-mVagdZgdO2UeBi85Jb5A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1439144891-8141-1-git-send-email-kuleshovmail@gmail.com>
In-Reply-To: <1439144891-8141-1-git-send-email-kuleshovmail@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Kuleshov <kuleshovmail@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Dan Carpenter <dan.carpenter@oracle.com>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sun, Aug 9, 2015 at 8:28 PM, Alexander Kuleshov
<kuleshovmail@gmail.com> wrote:
> Replace ((x) >> PAGE_SHIFT) with the predefined PFN_DOWN macro.
>
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
