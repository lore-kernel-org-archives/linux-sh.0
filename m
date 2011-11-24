From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 24 Nov 2011 09:03:08 +0000
Subject: Re: sh-sci CTS problem
Message-Id: <20111124090308.GA11698@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <OFB48B001D.3AA44CAE-ON80257950.0037E14A-80257950.0039B579@eu.necel.com>
In-Reply-To: <OFB48B001D.3AA44CAE-ON80257950.0037E14A-80257950.0039B579@eu.necel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Nov 22, 2011 at 10:32:41AM +0000, phil.edworthy@renesas.com wrote:
> Hi Yoshii-san, Paul,
> 
> Commit 4480a688 is a problem for some devices. For example, on the SH7203 
> some serial ports have RTS/CTS, but others don't.
> 
> I guess the right thing to do is add an extra field to struct 
> plat_sci_port to indicate support for RTS/CTS?
> 
Looking at the data sheets, I think we're probably going to have to do
something like that, as well as overhaul sci_get/set_mctrl(). There are
certainly fewer ports that actually support RTS/CTS in hardware than
those that don't, so the mctrl information is more often than not
completely bogus.

Could you elaborate what precisely you are encountering as a result of
the CTS reporting on SH7203? It was initially added as a correctness
fix to complement the existing RTS reporting, so it would be interesting
to know what your use case is or what ill effects fell out as a result.
