From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 25 Jan 2016 07:50:04 +0000
Subject: Re: [PATCH 1/2] v4l: vsp1: Add missing #include <linux/sched.h>
Message-Id: <CAMuHMdXa8O_WwARnkwBezj5YZsxxb2KiQwxFczK7covU9q=_Tg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1452536727-19538-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1452536727-19538-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Mon, Jan 25, 2016 at 1:37 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> I wonder, though, whether the right solution wouldn't be to fix wait.h and
> sched.h. They seem to depend on each other.

Include shuffling involving sched.h usually breaks something else, due to
include hell.

>> ---
>> Against renesas-drivers-2016-01-05-v4.4-rc8
>>
>>  drivers/media/platform/vsp1/vsp1_pipe.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/media/platform/vsp1/vsp1_pipe.c
>> b/drivers/media/platform/vsp1/vsp1_pipe.c index
>> 96f0e7d4c400172e..2283e64f12faadd1 100644
>> --- a/drivers/media/platform/vsp1/vsp1_pipe.c
>> +++ b/drivers/media/platform/vsp1/vsp1_pipe.c
>> @@ -13,6 +13,7 @@
>>
>>  #include <linux/delay.h>
>>  #include <linux/list.h>
>> +#include <linux/sched.h>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
