From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 22 May 2015 09:10:16 +0000
Subject: Re: [PATCH v3 11/11] ARM: shmobile: gose: enable R-Car Gen2 regulator quirk
Message-Id: <CAO3366zkmuah7o8ATe4RcOp=eDK+UEoitq64GVUWUUy_9u734w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1432205293-9488-12-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1432205293-9488-12-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

On Fri, May 22, 2015 at 11:07 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Does it also print "IRQ2 is not asserted, removing quirk", to indicate success
> after masking the da9063 and da9210 interrupt sources?

Yep:

i2c 6-0058: Masking da9063 interrupt sources
i2c 6-0068: Masking da9210 interrupt sources
i2c 6-0068: IRQ2 is not asserted, removing quirk

CU
Uli
