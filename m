From: phil.edworthy@renesas.com
Date: Thu, 24 Nov 2011 09:19:32 +0000
Subject: Re: sh-sci CTS problem
Message-Id: <OF63C852AE.944E027C-ON80257952.00320366-80257952.00330132@eu.necel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <OFB48B001D.3AA44CAE-ON80257950.0037E14A-80257950.0039B579@eu.necel.com>
In-Reply-To: <OFB48B001D.3AA44CAE-ON80257950.0037E14A-80257950.0039B579@eu.necel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,

> > Commit 4480a688 is a problem for some devices. For example, on the 
SH7203 
> > some serial ports have RTS/CTS, but others don't.
> > 
> > I guess the right thing to do is add an extra field to struct 
> > plat_sci_port to indicate support for RTS/CTS?
> > 
> Looking at the data sheets, I think we're probably going to have to do
> something like that, as well as overhaul sci_get/set_mctrl(). There are
> certainly fewer ports that actually support RTS/CTS in hardware than
> those that don't, so the mctrl information is more often than not
> completely bogus.
> 
> Could you elaborate what precisely you are encountering as a result of
> the CTS reporting on SH7203? It was initially added as a correctness
> fix to complement the existing RTS reporting, so it would be interesting
> to know what your use case is or what ill effects fell out as a result.

I am not sure if this actually causing any problems at all, this is 
probably a wild goose chase. I suspect that enabling RTS/CTS on ports that 
don't have these wired up won't change their behaviour.

I am trying to track down an issue with serial that has been around for a 
very long time. Actually this work is on SH7264 but the same issues are on 
at least SH7201 and SH7203 devices. Receiving data over serial often fails 
with framing and overrun errors. I fixed a few things locally, such as the 
multiplexed isr doesn't check that the interrupt source was an overrun, 
and the overrun handling needs some tweaking. However these are just 
addressing the symptoms, not the cause.

Phil
