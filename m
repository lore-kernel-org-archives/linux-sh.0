From: Simon Horman <horms@verge.net.au>
Date: Wed, 12 Nov 2014 09:05:48 +0000
Subject: Re: [PATCH 1/5] ARM: shmobile: kzm9g legacy: Set i2c clks_per_count to 2
Message-Id: <20141112090548.GZ9007@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1415274730-310-1-git-send-email-geert+renesas@glider.be>
 <1415274730-310-2-git-send-email-geert+renesas@glider.be>
 <20141107052420.GA1278@katana>
 <20141112014450.GC11597@verge.net.au>
 <CAMuHMdUUspG8-dYGiO7cmuECBLpfmQAYg=B8ZpajxRXhaEUJ2A@mail.gmail.com>
 <CAMuHMdXoiX6CreDJNaDHcmsifX0C+TRRvTy4JWYBc2c-MVT_Qw@mail.gmail.com>
In-Reply-To: <CAMuHMdXoiX6CreDJNaDHcmsifX0C+TRRvTy4JWYBc2c-MVT_Qw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Wed, Nov 12, 2014 at 09:55:58AM +0100, Geert Uytterhoeven wrote:
> On Wed, Nov 12, 2014 at 9:53 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> >>   i2c_shmobile support.") in v2.6.37.
> >>
> >>   Without this fix i2c may not operate correctly on the sh73a0/kzm9g.
> >
> > Thanks, that's correct.
> 
> git tag --contains b028f94b76319e1b8 says v2.6.38.
> 
> Not that you're gonna backport it to ltsi-v2.6.37 ;-)

Hopefully not!

I'll update my description anyway.
