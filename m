From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 15 Jul 2020 14:37:14 +0000
Subject: Re: ioremap and dma cleanups and fixes for superh (2nd resend)
Message-Id: <0322def7-fc16-c805-8f2b-c88fffce2f1e@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200714121856.955680-1-hch@lst.de>
 <b0745e43-0ff1-58f7-70d5-60b9c8b8d81b@physik.fu-berlin.de>
 <20200714155914.GA24404@brightrain.aerifal.cx>
 <8cbf2963-d0e4-0ca8-4ffe-c2057694447f@physik.fu-berlin.de>
 <011f29e6-ad71-366e-dbff-bc8471f3da60@physik.fu-berlin.de>
 <CAMuHMdUre2-fRgLP8YiwjAKN6J=m1vGhPSMMUdpof7jPJfcWuw@mail.gmail.com>
 <def65208-a38b-8663-492a-cae150027003@physik.fu-berlin.de>
 <b5f1853e-031d-c09d-57d2-fb4baffa01ea@physik.fu-berlin.de>
 <CAMuHMdW8RtJKk3u7RWQKP2tA3AYT2rB2aqhUT1KnJ4tJwWWKDA@mail.gmail.com>
 <b5cd845f-7b5e-af8e-a15d-3ede7e61ced4@physik.fu-berlin.de>
In-Reply-To: <b5cd845f-7b5e-af8e-a15d-3ede7e61ced4@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Geert!

On 7/15/20 10:27 AM, John Paul Adrian Glaubitz wrote:
>> Lemme gues: does commit 002ae7057069538a ("mm, dump_page(): do not crash
>> with invalid mapping pointer") in v5.8-rc1 help?
> 
> Hmm, it seems I already have that patch (I'm using Linus' main tree):
> 
> commit 002ae7057069538aa3afd500f6f60a429cb948b2
> Author: Vlastimil Babka <vbabka@suse.cz>
> Date:   Mon Jun 1 21:46:03 2020 -0700
> 
>     mm, dump_page(): do not crash with invalid mapping pointer

Okay, kernel 5.0.0 does not suffer from this bug. So I should be able to bisect
this particular issue.

I'm glad I don't have to start bisecting with earlier kernels because these
won't build easily with my current toolchain based on gcc-9.

Will report once I found the bad commit that introduced the problem.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
