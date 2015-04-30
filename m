From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 30 Apr 2015 14:18:04 +0000
Subject: Re: [PATCH 03/11] ARM: shmobile: add r8a7793 SoC device tree
Message-Id: <CAO3366zNMZgguxWKqs8uHJT3RhKC8Jz9Dei_q1_kbHGU7yhrRA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1425661798-10487-4-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1425661798-10487-4-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Mar 8, 2015 at 10:59 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Fri, Mar 6, 2015 at 6:09 PM, Ulrich Hecht
> <ulrich.hecht+renesas@gmail.com> wrote:
>> r8a7793 device tree including clock descriptions.
>
> Thanks for your patch!

And thanks for your review.

> I gave a few comments below, mostly by comparing with r8a7791.dtsi.
> As r8a7793 is very similar to r8a7791 (does anyone compiled a list of the
> differences?), perhaps it's best to just start from a copy of upstream
> r8a7791.dtsi and r8a7791-clock.h?

At least for the dtsi file, the result would be largely identical to
what we already have here, even if that was not intended from the
outset.  The diff gets a bit larger around the clocks section because
I reformatted some excessively long lines.

CU
Uli
