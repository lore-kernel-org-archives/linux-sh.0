From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 05 Sep 2014 09:17:30 +0000
Subject: Re: [PATCH] clk-rcar-gen2: RCAN clock support
Message-Id: <CAMuHMdUoZ3AX-y51BaBuodu1Lmw1SvzvGUNNEtfPvfYdsWJOCw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201407310023.43605.sergei.shtylyov@cogentembedded.com>
	<540772A1.8080101@cogentembedded.com>
	<CAMuHMdU0GJyYiP8NkELZia00gzKMmVRQ+1YwWCrFRLQytJ6YPw@mail.gmail.com>
In-Reply-To: <CAMuHMdU0GJyYiP8NkELZia00gzKMmVRQ+1YwWCrFRLQytJ6YPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Mike Turquette <mturquette@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Pavel Kiryukhin <vksavl@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Sergei,


On Fri, Sep 5, 2014 at 11:03 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Wed, Sep 3, 2014 at 9:57 PM, Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com> wrote:
>> On 07/31/2014 12:23 AM, Sergei Shtylyov wrote:
>>
>>> Add RCAN clock support to the R-Car generation 2 CPG driver. This clock
>>> gets
>>> derived from the USB_EXTAL clock by dividing it by 6. The layout of
>>> RCANCKCR
>>> register is close to those of the clocks supported by the 'clk-div6'
>>> driver
>>> but has no divider field, and so can't be supported by that driver...
>
> I'm not a clock expert (pulling in Laurent), but it looks fine to me.

While you did add the rcan clock to the dtsi in "[PATCH v3 1/3] ARM:
shmobile: r8a7791: add CAN clocks", I couldn't find a patch to update
the renesas,rcar-gen2-cpg-clocks binding doc?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
