From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 May 2016 08:05:02 +0000
Subject: Re: [PATCH v2 05/12] of: add J-Core SPI master bindings
Message-Id: <CAMuHMdV2FRhvRoP67WJNF5STyiQg5cvAEwTQBxsODjjhWwddLg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1463708766.git.dalias@libc.org>
	<32585cfb27d31e9d5cb399ecc4d8b89f4ec5e2cb.1463708766.git.dalias@libc.org>
In-Reply-To: <32585cfb27d31e9d5cb399ecc4d8b89f4ec5e2cb.1463708766.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>

On Fri, May 20, 2016 at 4:53 AM, Rich Felker <dalias@libc.org> wrote:
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/jcore,spi.txt
> @@ -0,0 +1,23 @@
> +Example:
> +
> +spi {

spi@40

> +       compatible = "jcore,spi2";
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +       reg = < 0x40 0x8 >;
> +       spi-max-frequency = <12500000>;
> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
