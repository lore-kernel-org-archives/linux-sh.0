From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Wed, 19 Mar 2014 01:17:33 +0000
Subject: Re: [RFC] spi: Using Trigger number to transmit/receive data
Message-Id: <8738ifng0l.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1394699364-5669-1-git-send-email-cm-hiep@jinso.co.jp>
	<1394699364-5669-2-git-send-email-cm-hiep@jinso.co.jp>
	<CAMuHMdUpm_4f7LynObRA+NDn4vqeUc0a2XZW-E=4LKL_Ro3XZw@mail.gmail.com>
In-Reply-To: <CAMuHMdUpm_4f7LynObRA+NDn4vqeUc0a2XZW-E=4LKL_Ro3XZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Cao Minh Hiep <cm-hiep@jinso.co.jp>, Mark Brown <broonie@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Geert Uytterhoeven <geert+renesas@linux-m68k.org>


Hi Geert, Hiep

> > +static void qspi_update(const struct rspi_data *rspi, u8 mask, u8 val, u8 reg)
> > +{
> > +       u8 data;
> > +
> > +       data = rspi_read8(rspi, reg);
> > +       data &= ~mask;
> > +       data |= (val & mask);
> 
> I think this "& mask" is superfluous.

This "& mask" protects data from un-anticipative overwrite IMO.
Other driver is using same style.
ex) snd_soc_update_bits()

