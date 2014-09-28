From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Sun, 28 Sep 2014 23:58:50 +0000
Subject: Re: [periperi] How to set default GPIO pin ?
Message-Id: <8738bb9u1a.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8738cc0vx9.wl%kuninori.morimoto.gx@gmail.com>
 <2862746.g5u9pdpKDi@avalon>
 <CACRpkdb1jF-ro3XcFHFC+Lhgi+0dEHzQYVSSLV6AWnAxiwNLdw@mail.gmail.com>
 <2033766.6tR9OHe7ZC@avalon>
In-Reply-To: <2033766.6tR9OHe7ZC@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


Hi Laurent, Linus

> > I have suggested adding GPIO hogs, so that a GPIO node can specify
> > that some GPIO's specified on the local ship be hogged high or
> > low at probe. Generic DT bindings and generic code in gpiolib.c.
> > 
> > gpios-hog-high = <....>;
> > gpios-hog-low = <....>;
> 
> How about just a gpios-hog property, with a list of gpio specifiers + flags ? 
> That's bikeshedding I suppose.
> 
> Morimoto-san, would you like to implement that ? :-)

Thank you for your help
OK, I try to implement this method (when I have time :)
Thank you

Best regards
---
Kuninori Morimoto
