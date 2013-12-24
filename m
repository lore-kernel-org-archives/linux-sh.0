From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Dec 2013 19:46:47 +0000
Subject: Re: [PATCH 6/6] [RFC] arm: shmobile: genmai reference: Add RSPI nodes
Message-Id: <CAMuHMdWMXAnLgkap-sQEr1z0M-nS8spwiBd_X4cGsrJq1UO6rA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387886210-3634-1-git-send-email-geert+renesas@linux-m68k.org>
 <1387886210-3634-7-git-send-email-geert+renesas@linux-m68k.org>
 <52B9ABFF.90902@cogentembedded.com>
In-Reply-To: <52B9ABFF.90902@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Sergei,

On Tue, Dec 24, 2013 at 4:45 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>> +       codec: wm8978@0 {
>
>    Do not give chip names to device nodes, please use somewhat generic names
> instead, like "sound-codec@0". That's to comply with ePAPR spec.

Oh, so the generic codec alias is not sufficient? Last time you gave this
comment, the code didn't contain a generic name at all, so I thought
this would be OK...

Seems like Documentation/devicetree/bindings can use some cleanups,
as it's full of examples like "codec: wm8510@1a"...

Thanks for your comments!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
