From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 16 Jul 2012 19:27:12 +0000
Subject: Re: [PATCH] MIPS: fix bug.h MIPS build regression
Message-Id: <CAMuHMdXSGgH+M_2+xuzY2t_sGZto24=atv3Kaj+R-dWAUPzW7w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1339962373-3224-1-git-send-email-geert@linux-m68k.org>
        <CAMuHMdVfLjgrtWoPpvbLf12+=ApE6W9dNcweqD-_2Benr-D7NQ@mail.gmail.com>
        <20120620152759.2caceb8c.yuasa@linux-mips.org>
        <20120620161249.GB29196@linux-mips.org>
        <4FE4B13E.10709@caviumnetworks.com>
In-Reply-To: <4FE4B13E.10709@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Daney <ddaney@caviumnetworks.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Yoichi Yuasa <yuasa@linux-mips.org>, Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org, Linuxppc-dev <linuxppc-dev@ozlabs.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, Linux-sh list <linux-sh@vger.kernel.org>, Chris Zankel <chris@zankel.net>

On Fri, Jun 22, 2012 at 7:54 PM, David Daney <ddaney@caviumnetworks.com> wrote:
> On 06/20/2012 09:12 AM, Ralf Baechle wrote:
>>
>> On Wed, Jun 20, 2012 at 03:27:59PM +0900, Yoichi Yuasa wrote:
>>
>>> Commit: 3777808873b0c49c5cf27e44c948dfb02675d578 breaks all MIPS builds.
>>
>>
>> Thanks, fix applied.
>>
>
> Where was it applied?
>
> It doesn't show up in linux-next for 20120622, which is where it is needed.

It's also desperately needed in mainline for 3.5.

Ralf?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
