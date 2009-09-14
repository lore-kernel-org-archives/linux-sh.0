From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 14 Sep 2009 13:10:17 +0000
Subject: Re: User mode address error problems on 7763
Message-Id: <20090914131017.GB21091@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <6e6aa1a80909111106l6dbcfccag4e9e7a3abb922688@mail.gmail.com>
In-Reply-To: <6e6aa1a80909111106l6dbcfccag4e9e7a3abb922688@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Sep 14, 2009 at 08:02:16AM -0500, Dale Larson wrote:
> I've built and run the latest code in the 'sh/cachetlb' branch od
> 'git://git.kernel.org/pub/scm/linux/kernel/git/lethal/sh-2.6.git' and
> I get many more fixup messages starting with 'swapper':
> 
These are fine, they are kernel accesses that are being fixed up.
Unfortunately some of the networking paths generate lots of unaligned
kernel traps, so we will probably have to go back to having a default of
not warning on them at all.  In any event, this behaviour is tunable.
Just open up arch/sh/kernel/traps_32.c and change se_kernmode_warn to 0.
