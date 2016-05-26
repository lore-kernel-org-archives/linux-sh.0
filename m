From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 May 2016 07:54:55 +0000
Subject: Re: [PATCH v3 02/12] of: add J-Core cpu bindings
Message-Id: <CAMuHMdX8whtu0Dfd6598xN6wWsk-s6UPWBhDm-RcaRZp88adYw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1464148904.git.dalias@libc.org>
	<39ad5c69533ef537e6ab0426efc057f9064ee581.1464148904.git.dalias@libc.org>
	<20160525102214.GF1337@leverpostej>
	<20160525230407.GT21636@brightrain.aerifal.cx>
In-Reply-To: <20160525230407.GT21636@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>

Hi Rich,

On Thu, May 26, 2016 at 1:04 AM, Rich Felker <dalias@libc.org> wrote:
> If you really do want a lot more detail for SMP-related bindings, I
> could consider submitting a version with SMP omitted for now (since
> the kernel patches submitted at this point don't include SMP) and do
> the addition of SMP as a separate patch later. But with the launch of
> open-hardware boards capable of running SMP J2 systems (see
> https://twitter.com/jcoreeng/status/730330848306700288) near, I'd like
> to be getting bindings we can use stabilized so that we're properly
> including DTB in the boot rom and not relying on external DTB files or
> linking DTB in kernel.

Submitting a version now without SMP is indeed a good idea, and allows
to move forward.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
