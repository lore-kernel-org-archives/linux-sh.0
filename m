From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 21 Dec 2014 09:04:07 +0000
Subject: Re: [PATCH v7 0/6] sh73a0 common clock framework implementation
Message-Id: <CAMuHMdWNEiCaN0R3W=+HAA-8Jy+JnSjpQfNa1p1=wyzu_qSa0w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418222727-19888-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1418222727-19888-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Dec 17, 2014 at 9:54 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Wed, Dec 17, 2014 at 9:40 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> On Wed, Dec 17, 2014 at 5:01 PM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>>> On Wed, Dec 17, 2014 at 8:54 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>>> This series looks like it has been receiving both plenty of review and
>>>> testing. What's your plan regarding merge?
>>>
>>> I plan to collect all clk-related patches in a branch, and ask Mike to pull it
>>> (after New year).
>>>
>>> Is that OK?
>>
>> That's fine with me - I guess that includes the DIV6 bits too. I saw
>> some pull request related to clocks from you earlier, but that got
>> dropped I suppose?
>
> The DIV6 bits have been pulled by Mike, and are in clk/clk-next, but I have
> the impression Mike hasn't sent a pull request for 3.19 to Linus yet?

JFYI, it's now in v3.19-rc1.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
