From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Mon, 25 Jan 2010 13:21:03 +0000
Subject: Re: [PATCH 2b/4 v2] ASoC: add support for the sh7722 Migo-R board
Message-Id: <20100125132102.GA26613@rakim.wolfsonmicro.main>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1001190839110.4607@axis700.grange>
 <Pine.LNX.4.64.1001190902000.4607@axis700.grange>
 <Pine.LNX.4.64.1001221909050.4652@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1001221909050.4652@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Magnus Damm <damm@opensource.se>

On Fri, Jan 22, 2010 at 07:17:09PM +0100, Guennadi Liakhovetski wrote:
> Add support for audio on sh7722-based Migo-R boards, using SIU and wm8978 
> codec, recording via external microphone and playback via headphones are 
> implemented.

> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

This is fine for me but can't be applied yet due to the CODEC driver
dependency.
