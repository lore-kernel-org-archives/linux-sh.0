From: Bastian Hecht <hechtb@googlemail.com>
Date: Tue, 14 Feb 2012 10:58:45 +0000
Subject: Re: [PATCH v2 0/7] SH Mobile sh_flctl driver brush up
Message-Id: <CABYn4sydNW_S=mivCOCd5RoxeW0T+Q-encFRUps2xYU0_H2GHg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1328960705-18699-1-git-send-email-hechtb@gmail.com>
 <1329140515.22240.145.camel@sauron.fi.intel.com>
 <20120214033810.GF21094@verge.net.au>
In-Reply-To: <20120214033810.GF21094@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, linux-mtd@lists.infradead.org, Laurent Pichart <laurent.pinchart@ideasonboard.com>, linux-sh@vger.kernel.org

Hello Artem,

2012/2/14 Simon Horman <horms@verge.net.au>:
> On Mon, Feb 13, 2012 at 03:41:55PM +0200, Artem Bityutskiy wrote:
>> On Sat, 2012-02-11 at 12:44 +0100, Bastian Hecht wrote:
>> > This patch series brushs up the sh_flctl.c a bit to make it work with
>> > the mackerel board. The hardware has changed and this needed to be
>> > reflected in the NAND host driver.
>> > On the road some minor enhancements have been incorporated.
>>
>> I cannot even compile-test this patch because I get the following error:
>>
>>
>> sh4-linux-gcc: error: command line option '-m4-nofpu' is not supported
>> by this configuration
>>
>>
>> with the cross-compiler downloaded from here:
>>
>> http://kernel.org/pub/tools/crosstool/files/bin/x86_64/4.6.0/x86_64-gcc-4.6.0-nolibc_sh4-linux.tar.bz2
>>
>> Could you please describe how could I compile-test it?
>
> You may find it easier to build a kernel for mackerel using
> arch arm and defconfig_mackerel.
>
> Personally I have had good experience using Code Sourcery (now part of
> Mentor Graphics?) G++ lite to compile both arm and sh kernels.
>
>

I as well use a Code Sourcery toolchain. arm-none-linux-gnueabi-gcc -v
states "gcc version 4.4.1 (Sourcery G++ Lite 2010q1-202)". It took me
quite a bit to find a link to the toolchain as these gpl toolchains
from Code Sourcery almost seem to be hidden. But here it is if you
want to give it a try:

http://www.codesourcery.com/sgpp/lite/arm/portal/package6488/public/arm-none-linux-gnueabi/arm-2010q1-202-arm-none-linux-gnueabi-i686-pc-linux-gnu.tar.bz2

I very appreciate that you take a look at the patches - I really hope
them to be merged.

thanks,

 Bastian
