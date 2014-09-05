From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 05 Sep 2014 09:03:51 +0000
Subject: Re: [PATCH] clk-rcar-gen2: RCAN clock support
Message-Id: <CAMuHMdU0GJyYiP8NkELZia00gzKMmVRQ+1YwWCrFRLQytJ6YPw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201407310023.43605.sergei.shtylyov@cogentembedded.com>
	<540772A1.8080101@cogentembedded.com>
In-Reply-To: <540772A1.8080101@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Mike Turquette <mturquette@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Pavel Kiryukhin <vksavl@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Sergei,

On Wed, Sep 3, 2014 at 9:57 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 07/31/2014 12:23 AM, Sergei Shtylyov wrote:
>
>> Add RCAN clock support to the R-Car generation 2 CPG driver. This clock
>> gets
>> derived from the USB_EXTAL clock by dividing it by 6. The layout of
>> RCANCKCR
>> register is close to those of the clocks supported by the 'clk-div6'
>> driver
>> but has no divider field, and so can't be supported by that driver...
>
>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
>
>> ---
>> The patch is against the 'clk-next' branch of Mike Turquette's 'linux.git'
>> repo.
>
>
>>   drivers/clk/shmobile/clk-rcar-gen2.c |   99
>> +++++++++++++++++++++++++++++++++++
>>   1 file changed, 99 insertions(+)
>
>
>    More than a months has passed, there hasn't been any feedback, patch
> hasn't been applied... what's wrong with it?

Sorry for missing this, it went under my radar.

I'm not a clock expert (pulling in Laurent), but it looks fine to me.
I'm just wondering whether you can simplify the code by using clk-gate?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
