From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 02 Dec 2013 01:32:37 +0000
Subject: Re: [PATCH 3/4] ARM: shmobile: r8a7790: add I2C support
Message-Id: <87iov8ca19.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87li0752rz.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87li0752rz.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent

> > @@ -76,6 +97,10 @@ void __init r8a7790_pinmux_init(void)
> >  	r8a7790_register_gpio(3);
> >  	r8a7790_register_gpio(4);
> >  	r8a7790_register_gpio(5);
> > +	r8a7790_register_i2c(0);
> > +	r8a7790_register_i2c(1);
> > +	r8a7790_register_i2c(2);
> > +	r8a7790_register_i2c(3);
> >  }
> 
> I might be wrong, but I believe we have been requested to add new devices 
> directly to the board-*.c files, not to the setup-*.c files.

It depends on device.
I2C host doesn't request board/platform information,
so, setup-xxxx.c is fine.
Please check other setup-xxx.c


Best regards
---
Kuninori Morimoto
