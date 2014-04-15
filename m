From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 15 Apr 2014 09:55:28 +0000
Subject: Re: [PATCH 21/28] Remove CPU_SUBTYPE_SH7764
Message-Id: <CAMuHMdXawwgr7x=TFumDUh+c+-KZteHdp+NrnXTFcFcwT6gjRQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1391971686-9517-1-git-send-email-richard@nod.at>
	<1391971686-9517-22-git-send-email-richard@nod.at>
	<1391981761.25855.58.camel@x220>
	<1397554747.1985.35.camel@x220>
In-Reply-To: <1397554747.1985.35.camel@x220>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Richard Weinberger <richard@nod.at>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Paul,

On Tue, Apr 15, 2014 at 11:39 AM, Paul Bolle <pebolle@tiscali.nl> wrote:
> On Sun, 2014-02-09 at 22:36 +0100, Paul Bolle wrote:
>> On Sun, 2014-02-09 at 19:47 +0100, Richard Weinberger wrote:
>> > The symbol is an orphan, get rid of it.
>> >
>> > Signed-off-by: Richard Weinberger <richard@nod.at>
>>
>> Paul Mundt had something similar queued a year ago:
>> https://lkml.org/lkml/2013/3/11/211 . What happened?
>
> By now the SuperH port has been orphaned. So what's the current
> procedure for small SuperH fixes like this one?

Please submit them to Andrew Morton <akpm@linux-foundation.org>.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
