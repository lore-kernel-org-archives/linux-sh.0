From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 10 Dec 2015 17:11:52 +0000
Subject: Re: [PATCH] gpio: rcar: Improve clock error handling and reporting
Message-Id: <CACRpkdaeuQ7d804Es5pkm5QH3bMn=ykG5pXeHyrOHRMmcvAuwQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1448377528-19307-1-git-send-email-geert+renesas@glider.be>
	<CACRpkdabE9=UsGsRqzVZg3P09ntLTMz1NE3ginQ_XdFiddh4bw@mail.gmail.com>
	<CAMuHMdUJYF_DQ_zaS-+nEcam-tuwPCjeowvr-iQyqJdz=825Zg@mail.gmail.com>
In-Reply-To: <CAMuHMdUJYF_DQ_zaS-+nEcam-tuwPCjeowvr-iQyqJdz=825Zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Alexandre Courbot <gnurou@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Tue, Dec 1, 2015 at 11:09 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Tue, Dec 1, 2015 at 10:54 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Tue, Nov 24, 2015 at 4:05 PM, Geert Uytterhoeven
>> <geert+renesas@glider.be> wrote:

>>> The new flag is merged with the existing has_both_edge_trigger boolean
>>> into a bitfield to save space.
>>
>> *DON'T* try to save bits in a megabyte kernel like this.
>> The better readability is worth the extra bits or bytes it takes.
>> Besides, did you really try to compile it before/after that change
>> to verify that it actually saved that space?
>
> Is it better readable?

OK sorry for being such an ass, I'm a bit stressed out.

> Size also depends on how many more flags we'll add later.

Yeah. But I really like the bools, I think the static checkers can also
make better use of them, but that's just me.

>> Where is that patch? This does not apply to my tree,
>> probably because of this.
>
> IIRC, you said "include it in your pull request" for that series.

OK so this needs to go in with the pin control stuff? Then it's cool...

>> Please sent the patches in a series.
>
> I can send both to you, as they're not pinctrl but gpio.
>
>>>         unsigned has_both_edge_trigger:1;
>>> +       unsigned needs_clk:1;
>>
>> both should be bool and assigned true/false.
>
> OK, if you prefer it that way.

Thanks!

Yours,
Linus Walleij
