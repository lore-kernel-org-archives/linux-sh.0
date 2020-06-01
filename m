From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 01 Jun 2020 21:12:17 +0000
Subject: Re: [GIT PULL] sh: remove sh5 support
Message-Id: <CAK8P3a3=XjLvQYz2xB_1=XHFb34Q6zhAJbpJEDRUPX_r=kEBRg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200424221948.1120587-1-arnd@arndb.de> <20200507143552.GA28683@infradead.org>
 <20200528054600.GA29717@infradead.org> <20200528161416.GY1079@brightrain.aerifal.cx>
 <20200529143059.GA25475@infradead.org> <20200529175335.GK1079@brightrain.aerifal.cx>
 <e86e1d78-9597-811a-da0e-42a910b0c9fe@physik.fu-berlin.de> <20200601181259.GV1079@brightrain.aerifal.cx>
In-Reply-To: <20200601181259.GV1079@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Christoph Hellwig <hch@infradead.org>, Linux-sh list <linux-sh@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Rob Landley <rob@landley.net>, Geert Uytterhoeven <geert@linux-m68k.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Jun 1, 2020 at 8:13 PM Rich Felker <dalias@libc.org> wrote:
> On Sat, May 30, 2020 at 10:08:09AM +0200, John Paul Adrian Glaubitz wrote:
> > On 5/29/20 7:53 PM, Rich Felker wrote:
> > > [PATCH next] sh: remove call to memset after dma_alloc_coherent
> > > https://marc.info/?l=linux-sh&m7793031102356&w=2
>
> Can anyone confirm that this is correct/safe?

Yes, this is safe, I checked both the API definition and the sh
implementation in arch_dma_alloc(), which passes __GFP_ZERO.

       Arnd
