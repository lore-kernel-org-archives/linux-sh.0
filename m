From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Oct 2014 11:02:02 +0000
Subject: Re: [PATCH] sh: fix sh770x SCIF memory regions
Message-Id: <CAMuHMdXWK3-LcOzsnFLMT-DjZKhvULiMK2MR3iNudmTaUZEBkw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CACuQN4CtNGL25d8790u+7KjDbrYjAZvJ8xjM2ggGdYkJ_EkFZw@mail.gmail.com>
In-Reply-To: <CACuQN4CtNGL25d8790u+7KjDbrYjAZvJ8xjM2ggGdYkJ_EkFZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Andriy,

On Fri, Oct 24, 2014 at 12:46 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Thank you for the patch.
>
> On Thursday 16 October 2014 21:46:50 Andriy Skulysh wrote:
>> sh: fix sh770x SCIF memory regions
>>
>> Resources scif1_resources & scif2_resources overlap.
>> Actual SCIF region size is 0x10.
>>
>> This is regression from:
>>
>> Author: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>> Date:   Fri Dec 6 10:59:48 2013 +0100
>> sh: Declare SCIF register base and IRQ as resources
>>
>> Signed-off-by: Andriy Skulysh <askulysh@gmail.com>
>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

As drivers/sh is unmaintained, please send this patch to Andrew Morton.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
