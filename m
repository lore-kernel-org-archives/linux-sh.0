From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 May 2014 09:00:22 +0000
Subject: Re: [PATCH 00/03] pinctrl: sh-pfc: Extend Multiplatform Support
Message-Id: <CAMuHMdWVqRUbWdNMZor5gjg=8c6-OBpfO1iAjMnbXy71n=mvFQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140507231748.29661.46207.sendpatchset@w520>
In-Reply-To: <20140507231748.29661.46207.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent, Simon,

On Wed, May 14, 2014 at 5:23 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wednesday 14 May 2014 12:08:32 Simon Horman wrote:
> [snip]
>
>> I got a little ahead of myself there.
>>
>> I'm not sure how to compile (and boot) a multiplaform kernel for Armadillo.
>> Do I need some patches which aren't in the renesas devel branch?
>
> You most probably do, and I expect those patches to be in Magnus' tree :-)

Yes. You need at least Ulrich's CCF patches.
And some extras (e.g. to hook it up into multi-platform) that AFAIK have
never been posted to the list.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
