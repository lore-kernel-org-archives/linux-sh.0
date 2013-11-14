From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 14 Nov 2013 13:46:22 +0000
Subject: Re: [PATCH 0/16] ARM: shmobile: SDHI support for r8a7790
Message-Id: <2008878.YfHkJYy4No@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87li0rz3to.wl%kuninori.morimoto.gx@renesas.com> <87txffxofc.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87txffxofc.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org

Hi Morimoto-san,

Thank you for the patches.

On Thursday 14 November 2013 02:34:03 Kuninori Morimoto wrote:
> Hi Simon
> 
> These are SDHI support for r8a7790.
> 
> Kuninori Morimoto (14):
>       ARM: shmobile: lager: add SDHI0/2 support
>       ARM: shmobile: lager: use gpio/fixed regulator for SDHI

As the second patches fixes a problem in the first one, I'd like to split them 
differently. Could you please submit a first patch that adds the regulators, 
and a second patch that adds SDHI0/2 support using the regulators ?

-- 
Regards,

Laurent Pinchart

