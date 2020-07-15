From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 15 Jul 2020 08:11:54 +0000
Subject: Re: ioremap and dma cleanups and fixes for superh (2nd resend)
Message-Id: <CAMuHMdW8RtJKk3u7RWQKP2tA3AYT2rB2aqhUT1KnJ4tJwWWKDA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200714121856.955680-1-hch@lst.de> <b0745e43-0ff1-58f7-70d5-60b9c8b8d81b@physik.fu-berlin.de>
 <20200714155914.GA24404@brightrain.aerifal.cx> <8cbf2963-d0e4-0ca8-4ffe-c2057694447f@physik.fu-berlin.de>
 <011f29e6-ad71-366e-dbff-bc8471f3da60@physik.fu-berlin.de>
 <CAMuHMdUre2-fRgLP8YiwjAKN6J=m1vGhPSMMUdpof7jPJfcWuw@mail.gmail.com>
 <def65208-a38b-8663-492a-cae150027003@physik.fu-berlin.de> <b5f1853e-031d-c09d-57d2-fb4baffa01ea@physik.fu-berlin.de>
In-Reply-To: <b5f1853e-031d-c09d-57d2-fb4baffa01ea@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Adrian,

On Wed, Jul 15, 2020 at 9:51 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 7/15/20 9:46 AM, John Paul Adrian Glaubitz wrote:
> > Indeed, it does. This patch should be picked up as well.
> >
> > Kernel boots without any errors now.
>
> Btw, booting with systemd as init causes a lot of hickups which I didn't see with 3.16:

> [   25.184000] BUG: Bad page state in process systemd-hiberna  pfn:5d91a

Lemme gues: does commit 002ae7057069538a ("mm, dump_page(): do not crash
with invalid mapping pointer") in v5.8-rc1 help?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
