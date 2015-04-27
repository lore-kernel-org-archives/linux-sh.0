From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 27 Apr 2015 13:53:01 +0000
Subject: Re: [PATCH 10/10] ARM: shmobile: marzen dts: Use generic names for device nodes
Message-Id: <CAMuHMdWOWmE9CwqEdcW_zm34P6+SifV0j9_KyBsXKT3kJsyg1w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1430139334-15272-1-git-send-email-geert+renesas@glider.be>
 <1430139334-15272-11-git-send-email-geert+renesas@glider.be>
 <553E3455.9070003@cogentembedded.com>
In-Reply-To: <553E3455.9070003@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Apr 27, 2015 at 3:06 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>> -       lan0_pins: lan0 {
>> +       ethernet_pins: ethernet {
>
>
>    Why change the label?

If there's only one instance, we usually name the pins like the device node.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
