From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Feb 2015 13:30:36 +0000
Subject: Re: [PATCH] dmaengine: shdma: Move DMA stop to (runtime) suspend callbacks
Message-Id: <CAMuHMdXfrVYicT6mW9igFZ9xt_Pv3BtNve0nSQHDRrkTkt5m=A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424946394-6784-1-git-send-email-geert+renesas@glider.be>
	<54EF1DC2.30703@cogentembedded.com>
In-Reply-To: <54EF1DC2.30703@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, dmaengine@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Thu, Feb 26, 2015 at 2:21 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>>   static struct platform_driver sh_dmae_driver = {
>> -       .driver         = {
>> +       .driver         = {
>
>
>    Hm, don't understand what was changed on this line...

One silly space that should have been a TAB.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
