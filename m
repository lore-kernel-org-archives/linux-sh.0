From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 08 Jun 2009 07:58:09 +0000
Subject: Re: Hi all,long silence from me
Message-Id: <aec7e5c30906080058j5e6b6ad3kf4241ec08f47a629@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <200906041501.25421.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <200906041501.25421.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Fabio,

On Fri, Jun 5, 2009 at 9:42 PM, Fabio
Giovagnini<fabio.giovagnini@aurion-tech.com> wrote:
> I have downloaded the source code from your website.
> I'm tring to build the toolchain step by step because I'd like to have the
> sh2a instruction set support but also the smallest size of applications; in
> fact I'm interested at this step to the toolchain for compiling my own
> application framework being not an OS at all. I'm not interested to run
> linux-sh at this step.
> So I'd like to build the toolchain with newlib support or at most uclibc
> support.
> Wher could I find the any docs regarding these aspectcs?
>
> Thanks a lot

I'm afraid that I have not seen any documentation in this area. You
are of course free to browse the source for the codesourcery/kpit/ST
tools and cherry pick patches, but I don't recommend it if you value
your time. =)

I spent a few days a year or two ago trying to cherry pick patches for
sh4al-dsp and integrate in buildroot and/or crosstool, and at that
point all I ended up with was a big mess. Things were far from good
upstream back then, hopefully it's better today.

Good luck! =)

/ magnus
