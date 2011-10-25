From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Tue, 25 Oct 2011 08:39:28 +0000
Subject: Re: [PATCH] gpiolib/arches: Centralise bolierplate asm/gpio.h
Message-Id: <20111025083928.GC31508@opensource.wolfsonmicro.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1319528012-19006-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20111025083301.GD4605@ponder.secretlab.ca>
In-Reply-To: <20111025083301.GD4605@ponder.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Russell King <linux@arm.linux.org.uk>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Mike Frysinger <vapier@gentoo.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Mundt <lethal@linux-sh.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, linux-arch@vger.kernel.org

On Tue, Oct 25, 2011 at 10:33:01AM +0200, Grant Likely wrote:

> (not that I've actually tested this much yet; it should probably go
> into a separate branch to marinate in linux-next for a bit without
> impacting the other GPIO patches I've got queued.

Yes, it should.  I've test built a few configurations covering both
asm/gpio.h and default implementations and it seems to be doing the
right thing but I might well have missed something.  I'm hoping to also
have a further patch to go on top of this which makes _OPTIONAL_GPOILIB
on by default.
