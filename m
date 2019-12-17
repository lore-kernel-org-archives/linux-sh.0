From: Karl Nasrallah <knnspeed@aol.com>
Date: Tue, 17 Dec 2019 08:15:09 +0000
Subject: Re: can someone solve string_32.h issue for SH ?
Message-Id: <1348932359.222850.1576570509794@mail.yahoo.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87h81zh4ap.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87h81zh4ap.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

I'm terribly sorry; I think I made a mistake. I looked at it again, double-checked the defined behavior of strncpy, and I think you actually just need to replace __src+__n with __dest+__n in your strncpy.
Additionally, I don't know what the linux kernel rules are on this, but maybe unsigned long __dummy; should be initialized to 0 explicitly for readability?

Sorry about that!

-----Original Message-----
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Karl Nasrallah <knnspeed@aol.com>
Cc: linux-sh <linux-sh@vger.kernel.org>
Sent: Tue, Dec 17, 2019 2:46 am
Subject: Re: can someone solve string_32.h issue for SH ?



Hi Karl


> This appears to be your culprit:
> 
> char vub_name[3 + (9 * 8) + 4 + 1];
> 
> in struct vub300_mmc_host on line 302 of the file /drivers/mmc/host/vub300.c.
> 
> This is the exact line triggering your warning, also in vub300.c:
> 
> 515 strncpy(vub300->vub_name, "EMPTY Processing Disabled", sizeof(vub300->vub_name));
> 
> And the fix would be to probably fix vub300.c, do a sizeof() on the string or hardcode the string size to 26 characters since the string is already hardcoded in as it stands.
> 
> The asm doesn't look wrong.
> 
> Hope this helps!
> (Sorry I can't do any pretty formatting: mail client and majordomo don't play very well together and html gets generated at even the slightest provocation, despite having disabled it...)


Oops, indeed
I got too many this kind of warning on SH.
I though, it is SH side issue.
(Why I don't get same warning on other CPU.. ??)

But anyway, Thanks a lot.
I will fixup driver side !!

Thank you for your help !!
Best regards
---
Kuninori Morimoto
