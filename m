From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 17 Dec 2014 07:57:31 +0000
Subject: Re: Armadillo boot failures
Message-Id: <CAMuHMdXUTQ-+DXqXDJ67EWxWhyCL6keuR12f3dxEjqqFb-8bKA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdV-vMxObnaDXv84vq=qNf1NForN0LL1SkrzLxoxiMDSGQ@mail.gmail.com>
In-Reply-To: <CAMuHMdV-vMxObnaDXv84vq=qNf1NForN0LL1SkrzLxoxiMDSGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Dec 16, 2014 at 4:12 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> --- /tmp/armadillo.dtb.good 2014-12-16 15:23:02.075461856 +0100
> +++ /tmp/armadillo.dtb.bad1 2014-12-16 16:03:43.027456464 +0100
> @@ -336,8 +336,8 @@
>  000014f0  00 00 00 03 00 00 00 04  00 00 00 88 00 03 d0 90  |................|
>  00001500  00 00 00 03 00 00 00 04  00 00 00 95 00 03 d0 90  |................|
>  00001510  00 00 00 03 00 00 00 09  00 00 01 d5 64 69 73 61  |............disa|
> -00001520  62 6c 65 64 00 00 00 00  00 00 00 02 00 00 00 01  |bled............|
> -00001530  73 65 72 69 61 6c 40 65  36 63 38 30 30 30 30 00  |serial@e6c80000.|
> +00001520  e8 a5 54 c0 b0 65 66 06  0d c0 a0 e1 f0 d8 2d e9  |..T..ef.......-.|
> +00001530  04 b0 4c e2 a6 6f 80 e2  00 40 a0 e1 06 00 a0 e1  |..L..o...@......|
>  00001540  00 00 00 03 00 00 00 24  00 00 00 1b 72 65 6e 65  |.......$....rene|
>  00001550  73 61 73 2c 73 63 69 66  61 2d 72 38 61 37 37 34  |sas,scifa-r8a774|
>  00001560  30 00 72 65 6e 65 73 61  73 2c 73 63 69 66 61 00  |0.renesas,scifa.|
> @@ -914,8 +914,8 @@
>  00003910  00 00 00 03 00 00 00 0c  00 00 03 d7 00 00 00 0f  |................|
>  00003920  00 00 00 4b 00 00 00 00  00 00 00 03 00 00 00 00  |...K............|
>  00003930  00 00 03 dc 00 00 00 03  00 00 00 04 00 00 01 58  |...............X|
> -00003940  00 00 00 18 00 00 00 03  00 00 00 04 00 00 01 5e  |...............^|
> -00003950  00 00 00 18 00 00 00 02  00 00 00 01 72 65 67 75  |............regu|
> +00003940  50 f0 ff eb 07 00 a0 e1  24 d0 4b e2 f0 ab 9d e8  |P.......$.K.....|
> +00003950  2f 30 4c c0 59 17 b7 d1  e8 a5 54 c0 b0 65 66 06  |/0L.Y.....T..ef.|

0x3940 - 0x1520 = 0x2420

> --- /tmp/armadillo.dtb.good 2014-12-16 15:23:02.075461856 +0100
> +++ /tmp/armadillo.dtb.bad4 2014-12-16 15:17:14.339462624 +0100
> @@ -323,8 +323,8 @@
>  00001420  00 00 00 04 00 00 00 95  00 03 d0 90 00 00 00 03  |................|
>  00001430  00 00 00 09 00 00 01 d5  64 69 73 61 62 6c 65 64  |........disabled|
>  00001440  00 00 00 00 00 00 00 02  00 00 00 01 73 65 72 69  |............seri|
> -00001450  61 6c 40 65 36 63 37 30  30 30 30 00 00 00 00 03  |al@e6c70000.....|
> -00001460  00 00 00 24 00 00 00 1b  72 65 6e 65 73 61 73 2c  |...$....renesas,|
> +00001450  e8 a5 54 c0 b0 65 66 06  0d c0 a0 e1 f0 d8 2d e9  |..T..ef.......-.|
> +00001460  04 b0 4c e2 a6 6f 80 e2  00 40 a0 e1 06 00 a0 e1  |..L..o...@......|
>  00001470  73 63 69 66 61 2d 72 38  61 37 37 34 30 00 72 65  |scifa-r8a7740.re|
>  00001480  6e 65 73 61 73 2c 73 63  69 66 61 00 00 00 00 03  |nesas,scifa.....|
>  00001490  00 00 00 08 00 00 00 66  e6 c7 00 00 00 00 01 00  |.......f........|
> @@ -901,8 +901,8 @@
>  00003840  00 00 03 72 66 69 78 65  64 2d 33 2e 33 56 00 00  |...rfixed-3.3V..|
>  00003850  00 00 00 03 00 00 00 04  00 00 03 81 00 32 5a a0  |.............2Z.|
>  00003860  00 00 00 03 00 00 00 04  00 00 03 99 00 32 5a a0  |.............2Z.|
> -00003870  00 00 00 03 00 00 00 00  00 00 03 b1 00 00 00 03  |................|
> -00003880  00 00 00 00 00 00 03 c5  00 00 00 03 00 00 00 04  |................|
> +00003870  50 f0 ff eb 07 00 a0 e1  24 d0 4b e2 f0 ab 9d e8  |P.......$.K.....|
> +00003880  b3 30 4c c0 59 17 b7 d1  e8 a5 54 c0 b0 65 66 06  |.0L.Y.....T..ef.|

0x3870 - 0x1450 = 0x2420, too

And the corrupted data is identical, too...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
