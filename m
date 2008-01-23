From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 23 Jan 2008 07:31:01 +0000
Subject: Re: [PATCH] sh: add spi header and r2d platform data V3
Message-Id: <20080123073101.GA21746@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080121102401.28997.63940.sendpatchset@clockwork.opensource.se>
In-Reply-To: <20080121102401.28997.63940.sendpatchset@clockwork.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jan 23, 2008 at 04:21:18PM +0900, Magnus Damm wrote:
> sh: add spi header and r2d platform data V3
> 
> This patch adds the header file asm/spi.h and board specific code for the
> r2d board. The header file contains a structure that should be used to
> point out a single spi bus. The board specific code for r2d is updated with
> such a structure for the new spi_sh_sci driver. The structure contains a
> chip select callback plus information about the R9701 rtc chip which is
> attached to the spi bus.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
> 
>  Changes since V2 include:
>  - Moved spi_register_board_info() to rts7751r2d_devices_setup().
>  - Removed silly comparison in r2d_chip_select().
> 
>  arch/sh/boards/renesas/rts7751r2d/setup.c |   42 +++++++++++++++++++++++++++++
>  include/asm-sh/spi.h                      |   13 ++++++++
>  2 files changed, 55 insertions(+)
> 
Looks fine. I'll queue it up once the other bits hit -mm.
