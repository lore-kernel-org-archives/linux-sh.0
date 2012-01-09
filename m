From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 09 Jan 2012 00:34:13 +0000
Subject: Re: [PATCH 00/05] sh: pfc: Variable bitfield width and unlock reg patches
Message-Id: <20120109003413.GC25648@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Dec 14, 2011 at 01:00:27AM +0900, Magnus Damm wrote:
> sh: pfc: Variable bitfield width and unlock reg patches
> 
> [PATCH 01/05] sh: pfc: Add gpio_read_bit() for data register access
> [PATCH 02/05] sh: pfc: Convert index to field and value pair
> [PATCH 03/05] sh: pfc: Add config_reg_helper() function
> [PATCH 04/05] sh: pfc: Variable bitfield width config register support
> [PATCH 05/05] sh: pfc: Unlock register support
> 
> Update the common PFC code to support r8a7779 by adding:
> - Variable bitfield width config register support (Patch 4)
> - Unlock register support (Patch 5)
> 
> Patch 1-3 contain incremental changes needed for 4.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  Depends on "[PATCH] sh: pfc: ioremap() support"
> 

Applied to common/pfc, thanks.
