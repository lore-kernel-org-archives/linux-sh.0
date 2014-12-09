From: Simon Horman <horms@verge.net.au>
Date: Tue, 09 Dec 2014 00:27:03 +0000
Subject: Re: stable boot: 93 boots: 92 pass, 1 fail (v3.17.6)
Message-Id: <20141209002703.GC8897@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <2553650.3KSUKtTdo3@wuerfel>
In-Reply-To: <2553650.3KSUKtTdo3@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Dec 08, 2014 at 09:35:49AM -0800, Kevin Hilman wrote:
> On Mon, Dec 8, 2014 at 9:17 AM, Kevin Hilman <khilman@kernel.org> wrote:
> > Geert Uytterhoeven <geert@linux-m68k.org> writes:
> >
> >> Hi Kevin,
> >>
> >> On Mon, Dec 8, 2014 at 5:45 PM, Kevin Hilman <khilman@kernel.org> wrote:
> >>> Arnd Bergmann <arnd@arndb.de> writes:
> >>>> On Monday 08 December 2014 14:48:20 Geert Uytterhoeven wrote:
> >>>>> On Mon, Dec 8, 2014 at 12:35 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >>>>> > On Sunday 07 December 2014 21:49:05 Kevin's boot bot wrote:
> >>>>> >> Full Build report: http://status.armcloud.us/build/stable/kernel/v3.17.6/
> >>>>> >> Full Boot report:  http://status.armcloud.us/boot/all/job/stable/kernel/v3.17.6/
> >>>>> >>
> >>>>> >> Tree/Branch: stable
> >>>>> >> Git describe: v3.17.6
> >>>>> >>
> >>>>> >> Failed boot tests
> >>>>> >> ========> >>>>> >>                      emev2-kzm9d:     FAIL:    arm-shmobile_defconfig
> >>>>> >>                                       http://storage.armcloud.us/kernel-ci/stable/v3.17.6/arm-shmobile_defconfig/boot-emev2-kzm9d.html
> >>
> >>> I figured it out.
> >>>
> >>> The problem is that my DHCP is no longer giving out a default root-path,
> >>> and I neglected to update the commandline for this board.  I'd forgotten
> >>> that the shmobile_defconfig doesn't have initrd support in v3.17, so it
> >>> can't boot from a ramdisk like all my other boards.
> >>
> >> Good to hear that!
> >>
> >>> Geert, Simon, any objections to enabling initrd support in v3.17 stable?
> >>> Probably just asking Greg to cherry-pick mainline commit which does
> >>> this[1] should suffice.
> >>
> >> Personally, I have no objections.
> >> It's just stretching stable-kernel-rules a little bit ;-)
> >
> > Yeah, but since it's just defconfig, and very platform specific, I think
> > Greg would accept it if it's coming from the platform maintainer.  So
> > I guess it's up to Simon to decide.
> 
> FWIW, Just to be sure, I double-checked and verified that
> cherry-picking that shmobile_defconfig patch from mainline gets
> ramdisk booting working again on v3.17.y stable.

Personally I am not entirely convinced that the change really is stable
material. However, if you feel strongly about it I would be happy for
you to submit it to stable: I'll Ack it if you do so.
