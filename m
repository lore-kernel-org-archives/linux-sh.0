From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 25 Mar 2015 04:54:31 +0000
Subject: Re: Can't mount QSPI-FLASH to userland on Lager
Message-Id: <CAMuHMdV0vTSDvS7sbncEUpVZOrPeH2Zo7dHkAuLa21zt1_CEEA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <550F6E10.8010907@jinso.co.jp>
In-Reply-To: <550F6E10.8010907@jinso.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Hiep-san,

On Wed, Mar 25, 2015 at 1:55 AM, Cao Minh Hiep <cm-hiep@jinso.co.jp> wrote:
> I attached the kernel bootlogs files of Koelsch and Lager.

Thanks!

Looking at the logs, the Lager seems to use systemd, the Koelsch doesn't?
Could this be the reason?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
