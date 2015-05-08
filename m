From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 08 May 2015 21:40:42 +0000
Subject: Re: [RFC] i2c-tools: i2ctransfer: add new tool
Message-Id: <20150508234042.26708f86@endymion.delvare>
List-Id: <linux-sh.vger.kernel.org>
References: <1425053816-19804-1-git-send-email-wsa@the-dreams.de>
	<20150507220812.3776bb83@endymion.delvare>
	<20150508105401.223a8598@endymion.delvare>
	<20150508143826.GA1513@katana>
In-Reply-To: <20150508143826.GA1513@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi Wolfram,

On Fri, 8 May 2015 16:38:26 +0200, Wolfram Sang wrote:
> > Having slept over it, I came up with a 3rd proposal:
> > 
> > # i2ctransfer 0 w0x11@0x50 0xc0 0xbd= r1@0x51
> > 
> > That is, combining the slave address, direction and length into a
> > single parameter. The advantage is that this is all more explicit and
> > the risk of mixing up values is close to zero. Whether it is more or
> > less readable than the previous proposals is probably a matter of
> > taste. Also I suspect it would make the parsing and state machine more
> > simple, but that's only a nice side effect.
> > 
> > Wolfram (and others), please tell me what you think. I am not trying to
> > force my views here, just suggesting alternatives for your
> > consideration.
> 
> I liked your proposal, so thanks for this input. I agree that the risk
> of mixing something up is high, I was okay with the printout of the
> messages to be sent, but a better syntax is very welcome, too. I need to
> think about the flags a little bit, though. Although this isn't
> implemented yet, PEC and 10-bit flags might be added in the future?

This is a good point, we need to think about it. Maybe not PEC, as
normally any PEC-enabled transaction would be handled by the other
tools already. And I don't think the kernel can handle PEC over ioctl
I2C_RDWR anyway. But 10-bit addresses, we already had a request to
support than and your new tool would be perfect for that.

One easy way would be to assume that the transaction either targets one
or more 10-bit addressed chips, or one or more 7-bit addressed chips,
but doesn't mix. In that case a simple flag (say -t) in front of the
transaction will do the trick. I'd think it is sufficient, and I even
suspect that some controllers may only support that, but OTOH I never
worked with 10-bit addressed chips so I can't really tell.

If you think it's not enough, then the address modifier could go
separately before or after the address byte, i.e. either r1@0x123t or
r1@t0x123. I suspect that the latter should be easier to implement.

> Handling R/W as "just another" flag made this option extremly simple.
> But we probably can work something out.

I think the proposal above makes more sense than grouping it with the
direction letter (r or w) even though it's also a letter, as it's
really an address modifier, which affects neither the direction nor the
length. But again it's really only a suggestion, if you can come up
with something clearer and/or easier to implement, please do.

> So much for the quick response, I'll have a closer look later.

I wouldn't call it "quick" ;-) but you're welcome.

-- 
Jean Delvare
SUSE L3 Support
