From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 08 Mar 2015 10:13:48 +0000
Subject: Re: [PATCH 09/11] serial: sh-sci: Add device tree bindings for r8a7793
Message-Id: <CAMuHMdW0JWBEaD6vbkmuU-p3_ZZ8JQSCq+jWqviKazMsAQx29Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1425661798-10487-10-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1425661798-10487-10-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 6, 2015 at 6:09 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> --- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> +++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> @@ -19,6 +19,10 @@ Required properties:
>      - "renesas,scifa-r8a7791" for R8A7791 (R-Car M2) SCIFA compatible UART.
>      - "renesas,scifb-r8a7791" for R8A7791 (R-Car M2) SCIFB compatible UART.
>      - "renesas,hscif-r8a7791" for R8A7791 (R-Car M2) HSCIF compatible UART.

Please rename the "M2" entries to "M2-W".

> +    - "renesas,scif-r8a7793" for R8A7793 (R-Car M2N) SCIF compatible UART.
> +    - "renesas,scifa-r8a7793" for R8A7793 (R-Car M2N) SCIFA compatible UART.
> +    - "renesas,scifb-r8a7793" for R8A7793 (R-Car M2N) SCIFB compatible UART.
> +    - "renesas,hscif-r8a7793" for R8A7793 (R-Car M2N) HSCIF compatible UART.

"M2-N"

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
