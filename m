From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Wed, 19 Aug 2009 12:28:01 +0000
Subject: Re: [PATCH 1/3] Add SuperH FSI driver support for ALSA
Message-Id: <20090819122801.GC20227@rakim.wolfsonmicro.main>
List-Id: <linux-sh.vger.kernel.org>
References: <uljlg59ls.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uljlg59ls.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

On Wed, Aug 19, 2009 at 08:25:19PM +0900, Kuninori Morimoto wrote:
> This driver is very simple.
> It support playback only now.
> It is tested by ms7724se board.

> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>

Again, this looks good from an ASoC point of view.  A couple of things
to clean up below but nothing major.

> +	if (1 = atomic_inc_return(&master->user))
> +		clk_enable(master->clk);

Normally I'd expect a clock API implementation to take care of the
reference counting for you - it should be possible to do multiple
enables on the clock and need an equal number of disables to actually
turn it off.

Also, the error handling in the function doesn't disable the clock or
drop the reference count so if there's an error in the parameters the
driver will loose track of the clock.

> +	fsi_reg_write(fsi, reg, data);
> +	dev_info(dai->dev, "use %s format (%d channel) use %d DMAC\n",
> +		 msg, fsi->chan, fsi->dma_chan);

This should be dev_dbg() instead.

> +static int fsi_pcm_close(struct snd_pcm_substream *substream)
> +{
> +	return 0;
> +}

You should just be able to remove this if it doesn't do anything - if
it's needed the core should be fixed to not require it.

> +			 struct snd_pcm_hw_params *hw_params)
> +{
> +	return snd_pcm_lib_malloc_pages(substream,
> +					params_buffer_bytes(hw_params));
> +}

hw_params() may be called multiple times per stream, especially if OSS
emulation is used.  This would lead to memory leaks since if more pages
need to be allocaeted the old buffer won't be freed.  Simply calling
free_pages() before malloc_pages() should plug this leak - free_pages()
will check to see if anything was allocated.

> +
> +		snd_soc_platform
> +
> +
> +************************************************************************/
> +#define PREALLOC_BUFFER		(32 * 1024)
> +#define PREALLOC_BUFFER_MAX	(32 * 1024)

Is it worth letting machines override these in the platform data or is
there no point?

> +	/* FSI is based on SPU mstp */
> +	snprintf(clk_name, sizeof(clk_name), "spu%d", pdev->id);
> +	master->clk = clk_get(&pdev->dev, clk_name);
> +	if (IS_ERR(master->clk)) {

Not an issue to fix in this driver but I'd expect that you shouldn't
need to do the print here - clk_get() should be using the struct device
it gets passed to pick up this information without the driver doing
anything.
