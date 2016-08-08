From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 08 Aug 2016 15:46:33 +0000
Subject: Re: Build regressions/improvements in v4.8-rc1
Message-Id: <CAMuHMdWKXTdxa451_E11zmmsW5ZzCQ=z4qMnp-ZLGSZmfGB5VQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <alpine.DEB.2.10.1608081032130.9359@ayla.of.borg>
 <CAMuHMdW_fPP5dyOtRC98gh1kG-zuW_KxV7vAME_7b8Z-U10N_g@mail.gmail.com> <20160808143139.GW15995@brightrain.aerifal.cx>
In-Reply-To: <20160808143139.GW15995@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Rich,

On Mon, Aug 8, 2016 at 4:31 PM, Rich Felker <dalias@libc.org> wrote:
> On Mon, Aug 08, 2016 at 10:38:07AM +0200, Geert Uytterhoeven wrote:
>> On Mon, Aug 8, 2016 at 10:32 AM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>> >   + error: No rule to make target arch/sh/boot/dts/.dtb.o:  => N/A
>>
>> sh-allyesconfig, sh-allmodconfig
>
> I saw this. Is there any canonical way I should fix this? The problem
> is that there's no default for the DTS name, but I'm not sure there
> should be a default. Getting a hard-coded DTB for a particular board
> when you do allyesconfig seems like a worse UX than getting a build
> failure.

Do you have a way to pass a DTB from the bootloader, like most other
architectures support?
If yes, can't you remove the dependency on a builtin DTB?
Allowing to build allmodconfig/allyesconfig helps a lot for build coverage.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
