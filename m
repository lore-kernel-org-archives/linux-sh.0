From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 20 Jun 2015 14:38:11 +0000
Subject: Re: [PATCH 2/3] rcar_can: print signed IRQ #
Message-Id: <55857AD3.4040000@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <2010452.WyFito6egU@wasted.cogentembedded.com>	<2390389.thI8mIvbv5@wasted.cogentembedded.com> <CAMuHMdWZFKR04NJc7xtnPUosYuosX9FPDJopG3wovu_GqGxSOw@mail.gmail.com>
In-Reply-To: <CAMuHMdWZFKR04NJc7xtnPUosYuosX9FPDJopG3wovu_GqGxSOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, wg@grandegger.com, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>

Hello.

On 6/20/2015 3:03 PM, Geert Uytterhoeven wrote:

>> Printing IRQ # using "%x" and "%u" unsigned formats isn't quite correct as
>> 'ndev->irq' is of  type *int*, so  the "%d" format  needs to be used instead.

>> While fixing this, beautify the dev_info() message in rcar_can_probe() a bit.

> If you change the message, why don't you make it consistent
> ("interrupt" vs. "IRQ")?

    I decided to change the message in a follow-up patch (posted afterwards).

>> Fixes: fd1159318e55 ("can: add Renesas R-Car CAN driver")
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

[...]

> Gr{oetje,eeting}s,
>                          Geert

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
