From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Date: Tue, 02 Sep 2014 09:08:05 +0000
Subject: RE: [PATCHv1 4/7] ASoC: dts: kirkwood-t5325: To support simple card newest style.
Message-Id: <e58337783d164e8da966938b27825cda@BY2PR0301MB0613.namprd03.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1409545781-20530-1-git-send-email-Li.Xiubo@freescale.com>
 <1409545781-20530-5-git-send-email-Li.Xiubo@freescale.com>
 <20140901134148.GB11312@lunn.ch>
In-Reply-To: <20140901134148.GB11312-g2DYL2Zd6BY@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Cc: "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "perex-/Fr2/VpizcU@public.gmane.org" <perex-/Fr2/VpizcU@public.gmane.org>, "tiwai-l3A5Bk7waGM@public.gmane.org" <tiwai-l3A5Bk7waGM@public.gmane.org>, "kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org" <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, "moinejf-GANU6spQydw@public.gmane.org" <moinejf-GANU6spQydw@public.gmane.org>, "jsarha-l0cyMroinI0@public.gmane.org" <jsarha-l0cyMroinI0@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Shawn Guo <Shawn.Guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>

Hi Andrew,

Thanks very much for you comment and advice.

I will resend this patch series to compatibility with the old DTs, and it will
Up to the owners to update the DTs to support the new style of DTs.

BRs
Xiubo




> -----Original Message-----
> From: Andrew Lunn [mailto:andrew@lunn.ch]
> Sent: Monday, September 01, 2014 9:42 PM
> To: Xiubo Li-B47053
> Cc: broonie@kernel.org; lgirdwood@gmail.com; perex@perex.cz; tiwai@suse.de;
> kuninori.morimoto.gx@renesas.com; moinejf@free.fr; andrew@lunn.ch;
> jsarha@ti.com; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-sh@vger.kernel.org; alsa-devel@alsa-
> project.org; Guo Shawn-R65073; linux-kernel@vger.kernel.org; Jason Cooper
> Subject: Re: [PATCHv1 4/7] ASoC: dts: kirkwood-t5325: To support simple card
> newest style.
> 
> On Mon, Sep 01, 2014 at 12:29:38PM +0800, Xiubo Li wrote:
> > This patch depends on the following simple card patch:
> > => > ASoC: simple-card: Merge single and muti DAI link code.
> 
> Saying what a patch depends on, is not the best of ChangeLog.
> 
> Say something like:
> 
> The simple-card binding has been changed, so that a dai-link subnode
> is now required, and the properties directly under the sound node are
> no longer allowed. Modify the DT to fit this new binding.
> 
>    Andrew
> 
> 
> >
> > This patch merge single DAI link and muti-DAI links code together,
> > and simply the simple-card driver code.
> >
> > And also do some other improvement:
> >
> > Since from the DAI format micro SND_SOC_DAIFMT_CBx_CFx, the 'CBx'
> > mean Codec's bit clock is as master/slave and the 'CFx' mean Codec's
> > frame clock is as master/slave.
> >
> > So these same DAI formats should be informed to CPU and CODE DAIs at
> > the same time. For the Codec driver will set the bit clock and frame
> > clock as the DAI formats said, but for the CPU driver, if the the
> > bit clock or frame clock is as Codec master, so it should be set CPU
> > DAI device as bit clock or frame clock as slave, and vice versa.
> >
> > The old code will cause confusion, and we should be clear that the
> > letter 'C' here mean to Codec.
> > => >
> > Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> > ---
> >  arch/arm/boot/dts/kirkwood-t5325.dts | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/kirkwood-t5325.dts
> b/arch/arm/boot/dts/kirkwood-t5325.dts
> > index 610ec0f..25d1223 100644
> > --- a/arch/arm/boot/dts/kirkwood-t5325.dts
> > +++ b/arch/arm/boot/dts/kirkwood-t5325.dts
> > @@ -189,7 +189,6 @@
> >
> >  	sound {
> >  		compatible = "simple-audio-card";
> > -		simple-audio-card,format = "i2s";
> >  		simple-audio-card,routing > >  			"Headphone Jack", "HPL",
> >  			"Headphone Jack", "HPR",
> > @@ -204,12 +203,14 @@
> >
> >  		simple-audio-card,mclk-fs = <256>;
> >
> > -		simple-audio-card,cpu {
> > -			sound-dai = <&audio>;
> > -		};
> > -
> > -		simple-audio-card,codec {
> > -			sound-dai = <&alc5621>;
> > +		simple-audio-card,dai-link {
> > +			format = "i2s";
> > +			cpu {
> > +				sound-dai = <&audio>;
> > +			};
> > +			codec {
> > +				sound-dai = <&alc5621>;
> > +			};
> >  		};
> >  	};
> >  };
> > --
> > 1.8.4
> >
