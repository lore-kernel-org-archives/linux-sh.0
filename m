From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 Apr 2014 07:26:46 +0000
Subject: Re: [PATCH 22/33] ARM: shmobile: Use r8a7740 suffix for i2c, mmcif, fsi2 compat strings
Message-Id: <CAMuHMdUBf4ATws9+P6EOvjG2V8povMMWL6xOQeFESC9Wm5xz8g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1398216022.git.horms+renesas@verge.net.au>
 <5c53f50c50badff499568a703467c3c9f23f9bfd.1398216022.git.horms+renesas@verge.net.au>
 <CAMuHMdUA+wJmgn0P_q38ri7_TAq7zha-ekSUrvdpntG5gFv56Q@mail.gmail.com>
 <20140423071813.GA2777@katana>
In-Reply-To: <20140423071813.GA2777@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Wolfram,

On Wed, Apr 23, 2014 at 9:18 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>> > -               compatible = "renesas,rmobile-iic";
>> > +               compatible = "renesas,iic-r8a7740", "renesas,rmobile-iic";
>>
>> I see an opportunity for improvement here: this driver doesn't seem to have
>> any bindings documented under Documentation/devicetree/bindings/?
>
> I am brushing up this driver currently, so consider it done. Just

That's great to hear, thanks!

> waiting for a minor email issue to be solved before I can send out
> patches.

Good luck!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
