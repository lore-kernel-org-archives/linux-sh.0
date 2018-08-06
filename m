From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 06 Aug 2018 14:37:45 +0000
Subject: Re: [PATCH/RFC 0/4] sh-sci : Do not derive regshift from regsize
Message-Id: <5328542.T44L6SpoGe@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20180806140755.24087-1-geert+renesas@glider.be>
In-Reply-To: <20180806140755.24087-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Chris Brandt <chris.brandt@renesas.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Ulrich Hecht <uli@fpond.eu>, Yoshinori Sato <ysato@users.sourceforge.jp>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-serial@vger.kernel.org

Hi Geert,

On Monday, 6 August 2018 17:07:51 EEST Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This RFC patch series was sparked by noticing that commit 2d4dd0da45401c7a

Where can that commit be found ?

> ("serial: sh-sci: Allow for compressed SCIF address") broke earlycon
> support on most Renesas ARM SoCs using SCIF ports, and by the fragility of
> deriving regshift from the register block size (which may be rounded up):

Why should it be rounded up ?

>   1. The first patch is an old patch from Sato-san, which I never really
>      understood.  But it turned out to be a dependency for patch 2.
>   2. Patch 2 makes sure regshift is initialized when using earlycon,
>      unbreaking the serial console on e.g. R-Car Gen2 and Gen3.
>   3. Patch 3 reverts the patch that started deriving regshift from the
>      register block size, and that removed the plat_sci_port.regshift
>      field.  Which is a field I needed again in patch 4.
>   4. Patch 4 removes the remaining regshift derivations on DT platforms.
>  (5. I didn't bother writing patch 5, which involves adding .regshift
>      initializations to all SH board files that need it.)
> 
> However, I'm not happy with the end result, so please DO NOT apply this!
> As I spent almost a full day on this, and would still like to know the
> story about "sh-sci: Use a separate sci_port for earlycon", I decided to
> post it anyway.
> 
> As earlycon will be broken in v4.19-rc1 on RZ/A1, RZ/G, and R-Car, assuming
> no other actions are taken, an alternative solution would be to:
>   1. Revert commit 7acece71a517cad8 ("serial: sh-sci: Remove
>      SCIx_RZ_SCIFA_REGTYPE"),
>   2. Revert commit 2d4dd0da45401c7a ("serial: sh-sci: Allow for compressed
>      SCIF address") alternative,
>   3. Add an OF_EARLYCON_DECLARE() for RZ/A2, to fix earlycon on RZ/A2.
> 
> What do you think?
> Thanks for your comments!
> 
> P.S. Apparently SCIx_SH4_SCIF_REGTYPE and SCIx_SH2_SCIF_FIFODATA_REGTYPE
>      are identical?
> 
> Geert Uytterhoeven (3):
>   [RFC] sh-sci: Take into account regshift to fix earlycon breakage
>   [RFC] Revert "serial: sh-sci: Compute the regshift value for SCI
>     ports"
>   [RFC] sh-sci: Derive regshift value from DT compatible value
> 
> Yoshinori Sato (1):
>   [RFC] sh-sci: Use a separate sci_port for earlycon
> 
>  arch/sh/kernel/cpu/sh3/setup-sh770x.c |  1 +
>  arch/sh/kernel/cpu/sh4/setup-sh7750.c |  3 +-
>  arch/sh/kernel/cpu/sh4/setup-sh7760.c | 10 +---
>  drivers/tty/serial/sh-sci.c           | 68 +++++++++++++++++----------
>  include/linux/serial_sci.h            |  1 +
>  5 files changed, 49 insertions(+), 34 deletions(-)

-- 
Regards,

Laurent Pinchart



