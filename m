From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 25 Feb 2015 17:49:05 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a73a4: Remove legacy code
Message-Id: <54EE0B11.9030100@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418771008-5676-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1418771008-5676-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 02/24/2015 06:30 PM, Geert Uytterhoeven wrote:

>>> The mmc problems seem to be resolved in v4.0-rc1 and I have queued
>>> this patch up as part of rebasing renesas-devel/next on top of that rc
>>> release.

>> I can't find the patch in your next or devel branches. Am I looking at the
>> wrong tree ?

> I saw it, too. But as renesas-devel-20150224-4.0-rc1 predates the email
> from Simon, I assumed he just hasn't pushed out that version yet.

    BTW, does this tag work for anybody? I got the kernel hang with the blank 
console after the kernel decompression on the SILK board. After I enabled 
CONFIG_DEBUG_LL and early printk(), I saw that the PFC driver fails to load, 
all drivers dependent on the PFC driver failing the probes, and then the early 
console was disabled before I could see any crash report... I will provide the 
kernel log a bit later if anybody is interested...

> Gr{oetje,eeting}s,
>                          Geert

WBR, Sergei

