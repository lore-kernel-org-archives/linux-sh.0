From: Simon Horman <horms@verge.net.au>
Date: Thu, 23 Dec 2010 06:36:28 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: mackerel: Add sdhi support
Message-Id: <20101223063626.GA4540@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p7hfw4po7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Goda-san,

The SDHI1 portions of this code do not seem to work for me.
If I remove then then I can access SDHI0 and 2, but if they
are included then I can't access any MMC devices.

I can access the same port that SDHI1 uses by using
the MMCIF driver as per your subsequent patch.

Let me know if I can provide any more information.

