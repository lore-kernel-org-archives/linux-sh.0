From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 22 Dec 2015 13:23:00 +0000
Subject: Re: [PATCH 3/5] pinctrl: sh-pfc: add missing of_node_put
Message-Id: <CAMuHMdVRFgKNbJMGoE-aLTbQFgpn6m2HqqE7mOyPZ4L6A3QXGg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450715988-4770-1-git-send-email-Julia.Lawall@lip6.fr>
	<1450715988-4770-4-git-send-email-Julia.Lawall@lip6.fr>
	<CACRpkdbmG8h31EFJMHFC2nx3vp4_G2ZR-wvOmioF5eh5YmVn7w@mail.gmail.com>
In-Reply-To: <CACRpkdbmG8h31EFJMHFC2nx3vp4_G2ZR-wvOmioF5eh5YmVn7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, Geert Uytterhoeven <geert+renesas@glider.be>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Linus,

On Tue, Dec 22, 2015 at 1:47 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Dec 21, 2015 at 5:39 PM, Julia Lawall <Julia.Lawall@lip6.fr> wrote:
>> for_each_child_of_node performs an of_node_get on each iteration, so a
>> goto out of the loop requires an of_node_put.
>>
>> A simplified version of the semantic patch that fixes this problem is as
>> follows (http://coccinelle.lip6.fr):
>
> Patch applied with Laurent's ACK.
>
> Geert: since I don't think you're gonna send me more pull
> requests before the merge window I went ahead and applied
> this directly, OK?

You're reading my mind ;-)

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
