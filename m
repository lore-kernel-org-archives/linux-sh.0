From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 01 Dec 2010 03:57:55 +0000
Subject: Re: [patch v4 0/2] ARM: mach-shmobile: Add zboot support for SuperH
Message-Id: <w3p62ve2lh9.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20101122231514.766413220@vergenet.net>
In-Reply-To: <20101122231514.766413220@vergenet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


Dear Simon

> this short patch series by Kuninori Morimoto and myself adds
> zboot support to mach-shmobile.
> 
> This is v4 of the patch series, which includes
> a minor rediff to apply cleanly against linux-2.6-arm/devel
> without any fuzz.
> 
> v2 implemented Magnus's suggestion to initialising atags directly rather
> than using assembly.
> 
> v2 implemented Magnus's suggestion of setting atags in the framework and
> passing them to the kernel rather than using a board-specific fixup.

I tested these patches on v2.6.37-rc3 + AP4EVB.
And it works well. Thanks

Best regards
--
Kuninori Morimoto
 
