From: Rob Landley <rob@landley.net>
Date: Thu, 31 Jan 2019 12:42:18 +0000
Subject: Re: Commit 594cc251fdd0 (user_access_begin does access_ok) made arch/sh stop booting on qemu.
Message-Id: <77f57f50-4460-8997-756a-6d6f45504cb5@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <51e0329b-5d0b-1099-54f3-b51a34b6b216@landley.net>
 <CAHk-=wgTxAaviY-WuOKtAd8f4XpE7WF43aaO8F9-CgyowyxSfA@mail.gmail.com>
In-Reply-To: <CAHk-=wgTxAaviY-WuOKtAd8f4XpE7WF43aaO8F9-CgyowyxSfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>

On 1/31/19 2:30 AM, Linus Torvalds wrote:
> See
> 
>  
>   https://lore.kernel.org/lkml/CAHk-=wiHe4dNHKpE4oGhwwmy23jNTuuFQAgWTGCjjxyOVYjG_w@mail.gmail.com/
> 
> for an explanation of the SH bug.
> 
> But Guenter Roeck confirmed that my patch fixed it on SH for him. Is there
> something else going on in your configuration?

That fixed it for me.

Thanks,

Rob
