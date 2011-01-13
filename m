From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 13 Jan 2011 06:20:14 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: Kill off unused !gpio_is_valid() case
Message-Id: <20110113062014.GF12013@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20110112104307.11071.4228.sendpatchset@t400s>
In-Reply-To: <20110112104307.11071.4228.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jan 12, 2011 at 07:43:07PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> The Card Detect GPIOs used on AP4EVB and Mackerel are
> alwayws valid, so kill off the unused !gpio_is_valid()
> case.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Applied, thanks.
