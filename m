From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 07 Sep 2010 03:56:32 +0000
Subject: Re: [PATCH 2/4 v2] ASoC: Add sh_mobile_hdmi sound support
Message-Id: <w3p1v968avi.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p39tv72sx.wl%kuninori.morimoto.gx@renesas.com>
	<w3pwrr75o6d.wl%kuninori.morimoto.gx@renesas.com>
	<Pine.LNX.4.64.1009060932430.20387@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1009060932430.20387@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Paul Mundt <lethal@linux-sh.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>


Dear Guennadi

> > +		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
> 
> Again, this I am not sure about. The datasheet says 16 to 32 bit are 
> possible, but then I only see configuration for 16 to 24 bits, but in any 
> case, I think, you'd want to implement .hw_params to support non-default 
> formats.

Yes. .hw_params implementation is needed for advanced support.
I will send its patch in future.

>> +config SND_FSI_HDMI
>> +	bool "FSI-HDMI sound support"
>> +	depends on SND_SOC_SH4_FSI && FB_SH_MOBILE_HDMI
>> +	help
>> +	  This option enables generic sound support for the
>> +	  FSI - HDMI unit
(snip)
> With this config option you will have 3 SND_SOC_SH4_FSI implementations in 
>the Kconfig, all selectable independently. Do you really think it makes 
> sense and would work, if someone were to select more than one of those 
> options at the same time?

Yes. I created it for independently.
for example, you can select FSI-AK4642 and FSI-HDMI in same time.
If you select FSI-DA7210 and FSI-AK4642, small patch which change
FSIA <-> FSIB is needed for now.

>> +	switch (rate) {
>> +	case 48000:
>> +		clk_set_rate(clk, clk_round_rate(clk, 85428000));
>> +		__raw_writel(0x00070003, base + 0x8);
>
>Hm, these two registers seem to be a perfect candidate for the clock API?

? I think so. why ?

Best regards
--
Kuninori Morimoto
 
