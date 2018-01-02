From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 02 Jan 2018 10:49:48 +0000
Subject: Re: Build regressions/improvements in v4.15-rc6
Message-Id: <CAMuHMdXEoMH1=yWSnmDkqiZEyaBeR+DOfzVPvhmAgU2kp2zRRw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1514890072-16256-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1514890072-16256-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>

On Tue, Jan 2, 2018 at 11:47 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.15-rc6[1] to v4.15-rc5[3], the summaries are:
>   - build errors: +1/-2

  + {standard input}: Error: unknown opcode:  => 4554, 3363, 2025,
1819, 788, 2605, 2035, 6420, 4224, 1442, 3788, 768, 144, 3386, 2702,
6299, 3263, 1403, 4629, 1777, 4616, 301, 464, 9439, 7321, 2938, 721,
4287, 1032, 1984, 5457, 2796, 3891, 448, 8820, 7236, 7554, 4308, 273,
70, 12519, 4236, 9328, 2876, 1307, 5332, 2254, 3913, 9489, 2337, 7557,
1027, 4275, 4443, 4444, 6426, 6443, 8558, 11347, 14301, 6223, 9815,
4327, 1329, 6096, 4571, 2099, 7573, 4034, 1458, 8141, 7666, 41, 5299,
2863, 4566, 2853, 537, 7540, 6514, 5143, 4535, 2994, 1328, 2599, 5271,
2714, 4172, 6621, 8955, 4617, 11573, 6478, 1469, 5160, 9075, 7523,
3207, 1362, 1486, 527, 3007, 3636, 5323, 5272, 774, 21710, 6006, 4710,
3621, 4556, 1545, 1717, 2493, 4578, 8289, 5020, 1404, 4193, 1515,
11241, 604, 6572, 6181, 46, 1230, 14340, 5509, 4514, 2074, 4607, 379,
2716, 1150, 12022, 6053, 866, 10521, 5285, 549, 2239, 1933, 2918,
2193, 9420

sh4/sh-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/30a7acd573899fd8b8ac39236eff6468b195ac7d/ (all 270 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/464e1d5f23cca236b930ef068c328a64cab78fb1/ (all 270 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
