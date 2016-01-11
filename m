From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 11 Jan 2016 18:43:15 +0000
Subject: Re: [PATCH 2/2] v4l: vsp1: Add missing #include <linux/slab.h>
Message-Id: <CAMuHMdWhubiVBJ_-61r8Hk-vaZzQ4RGVs0Nw4TZ8gGaUc7KyHQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1452536727-19538-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1452536727-19538-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Mon, Jan 11, 2016 at 7:27 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Monday 11 January 2016 19:25:27 Geert Uytterhoeven wrote:
>> If CONFIG_SPI=n:
>>
>> drivers/media/platform/vsp1/vsp1_dl.c: In function 'vsp1_dl_create':
>> drivers/media/platform/vsp1/vsp1_dl.c:271:2: error: implicit declaration of
>> function 'kzalloc' [-Werror=implicit-function-declaration] dl >> kzalloc(sizeof(*dl), GFP_KERNEL);
>>   ^
>> drivers/media/platform/vsp1/vsp1_dl.c:271:5: warning: assignment makes
>> pointer from integer without a cast dl = kzalloc(sizeof(*dl), GFP_KERNEL);
>>      ^
>> drivers/media/platform/vsp1/vsp1_dl.c:283:3: error: implicit declaration of
>> function 'kfree' [-Werror=implicit-function-declaration] kfree(dl);
>>    ^
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> I have this in my tree already.

OK.

I had checked http://git.linuxtv.org//pinchartl/media.git/, but didn't see a
new tag ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
