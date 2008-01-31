From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 31 Jan 2008 23:57:00 +0000
Subject: Re: SH-Sci(f) driver as console
Message-Id: <20080131235700.GC16399@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1201776250.20171.72.camel@Atlas>
In-Reply-To: <1201776250.20171.72.camel@Atlas>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 31, 2008 at 06:09:58PM +0000, Kieran Bingham wrote:
> Urgh ... my head hurts from following this ENXIO error all the way
> through sys_open, through VFS / VT / TTY and down to Uart :P
> 
> I think I went the long way round :( silly me !
> 
Er, what? If you're getting in to userspace, you don't need to bother
with an early_sci_setup(). This is the regular case, which works for
every other CPU and board, suggesting that there's either something amiss
in the CPU setup, or your .config.

> Where is this supposed to be set up ? Is this because I've set my uart
> port up too early, and something has missed it ? or am I just missing
> something more fundamental ?

The early setup is just to allow you to bang some bytes down the line
early incase you happen to blow up before you get that far. Usually the
early printk suffices for this, so there's no need in general to hand the
port def off to early_sci_setup().

If you're doing all of this to work around the fact you can't open
/dev/console, you've been chasing the wrong problem :-)
