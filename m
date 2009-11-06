From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 06 Nov 2009 01:33:57 +0000
Subject: Re: [PATCH 02/05] Driver Core: Early platform driver buffer
Message-Id: <20091106013357.GB3226@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20091105143508.9902.22192.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091105143508.9902.22192.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Nov 05, 2009 at 11:35:08PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add early_platform_init_buffer() support and update the
> early platform driver code to allow passing parameters
> to the driver on the kernel command line.
> 
> early_platform_init_buffer() simply allows early platform
> drivers to provide a pointer and length to a memory area
> where the remaining part of the kernel command line option
> will be stored.
> 
> Needed to pass baud rate and other serial port options
> to the reworked early serial console code on SuperH.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  drivers/base/platform.c         |   29 ++++++++++++++++++++++-------
>  include/linux/platform_device.h |   20 +++++++++++++++-----
>  2 files changed, 37 insertions(+), 12 deletions(-)
> 
This needs to be run by Greg and acked before anything can be done with
the rest of this series.
