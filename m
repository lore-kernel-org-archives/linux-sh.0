From: Simon Horman <horms@verge.net.au>
Date: Tue, 18 Jun 2013 01:02:38 +0000
Subject: Re: [PATCH 14/15] ARM: shmobile: Remove AP4EVB board support
Message-Id: <20130618010238.GC30216@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1371106793-25071-1-git-send-email-horms+renesas@verge.net.au>
 <201306141629.26580.arnd@arndb.de>
 <CANqRtoQVqfZaGbuVLiY8PiMTjVpt8VDs7KZyqnqjud+1yZtvQQ@mail.gmail.com>
 <201306172220.54015.arnd@arndb.de>
In-Reply-To: <201306172220.54015.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Jun 17, 2013 at 10:20:53PM +0200, Arnd Bergmann wrote:
> On Monday 17 June 2013, Magnus Damm wrote:
> > On Fri, Jun 14, 2013 at 11:29 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Friday 14 June 2013, Magnus Damm wrote:
> > >> > If still possible, would be good to delay removing this board until we
> > >> > complete our discussion.
> > >>
> > >> If fine with keeping the board if someone can show me progress in the
> > >> area of INTC DT support. Recently I have not seen anything.
> > >
> > > As mentioned the last time we discussed this, I'm fine with using the
> > > existing code and "legacy" irqdomain for the older INTC implementations,
> > > as long as all the new ones can use your new generic code.
> > 
> > Thanks for explaining once again. Do you have any issues with us
> > reducing the number of supported boards and/or SoCs?
> 
> No, I'm sure you know who the users of the board files in upstream kernels
> are. If someone comes up with a good reason why one of the files is
> needed after all, we can always revert the removal at a later point.
> 
> I'm definitely in favor of removing known unused code that gets in the way
> of progress and adding clean code as quickly as we can review it.

Hi Arnd,

thanks for clarifying this. I am in complete agreement.
