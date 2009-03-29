From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Sun, 29 Mar 2009 23:35:58 +0000
Subject: Re: regression in 2.6.29-git3 on SH/Dreamcast
Message-Id: <1238369758.6471.16.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1238353446.6471.14.camel@localhost.localdomain>
In-Reply-To: <1238353446.6471.14.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-sh <linux-sh@vger.kernel.org>

On Sun, 2009-03-29 at 20:04 +0100, Adrian McMenamin wrote:
> While 2.6.29 boots cleanly on the Dreamcast, later revisions are likely
> to crash with an OOM condition (this is a race, it doesn't happen on
> every boot, but on about one in every three or four).
> 

Still don't know why this timer patch is tipping the machine over, but I
have found that if I set CONFIG_NO_HZ=y then the machine will boot with
the patch applied.




