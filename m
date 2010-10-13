From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 13 Oct 2010 10:25:37 +0000
Subject: Re: [PATCH] sh: remove name and id from struct clk
Message-Id: <20101013102537.GD10013@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20101013074436.19791.66447.sendpatchset@t400s>
In-Reply-To: <20101013074436.19791.66447.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 13, 2010 at 04:44:36PM +0900, Magnus Damm wrote:
> Remove "name" and "id" from drivers/sh/ struct clk.
> 
> The struct clk members "name" and "id" are not used
> now when matching is done through clkdev.

Applied, thanks.
