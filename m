From: morimoto.kuninori@renesas.com
Date: Fri, 05 Dec 2008 04:23:29 +0000
Subject: Re: [PATCH] Add plain udivsi3 (not _i4*) for gcc-4.1 and lower.
Message-Id: <uoczrtflq.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49389A5D.5040107@renesas.com>
In-Reply-To: <49389A5D.5040107@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Thanks Yoshii-san

> Three symbols are sharing one code, which is actually udivsi3_i4i.
> But, this results unwanted code with gcc 4.1.
(snip)
> I checked git:lethal/master for ap325rxa.
>  the one compiled by gcc 4.1.2 was NG (No output to console),
>  while gcc 4.2.4 was OK
> I have added plain udivsi3 as a patch below.
> After that, both gcc 4.1.2 and 4.2.4 are OK
(snip)
>  We chan't share code for udivsi3 and udivsi3_i4, because they have
>  different clobber list. Copied udivsi3 from gcc-4.1.2.
> 
> Signed-off-by: Takashi YOSHII <yoshii.takashi@renesas.com>
> ---

This patch works well on my environment.
Thank you.

Best regards
--
Kuninori Morimoto
 
