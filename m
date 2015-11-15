From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sun, 15 Nov 2015 14:05:49 +0000
Subject: Re: [PATCH 0/2] fix Lager earlycon
Message-Id: <87pozb2w8y.wl-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1447431743-16376-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1447431743-16376-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, 14 Nov 2015 01:22:21 +0900,
Ulrich Hecht wrote:
> 
> Hi!
> 
> This makes earlycon work on the Lager board:
> 
> 1. It amends the SCI earlycon patch by Sato-san slightly to preserve the
> other bits in SCSCR when asserting RE and TE.
> 
> 2. It switches the serial console back to SCIF0, because that's what the
> boot loader uses, and we rely on it to set up the port for us...
> 
> I have yet to check to what extent other boards/SoCs are affected by this.
> 

Works fine on SCI.
Thanks.

> CU
> Uli
> 
> 
> Ulrich Hecht (2):
>   sh-sci: Add CONFIG_SERIAL_EARLYCON support
>   ARM: shmobile: r8a7790: switch console back to scif0
> 
>  arch/arm/boot/dts/r8a7790-lager.dts | 14 ++++----
>  drivers/tty/serial/Kconfig          |  6 ++++
>  drivers/tty/serial/sh-sci.c         | 71 +++++++++++++++++++++++++++++++++++--
>  3 files changed, 81 insertions(+), 10 deletions(-)
> 
> -- 
> 2.6.1
> 

-- 
Yoshinori Sato
<ysato@users.sourceforge.jp>
