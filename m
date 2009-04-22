From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 22 Apr 2009 10:51:07 +0000
Subject: Re: [PATCH] sh: sh7785lcr: fix defconfig for 29-bit mode
Message-Id: <20090422105106.GB24515@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <49EEF66B.2010507@renesas.com>
In-Reply-To: <49EEF66B.2010507@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 22, 2009 at 12:51:05PM +0200, Michael Trimarchi wrote:
> Yoshihiro Shimoda wrote:
> >Fix the problem that cannot work 29-bit mode when use sh7785lcr_defconfig.
> >
> >Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
> >  
> Just to know... Is it impossible to select the 29bit mode for sh7785?

It should be fine. I have been booting both 29bit and 32bit on my
sh7785lcr without incident.
