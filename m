From: Christoph Hellwig <hch@lst.de>
Date: Tue, 01 Sep 2020 15:06:54 +0000
Subject: Re: [PATCH v2] mmc: mmc_spi: Allow the driver to be built when CONFIG_HAS_DMA is unset
Message-Id: <20200901150654.GB30034@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200901150438.228887-1-ulf.hansson@linaro.org>
In-Reply-To: <20200901150438.228887-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>, Mark Brown <broonie@kernel.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 05:04:38PM +0200, Ulf Hansson wrote:
> +#ifdef CONFIG_HAS_DMA
> +static int mmc_spi_dma_alloc(struct mmc_spi_host *host)
> +{
> +	struct spi_device *spi = host->spi;
> +	struct device *dev;
> +
> +	if (!spi->master->dev.parent->dma_mask)
> +		return 0;

I still don't think this makes sense, as the dma_mask should always
be non-NULL here.
