From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 01 Dec 2010 07:09:11 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: mackerel: Add LEDs support
Message-Id: <20101201070911.GA2320@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Nov 30, 2010 at 03:52:18PM +0900, Kuninori Morimoto wrote:
> you can control it by
> echo 0 > /sys/class/leds/led0/brightness
> echo 1 > /sys/class/leds/led0/brightness
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

On Wed, Dec 01, 2010 at 09:31:46AM +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> This patch is depend on
> [PATCH] ARM: mach-shmobile: mackerel: Add LEDs support
> 
> On paul's rmobile/mackerel branch + this patch,
> compile is OK, but FSI-AK4643 doesn't work.
> If ALSA tree was merged, it start work.
> 
That's fine, it'll all get sorted out in -next or the merge window.

Both applied, thanks.
