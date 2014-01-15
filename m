From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 15 Jan 2014 08:46:14 +0000
Subject: Re: [PATCH 0/9] Renesas RSPI/QSPI DT support
Message-Id: <CAMuHMdXLD3RmU72nj1gGXJu26Ten+hbdSVb7MXkWJRfwYYontA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1389525222-3482-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdWmFa-XsderYDp4jMw6r7fnwpm5XgQGfz8gEbCryXEkHg@mail.gmail.com>
 <20140114005312.GF18217@verge.net.au>
 <CAMuHMdWMZE23JkEr7Weq6MWgPK5w-Gy_kus5HxvcLBdgPn5Daw@mail.gmail.com>
 <20140114234951.GA8769@verge.net.au>
In-Reply-To: <20140114234951.GA8769@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon,

On Wed, Jan 15, 2014 at 12:49 AM, Simon Horman <horms@verge.net.au> wrote:
>> >> >     [6/9][V3] ARM: shmobile: r7s72100 dtsi: Add RSPI nodes
>> >> >     [7/9][V3] ARM: shmobile: genmai reference: Add RSPI nodes
>> >> >     [8/9] ARM: shmobile: r8a7791 dtsi: Add QSPI node
>> >> >     [9/9] ARM: shmobile: koelsch: Add QSPI nodes

> run-time dependencies of 6-9/9 ?

None, these are just DT nodes. It may print warnings due to unknown
pinctrl groups and functions, but that's it.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
