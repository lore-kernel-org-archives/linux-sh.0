From: Andrew Lunn <andrew@lunn.ch>
Date: Mon, 01 Sep 2014 13:34:12 +0000
Subject: Re: [PATCHv1 1/7] ASoC: simple-card: Merge single and muti DAI link code.
Message-Id: <20140901133412.GA11312@lunn.ch>
List-Id: <linux-sh.vger.kernel.org>
References: <1409545781-20530-1-git-send-email-Li.Xiubo@freescale.com>
 <1409545781-20530-2-git-send-email-Li.Xiubo@freescale.com>
In-Reply-To: <1409545781-20530-2-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, kuninori.morimoto.gx@renesas.com, moinejf@free.fr, andrew@lunn.ch, jsarha@ti.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, alsa-devel@alsa-project.org, shawn.guo@freescale.com, linux-kernel@vger.kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>

On Mon, Sep 01, 2014 at 12:29:35PM +0800, Xiubo Li wrote:
> This patch merge single DAI link and muti-DAI links code together,
> and simply the simple-card driver code.

Hi Xiubo

It would be good to note that this breaks the Binary API with DT
blobs. Old blobs will not work with this new C code.

> And also do some other improvement:

It would be good to put these improvements into separate patches,
making them easier to review.

> +==
> +DAI link node(s) and its or their subnodes:
>  
> -Required dai-link subnodes:
> +There must be one DAI link node exsit at least, and each DAI link must

typ0. It would also be better to say:

There must be at least one DAI link, and each DAI link must

> +contain one CPU subnode and one CODEC subnode.

  Andrew
