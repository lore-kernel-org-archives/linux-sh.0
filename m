From: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
Date: Fri, 25 Nov 2011 05:07:47 +0000
Subject: Re: sh-sci CTS problem
Message-Id: <4ECF22A3.2000803@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <OFB48B001D.3AA44CAE-ON80257950.0037E14A-80257950.0039B579@eu.necel.com>
In-Reply-To: <OFB48B001D.3AA44CAE-ON80257950.0037E14A-80257950.0039B579@eu.necel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

> I guess the right thing to do is add an extra field to struct 
> plat_sci_port to indicate support for RTS/CTS?

Right. I guess each real pin manipulation will be handled like sci_init_pins().
On the other hand, I don't think there is much things to do here for channels
that does *not* support control lines. get_mctrl() does not provide the function
to tell "not supported" condition anyway.

I think that should be implemented in sci_set_termios().
Currently, it sets SCFCR.MCE regardless of the HW function, and does not
fix any bits in c_flags. We can negate CRTSCTS in termios->c_cflag there,
unless (s->cfg->flags & UPF_xx) or something.
Does anyone know good flags or constant definitions?
/yoshii


