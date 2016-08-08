From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 08 Aug 2016 20:06:27 +0000
Subject: Re: Build regressions/improvements in v4.8-rc1
Message-Id: <CAMuHMdX+=Qof7za_KYXpNhUgAQDvkLDXri3j=M7dp7bgeww-QQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <alpine.DEB.2.10.1608081032130.9359@ayla.of.borg>
 <CAMuHMdW_fPP5dyOtRC98gh1kG-zuW_KxV7vAME_7b8Z-U10N_g@mail.gmail.com>
 <20160808143139.GW15995@brightrain.aerifal.cx> <CAMuHMdWKXTdxa451_E11zmmsW5ZzCQ=z4qMnp-ZLGSZmfGB5VQ@mail.gmail.com>
 <20160808162204.GX15995@brightrain.aerifal.cx> <87shufi47l.fsf@linux-m68k.org>
In-Reply-To: <87shufi47l.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Rich Felker <dalias@libc.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>

On Mon, Aug 8, 2016 at 7:02 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> On Mo, Aug 08 2016, Rich Felker <dalias@libc.org> wrote:
>
>> Users should leave builtin-DTB off, but allyesconfig turns it on.
>
> Perhaps you could inverse the meaning of the config so that y means
> builtin-DTB off?

That's one option,

The other one is to ignore it if CONFIG_BUILTIN_DTB_SOURCE is an
empty string. A bit similar to CONFIG_CMDLINE on ARM.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
