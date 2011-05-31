From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 31 May 2011 04:08:06 +0000
Subject: Re: [PATCH] Subject: shmobile: Fix build of the LCDC driver
Message-Id: <20110531040806.GB1745@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201105280123.06622.rjw@sisk.pl>
In-Reply-To: <201105280123.06622.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-sh@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>

On Sat, May 28, 2011 at 01:23:06AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The shmobile lcdcfb driver fails to build because of the undefined
> ret variable in sh_mobile_lcdc_start().  Fix this problem.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
> 
> Hi,
> 
> I don't know whether this is known or not.  In case it isn't,
> here's a fix. :-)
> 
Already fixed in the fbdev tree, it'll be in the next round of updates.
