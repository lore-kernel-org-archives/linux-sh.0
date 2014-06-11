From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 11 Jun 2014 08:30:40 +0000
Subject: Re: [alsa-devel] "ak" vs "asahi-kasei" (was: Re: [PATCH 3/3 v3] ARM: shmobile: lager: add sound supp
Message-Id: <87ioo7c0g5.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdWTVBjFzA9L9Eqpq_2Xi9_NHkOCLrb_UjK611SBfwnc=Q@mail.gmail.com>
In-Reply-To: <CAMuHMdWTVBjFzA9L9Eqpq_2Xi9_NHkOCLrb_UjK611SBfwnc=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus <magnus.damm@gmail.com>, Simon <horms@verge.net.au>, Ben Dooks <ben.dooks@codethink.co.uk>


Hi Geert

> > grep asahi-kasei sound/soc/codecs/*
> > sound/soc/codecs/ak4104.c:      { .compatible = "asahi-kasei,ak4104", },
> > sound/soc/codecs/ak4554.c:      { .compatible = "asahi-kasei,ak4554" },
> > sound/soc/codecs/ak4642.c:      { .compatible = "asahi-kasei,ak4642",   .data = &ak4642_drvdata},
> > sound/soc/codecs/ak4642.c:      { .compatible = "asahi-kasei,ak4643",   .data = &ak4643_drvdata},
> > sound/soc/codecs/ak4642.c:      { .compatible = "asahi-kasei,ak4648",   .data = &ak4648_drvdata},
> > sound/soc/codecs/ak5386.c:      { .compatible = "asahi-kasei,ak5386", },
> >
> > ak4642 driver can't probe by "ak";
> 
> That's bad. And all but one of these match entries have been added
> _after_ the addition of "ak" to vendor-prefixes.txt...
> 
> Outside sound, there's also "asahi-kasei,ak8975" vs. "ak,ak8975".

In my quick check,
The driver which is supporting "ak" is only ak8975.
Other Asahi-Kasei driver is using "asahi-kasei".

Very interesting is that the document of ak8975
./Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
said it should be "asahi-kasei"

what is the policy of Documentation/devicetree/bindings/vendor-prefixes.txt ?

-----------------------------------------------
grep compatible `find | grep ".*/ak"`
./arch/arm/boot/dts/aks-cdu.dts:                compatible = "gpio-leds";
./drivers/iio/magnetometer/ak8975.c:    { .compatible = "asahi-kasei,ak8975", },
./drivers/iio/magnetometer/ak8975.c:    { .compatible = "ak8975", },
./sound/soc/codecs/ak4104.c:    { .compatible = "asahi-kasei,ak4104", },
./sound/soc/codecs/ak5386.c:    { .compatible = "asahi-kasei,ak5386", },
./sound/soc/codecs/ak4554.c:    { .compatible = "asahi-kasei,ak4554" },
./sound/soc/codecs/ak4642.c:    { .compatible = "asahi-kasei,ak4642",   .data = &ak4642_drvdata},
./sound/soc/codecs/ak4642.c:    { .compatible = "asahi-kasei,ak4643",   .data = &ak4643_drvdata},
./sound/soc/codecs/ak4642.c:    { .compatible = "asahi-kasei,ak4648",   .data = &ak4648_drvdata},
./Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt:  - compatible : should be "asahi-kasei,ak8975"
./Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt:        compatible = "asahi-kasei,ak8975";
./Documentation/devicetree/bindings/sound/ak4642.txt:  - compatible : "asahi-kasei,ak4642" or "asahi-kasei,ak4643" or "asahi-kasei,ak4648"
./Documentation/devicetree/bindings/sound/ak4642.txt:           compatible = "asahi-kasei,ak4642";
./Documentation/devicetree/bindings/sound/ak5386.txt:  - compatible : "asahi-kasei,ak5386"
./Documentation/devicetree/bindings/sound/ak5386.txt:   compatible = "asahi-kasei,ak5386";
./Documentation/devicetree/bindings/sound/ak4104.txt:  - compatible : "asahi-kasei,ak4104"
./Documentation/devicetree/bindings/sound/ak4104.txt:   compatible = "asahi-kasei,ak4104";
./Documentation/devicetree/bindings/sound/ak4554.c:  - compatible : "asahi-kasei,ak4554"
./Documentation/devicetree/bindings/sound/ak4554.c:     compatible = "asahi-kasei,ak4554";
