From: Simon Horman <horms@verge.net.au>
Date: Thu, 20 Aug 2015 18:54:48 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7790 dtsi: Add CPG/MSTP Clock Domain for sound
Message-Id: <20150820185445.GG18990@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87d1yidabo.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d1yidabo.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 20, 2015 at 01:24:44AM +0000, Kuninori Morimoto wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> 484adb0 ("ARM: shmobile: r8a7790 dtsi: Add CPG/MSTP Clock Domain")
> added CPG/MSTP clock-cells domain support, but it was missing sound
> support. This patch adds it.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks,

I have queued this up as a fix for v4.3 with a minor tweak:

It is my understanding that there is a preference for 12 digit commit
ids in changelogs. Accordingly I have updated the text above to refer
to 484adb005886.
