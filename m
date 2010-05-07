From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 07 May 2010 09:54:37 +0000
Subject: Re: [PATCH] sh: fix the id of scif in SH7757
Message-Id: <20100507095437.GF14009@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4BE3DB0C.3020006@renesas.com>
In-Reply-To: <4BE3DB0C.3020006@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, May 07, 2010 at 06:50:48PM +0900, Yoshihiro Shimoda wrote:
> Paul Mundt wrote:
> > On Fri, May 07, 2010 at 06:19:08PM +0900, Yoshihiro Shimoda wrote:
> >> Because the value of CONFIG_SERIAL_SH_SCI_NR_UARTS is 3.
> >>
> >> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > 
> > If there are only 3 devices, then why do we have them named scif2, scif3,
> > and scif4? Presumably there used to be a scif0 and scif1?
> 
> Yes, this cpu also has scif0 and scif1.
> But those scif is only named "SCIF0" and "SCIF1".
> Actually those functions are 16550 based serial port.
> 
If the 16550 based UARTs have been named SCIF0 and SCIF1 that really
doesn't bode well for the rest of the CPU..

I'll apply it, thanks for the clarification.
