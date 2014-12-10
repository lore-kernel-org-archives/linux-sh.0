From: Simon Horman <horms@verge.net.au>
Date: Wed, 10 Dec 2014 00:26:22 +0000
Subject: Re: [PATCH] ARM: shmobile: koelsch: Fix QSPI mode of SPI-Flash into mode3
Message-Id: <20141210002622.GE9690@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1418085432-20374-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdXj9N3tL_9ttw+jU7fxjC8x=JJwXQynMkjOAJp38=L4ww@mail.gmail.com>
In-Reply-To: <CAMuHMdXj9N3tL_9ttw+jU7fxjC8x=JJwXQynMkjOAJp38=L4ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Dec 09, 2014 at 09:53:04AM +0100, Geert Uytterhoeven wrote:
> On Tue, Dec 9, 2014 at 1:37 AM, Simon Horman <horms+renesas@verge.net.au> wrote:
> > From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> >
> > In order to change into mode3, CPOL and CPHA bit of SPCMD register
> > of QSPI is changed. Mode3 can avoid intermediate voltage.
> >
> > Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> > [horms: Updated changelog and re-ordered properties]
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up.
