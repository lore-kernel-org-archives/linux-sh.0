From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 19 Apr 2013 00:27:47 +0000
Subject: Re: [PATCH v2 0/9] Reorganize R8A7779/Marzen USB code
Message-Id: <87a9ov74ao.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201304090110.50154.sergei.shtylyov@cogentembedded.com>
 <87zjx89rfb.wl%kuninori.morimoto.gx@renesas.com>
 <51640D21.3090800@cogentembedded.com>
 <87txnfjhmu.wl%kuninori.morimoto.gx@renesas.com>
 <51689399.5090203@cogentembedded.com>
 <51689488.7040109@cogentembedded.com>
 <87mwsydklg.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mwsydklg.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


Hi Sergei

> > >>>      I'm going to post R8A7778/BOCK-W series following this one, and 
> > >>> all the
> > >>> patches in 1st series should additionally be tested on BOCK-W. Well, I
> > >>> probably can hold up posting version 3 until I have the second 
> > >>> series verified.
> > >>>      BTW, about R8A7778/BOCK-W, R-Car M1A user manual talks about a 
> > >>> ferrite
> > >>> bead in 49.4.1 (3) Setting USB-PHY. Do you know for sure if it's 
> > >>> used or not
> > >>> on BOCK-W board? PHY initialization seems to work with either 
> > >>> settings...
> > >> I can ask it to HW team if you want me.
> > 
> >     Yes, ask them please.
> 
> Now, I'm asking it to HW team
> Please wait

According to HW team,
this setting is for some kind of USB compliance test (?).
So, in general, we can use "No ferrite bead".

Best regards
---
Kuninori Morimoto
