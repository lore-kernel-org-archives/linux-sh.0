From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Fri, 17 Sep 2010 12:53:19 +0000
Subject: Re: [PATCH 3/5] ASoC: lowercase wm8978 codec name to match its
Message-Id: <20100917125319.GF4322@rakim.wolfsonmicro.main>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1009171129550.4988@axis700.grange>
 <Pine.LNX.4.64.1009171214281.4988@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1009171214281.4988@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>

On Fri, Sep 17, 2010 at 12:30:05PM +0200, Guennadi Liakhovetski wrote:
> All ASoC codecs are called in lower case, adjust wm8978 to match them and also
> to match its so far only user - the sh7722 migor board.

>  	.driver = {
> -		.name = "WM8978-codec",
> +		.name = "wm8978-codec",

Better yet would be to rename this to wm8978 (and adjust the board).
