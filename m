From: Simon Horman <horms@verge.net.au>
Date: Fri, 14 Mar 2014 00:28:12 +0000
Subject: Re: [PATCH 0/2] ARM: shmobile: koelsch, lager: Annotate clk_names with __initconst
Message-Id: <20140314002811.GC28137@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1394692198-30715-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdXpXDv8C6b1T+LyE8BSnhdD4dPq_HF6O3OY7Aev+EFfXA@mail.gmail.com>
In-Reply-To: <CAMuHMdXpXDv8C6b1T+LyE8BSnhdD4dPq_HF6O3OY7Aev+EFfXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Mar 13, 2014 at 09:28:23AM +0100, Geert Uytterhoeven wrote:
> On Thu, Mar 13, 2014 at 7:29 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Add __initconst annotations to recently added clk_names.
> >
> > Depends on
> > "[PATCH v2 00/03] ARM: shmobile: Break out and extend clock workaround V2"
> >
> > Simon Horman (2):
> >   ARM: shmobile: koelsch: Annotate clk_names with __initconst
> >   ARM: shmobile: lager: Annotate clk_names with __initconst
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Thanks, I will queue these up.
