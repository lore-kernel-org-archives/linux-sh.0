From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 15 Dec 2015 08:18:23 +0000
Subject: Re: renesas-drivers-2015-12-14-v4.4-rc5
Message-Id: <CAMuHMdWMyOhhg9nYgwZDY-x-TDdQ-O1+tQ5KKy3zwdoFSjtk-A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450119324-659-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1450119324-659-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Khiem-san,

On Tue, Dec 15, 2015 at 2:18 AM, Khiem Nguyen
<khiem.nguyen.xt@rvc.renesas.com> wrote:
> On 12/15/2015 1:55 AM, Geert Uytterhoeven wrote:
>> I've pushed renesas-drivers-2015-12-14-v4.4-rc5 to
>> https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git
>> This tree is meant to ease development of platform support and drivers for
>> Renesas ARM ("shmobile") SoCs. It's created by merging (a) the for-next
>> branches of various subsystem trees and (b) branches with driver code
>> submitted or planned for submission to maintainers into the development
>> branch of Simon Horman's renesas.git tree.
>>
>> Today's version is based on renesas-devel-20151214-v4.4-rc5.
>>
> [snip]
>>
>> Dropped (crashes):
>>    - git://linuxtv.org/mchehab/media-next.git#master
>>    - git://linuxtv.org/pinchartl/media.git#vsp1-kms-20151206~3
>
> I believe that Laurent will have to look into this crash. :)
> The crash is occurred when CONFIG_VIDEO_RENESAS_VSP1 config is enabled, I
> guess.

Yes.

Details have already been reported upstream.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
