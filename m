From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Mon, 02 Jun 2008 01:43:57 +0000
Subject: Re: [PATCH] video: SuperH Mobile LCDC Driver V2
Message-Id: <aec7e5c30806011843k32b692e3q3105b20d7611781a@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080530110239.21680.46731.sendpatchset@rx1.opensource.se>
	<20080530120606.9ff1b384.akpm@linux-foundation.org>
	<20080530214418.f024ba0c.krzysztof.h1@poczta.fm>
	<200805311625.27018.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <200805311625.27018.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, iwamatsu@nigauri.org, linux-sh@vger.kernel.org, lethal@linux-sh.org, Andrew Morton <akpm@linux-foundation.org>

On Sat, May 31, 2008 at 11:25 PM, Fabio Giovagnini
<fabio.giovagnini@aurion-tech.com> wrote:
> Which differences are bteween SuperH Mobile LCDC frame buffer and SH2A 7203
> LCDC controller?

Judging from the data sheets the LCDC block in sh7203, sh7763 and
sh7720 are identical. Except different base address for registers and
palette. And maybe IRQ number and pin configuration. =) Anyway, the
sh7760 LCDC is very similar but seems to be missing a few registers.
I'm sure there are other parts that are using this LCDC block as well.
Having a shared driver for sh7203/sh7763/sh7720 and sh7760 makes
sense.

The SuperH Mobile LCDC block (sh7723/sh7722/sh7343) is very different:
Supported pixel formats, hardware interfaces, number of channels,
register layout and register width.

/ magnus
