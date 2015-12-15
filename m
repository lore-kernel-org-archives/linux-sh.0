From: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
Date: Tue, 15 Dec 2015 01:18:40 +0000
Subject: Re: renesas-drivers-2015-12-14-v4.4-rc5
Message-Id: <566F6A70.5050003@rvc.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450119324-659-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1450119324-659-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 12/15/2015 1:55 AM, Geert Uytterhoeven wrote:
> I've pushed renesas-drivers-2015-12-14-v4.4-rc5 to
> https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git
> This tree is meant to ease development of platform support and drivers for
> Renesas ARM ("shmobile") SoCs. It's created by merging (a) the for-next
> branches of various subsystem trees and (b) branches with driver code
> submitted or planned for submission to maintainers into the development
> branch of Simon Horman's renesas.git tree.
>
> Today's version is based on renesas-devel-20151214-v4.4-rc5.
>
[snip]
>
> Dropped (crashes):
>    - git://linuxtv.org/mchehab/media-next.git#master
>    - git://linuxtv.org/pinchartl/media.git#vsp1-kms-20151206~3
>

I believe that Laurent will have to look into this crash. :)
The crash is occurred when CONFIG_VIDEO_RENESAS_VSP1 config is enabled, 
I guess.

-- 
Best regards,
KHIEM Nguyen
