From: Kevin Hilman <khilman@kernel.org>
Date: Wed, 04 Feb 2015 17:08:39 +0000
Subject: Re: [PATCH v3] ARM: multi_v7_defconfig: Enable shmobile platforms
Message-Id: <7h1tm5li3s.fsf@deeprootsystems.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1421684018-11894-1-git-send-email-geert+renesas@glider.be>
 <1467925.IxO001Hv1t@avalon>
 <CAMuHMdWObPPnpDPQbrq1HRj9BSBFuNNusQkDhaDTxP+_16oMNg@mail.gmail.com>
In-Reply-To: <CAMuHMdWObPPnpDPQbrq1HRj9BSBFuNNusQkDhaDTxP+_16oMNg@mail.gmail.com>
 (Geert Uytterhoeven's message of "Wed, 21 Jan 2015 14:09:56 +0100")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Hi Laurent,
>
> On Wed, Jan 21, 2015 at 2:02 PM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
>> To avoid bloating the kernel needlessly, couldn't at least some of the drivers
>> needed for the shmobile boards be compiled as modules ? Audio, USB, SATA,
>> touchscreen are possible candidates, depending on what we need to boot the
>> boards to userspace.
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

The general rule (though not really enforced) has been: if it's needed for
a rootfs, it's OK to be built in (e.g. MMC, network, etc.)  Everything
else should be modules.

FWIW, in my farm, modules are built and installed into the ramdisk so if
the kernel/rootfs needs them, they will be loaded.

Kevin

