From: Christoph Hellwig <hch@lst.de>
Date: Fri, 28 Aug 2020 04:24:22 +0000
Subject: Re: [PATCH 09/10] sh: don't allow non-coherent DMA for NOMMU
Message-Id: <20200828042422.GA29734@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200714121856.955680-1-hch@lst.de> <20200714121856.955680-10-hch@lst.de> <20200828020045.GT3265@brightrain.aerifal.cx> <20200828021152.GU3265@brightrain.aerifal.cx>
In-Reply-To: <20200828021152.GU3265@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Christoph Hellwig <hch@lst.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org

On Thu, Aug 27, 2020 at 10:11:53PM -0400, Rich Felker wrote:
> > This change broke SD card support on J2 because MMC_SPI spuriously
> > depends on HAS_DMA. It looks like it can be fixed just by removing
> > that dependency from drivers/mmc/host/Kconfig.
> 
> It can't. mmp_spi_probe fails with ENOMEM, probably due to trying to
> do some DMA setup thing that's not going to be needed if the
> underlying SPI device doesn't support/use DMA.

Adding the linux-mmc and linux-spi lists, as that seems pretty odd.
