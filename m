From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Sun, 19 Sep 2010 15:04:48 +0000
Subject: Re: [PATCH 1/5] ASoC: fix compile breakage of the sh/siu driver
Message-Id: <20100919150448.GB18789@opensource.wolfsonmicro.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1009171211580.4988@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1009171211580.4988@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Sep 17, 2010 at 12:29:46PM +0200, Guennadi Liakhovetski wrote:
> The sh/siu ASoC driver doesn't compile because of a function defined static in
> the source and extern in a header. Remove the unneeded declaration in the
> header.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Applied, thanks.
