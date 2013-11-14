From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 14 Nov 2013 10:21:42 +0000
Subject: Re: [PATCH 0/16] mmc: bug fix patches
Message-Id: <87habfz3kd.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87li0rz3to.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87li0rz3to.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>, Chris Ball <cjb@laptop.org>
Cc: Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org


Hi Chris

These are mmc bugfix patches

Kuninori Morimoto
       mmc: tmio: don't overwrite caps2
 
Shinobu Uehara (2):
       mmc: tmio: Fix odd size access
       mmc: tmio: Add error IRQ status clear
