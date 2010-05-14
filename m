From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 14 May 2010 06:02:40 +0000
Subject: Re: [PATCH] media/IR: Add missing include file to rc-map.c
Message-Id: <20100514060240.GD12002@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201005051720.22617.PeterHuewe@gmx.de> <201005112042.14889.PeterHuewe@gmx.de>
In-Reply-To: <201005112042.14889.PeterHuewe@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter H?we <PeterHuewe@gmx.de>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>, linuxppc-dev@ozlabs.org, David H?rdeman <david@hardeman.nu>, linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, linux-mips@linux-mips.org, linux-m68k@lists.linux-m68k.org

On Tue, May 11, 2010 at 08:42:14PM +0200, Peter H?we wrote:
> Am Mittwoch 05 Mai 2010 17:20:21 schrieb Peter H?we:
> > From: Peter Huewe <peterhuewe@gmx.de>
> > 
> > This patch adds a missing include linux/delay.h to prevent
> > build failures[1-5]
> > 
> > Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
> > ---
> Any updates on this patch?
> Issue still exists with today's linux-next tree
> 
You might want to send this to the linux-next list at least. If the
people who introduced the breakage are unresponsive (as often tends to be
the case with -next) it's still worth getting trivial fixes rolled in for
the interim. This change doesn't exist outside of -next and whatever tree
introduced it, so there's not much else anyone can do about it at
present.
