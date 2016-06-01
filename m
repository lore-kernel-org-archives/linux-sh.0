From: Rich Felker <dalias@libc.org>
Date: Wed, 01 Jun 2016 22:28:09 +0000
Subject: Re: Build regressions/improvements in v4.7-rc1
Message-Id: <20160601222809.GG10893@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <1464593333-10283-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdVvK9h2MLVAeB3n8G6hfKJU1Rma2_uVYBTqsFxnRv2YsA@mail.gmail.com>
 <20160601221801.GF10893@brightrain.aerifal.cx>
In-Reply-To: <20160601221801.GF10893@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Wed, Jun 01, 2016 at 06:18:02PM -0400, Rich Felker wrote:
> On Mon, May 30, 2016 at 09:34:07AM +0200, Geert Uytterhoeven wrote:
> > >   + /home/kisskb/slave/src/arch/sh/kernel/setup.c: error: implicit declaration of function 'early_init_dt_scan' [-Werror=implicit-function-declaration]:  => 256:2
> > 
> > sh-randconfig
> 
> Nice find. I think I'm incorrectly checking for CONFIG_OF in places
> that should actually be checking for CONFIG_OF_FLATTREE. Does that
> look right to you? Nothing breaks in actual configurations that make
> sense now, only if you enable OF manually without selecting
> SH_DEVICE_TREE as your board.
> 
> If you can confirm that my assessment is correct I'll include a fix in
> my (now-late) pull request.

BTW it seems a bigger version of the same issue affects my J2 support
patch series: CONFIG_CPU_J2 enables code that performs an early FDT
scan to obtain cache information, so it needs to select OF and
OF_FLATTREE to avoid build errors. Eventually none of this will matter
once we drop legacy support and make it so SUPERH implies OF and
OF_EARLY_FLATTREE.

Rich
