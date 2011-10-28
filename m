From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 28 Oct 2011 06:06:56 +0000
Subject: Re: [PATCH] sh: pfc: Remove unused gpio_in_use member
Message-Id: <20111028060656.GC32187@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Sep 28, 2011 at 04:47:06PM +0900, Magnus Damm wrote:
> Remove unused member gpio_in_use from struct pinmux_info.
> 

On Wed, Sep 28, 2011 at 04:50:58PM +0900, Magnus Damm wrote:
> Add GPIO IRQ support to the shared PFC code in drivers/sh/pfc.c
> 
> The enums pointed out by a certain GPIO will be matched against
> a table for IRQ to enum mappings.
> 
> Only the shared PFC code is updated by this patch. SoC specific
> changes are also needed to allow platforms to make use of this
> feature.

Both applied, thanks.
