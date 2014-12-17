From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 17 Dec 2014 08:54:49 +0000
Subject: Re: [PATCH v7 0/6] sh73a0 common clock framework implementation
Message-Id: <CAMuHMdV5maLNa-WC7VSTp+3AKLK+H0gkaM0RycB_pyE3gFJ0Gw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418222727-19888-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1418222727-19888-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Wed, Dec 17, 2014 at 9:40 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Wed, Dec 17, 2014 at 5:01 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Wed, Dec 17, 2014 at 8:54 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>> This series looks like it has been receiving both plenty of review and
>>> testing. What's your plan regarding merge?
>>
>> I plan to collect all clk-related patches in a branch, and ask Mike to pull it
>> (after New year).
>>
>> Is that OK?
>
> That's fine with me - I guess that includes the DIV6 bits too. I saw
> some pull request related to clocks from you earlier, but that got
> dropped I suppose?

The DIV6 bits have been pulled by Mike, and are in clk/clk-next, but I have
the impression Mike hasn't sent a pull request for 3.19 to Linus yet?

New stuff will be in 3.20.

> How do we handle integration patches in the mean time? I saw that you
> had hundreds of patches in your queue, but for me it is enough with
> just a couple of series to stack up to go nuts when I'm attempting to
> add sh73a0 multiplatform. =)

I am going nuts with all those patches ;-)

Now, we cannot integrate multiplatform support for sh73a0/r8a73a4 without
a (stable) branch with CCF first.

>> Note that there were still some comments on [PATCH 1/6].
>
> Sure, but perhaps those can be handled incrementally?

OK.

>> And I have to repost a new version of the renesas,bsc series first, as we
>> need to for working Ethernet with CCF on kzm9g.
>
> That's a good idea.

And also on ape6evm, if I'm not mistaken.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
