From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 02 Jun 2014 14:57:00 +0000
Subject: Re: [PATCH 18/18] [RFC] spi: rspi: Add DT support to DMA setup
Message-Id: <CAMuHMdXhduVy_xxTnUzhkQDd5pah8svpTyB1jahSCb1szR75kg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1401716301-29612-1-git-send-email-geert+renesas@glider.be>
	<1401716301-29612-19-git-send-email-geert+renesas@glider.be>
	<20140602145447.GJ31751@sirena.org.uk>
In-Reply-To: <20140602145447.GJ31751-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Mark,

On Mon, Jun 2, 2014 at 4:54 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Jun 02, 2014 at 03:38:20PM +0200, Geert Uytterhoeven wrote:
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: devicetree@vger.kernel.org
>> ---
>> The format of the DMA specifiers depends on the DT bindings for SHDMA,
>> which are still under development.
>
> This looks fine to me, can you resend when the DMA specifiers for the
> controller are resolved?  I've applied everything up to here, it all

Sure.

> looks good especially the performance improvement.

That was quick, thanks a lot!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
