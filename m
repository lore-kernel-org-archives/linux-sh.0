From: Simon Horman <horms@verge.net.au>
Date: Wed, 26 Feb 2014 08:56:45 +0000
Subject: Re: [PATCH v3 15/20] ARM: shmobile: marzen-reference: Instantiate clkdevs for SCIF and TMU
Message-Id: <20140226085645.GB7720@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1393400016-23433-1-git-send-email-horms+renesas@verge.net.au>
 <1393400016-23433-16-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdU1OJ8mMfe0-EJJizVXX0V=3YkELcTjfce8bk6qn9jhzA@mail.gmail.com>
In-Reply-To: <CAMuHMdU1OJ8mMfe0-EJJizVXX0V=3YkELcTjfce8bk6qn9jhzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Feb 26, 2014 at 09:29:52AM +0100, Geert Uytterhoeven wrote:
> On Wed, Feb 26, 2014 at 8:33 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Now that the common clock framework is supported, the clock lookup
> > entries in clock-r8a7779.c are not registered anymore. Devices must
> > instead reference their clocks in the device tree. However, SCIF and CMT
> > devices are still instantiated through platform code, and thus need a
> > clock lookup entry.
> >
> > Retrieve the SCIF and CMT clock entries by name and register clkdevs for
> > the corresponding devices. This will be removed when the SCIF and CMT
> > devices will be instantiated from the device tree.
> >
> > Based on work for the Koelsch board by Laurent Pinchart.
> 
> Would be nice to do this on top of Magnu's shmobile_clk_workaround().

Yes, I plan to either do so. Either by updating this
patch or providing an incremental change.
