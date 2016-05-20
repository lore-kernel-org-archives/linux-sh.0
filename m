From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 May 2016 08:03:16 +0000
Subject: Re: [PATCH v2 04/12] of: add J-Core timer bindings
Message-Id: <CAMuHMdUDy7A6On1emuuu5vndJWBRECBspZNiY_-xfgn+AO+_nw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1463708766.git.dalias@libc.org>
	<3460e061e18c6355407b585a8394b8da8cbd9fc8.1463708766.git.dalias@libc.org>
In-Reply-To: <3460e061e18c6355407b585a8394b8da8cbd9fc8.1463708766.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>

On Fri, May 20, 2016 at 4:53 AM, Rich Felker <dalias@libc.org> wrote:
> +++ b/Documentation/devicetree/bindings/timer/jcore,pit.txt
> @@ -0,0 +1,28 @@

> +Example:
> +
> +timer {

timer@200

> +       compatible = "jcore,pit";
> +       reg = < 0x200 0x30 >;
> +       cpu-offset = < 0x300 >;
> +       interrupts = < 0x48 >;
> +};

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
