From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 08 Mar 2015 10:15:47 +0000
Subject: Re: [PATCH 09/11] serial: sh-sci: Add device tree bindings for r8a7793
Message-Id: <CAMuHMdW6c2Zh-4c+3gPN7TV+MKTbpFkTUAvcww8Jz==2rYkPWw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1425661798-10487-10-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1425661798-10487-10-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Mar 7, 2015 at 1:07 AM, Simon Horman <horms@verge.net.au> wrote:
>> --- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
>> +++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
>> @@ -19,6 +19,10 @@ Required properties:
>>      - "renesas,scifa-r8a7791" for R8A7791 (R-Car M2) SCIFA compatible UART.
>>      - "renesas,scifb-r8a7791" for R8A7791 (R-Car M2) SCIFB compatible UART.
>>      - "renesas,hscif-r8a7791" for R8A7791 (R-Car M2) HSCIF compatible UART.
>
> Not appropriate for this patch, but
> I wonder if M2 should be updated to M2W throughout
> Documentation/devicetree/bindings/

For e.g. rspi I did it in the patch that introduced "M2-N" support
(cfr. commit 6089af775a4b4ea5 ("spi: rspi: Add support for new R-Car Gen2
SoCs").

No preference, may depend on your love for statistics
(http://www.remword.com/kps_result/ ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
