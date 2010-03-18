From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 18 Mar 2010 11:33:45 +0000
Subject: Re: [alsa-devel] [PATCH] ASoC: SIU driver shall select FW_LOADER
Message-Id: <20100318113345.GF3080@opensource.wolfsonmicro.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1003180916590.4485@axis700.grange>
 <1268902865.3773.15.camel@odin>
In-Reply-To: <1268902865.3773.15.camel@odin>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, alsa-devel@alsa-project.org, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Thu, Mar 18, 2010 at 09:01:05AM +0000, Liam Girdwood wrote:
> On Thu, 2010-03-18 at 09:39 +0100, Guennadi Liakhovetski wrote:
> > The SIU ASoC driver must load firmware to program the DSP, therefore it 
> > has to select FW_LOADER in its Kconfig entry.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

Applied for 2.6.34, but note that unless Kconfig has been improved
this'll get ignored.
