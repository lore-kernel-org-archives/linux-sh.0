From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Tue, 29 Sep 2009 16:25:39 +0000
Subject: Re: [PATCH] sh: mach-ecovec24: modify MTD mask_flags typo
Message-Id: <20090929162539.GA27785@game.jcrosoft.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uhbumqaj9.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uhbumqaj9.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 20:02 Tue 29 Sep     , Kuninori Morimoto wrote:
> This patch modify bug which can erase boot loader image area.
IIC you do not want to be able to modify the boot loader area
why?
and why do you allow to write it?

Best Regards,
J.
