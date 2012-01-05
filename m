From: Samuel Ortiz <sameo@linux.intel.com>
Date: Thu, 05 Jan 2012 11:53:16 +0000
Subject: Re: [PATCH 06/11] mfd: tmio: remove now unneeded tmio_mmc_cd_wakeup()
Message-Id: <20120105115316.GM5183@sortiz-mobl>
List-Id: <linux-sh.vger.kernel.org>
References: <1325686636-23905-1-git-send-email-g.liakhovetski@gmx.de>
 <1325686636-23905-7-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1325686636-23905-7-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

Hi Guennadi,

On Wed, Jan 04, 2012 at 03:17:11PM +0100, Guennadi Liakhovetski wrote:
> Now, that all users of tmio_mmc_cd_wakeup() have been converted over to
> drivers/mmc/core/cd-gpio.c, that function can be removed.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
