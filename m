From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Fri, 05 Oct 2012 11:43:19 +0000
Subject: Re: [PATCH] spi: spi-rspi: fix build error for the latest shdma driver
Message-Id: <20121005114319.GY4360@opensource.wolfsonmicro.com>
List-Id: <linux-sh.vger.kernel.org>
References: <501A379D.6060009@renesas.com>
In-Reply-To: <501A379D.6060009@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, spi-devel-general@lists.sourceforge.net, SH-Linux <linux-sh@vger.kernel.org>

On Thu, Aug 02, 2012 at 05:17:33PM +0900, Shimoda, Yoshihiro wrote:
> Because the latest shdma driver changed, it caused build error in
> the spi-rspi driver. This patch fixed the build error.

Applied, thanks.  This should really have been done as part of the shdma
update...
