From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 21 Jan 2015 13:15:40 +0000
Subject: Re: [PATCH v3] ARM: multi_v7_defconfig: Enable shmobile platforms
Message-Id: <1624861.F2XBvOBm9V@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <1421684018-11894-1-git-send-email-geert+renesas@glider.be>
 <1467925.IxO001Hv1t@avalon>
 <CAMuHMdWObPPnpDPQbrq1HRj9BSBFuNNusQkDhaDTxP+_16oMNg@mail.gmail.com>
In-Reply-To: <CAMuHMdWObPPnpDPQbrq1HRj9BSBFuNNusQkDhaDTxP+_16oMNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wednesday 21 January 2015 14:09:56 Geert Uytterhoeven wrote:
> Hi Laurent,
> 
> On Wed, Jan 21, 2015 at 2:02 PM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> > To avoid bloating the kernel needlessly, couldn't at least some of the drivers
> > needed for the shmobile boards be compiled as modules ? Audio, USB, SATA,
> > touchscreen are possible candidates, depending on what we need to boot the
> > boards to userspace.
> 
> That's a possibility.
> 
> Note that currently there are almost no modules in multi_v7_defconfig:
> CONFIG_INET6_AH=m
> CONFIG_INET6_ESP=m
> CONFIG_INET6_IPCOMP=m
> CONFIG_IPV6_MIP6=m
> CONFIG_IPV6_TUNNEL=m
> CONFIG_CFG80211=m
> CONFIG_MAC80211=m
> CONFIG_BRCMFMAC=m
> CONFIG_RT2X00=m
> CONFIG_RT2800USB=m
> 
> Arnd, Olof: What do you prefer?
> 

I think it would be nice to move to having more loadable modules. We
haven't really asked people to do that in the past, but the size is
starting to become a problem and we may end up having to change a lot
of the '=y' to '=m' in the future.

	Arnd
