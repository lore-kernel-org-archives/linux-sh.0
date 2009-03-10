From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 10 Mar 2009 06:19:35 +0000
Subject: Re: [PATCH] video: deferred io cleanup fix for sh_mobile_lcdcfb
Message-Id: <20090310061935.GD10393@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090310060849.22278.94445.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090310060849.22278.94445.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-sh@vger.kernel.org

On Tue, Mar 10, 2009 at 03:08:49PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> Fix deferred io cleanup patch in the sh_mobile_lcdcfb driver.
> 
> If probe() fails early the sh_mobile_lcdc_stop() function will
> be called to clean up deferred io. This patch modifies the
> code to only call fb_deferred_io_cleanup() after deferred io
> has been initialized. 
> 
> With this patch applied we no longer hit BUG_ON() inside
> fb_deferred_io_cleanup(). Triggers on a Migo-R with the
> SYS QVGA panel board unmounted.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Rolled in to the for-2.6.29 queue, thanks.
