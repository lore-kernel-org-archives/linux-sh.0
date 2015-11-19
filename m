From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 19 Nov 2015 20:49:05 +0000
Subject: Re: [PATCH 08/25] serial: sh-sci: Make unsigned values in sci_baud_calc_hscif() unsigned
Message-Id: <CAMuHMdWDd-2gRhkBPeKw3EKG7JFbdG2EDk0bj3gf=iiH04V32g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1447958344-836-1-git-send-email-geert+renesas@glider.be>
	<1447958344-836-9-git-send-email-geert+renesas@glider.be>
	<1636784.2d3bsCa4Hn@avalon>
In-Reply-To: <1636784.2d3bsCa4Hn@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Nov 19, 2015 at 9:36 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> --- a/drivers/tty/serial/sh-sci.c
>> +++ b/drivers/tty/serial/sh-sci.c

>> @@ -1880,9 +1881,9 @@ static void sci_baud_calc_hscif(unsigned int bps,
>> unsigned long freq, int *brr, for (c = 0; c <= 3; c++) {
>>                       /* integerized formulas from HSCIF documentation */
>>                       br = DIV_ROUND_CLOSEST(freq, (sr *
>> -                                           (1 << (2 * c + 1)) * bps)) - 1;
>> -                     br = clamp(br, 0, 255);
>> -                     err = DIV_ROUND_CLOSEST(freq, ((br + 1) * bps * sr *
>> +                                           (1 << (2 * c + 1)) * bps));
>> +                     br = clamp(br, 1U, 256U);
>> +                     err = DIV_ROUND_CLOSEST(freq, (br * bps * sr *
>>                                              (1 << (2 * c + 1)) / 1000)) -
>>                                              1000;
>
> While you're at it you can remove the parentheses around the second argument
> to DIV_ROUND_CLOSEST, they're not needed.

The factor between parentheses is removed in the next patch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
