From: Simon Horman <horms@verge.net.au>
Date: Tue, 13 May 2014 08:10:20 +0000
Subject: Re: [PATCH] ARM: shmobile: Use shmobile_init_late() on r8a7740
Message-Id: <20140513081019.GA10412@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140511231050.19908.86623.sendpatchset@w520>
 <CAMuHMdW4-r8khvk-hJcx1OXqwT0nGsVm3zEnmW6TUhyeDRPWdg@mail.gmail.com>
In-Reply-To: <CAMuHMdW4-r8khvk-hJcx1OXqwT0nGsVm3zEnmW6TUhyeDRPWdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, May 12, 2014 at 09:42:15AM +0200, Geert Uytterhoeven wrote:
> On Mon, May 12, 2014 at 1:10 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> > From: Magnus Damm <damm+renesas@opensource.se>
> >
> > Hook up ->init_late for r8a7740 to initialize Suspend-to-RAM
> > and CPUIdle in case of C-code less board support for r8a7740.
> >
> > Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks, I will queue this up.
