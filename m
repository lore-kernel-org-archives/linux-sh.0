From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 31 Jan 2008 23:17:15 +0000
Subject: Re: [PATCH/KCONFIG] - Add SUPERH depends to sound/soc/sh/Kconfig
Message-Id: <20080131231715.GB16399@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080131225811.a175de2c.Kristoffer.ericson@gmail.com>
In-Reply-To: <20080131225811.a175de2c.Kristoffer.ericson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: linux-sh <linux-sh@vger.kernel.org>, linux-main <linux-kernel@vger.kernel.org>

On Thu, Jan 31, 2008 at 10:58:11PM +0100, Kristoffer Ericson wrote:
> Currently you will see an empty "SoC Audio support for SuperH" menu 
> when building for other archs (example pxa).
> This patch adds "depends on SUPERH" to remove that empty menu.
> 
> signed-off-by: Kristoffer Ericson <kristoffer.ericson@gmail.com>
> 
Yeah, I noticed that too. Please send this to the ALSA folks.
